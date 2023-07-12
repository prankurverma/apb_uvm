class apb_cov extends uvm_subscriber#(apb_sequence_item);
  `uvm_component_utils(apb_cov)
  uvm_analysis_imp #(apb_sequence_item,apb_cov) rx_port;
  apb_sequence_item base_pkt;
  covergroup cg;
  
  pwdata : coverpoint base_pkt.PWDATA;
  ///coverage has to be added/////
  endgroup
  
  function new(string name,uvm_component parent);
    super.new(name,parent);
    cg=new();
  endfunction
  
  function void build_phase(uvm_phase phase);
    rx_port=new("rx_port",this);
  endfunction
  
  function void write(apb_sequence_item t);
    this.base_pkt=t;
    $write($time);
    //base_pkt.print();
    cg.sample();
  endfunction

endclass