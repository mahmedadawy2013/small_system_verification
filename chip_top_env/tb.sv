module tb ();

    import uvm_pkg::*;  
    import pack1::*;
    top_intf intf1(); 
   
    alu_intf alu_intf_instance();
    reg_intf reg_intf_instance();
    reg_agent_config reg_agent_conf1   = reg_agent_config_local::type_id::create("reg_agent_conf1");
    reg2_agent_config reg2_agent_conf1 = reg2_agent_config_local::type_id::create("reg2_agent_conf1");
    alu_agent_config alu_agent_conf1   = alu_agent_config::type_id::create("alu_agent_conf1");
    

    chip_top TOP_INSTANCE (
        .clk_top(intf1.clk_top_intf),
        .rst_top(intf1.rst_top_intf),
        .sel_top(intf1.sel_top_intf),
        .mux_out_top(intf1.mux_out_top_intf)
    ) ; 

    bind TOP_INSTANCE.REGFILE_INSTANCE reg_intf IF_REG(
        .clk_intf(clk),
        .rst_intf(rst),
        .WrEn_intf(WrEn),
        .RdEn_intf(RdEn),
        .Address_intf(Address),
        .WrData_intf(WrData),
        .RdData_intf(RdData)
    );

    bind TOP_INSTANCE.REGFILE_INSTANCE2 reg2_intf IF2_REG(
        .clk_intf(clk),
        .rst_intf(rst),
        .WrEn_intf(WrEn),
        .RdEn_intf(RdEn),
        .Address_intf(Address),
        .WrData_intf(WrData),
        .RdData_intf(RdData)
    );

    assign alu_intf_instance.CLK           = TOP_INSTANCE.ALU_INSTANCE.CLK;       
    assign alu_intf_instance.ALU_FUN       = TOP_INSTANCE.ALU_INSTANCE.ALU_FUN;   
    assign alu_intf_instance.A             = TOP_INSTANCE.ALU_INSTANCE.A;         
    assign alu_intf_instance.B             = TOP_INSTANCE.ALU_INSTANCE.B;         
    assign alu_intf_instance.RST           = TOP_INSTANCE.ALU_INSTANCE.RST;       
    assign alu_intf_instance.Arith_Flag    = TOP_INSTANCE.ALU_INSTANCE.Arith_Flag;
    assign alu_intf_instance.ALU_OUT       = TOP_INSTANCE.ALU_INSTANCE.ALU_OUT; 

    // bind TOP_INSTANCE.ALU_INSTANCE alu_intf IF_ALU(
    // .CLK(CLK),          
    // .ALU_FUN(ALU_FUN),      
    // .A(A),            
    // .B(B),            
    // .RST(RST),          
    // .Arith_Flag(Arith_Flag),   
    // .ALU_OUT(ALU_OUT)      
    // );

    // always_comb begin 
    //     if (force_enable == 1) begin 
    //         force alu_intf_instance.CLK           = TOP_INSTANCE.ALU_INSTANCE.CLK;       
    //         force alu_intf_instance.ALU_FUN       = TOP_INSTANCE.ALU_INSTANCE.ALU_FUN;   
    //         force alu_intf_instance.A             = TOP_INSTANCE.ALU_INSTANCE.A;         
    //         force alu_intf_instance.B             = TOP_INSTANCE.ALU_INSTANCE.B;         
    //         force alu_intf_instance.RST           = TOP_INSTANCE.ALU_INSTANCE.RST;       
    //               alu_intf_instance.Arith_Flag    = TOP_INSTANCE.ALU_INSTANCE.Arith_Flag; 
    //               alu_intf_instance.ALU_OUT       = TOP_INSTANCE.ALU_INSTANCE.ALU_OUT; 
    //     end  
    //     else begin
    //         release alu_intf_instance.CLK;
    //         release alu_intf_instance.ALU_FUN;
    //         release alu_intf_instance.A;
    //         release alu_intf_instance.B;
    //         release alu_intf_instance.RST;
    //     end 
    // end
    initial begin 
        intf1.clk_top_intf = 1 ; 
        TOP_INSTANCE.REGFILE_INSTANCE.IF_REG.clk_intf = 1;
        TOP_INSTANCE.REGFILE_INSTANCE2.IF2_REG.clk_intf = 1;
        // reg_intf_instance.clk_intf = 1;
    end  

    always  begin
       #5 intf1.clk_top_intf = ~ intf1.clk_top_intf;
    end
    always begin 
        #5  TOP_INSTANCE.REGFILE_INSTANCE.IF_REG.clk_intf =  ~ TOP_INSTANCE.REGFILE_INSTANCE.IF_REG.clk_intf ;
        // #5  reg_intf_instance.clk_intf =  ~ reg_intf_instance.clk_intf ; not working 
    end 
    always begin 
        #5  TOP_INSTANCE.REGFILE_INSTANCE2.IF2_REG.clk_intf =  ~ TOP_INSTANCE.REGFILE_INSTANCE2.IF2_REG.clk_intf ;
    end 

    initial begin
        uvm_config_db #(virtual top_intf)::set(null,"*","my_vif",intf1); 
        // uvm_config_db #(virtual reg_intf)::set(null,"*","reg_my_vif",reg_intf_instance);  not working 
        uvm_config_db #(virtual reg_intf)::set(null,"*","reg_my_vif",TOP_INSTANCE.REGFILE_INSTANCE.IF_REG); 
        uvm_config_db #(virtual reg2_intf)::set(null,"*","reg2_my_vif",TOP_INSTANCE.REGFILE_INSTANCE2.IF2_REG); 
        uvm_config_db #(virtual alu_intf)::set(null,"*","alu_my_vif",alu_intf_instance);
        // uvm_config_db #(virtual alu_intf)::set(null,"*","alu_my_vif",TOP_INSTANCE.ALU_INSTANCE.IF_ALU); // not working well 

        uvm_config_db #(reg_agent_config)::set(null,"uvm_test_top.environment_instance.reg_agent_instance","reg_agent_config",reg_agent_conf1); 
        uvm_config_db #(reg2_agent_config)::set(null,"uvm_test_top.environment_instance.reg2_agent_instance","reg2_agent_config",reg2_agent_conf1); 
        uvm_config_db #(alu_agent_config)::set(null,"uvm_test_top.environment_instance.alu_agent_instance","alu_agent_config",alu_agent_conf1);
        run_test("top_test"); 
    end 

    initial begin 
        #5;
        intf1.rst_top_intf = 0; 
        #10;
        intf1.rst_top_intf = 1; 
    end 
endmodule