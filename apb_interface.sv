interface apb_interface (input logic pclk,  input logic preset );

  logic                                   p_enable;
  logic                                   p_write;
  logic    [ADDR_WIDTH -1 : 0]            p_addr;
  logic    [N-1:0]                        p_sel;
  logic    [DATA_WIDTH -1 : 0]            p_wdata;
  logic    [N-1:0][DATA_WIDTH -1 : 0]     p_rdata;
  logic    [N-1:0]                        p_ready;
  logic    [N-1:0]                        p_slverr;

endinterface

//FLOWER by Jisoo
