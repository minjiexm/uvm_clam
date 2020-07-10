/****************************************************************************
 * testbench.sv
 ****************************************************************************/

/**
 * Module: testbench
 *
 * TODO: Add module documentation
 */

`include "uvm_macros.svh"
`include "uvm_clam_macros.svh"
`include "uvm_clam_pkg.sv"
`include "uvm_clam_demo.svh"

module testbench;

    import uvm_pkg::*;
    
    //Connect TB to UVM
    initial begin
        run_test();
    end

endmodule : testbench
