`ifndef UVM_CLAM_TEST_COMPONENT_OOP_ARGS_SVH
`define UVM_CLAM_TEST_COMPONENT_OOP_ARGS_SVH

class axi_env extends uvm_env;

	int unsigned axi_uvc_num;

	`uvm_component_utils(axi_env)

	function new(string name = "axi_env", uvm_component parent);
		super.new(name, parent);
		`uvm_clam_add_arg_readme("axi_uvc_num", "Control how many axi uvc will be created with axi_env")
	endfunction : new

	/****************************************************************
	 * build_phase()
	 ****************************************************************/
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`uvm_clam_get_int_arg(axi_uvc_num, "axi_uvc_num", 18, this)
	endfunction : build_phase
	
endclass : axi_env


class uvm_clam_test_component_oop_args extends uvm_test;

	axi_env usb_axi_env;
	axi_env pcie_axi_env;

	`uvm_component_utils(uvm_clam_test_component_oop_args)
	
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

		this.usb_axi_env  = axi_env::type_id::create("usb_axi_env", this);
		this.pcie_axi_env = axi_env::type_id::create("pcie_axi_env", this);

	endfunction : build_phase

endclass : uvm_clam_test_component_oop_args


class uvm_clam_test_component_oop_args_default extends uvm_clam_test_component_oop_args;
	
	int unsigned axi_uvc_num_default = 18;

	`uvm_component_utils(uvm_clam_test_component_oop_args_default)
	
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
				
		if(this.usb_axi_env.axi_uvc_num != axi_uvc_num_default)
			`uvm_error("TEST", $psprintf("usb_axi_env.axi_uvc_num not equal to default value %0d", axi_uvc_num_default))
			
		if(this.pcie_axi_env.axi_uvc_num != axi_uvc_num_default)
			`uvm_error("TEST", $psprintf("pcie_axi_env.axi_uvc_num not equal to default value %0d", axi_uvc_num_default))

	endtask : main_phase

endclass : uvm_clam_test_component_oop_args_default


//This test will add one global simulation argument and expect argument use global cmd input value
class uvm_clam_test_component_oop_args_global extends uvm_clam_test_component_oop_args;
	
	int unsigned axi_uvc_num = 16;

	`uvm_component_utils(uvm_clam_test_component_oop_args_global)
	
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
				
		if(this.usb_axi_env.axi_uvc_num != axi_uvc_num)
			`uvm_error("TEST", $psprintf("usb_axi_env.axi_uvc_num not equal to global value %0d", axi_uvc_num))
			
		if(this.pcie_axi_env.axi_uvc_num != axi_uvc_num)
			`uvm_error("TEST", $psprintf("pcie_axi_env.axi_uvc_num not equal to global value %0d", axi_uvc_num))

	endtask : main_phase

endclass : uvm_clam_test_component_oop_args_global


//This test will add two simulation arguments to set different value to different instances
//sim args with instance name will have higher priority than global sim args.
class uvm_clam_test_component_oop_args_diff_value extends uvm_clam_test_component_oop_args;
	
	int unsigned usb_axi_uvc_num = 6;
	int unsigned pcie_axi_uvc_num = 8;

	`uvm_component_utils(uvm_clam_test_component_oop_args_diff_value)
	
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

		if(this.usb_axi_env.axi_uvc_num != usb_axi_uvc_num)
			`uvm_error("TEST", $psprintf("usb_axi_env.axi_uvc_num not equal to cmd line value %0d", usb_axi_uvc_num))
			
		if(this.pcie_axi_env.axi_uvc_num != pcie_axi_uvc_num)
			`uvm_error("TEST", $psprintf("pcie_axi_env.axi_uvc_num not equal to cmd_line value %0d", pcie_axi_uvc_num))

	endtask : main_phase

endclass : uvm_clam_test_component_oop_args_diff_value


//This test will add two simulation arguments to set different value to different instances
//Also we direct set values through config_db
//sim args with instance name will have higher priority than cfg_db setting.
class uvm_clam_test_component_oop_args_cfg_db extends uvm_clam_test_component_oop_args_diff_value;
	
	`uvm_component_utils(uvm_clam_test_component_oop_args_cfg_db)
	
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
	virtual function void build_phase(uvm_phase phase);

		uvm_config_db#(uvm_bitstream_t)::set(this, "usb_axi_env", "axi_uvc_num", 256);
		uvm_config_db#(uvm_bitstream_t)::set(this, "pcie_axi_env", "axi_uvc_num", 512);

		super.build_phase(phase);
	endfunction : build_phase

endclass : uvm_clam_test_component_oop_args_cfg_db


`endif //UVM_CLAM_TEST_COMPONENT_OOP_ARGS_SVH
  