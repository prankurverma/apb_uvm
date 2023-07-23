class apb_monitor extends uvm_monitor;
  `uvm_component_utils(apb_monitor)
  
  uvm_analysis_port #(apb_sequence_item) tx_port;
  
  apb_sequence_item base_pkt;
  virtual apb_interface intf;
  function new(string name = "apb_monitor", uvm_component parent=null);
    super.new(name, parent);
  endfunction
   
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    base_pkt=apb_sequence_item::type_id::create("base_pkt");
    tx_port = new("tx_port",this);
    if (! (uvm_config_db #(virtual apb_interface)::get(this,"*","intf", intf)))
      `uvm_error(get_type_name(), "Could not get interface");
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    forever begin
      @(posedge intf.pclk)
      
      if(intf.psel && intf.penable ) begin
        base_pkt.PADDR   <= intf.paddr;
        base_pkt.PWRITE  <= intf.pwrite;
        base_pkt.PSEL    <= intf.psel;
        base_pkt.PWDATA  <= intf.pwdata;
        base_pkt.PENABLE <= intf.penable;
        base_pkt.PRDATA  <= intf.prdata;
        base_pkt.PREADY  <= intf.pready;
        base_pkt.PSLVERR <= intf.pslverr;
        
        if(enable_check)
        begin
          fork
          valid_paddr();
          valid_pwrite();
          valid_pwdata();
          valid_penable();
          valid_prdata();
          psel_atmost_one();
          valid_address();
          pslverr_asserted();
          join
        end 
        tx_port.write(base_pkt);
      end      
    end
  endtask
  
  virtual function void valid_paddr();
    if($isunknown(intf.paddr)) 
      `uvm_error("ERROR","UNVALID VALUE OF PADDR")
    else                 
      `uvm_info(get_type_name(),"VALID VALUE OF PADDR",UVM_HIGH)
  endfunction
    
  virtual function void valid_pwrite();
    if($isunknown(intf.pwrite)) 
      `uvm_error("ERROR","UNVALID VALUE OF PWRITE")
    else                 
      `uvm_info(get_type_name(),"VALID VALUE OF PWRITE",UVM_HIGH)
  endfunction
  
  virtual function void valid_pwdata();
    if(intf.paddr>MEM_SIZE) 
      `uvm_error("ERROR","PWDATA IS NOT WRITTEN")
    else                 
      `uvm_info(get_type_name(),"VALID VALUE OF PWDATA",UVM_HIGH)
  endfunction
  
  virtual function void valid_penable();
    if($isunknown(intf.penable)) 
      `uvm_error("ERROR","UNVALID VALUE OF Penable")
    else                 
      `uvm_info(get_type_name(),"VALID VALUE OF PENABLE",UVM_HIGH)
  endfunction
  
  virtual function void valid_prdata();
    if(intf.paddr>MEM_SIZE) 
      `uvm_error("ERROR","UNVALID VALUE OF PRDATA")
    else                 
      `uvm_info(get_type_name(),"VALID VALUE OF PRDATA",UVM_HIGH)
  endfunction
  
  virtual function void pslverr_asserted();
    if(intf.pslverr) 
      `uvm_error("ERROR","NO READING or WRITING AS PSLVERR HIGH")
    else                 
      `uvm_info(get_type_name(),"NO PSLVERR",UVM_HIGH)
  endfunction
  
  virtual function void psel_atmost_one();
    if($onehot0(intf.psel)) 
      `uvm_info(get_type_name(),"AT MOST ONE SLAVE IS ACTIVE",UVM_HIGH)
    else                 
      `uvm_error("ERROR","MORE THAN ONE SLAVE IS ACTIVE")
  endfunction
  
  virtual function void valid_address();
    if(intf.paddr<MEM_SIZE) 
      `uvm_info("VALID ADDRESS","ADDRESS IS IN RANGE",UVM_HIGH)
    else                 
      `uvm_error("ERROR","OUT OF RANGE ADDRESS")
  endfunction
  endclass
