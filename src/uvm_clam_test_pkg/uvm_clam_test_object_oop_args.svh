`ifndef UVM_CLAM_TEST_OBJ_OOP_ARGS_SVH
`define UVM_CLAM_TEST_OBJ_OOP_ARGS_SVH


class my_sequence extends uvm_sequence;

	int unsigned pkt_num;

	uvm_sequence_item pkt;

	`uvm_object_utils(my_sequence)
	
	function new(string name = "my_sequence");
		super.new(name);
		`uvm_clam_add_arg_readme("pkt_num", "Control the packet number send by my_sequence")
	endfunction : new

	//for support factory override
	virtual function void set_name(string name);
		super.set_name(name);
		`uvm_clam_get_int_arg(pkt_num, "pkt_num", 28, this)
	endfunction : set_name

	
	virtual task body();
		for(int unsigned idx = 0; idx < this.pkt_num; idx++) begin
			`uvm_do(pkt);
		end
	endtask
	
endclass : my_sequence


class uvm_clam_test_object_oop_args extends uvm_test;

	my_sequence sequence_port0;
	my_sequence sequence_port1;

	`uvm_component_utils(uvm_clam_test_object_oop_args)
	
	/****************************************************************
	 * Data Fields
	 ****************************************************************/
	
	/****************************************************************
	 * new()
	 ****************************************************************/
	function new(string name, uvm_component parent=null);
		super.new(name, parent);
	endfunction

	/****************************************************************
	 * build_phase()
	 ****************************************************************/
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		this.sequence_port0 = my_sequence::type_id::create({this.get_full_name(), ".sequence_port0"});
		this.sequence_port1 = my_sequence::type_id::create({this.get_full_name(), ".sequence_port1"});

	endfunction : build_phase

endclass : uvm_clam_test_object_oop_args


//This test will not add any simulation arguments and expect argument use default value
class uvm_clam_test_object_oop_args_default extends uvm_clam_test_object_oop_args;

	int unsigned pkt_num_default = 28;
	
	`uvm_component_utils(uvm_clam_test_object_oop_args_default)
	
	/****************************************************************
	 * Data Fields
	 ****************************************************************/
	
	/****************************************************************
	 * new()
	 ****************************************************************/
	function new(string name, uvm_component parent=null);
		super.new(name, parent);
	endfunction

	/****************************************************************
	 * main_phase()
	 ****************************************************************/
	virtual task main_phase(uvm_phase phase);
		super.main_phase(phase);
		
		if(this.sequence_port0.pkt_num != pkt_num_default)
			`uvm_error("TEST", $psprintf("sequence_port0.pkt_num not equal to default value %0d", pkt_num_default))
			
		if(this.sequence_port1.pkt_num != pkt_num_default)
			`uvm_error("TEST", $psprintf("sequence_port1.pkt_num not equal to default value %0d", pkt_num_default))

	endtask : main_phase

endclass : uvm_clam_test_object_oop_args_default


//This test will add one global simulation argument and expect argument use global cmd input value
class uvm_clam_test_object_oop_args_global extends uvm_clam_test_object_oop_args;

	int unsigned pkt_num_cmd_input = 16;
	
	`uvm_component_utils(uvm_clam_test_object_oop_args_global)
	
	/****************************************************************
	 * Data Fields
	 ****************************************************************/
	
	/****************************************************************
	 * new()
	 ****************************************************************/
	function new(string name, uvm_component parent=null);
		super.new(name, parent);
	endfunction

	/****************************************************************
	 * main_phase()
	 ****************************************************************/
	virtual task main_phase(uvm_phase phase);
		super.main_phase(phase);
		
		if(this.sequence_port0.pkt_num != pkt_num_cmd_input)
			`uvm_error("TEST", $psprintf("sequence_port0.pkt_num not equal to global cmd line input value %0d", pkt_num_cmd_input))
			
		if(this.sequence_port1.pkt_num != pkt_num_cmd_input)
			`uvm_error("TEST", $psprintf("sequence_port1.pkt_num not equal to global cmd line input value %0d", pkt_num_cmd_input))

	endtask : main_phase

endclass : uvm_clam_test_object_oop_args_global


//This test will add two simulation arguments to set different value to different instances
//sim args with instance name will have higher priority than global sim args.
class uvm_clam_test_object_oop_args_diff_value extends uvm_clam_test_object_oop_args;

	int unsigned pkt_num_p0 = 11;
	int unsigned pkt_num_p1 = 23;
	
	`uvm_component_utils(uvm_clam_test_object_oop_args_diff_value)
	
	/****************************************************************
	 * Data Fields
	 ****************************************************************/
	
	/****************************************************************
	 * new()
	 ****************************************************************/
	function new(string name, uvm_component parent=null);
		super.new(name, parent);
	endfunction

	/****************************************************************
	 * main_phase()
	 ****************************************************************/
	virtual task main_phase(uvm_phase phase);
	    super.main_phase(phase);
		
		if(this.sequence_port0.pkt_num != pkt_num_p0)
			`uvm_error("TEST", $psprintf("sequence_port0.pkt_num not equal to cmd line input value %0d", pkt_num_p0))
			
		if(this.sequence_port1.pkt_num != pkt_num_p1)
			`uvm_error("TEST", $psprintf("sequence_port1.pkt_num not equal to cmd line input value %0d", pkt_num_p1))

	endtask : main_phase

endclass : uvm_clam_test_object_oop_args_diff_value


`endif //UVM_CLAM_TEST_OBJ_OOP_ARGS_SVH