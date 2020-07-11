/****************************************************************************
 * testbench.sv
 ****************************************************************************/

/**
 * Module: testbench
 *
 * TODO: Add module documentation
 */

`include "uvm_macros.svh"
`include "uvm_clam_pkg.sv"
`include "uvm_clam_test_pkg.sv"

module testbench;

    import uvm_pkg::*;
    import uvm_clam_pkg::*;
    import uvm_clam_test_pkg::*;
    
    //Connect TB to UVM
    initial begin
        run_test();
    end

endmodule : testbench
