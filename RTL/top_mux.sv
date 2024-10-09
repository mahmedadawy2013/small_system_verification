module top_mux #(
    /* parameters */
) (
    input wire sel ,
    input wire [15:0] alu_out ,
    input wire [19:0] reg_out ,
    output reg [19:0] mux_out
);

localparam MEMORY_OUT = 0 ; 
localparam ALU_OUT    = 1 ; 

    always @(*) begin 
        case (sel)
            MEMORY_OUT : mux_out = reg_out ;
            ALU_OUT    : mux_out = alu_out ;
        endcase
    end 
endmodule