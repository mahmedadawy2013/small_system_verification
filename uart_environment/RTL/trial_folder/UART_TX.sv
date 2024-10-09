package my_pkg1;
`timescale 1ns/10ps 
endpackage
module parity_calc # ( parameter WIDTH = 8 )

(
 input   wire                  CLK,
 input   wire                  RST,
 input   wire                  parity_enable,
 input   wire                  parity_type,
 input   wire   [WIDTH-1:0]    DATA,
 input   wire                  Data_Valid,
 output  reg                   parity 
);

reg  [WIDTH-1:0]    DATA_V ;

//isolate input 
always @ (posedge CLK or negedge RST)
 begin
  if(!RST)
   begin
    DATA_V <= 'b0 ;
   end
  else if(Data_Valid)
   begin
    DATA_V <= DATA ;
   end 
 end
 

always @ (posedge CLK or negedge RST)
 begin
  if(!RST)
   begin
    parity <= 'b0 ;
   end
  else
   begin
    if (parity_enable)
	 begin
	  case(parity_type)
	  1'b0 : begin                 
	          parity <= ^DATA_V  ;     // Even Parity
	         end
	  1'b1 : begin
	          parity <= ~^DATA_V ;     // Odd Parity
	         end		
	  endcase       	 
	 end
   end
 end 


endmodule
 
module mux  (

 input   wire                  CLK,
 input   wire                  RST,
 input   wire                  IN_0,
 input   wire                  IN_1,
 input   wire                  IN_2,
 input   wire                  IN_3,
 input   wire     [1:0]        SEL,
 output  reg                   OUT 

 );

reg              mux_out ;
 
always @ (*)
  begin
   case(SEL)
	2'b00 : begin                 
	         mux_out <= IN_0 ;       
	        end
	2'b01 : begin
	         mux_out <= IN_1 ;      
	        end	
	2'b10 : begin
	         mux_out <= IN_2 ;       
	        end	
	2'b11 : begin
	         mux_out <= IN_3 ;      
	        end		
	endcase        	   
  end
 

//register mux output
always @ (posedge CLK or negedge RST)
 begin
  if(!RST)
   begin
    OUT <= 'b0 ;
   end
  else
   begin
    OUT <= mux_out ;
   end 
 end  
 
 
endmodule


module UART_TX  (
`timescale 1ns/10fs 
 input   wire                  CLK,
 input   wire                  RST,
 input   wire     [7:0]        P_DATA,
 input   wire                  Data_Valid,
 input   wire                  parity_enable,
 input   wire                  parity_type, 
 output  wire                  TX_OUT,
 output  wire                  busy               

 );

wire          seriz_en    , 
              seriz_done  ,
		 	  ser_data    ,
		 	  parity      ;
			
wire  [1:0]   mux_sel ;
 
uart_tx_fsm  U0_fsm (
.CLK(CLK),
.RST(RST),
.Data_Valid(Data_Valid), 
.parity_enable(parity_enable),
.ser_done(seriz_done), 
.Ser_enable(seriz_en),
.mux_sel(mux_sel),
.busy(busy)
);

Serializer U0_Serializer (
.CLK(CLK),
.RST(RST),
.DATA(P_DATA),
.Busy(busy),
.Enable(seriz_en), 
.Data_Valid(Data_Valid), 
.ser_out(ser_data),
.ser_done(seriz_done)
);

mux U0_mux (
.CLK(CLK),
.RST(RST),
.IN_0(1'b0),
.IN_1(ser_data),
.IN_2(parity),
.IN_3(1'b1),
.SEL(mux_sel),
.OUT(TX_OUT) 
);

parity_calc U0_parity_calc (
.CLK(CLK),
.RST(RST),
.parity_enable(parity_enable),
.parity_type(parity_type),
.DATA(P_DATA),
.Data_Valid(Data_Valid), 
.parity(parity)
); 



endmodule
 
 
module uart_tx_fsm  (

 input   wire                  CLK,
 input   wire                  RST,
 input   wire                  Data_Valid, 
 input   wire                  ser_done, 
 input   wire                  parity_enable, 
 output  reg                   Ser_enable,
 output  reg     [1:0]         mux_sel, 
 output  reg                   busy
);


// gray state encoding
parameter   [2:0]      IDLE   = 3'b000,
                       start  = 3'b001,
					   data   = 3'b011,
					   parity = 3'b010,
					   stop   = 3'b110 ;

reg         [2:0]      current_state , next_state ;
			

reg                    busy_c ;
			
//state transiton 
always @ (posedge CLK or negedge RST)
 begin
  if(!RST)
   begin
    current_state <= IDLE ;
   end
  else
   begin
    current_state <= next_state ;
   end
 end
 

// next state logic
always @ (*)
 begin
  case(current_state)
  IDLE   : begin
            if(Data_Valid)
			 next_state = start ;
			else
			 next_state = IDLE ; 			
           end
  start  : begin
			 next_state = data ;  
           end
  data   : begin
            if(ser_done)
			 begin
			  if(parity_enable)
			   next_state = parity ;
              else
			   next_state = stop ;			  
			 end
			else
			 next_state = data ; 			
           end
  parity : begin
			 next_state = stop ; 
           end
  stop   : begin
			 next_state = IDLE ; 
           end	
  default: begin
			 next_state = IDLE ; 
           end	
  endcase                 	   
 end 

 
// output logic
always @ (*)
 begin
     Ser_enable = 1'b0 ;
     mux_sel = 2'b00 ;	
     busy_c = 1'b0 ;
  case(current_state)
  IDLE   : begin
			Ser_enable = 1'b0 ;
            mux_sel = 2'b11 ;	
            busy_c = 1'b0 ;									
           end
  start  : begin
			Ser_enable = 1'b0 ;  
            busy_c = 1'b1 ;
            mux_sel = 2'b00 ;	
           end
  data   : begin 
			Ser_enable = 1'b1 ;    
            busy_c = 1'b1 ;
            mux_sel = 2'b01 ;	
            if(ser_done)
			 Ser_enable = 1'b0 ;  
			else
 			 Ser_enable = 1'b1 ;              			 
           end
  parity : begin
            busy_c = 1'b1 ;
            mux_sel = 2'b10 ;	
           end
  stop   : begin
            busy_c = 1'b1 ;
            mux_sel = 2'b11 ;			
           end		
  default: begin
            busy_c = 1'b0 ;
			Ser_enable = 1'b0 ;
            mux_sel = 2'b00 ;		
           end	
  endcase         	              
 end 
 
 

//register output 
always @ (posedge CLK or negedge RST)
 begin
  if(!RST)
   begin
    busy <= 1'b0 ;
   end
  else
   begin
    busy <= busy_c ;
   end
 end
  

endmodule
 
package my_pkg2;
`timescale 1ns/10ps 
endpackage
module Serializer # ( parameter WIDTH = 8 )

(
 input   wire                  CLK,
 input   wire                  RST,
 input   wire   [WIDTH-1:0]    DATA,
 input   wire                  Enable, 
 input   wire                  Busy,
 input   wire                  Data_Valid, 
 output  wire                  ser_out,
 output  wire                  ser_done
);

reg  [WIDTH-1:0]    DATA_V ;
reg  [2:0]          ser_count ;
              
//isolate input 
always @ (posedge CLK or negedge RST)
 begin
  if(!RST)
   begin
    DATA_V <= 'b0 ;
   end
  else if(Data_Valid && !Busy)
   begin
    DATA_V <= DATA ;
   end	
  else if(Enable)
   begin
    DATA_V <= DATA_V >> 1 ;         // shift register
   end
 end
 

//counter
always @ (posedge CLK or negedge RST)
 begin
  if(!RST)
   begin
    ser_count <= 'b0 ;
   end
  else
   begin
    if (Enable)
	 begin
      ser_count <= ser_count + 'b1 ;		 
	 end
	else 
	 begin
      ser_count <= 'b0 ;		 
	 end	
   end
 end 

assign ser_done = (ser_count == 'b111) ? 1'b1 : 1'b0 ;

assign ser_out = DATA_V[0] ;

endmodule
 