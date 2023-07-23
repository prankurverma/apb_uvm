import uvm_pkg::*;
`include"uvm_macros.svh"
parameter ADDR_WIDTH = 32;
parameter DATA_WIDTH = 32;
parameter MEM_SIZE   = 65536;
parameter enable_check=1;                   // bit for monitor check
parameter N=10;                             // total no.of slave 
parameter s=5;                              // slave selection onto which i want to read and write.
`include "slave.sv"
`include "interface.sv"
`include "sequence_item.sv"
`include "sequence.sv"
`include "sequencer.sv"
`include "driver.sv"
`include "agent1.sv"
`include "monitor.sv"
`include "coverage.sv"
`include "agent2.sv"
`include "scoreboard.sv"
`include "env.sv"
`include "test.sv"

module top();
  reg clock;
  reg preset;
  apb_interface intf(.pclk(clock), .preset(preset));
  
  genvar i;
  generate
    for(i=0;i<N;i=i+1)
    begin
      mem_apb dut (.pclk(intf.pclk),
                   .prst(intf.preset),
                   .psel(intf.psel[i]),
                   .penable(intf.penable),
                   .paddr(intf.paddr),
                   .pwrite(intf.pwrite),
                   .pw_data(intf.pwdata),
                   .pr_data(intf.prdata[i]),
                   .pready(intf.pready[i]),
                   .pslverr(intf.pslverr[i]) );
    end
  endgenerate
  
  
  initial begin
    uvm_config_db #(virtual apb_interface)::set(null, "*", "intf", intf);
  end
  
  initial begin
    run_test("apb_write_read_rand_test");
  end
  
  initial begin
    preset = 0;
    #50;
    preset = 1;
  end
  
  initial begin
    clock = 0;
    forever begin
      #5 clock = ~clock;
    end
  end
    
  initial begin
    $dumpfile("d.vcd");
    $dumpvars();
  end

  initial #15000 $finish;

endmodule
