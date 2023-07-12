class apb_sequencer extends uvm_sequencer #(apb_sequence_item);
  `uvm_component_utils(apb_sequencer)
  function new(string name = "apb_sequencer", uvm_component parent=null);
  super.new(name, parent);
  endfunction
  function void build_phase(uvm_phase phase);
  super.build_phase(phase);
  `uvm_info(get_type_name(), " Build Phase ", UVM_HIGH);
  endfunction
  
  function void connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  `uvm_info(get_type_name(), " Connect Phase ", UVM_HIGH);
  endfunction
  task run_phase(uvm_phase phase);
  super.run_phase(phase);
  `uvm_info(get_type_name(), "In run phase", UVM_HIGH);
  endtask
  endclass
  