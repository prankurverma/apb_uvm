class apb_driver extends uvm_driver #(apb_sequence_item);
  `uvm_component_utils(apb_driver)
  apb_sequence_item base_pkt;
  virtual apb_interface intf;
  //int i;
  
  function new(string name = "apb_driver", uvm_component parent=null);
  super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
  super.build_phase(phase);
  base_pkt = apb_sequence_item::type_id::create("Base Packet");
  if (! (uvm_config_db #(virtual apb_interface)::get(this,"*","intf", intf)))
  `uvm_error(get_type_name(), "Could not get interface");
  endfunction
  
  task run_phase(uvm_phase phase);
  super.run_phase(phase);   
  forever begin
  
  @(posedge intf.pclk)
  
  seq_item_port.get_next_item(base_pkt);
        
  if(!intf.preset) begin
  intf.paddr  <= 0;
  intf.pwrite <= 0;
  intf.psel   <= 0;
  intf.pwdata <= 0;
  intf.penable<= 0;
  end
  
  else 
  begin
  intf.psel      <= 2**s;
  intf.penable   <= 0;
  intf.paddr     <= base_pkt.PADDR;
  intf.pwrite    <= base_pkt.PWRITE;
  intf.pwdata    <= base_pkt.PWDATA;
                
  @(posedge intf.pclk)
  intf.penable <= 1;
  @(posedge intf.pclk)
  intf.psel <= 0  ;
  intf.penable <= 0;
  
  end
  seq_item_port.item_done();
  seq_item_port.put(base_pkt);
  
  end
      
  endtask
    
    
  endclass