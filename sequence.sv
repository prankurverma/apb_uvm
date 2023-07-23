class apb_sequence extends uvm_sequence #(apb_sequence_item);
  `uvm_object_utils(apb_sequence)
  apb_sequence_item base_pkt;
  
  function new(string name="");
    super.new(name);
  endfunction
  
  task pre_body();
    base_pkt=apb_sequence_item::type_id::create("base_pkt");
  endtask
endclass
  
class apb_read_sequence extends apb_sequence;
  `uvm_object_utils(apb_read_sequence)
  
  function new(string name="");
    super.new(name);
  endfunction
  
  task body();
    repeat(50)begin
      start_item(base_pkt);
      assert(base_pkt.randomize() with {PWRITE == 1'bx;PADDR>12'b10x00;PADDR<2000;PWDATA==32'b1xxz10;});
      finish_item(base_pkt);
      get_response(base_pkt);
    end
      
    repeat(10)begin
      start_item(base_pkt);
      assert(base_pkt.randomize() with {PWRITE==0;PADDR>1000;PADDR<2000;});
      finish_item(base_pkt);
      get_response(base_pkt);
    end
  endtask
endclass
    
class apb_write_read_sequence extends apb_sequence;
  `uvm_object_utils(apb_write_read_sequence)
  
  function new(string name="");
    super.new(name);
  endfunction
  
  task body();
    begin
      repeat(10) begin
        start_item(base_pkt);
        assert(base_pkt.randomize() with {PWRITE==1;PADDR==60;PWDATA==82919;});
        finish_item(base_pkt);
        get_response(base_pkt);
      end
      
      repeat(10) begin
        start_item(base_pkt);
        assert(base_pkt.randomize with {PWRITE==0;PADDR==60;});
        finish_item(base_pkt);
        get_response(base_pkt);
      end
      
    end
  endtask
endclass
      
class apb_write_read_rand_sequence extends apb_sequence;
  `uvm_object_utils(apb_write_read_rand_sequence)
  
  function new(string name="");
  super.new(name);
  endfunction
  
  task body();
    begin
      repeat(100)begin
        start_item(base_pkt);
        assert(base_pkt.randomize() with {PWRITE==1;PADDR>400;PADDR<470;});
        finish_item(base_pkt);
        get_response(base_pkt);
      end
      repeat(100)begin
        start_item(base_pkt);
        assert(base_pkt.randomize() with {PWRITE==0;PADDR>400;PADDR<420;});
        finish_item(base_pkt);
        get_response(base_pkt);
      end
      repeat(100)begin
        start_item(base_pkt);
        assert(base_pkt.randomize() with {PWRITE==0;PADDR>400;PADDR<500;});
        finish_item(base_pkt);
        get_response(base_pkt);
      end
    end
  endtask
endclass
      
      
class apb_monitor_check_sequence extends apb_sequence;
 `uvm_object_utils(apb_monitor_check_sequence)
  
  function new(string name="");
  super.new(name);
  endfunction
  
  task body();
    begin
      repeat(10)begin
        start_item(base_pkt);
        assert(base_pkt.randomize() with {PWRITE==1'bx;PADDR>20'o1x200;PADDR<4700;});
        finish_item(base_pkt);
        get_response(base_pkt);
      end
      repeat(10)begin
        start_item(base_pkt);
        assert(base_pkt.randomize() with {PWRITE==1'bx;PADDR>20'o1x500;PADDR<5000;});
        finish_item(base_pkt);
        get_response(base_pkt);
      end
    end
  endtask
endclass
      
      
class apb_err_sequence extends apb_sequence;
  `uvm_object_utils(apb_err_sequence)
  
  function new(string name="");
    super.new(name);
  endfunction
  
  task body();
    begin
      repeat(20)begin
        start_item(base_pkt);
        assert(base_pkt.randomize() with {PWRITE==1;PADDR>70000;});
        finish_item(base_pkt);
        get_response(base_pkt);
      end
      repeat(20)begin
        start_item(base_pkt);
        assert(base_pkt.randomize() with {PWRITE==0;PADDR>70000;});
        finish_item(base_pkt);
        get_response(base_pkt);
      end
    end 
  endtask
endclass
      
class apb_wr7_sequence extends apb_sequence;
  `uvm_object_utils(apb_wr7_sequence)
  
  function new(string name="");
    super.new(name);
  endfunction
  
  task body();
    begin
      repeat(10)begin
        start_item(base_pkt);
        assert(base_pkt.randomize() with {PWRITE==1;PADDR==9428;PWDATA==372837;});
        finish_item(base_pkt);
        get_response(base_pkt);
      end
        
      repeat(10)begin
        start_item(base_pkt);
        assert(base_pkt.randomize() with {PWRITE==1;PADDR==9428;PWDATA==8347386;});
        finish_item(base_pkt);
        get_response(base_pkt);
      end
        
      repeat(15)begin
        start_item(base_pkt);
        assert(base_pkt.randomize() with {PWRITE==0;PADDR==9428;});
        finish_item(base_pkt);
        get_response(base_pkt);
      end
    end
  endtask
endclass
      
class apb_wr8_sequence extends apb_sequence;
  `uvm_object_utils(apb_wr8_sequence)
  
  function new(string name="");
    super.new(name);
  endfunction
  
  task body();
    begin
      repeat(10)begin
        start_item(base_pkt);
        assert(base_pkt.randomize() with {PWRITE==0;PADDR==999999428;});
        finish_item(base_pkt);
        get_response(base_pkt);
      end
      repeat(10)begin
        start_item(base_pkt);
        assert(base_pkt.randomize() with {PWRITE==0;PADDR==9428;});
        finish_item(base_pkt);
        get_response(base_pkt);
      end
      repeat(10)begin
        start_item(base_pkt);
        assert(base_pkt.randomize() with {PWRITE==1;PADDR==9428;PWDATA==8347386;});
        finish_item(base_pkt);
        get_response(base_pkt);
      end
      repeat(10)begin
        start_item(base_pkt);
        assert(base_pkt.randomize() with {PWRITE==0;PADDR==9428;});
        finish_item(base_pkt);
        get_response(base_pkt);
      end
    end
  endtask
endclass      
