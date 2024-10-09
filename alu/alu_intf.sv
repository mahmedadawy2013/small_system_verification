interface  alu_intf(); 

    logic       CLK;
    logic [3:0] ALU_FUN; 
    logic [7:0] A; 
    logic [7:0] B;
    logic       RST; 
    bit         Arith_Flag; 
    bit   [15:0]ALU_OUT; 

endinterface

// used in binding but not working well 
// interface  alu_intf( 

//     input logic       CLK,
//     input logic [3:0] ALU_FUN, 
//     input logic [7:0] A, 
//     input logic [7:0] B,
//     input logic       RST, 
//     input bit         Arith_Flag, 
//     input bit   [15:0]ALU_OUT 
// );
// endinterface