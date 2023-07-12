module mem_apb(  
  input                        pclk,
  input                        prst,
  input                        penable,
  input                        psel,
  output logic                 pready,
  input                        pwrite,
  input [(ADDR_WIDTH-1):0]     paddr,
  input [(DATA_WIDTH-1):0]     pw_data,
  output logic [(DATA_WIDTH-1):0]pr_data,
  output logic                  pslverr);
    
  logic [(DATA_WIDTH-1):0] temp[((MEM_SIZE) - 1):0];
  integer i;
  
  always@(posedge pclk  or negedge prst or penable )
  begin
    if(prst==0)
   begin
   pr_data<=0; 
   pslverr<=0;
   pready<=0;
   for(i=0;i< (MEM_SIZE);i=i+1)
   begin
   temp[i]<=0;
   end
   end
   else begin
              if(!psel && !penable) begin
                  pready = 0;
                  pslverr = 0;
                  end
              else if(psel && !penable)
                  begin
                  pready = 0;
                  pslverr = 0;
                  end
              else if(psel && penable) begin
                  pready=1;
                  if(pwrite ) begin
                      if(paddr < MEM_SIZE) begin
                       temp[paddr]=pw_data;
                       pslverr = 0;
                      end
                      else begin
                       pslverr = 1;
                      end
                      end
                  else if(!pwrite ) begin
                      if(paddr < MEM_SIZE) begin  
                          pr_data = temp[paddr];
                          pslverr = 0;
                          end
                      else begin
                          pslverr = 1;
                         end
                         end
                  
                    @(posedge pclk);
                      pready = 0;
                     end
                     end
                     end
      endmodule
  