`ifndef UVM_CLAM_SVH
`define UVM_CLAM_SVH

class uvm_clam extends uvm_object;

	static uvm_clam global_access = null;
	
    uvm_cmdline_processor cmdpros = uvm_cmdline_processor::get_inst();
    
    string args_readme[string];
    
	bit print_help = 0;
	bit print_trace_info = 0;
	
    string msg_id = "TRACE_ARG";

	`uvm_object_utils(uvm_clam)

	function new(string name = "uvm_clam");
		super.new(name);
		
		this.add_argument_readme("ARGS_HELP",  "Print help information for all arguments");
		this.add_argument_readme("ARGS_TRACE", "For enable print command line arguments debug information");

		print_help = this.get_plus_arg("ARGS_HELP", this);
		print_trace_info = this.get_plus_arg("ARGS_TRACE", this);
		if(print_trace_info) print_help = 1;
	
	endfunction : new


	static function uvm_clam get_inst();
		if(global_access == null) begin
			global_access = uvm_clam::type_id::create("uvm_clam");
		end
		return global_access;
	endfunction : get_inst

	
	virtual function void add_argument_readme(string argName, string readme);
		string argValue;

		if(!this.args_readme.exists(argName)) begin
			this.args_readme[argName] = readme;
			if(print_help)
				`uvm_info(msg_id, $psprintf("[HELP] argument \"%s\" : \"%s\"", argName, readme), UVM_NONE)
		end
		else if(this.args_readme[argName] != readme) //try to add argument with different readme
			`uvm_error(this.msg_id, $psprintf("[add_argument_readme argument] argument %s already exists with readme : %s", argName, this.args_readme[argName]))

	endfunction : add_argument_readme


	virtual function bit exists(string argName);
		exists = this.args_readme.exists(argName);
	endfunction : exists

	
	protected function void trace_print(string func, string debug_message, uvm_object location);
		if(this.print_trace_info) begin
			string prefix = {"[", func, "]"};
			if(location != null) begin
				string _type = "uvm_object";

				uvm_component comp;
				if($cast(comp, location))
					_type = "uvm_component";
			
				prefix = $sformatf("%s Location %s type %s", prefix, location.get_full_name(), _type);
			end
			`uvm_info(this.msg_id, {prefix, " ", debug_message}, UVM_NONE)
		end
	endfunction : trace_print
	

	virtual function int get_plus_arg(string argName, uvm_object location);
		string locArgName;
		string argValue;
		string plusArgs[$];
		string locPlusArgs[$];
		string func = "get_plus_arg";

		if(!args_readme.exists(argName)) begin
			`uvm_error(this.msg_id, $psprintf("[get_plus_arg] Please use add_argument_readme to give a readme to the argument \"%s\"", argName))
		end

		if(location != null)
			locArgName = {location.get_full_name(), ".", argName};

        void'(cmdpros.get_arg_matches({"+", argName}, plusArgs));
        void'(cmdpros.get_arg_matches({"+", locArgName}, locPlusArgs));
		
		if(plusArgs.size() > 0) begin
			get_plus_arg = 1;
			this.trace_print(func, $psprintf("Get plus argument \"%s\" from command line", argName), location);
		end
		else if(locPlusArgs.size() > 0) begin
			get_plus_arg = 1;
			this.trace_print(func, $psprintf("Get plus argument \"%s\" from command line", locArgName), location);
		end
		else begin
			get_plus_arg = 0;
			this.trace_print(func, $psprintf("Did not find plus argument \"%s\" from command line", argName), location);
		end
	endfunction : get_plus_arg


    virtual function int get_int_arg(string argName, int def_value, uvm_object location = null);
        string argValue;
        string locArgName;
        uvm_component component;
        string func = "get_int_arg";
        
        //if(!args_readme.exists(argName)) begin
        //	`uvm_error(this.msg_id, $psprintf("[%s] Please use add_argument_readme to give a readme to the argument \"%s\"", func, argName))
        //end

        if(location != null) begin
        	locArgName = {location.get_full_name(), ".", argName};
        end
        
        if($cast(component, location) && uvm_config_db#(uvm_bitstream_t)::get(component, "", argName, get_int_arg)) begin
        	this.trace_print(func, $psprintf("Get argument \"%s\" with value \"%0d\" from config_db", argName, get_int_arg), location);
        end
        else if(cmdpros.get_arg_value({"+", locArgName, "="}, argValue)) begin
        	get_int_arg = argValue.atoi();
        	this.trace_print(func, $psprintf("Get argument \"%s\" with value \"%0d\" from command line", locArgName, get_int_arg), location);
        end
        else if(cmdpros.get_arg_value({"+", argName, "="}, argValue)) begin
            get_int_arg = argValue.atoi();
            this.trace_print(func, $psprintf("Get argument \"%s\" with value \"%0d\" from command line", argName, get_int_arg), location);
    	end
    	else begin
    		get_int_arg = def_value;  //default number
    		this.trace_print(func, $psprintf("Use argument \"%s\" default value \"%0d\"", argName, get_int_arg), location);
    	end

    endfunction : get_int_arg


    virtual function string get_string_arg(string argName, string def_value, uvm_object location = null);
        string argValue;
        string locArgName;
        uvm_component component;
        string func = "get_string_arg";

        //if(!args_readme.exists(argName)) begin
        //	`uvm_error(this.msg_id, $psprintf("[%s] Please use add_argument_readme to give a readme to the argument \"%s\"", func, argName))
        //end
        
        if(location != null)
        	locArgName = {location.get_full_name(), ".", argName};

        if($cast(component, location) && uvm_config_db#(string)::get(component, "", argName, get_string_arg)) begin
        	this.trace_print(func, $psprintf("Get argument \"%s\" with value \"%0d\" from config_db", argName, get_string_arg), location);
        end
        else if(cmdpros.get_arg_value({"+", locArgName, "="}, argValue)) begin
        	get_string_arg = argValue;
        	this.trace_print(func, $psprintf("Get argument \"%s\" with value \"%0d\" from command line", locArgName, get_string_arg), location);
        end
        else if(cmdpros.get_arg_value({"+", argName, "="}, argValue)) begin
        	get_string_arg = argValue;
        	this.trace_print(func, $psprintf("Get argument \"%s\" with value \"%0d\" from command line", argName, get_string_arg), location);
        end
        else begin
        	get_string_arg = def_value;  //default value
        	this.trace_print(func, $psprintf("Use argument \"%s\" default value \"%s\"", argName, get_string_arg), location);
        end

    endfunction : get_string_arg


endclass : uvm_clam


`endif // UVM_CLAM_SVH