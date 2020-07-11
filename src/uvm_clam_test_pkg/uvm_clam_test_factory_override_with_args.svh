`ifndef UVM_CLAM_TEST_FACTORY_OVERRIDE_WITH_ARGS_SVH
`define UVM_CLAM_TEST_FACTORY_OVERRIDE_WITH_ARGS_SVH

class usb_env_config extends uvm_object;

	rand int unsigned usb_dev_num;

	constraint usb_dev_num_range {
		usb_dev_num < 10;
	}
	
	`uvm_object_utils(usb_env_config)
	
	function new(string name = "usb_env_config");
		super.new(name);
	endfunction : new

endclass : usb_env_config


class usb_env_config_with_args extends usb_env_config;

	`uvm_object_utils(usb_env_config_with_args)

	function new(string name = "usb_env_config_with_args");
		super.new(name);
		`uvm_clam_add_arg_readme("usb_dev_num", "Control the number of usb devices")
	endfunction : new
	
	//for support factory override
	//virtual function void set_name(string name);
	//	super.set_name(name);
	//	`uvm_clam_get_int_arg(test_arg, "TEST_ARG", 10, this)
	//endfunction : set_name

	function void post_randomize();
		`uvm_clam_get_int_arg(usb_dev_num, "usb_dev_num", 10, this)
	endfunction : post_randomize

endclass : usb_env_config_with_args


class uvm_clam_test_factory_override_with_args extends uvm_test;
	
	usb_env_config usb_cfg;

	`uvm_component_utils(uvm_clam_test_factory_override_with_args)
	
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

		this.usb_cfg = usb_env_config::type_id::create({this.get_full_name(), ".usb_cfg"},, this.get_full_name());
		void'(this.usb_cfg.randomize());

        `uvm_info("TEST", $psprintf("usb_cfg.usb_dev_num = %0d", this.usb_cfg.usb_dev_num), UVM_NONE)
		
		if(this.usb_cfg.usb_dev_num != 99) begin
			`uvm_error("TEST", $psprintf("usb_cfg.usb_dev_num not equal to command line value %0d", 99), UVM_NONE)
		end
		
	endfunction : build_phase

	
endclass : uvm_clam_test_factory_override_with_args


`endif //UVM_CLAM_TEST_FACTORY_OVERRIDE_WITH_ARGS_SVH
  