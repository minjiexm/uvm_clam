`ifndef UVM_CLAM_PKG_SVH
`define UVM_CLAM_PKG_SVH

package uvm_clam_pkg;

    timeunit 1ns;
    timeprecision 1ps;
    
    `include "uvm_macros.svh"
    import uvm_pkg::*;

    `include "uvm_clam_macros.svh"
    `include "uvm_clam.svh"

endpackage : uvm_clam_pkg

`endif // UVM_CLAM_PKG_SVH
