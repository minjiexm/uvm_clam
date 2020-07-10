`ifndef UVM_CLAM_TEST_OBJ_OOP_ARGS_SVH
`define UVM_CLAM_TEST_OBJ_OOP_ARGS_SVH

class my_config extends uvm_object;

	rand int unsigned test_arg;

	constraint test_arg_range {
		test_arg < 10;
	}
	
	`uvm_object_utils(my_config)
	
	function new(string name = "my_config");
		super.new(name);
	endfunction : new

endclass : my_config


class my_config_with_args extends my_config;

	int unsigned test_arg;

	`uvm_object_utils(my_config_with_args)
	
	function new(string name = "my_config_with_args");
		super.new(name);
	endfunction : new
	
	//for support factory override
	//virtual function void set_name(string name);
	//	super.set_name(name);
	//	`uvm_clam_get_int_arg(test_arg, "TEST_ARG", 10, this)
	//endfunction : set_name

	function void post_randomize();
		`uvm_clam_get_int_arg(test_arg, "TEST_ARG", 10, this)
	endfunction : post_randomize

endclass : my_config_with_args


class uvm_clam_test_object_oop_args extends uvm_test;
	
	my_config cfg;

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

		this.cfg = my_config::type_id::create({this.get_full_name(), ".cfg"},, this.get_full_name());
		void'(this.cfg.randomize());
		
		`uvm_info("TEST", $psprintf("cfg.test_arg = %0d", this.cfg.test_arg), UVM_NONE)
	endfunction : build_phase


	/****************************************************************
	 * connect_phase()
	 ****************************************************************/
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
	endfunction

	/****************************************************************
	 * run_phase()
	 ****************************************************************/
	task run_phase(uvm_phase phase);
		// TODO: Launch any local behavior
	endtask
	
endclass : uvm_clam_test_object_oop_args


`endif //UVM_CLAM_TEST_OBJ_OOP_ARGS_SVH
  