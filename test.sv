class apb_test extends uvm_test;
  `uvm_component_utils(apb_test)
  apb_env env;
  function new(string name,uvm_component parent);
  super.new(name,parent);
  endfunction
  function void end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);
  `uvm_info(get_type_name(), " End of elaboration Phase ", UVM_HIGH);
  uvm_top.print_topology();
  endfunction
  
  function void build_phase(uvm_phase phase);
  env=apb_env::type_id::create("env",this);
  endfunction
  endclass
  
  class apb_read_test extends apb_test;
  `uvm_component_utils(apb_read_test)
  apb_read_sequence base_pkt;
  function new(string name,uvm_component parent);
  super.new(name,parent);
  endfunction
  function void build_phase(uvm_phase phase);
  super.build_phase(phase);
  endfunction
  task run_phase(uvm_phase phase);
  base_pkt=apb_read_sequence::type_id::create("base_pkt",this);
  phase.raise_objection(this);
  base_pkt.start(env.ag1.seqr);
  phase.drop_objection(this);
  endtask
  endclass
  class apb_write_read_test extends apb_test;
  `uvm_component_utils(apb_write_read_test)
  apb_write_read_sequence base_pkt;
  function new(string name,uvm_component parent);
  super.new(name,parent);
  endfunction
  function void build_phase(uvm_phase phase);
  super.build_phase(phase);
  endfunction
  task run_phase(uvm_phase phase);
  base_pkt=apb_write_read_sequence::type_id::create("base_pkt",this);
  phase.raise_objection(this);
  base_pkt.start(env.ag1.seqr);
  phase.drop_objection(this);
  endtask
  endclass
  class apb_write_read_rand_test extends apb_test;
  `uvm_component_utils(apb_write_read_rand_test)
  apb_write_read_rand_sequence base_pkt;
  function new(string name,uvm_component parent);
  super.new(name,parent);
  endfunction
  function void build_phase(uvm_phase phase);
  super.build_phase(phase);
  endfunction
  task run_phase(uvm_phase phase);
  base_pkt=apb_write_read_rand_sequence::type_id::create("base_pkt",this);
  phase.raise_objection(this);
  base_pkt.start(env.ag1.seqr);
  phase.drop_objection(this);
  endtask
  endclass
  class apb_monitor_check_test extends apb_test;
  `uvm_component_utils(apb_monitor_check_test)
  apb_monitor_check_sequence base_pkt;
  function new(string name,uvm_component parent);
  super.new(name,parent);
  endfunction
  function void build_phase(uvm_phase phase);
  super.build_phase(phase);
  endfunction
  task run_phase(uvm_phase phase);
  base_pkt=apb_monitor_check_sequence::type_id::create("base_pkt",this);
  phase.raise_objection(this);
  base_pkt.start(env.ag1.seqr);
  phase.drop_objection(this);
  endtask
  endclass
  class apb_err_test extends apb_test;
  `uvm_component_utils(apb_err_test)
  apb_err_sequence base_pkt;
  function new(string name,uvm_component parent);
  super.new(name,parent);
  endfunction
  function void build_phase(uvm_phase phase);
  super.build_phase(phase);
  endfunction
  task run_phase(uvm_phase phase);
  base_pkt=apb_err_sequence::type_id::create("base_pkt",this);
  phase.raise_objection(this);
  base_pkt.start(env.ag1.seqr);
  phase.drop_objection(this);
  endtask
  endclass
  class apb_wr7_test extends apb_test;
  `uvm_component_utils(apb_wr7_test)
  apb_wr7_sequence base_pkt;
  function new(string name,uvm_component parent);
  super.new(name,parent);
  endfunction
  function void build_phase(uvm_phase phase);
  super.build_phase(phase);
  endfunction
  task run_phase(uvm_phase phase);
  base_pkt=apb_wr7_sequence::type_id::create("base_pkt",this);
  phase.raise_objection(this);
  base_pkt.start(env.ag1.seqr);
  phase.drop_objection(this);
  endtask
  endclass
  class apb_wr8_test extends apb_test;
  `uvm_component_utils(apb_wr8_test)
  apb_wr8_sequence base_pkt;
  function new(string name,uvm_component parent);
  super.new(name,parent);
  endfunction
  function void build_phase(uvm_phase phase);
  super.build_phase(phase);
  endfunction
  task run_phase(uvm_phase phase);
  base_pkt=apb_wr8_sequence::type_id::create("base_pkt",this);
  phase.raise_objection(this);
  base_pkt.start(env.ag1.seqr);
  phase.drop_objection(this);
  endtask
  endclass
    