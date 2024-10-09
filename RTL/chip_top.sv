module chip_top(
    input wire             clk_top,
    input wire             rst_top,
    input wire             sel_top,
    output reg [19:0]      mux_out_top
       
);

wire [19:0] ALU_IN;
wire [19:0] reg_mem_out_to_mux;
wire [15:0] alu_out_to_mux;

RegFile REGFILE_INSTANCE (
.clk(),
.rst(),
.WrEn(),
.RdEn(),
.Address(),
.WrData(),
.RdData(ALU_IN)
);
RegFile REGFILE_INSTANCE2 (
.clk(),
.rst(),
.WrEn(),
.RdEn(),
.Address(),
.WrData(),
.RdData(reg_mem_out_to_mux)
);		
//RegFile REGFILE_INSTANCE (
//.clk(clk_top),
//.rst(rst_top),
//.WrEn(WrEn_top),
//.RdEn(RdEn_top),
//.Address(Address_top),
//.WrData(WrData_top),
//.RdData(ALU_IN)
//);
ALU ALU_INSTANCE(
   .A(ALU_IN[7:0]),
   .B(ALU_IN[15:8]),
   .ALU_FUN(ALU_IN[19:16]),
   .CLK(clk_top),
   .RST(rst_top),
   .Arith_Flag(), 
   .ALU_OUT(alu_out_to_mux)
);

top_mux MUX_INSTANCE (
.sel (sel_top),
.alu_out (alu_out_to_mux),
.reg_out (reg_mem_out_to_mux),
.mux_out(mux_out_top)
);
endmodule

// module tb_rtl(
//     /* port_list */
// );
//     initial begin 
//         #10;
//         $finish();
//     end 
// endmodule