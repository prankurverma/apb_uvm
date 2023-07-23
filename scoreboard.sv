class apb_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(apb_scoreboard)
  uvm_analysis_imp #(apb_sequence_item, apb_scoreboard) rx_port;
  apb_sequence_item actual_pkt_q[$];
  apb_sequence_item actual_pkt; 
  logic [DATA_WIDTH-1:0] mem [65536];
  int i;  
  
    
  function new(string name = "apb_scoreboard", uvm_component parent);
    super.new(name, parent);
    rx_port = new("rx_port",this);
  endfunction
  
  function void write(apb_sequence_item base_pkt);
    actual_pkt_q.push_back(base_pkt);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info(get_type_name(), "In build phase", UVM_HIGH);
    actual_pkt = apb_sequence_item::type_id::create("actual_pkt");
    foreach(mem[i])
      mem[i] = 0;
  endfunction
    
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    `uvm_info(get_type_name(), "In run phase", UVM_HIGH);
    forever begin
      wait(actual_pkt_q.size() != 0);
      actual_pkt = actual_pkt_q.pop_front();
      compare();
    end
  endtask
    
  task compare();
            
  if(actual_pkt.PSEL) begin
          
    if(actual_pkt.PENABLE && actual_pkt.PREADY && actual_pkt.PWRITE ) begin
      mem[actual_pkt.PADDR] = actual_pkt.PWDATA;
      `uvm_info("WRITE DATA ",$psprintf(" Data written: %0d Data address: %0d ",actual_pkt.PWDATA,actual_pkt.PADDR),UVM_LOW)
    end
            
    else if(actual_pkt.PENABLE && actual_pkt.PREADY && !actual_pkt.PWRITE ) begin
      actual_pkt.PRDATA=mem[actual_pkt.PADDR];     
      if(actual_pkt.PRDATA==mem[actual_pkt.PADDR]) begin
        `uvm_info("READ DATA MATCH",$psprintf(" Expected prdata: %0d Actual prdata: %0d ",mem[actual_pkt.PADDR],actual_pkt.PRDATA),UVM_LOW)
      end
      else begin
        `uvm_error("NO MATCH", $psprintf("Expected PRDATA:  %0d, Actual PRDATA: %0d data address: %0d", mem[actual_pkt.PADDR], actual_pkt.PRDATA,actual_pkt.PADDR));
      end
    end
  end
  endtask
  
  endclass
  
