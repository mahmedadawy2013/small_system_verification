module ALU (
  input wire [7:0]  A, B,
  input wire [3:0]  ALU_FUN,
  input wire        CLK,
  input wire        RST,
  output reg        Arith_Flag, 
  output reg [15:0] ALU_OUT
 
);
  
//internal_signals  
  reg [15:0] ALU_OUT_Comb;
  
always @(posedge CLK or negedge RST)
  if (!RST)
  begin 
    ALU_OUT    <= 0 ; 
    Arith_Flag <= 0 ; 
  end 

 else begin
   ALU_OUT = ALU_OUT_Comb;
 end  
  
always @(*)
  begin
     Arith_Flag = 1'b0 ;
	 ALU_OUT_Comb = 1'b0 ;
    case (ALU_FUN) 
    4'b0000: begin
               ALU_OUT_Comb = A+B;
			   Arith_Flag = 1'b1 ;
              end
    4'b0001: begin
               ALU_OUT_Comb = A-B;
			   Arith_Flag = 1'b1 ;
              end
    4'b0010: begin
               ALU_OUT_Comb = A*B;
			   Arith_Flag = 1'b1 ;
              end
    4'b0011: begin
               ALU_OUT_Comb = A/B;
			   Arith_Flag = 1'b1 ;
              end
    default: begin
	           Arith_Flag = 1'b0 ;
               ALU_OUT_Comb = 16'b0;
             end
    endcase
  end
  
  

endmodule