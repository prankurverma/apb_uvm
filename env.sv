class apb_env extends uvm_env;
  `uvm_component_utils(apb_env)
  apb_agent1 ag1;
  apb_agent2 ag2;
  apb_scoreboard scb;
  function new(string name,uvm_component parent);
  super.new(name,parent);
  endfunction
  function void build_phase(uvm_phase phase);
  ag1=apb_agent1::type_id::create("agent1",this);
  ag2=apb_agent2::type_id::create("agent2",this);
  scb=apb_scoreboard::type_id::create("scb",this);
  endfunction
  function void connect_phase(uvm_phase phase);
  ag2.mon.tx_port.connect(scb.rx_port);
  endfunction
  endclass
  