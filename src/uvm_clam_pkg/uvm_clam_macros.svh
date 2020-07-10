//Filename : uvm_clam_macros.sv

`ifndef UVM_CLAM_MACROS_SVH
`define UVM_CLAM_MACROS_SVH

`define uvm_clam_get_int_arg(argValue, argName, defValue, location) \
	begin \
	    uvm_clam global_clam_access = uvm_clam::get_inst(); \
	    argValue = global_clam_access.get_int_arg(argName, defValue, location); \
	end

	
`define uvm_clam_get_string_arg(argValue, argName, defValue, location) \
	begin \
	    uvm_clam global_clam_access = uvm_clam::get_inst(); \
	    argValue = global_clam_access.get_string_arg(argName, defValue, location); \
	end	


`define uvm_clam_get_plus_arg(argValue, argName, location) \
	begin \
	    uvm_clam global_clam_access = uvm_clam::get_inst(); \
	    argValue = global_clam_access.get_plus_arg(argName, location); \
	end	

	
`define uvm_clam_add_arg_readme(argName, readme) \
	begin \
	uvm_clam global_clam_access = uvm_clam::get_inst(); \
	global_clam_access.add_argument_readme(argName, readme); \
	end	


`endif // UVM_CLAM_MACROS_SVH
