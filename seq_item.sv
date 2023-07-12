class apb_sequence_item extends uvm_sequence_item;

  `uvm_object_utils(apb_sequence_item)
  
  function new (string name = "apb_transaction");
  super.new(name);
  endfunction
     
  logic                                      PRESET; 
  rand logic      [ADDR_WIDTH-1:0]           PADDR;
  rand logic                                 PWRITE;
  rand logic      [N-1:0]                    PSEL;
  rand logic      [DATA_WIDTH-1:0]           PWDATA;
  rand logic                                 PENABLE;
  logic           [N-1:0][DATA_WIDTH-1:0]    PRDATA;
  logic           [N-1:0]                    PREADY;
  logic           [N-1:0]                    PSLVERR;
    
  /*
  function void print(string component);
      
  $display(" ");
  $display(" ============================================== ");
  $display(" Printing from %s", component);
  $display("t=%0t  PADDR: %0d PWRITE:%0d PSEL:%0b PWDATA:%0d PENABLE:%0d PRDATA:%0d PREADY:%0d PLVERR:%0d ",$time,
   PADDR,PWRITE,PSEL,PWDATA,PENABLE,PRDATA,PREADY,PSLVERR );
   
  endfunction*/
  endclass
  