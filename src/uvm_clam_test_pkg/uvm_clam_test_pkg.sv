`ifndef UVM_CLAM_TEST_PKG_SVH
`define UVM_CLAM_TEST_PKG_SVH

package uvm_clam_test_pkg;

    timeunit 1ns;
    timeprecision 1ps;
    
    `include "uvm_macros.svh"
    import uvm_pkg::*;
    import uvm_clam_pkg::*;

    `include "uvm_clam_macros.svh"

    `include "uvm_clam_test_object_oop_args.svh"
    `include "uvm_clam_test_component_oop_args.svh"
    `include "uvm_clam_test_factory_override_with_args.svh"

endpackage : uvm_clam_test_pkg

`endif // UVM_CLAM_TEST_PKG_SVH
