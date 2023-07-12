class apb_agent1 extends uvm_agent;

  `uvm_component_utils(apb_agent1)
  apb_sequencer       seqr;
  apb_driver          drv;

  function new(string name = "apb_agent1", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info(get_type_name(), " Build Phase ", UVM_HIGH);
    drv  = apb_driver::type_id::create("Driver",this);
    seqr = apb_sequencer::type_id::create("Sequencer",this);
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info(get_type_name(), " Connect Phase ", UVM_HIGH);
    drv.seq_item_port.connect(seqr.seq_item_export);
  endfunction

endclass