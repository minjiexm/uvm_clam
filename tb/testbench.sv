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

module testbench;

    import uvm_pkg::*;
    import uvm_clam_pkg::*;
    
    //Connect TB to UVM
    initial begin
        run_test();
    end

endmodule : testbench
