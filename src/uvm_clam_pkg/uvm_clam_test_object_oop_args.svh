`ifndef UVM_CLAM_TEST_OBJ_OOP_ARGS_SVH
`define UVM_CLAM_TEST_OBJ_OOP_ARGS_SVH


class uvm_clam_args_object extends uvm_sequence;

	int unsigned test_arg;

	`uvm_object_utils(uvm_clam_args_object)
	
	function new(string name = "uvm_clam_args_object");
		super.new(name);
	endfunction : new
	
	//for support factory override
	virtual function void set_name(string name);
		super.set_name(name);
		`uvm_clam_get_int_arg(test_arg, "TEST_ARG", 10, this)
	endfunction : set_name

endclass : uvm_clam_args_object


class uvm_clam_args_component extends uvm_component;

	int unsigned test_arg;

	`uvm_component_utils(uvm_clam_args_component)
	
	function new(string name = "uvm_clam_args_component", uvm_component parent);
		super.new(name, parent);	
	endfunction : new

	/****************************************************************
	 * build_phase()
	 ****************************************************************/
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);		
		`uvm_clam_get_int_arg(test_arg, "TEST_ARG", 10, this)
	endfunction : build_phase
	
endclass : uvm_clam_args_component


class uvm_clam_test_object_oop_args extends uvm_test;
	
	int unsigned test_arg;

	uvm_clam_args_object args_object_1;
	uvm_clam_args_object args_object_2;

	uvm_clam_args_component args_component_1;
	uvm_clam_args_component args_component_2;

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

		`uvm_clam_add_arg_readme("TEST_ARG", "For test purpuse")

		uvm_config_db#(uvm_bitstream_t)::set(this, "args_component_2", "TEST_ARG", 15);

		this.args_object_1 = uvm_clam_args_object::type_id::create({this.get_full_name(), ".args_object_1"});
		this.args_object_2 = uvm_clam_args_object::type_id::create({this.get_full_name(), ".args_object_2"});
        
		this.args_component_1 = uvm_clam_args_component::type_id::create("args_component_1", this);
		this.args_component_2 = uvm_clam_args_component::type_id::create("args_component_2", this);

	endfunction : build_phase

endclass : uvm_clam_test_object_oop_args


`endif //UVM_CLAM_TEST_OBJ_OOP_ARGS_SVH
  