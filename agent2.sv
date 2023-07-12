class apb_agent2 extends uvm_agent;
  `uvm_component_utils(apb_agent2)
  apb_cov             cg; 
  apb_monitor         mon;

  function new(string name = "apb_agent2", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info(get_type_name(), " Build Phase ", UVM_HIGH);
    cg = apb_cov::type_id::create("cov",this);
    mon  = apb_monitor::type_id::create("Monitor",this);
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info(get_type_name(), " Connect Phase ", UVM_HIGH);
    mon.tx_port.connect(cg.rx_port);
  endfunction
endclass