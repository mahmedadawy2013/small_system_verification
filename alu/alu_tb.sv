module tb ()  ;

    import uvm_pkg::*;  
    import pack1::*;
    alu_intf intf1(); 
    alu_env_config_local alu_env_conf1     = alu_env_config_local::type_id::create("alu_env_conf1");
    alu_agent_config_local alu_agent_conf1 = alu_agent_config_local::type_id::create("alu_agent_conf1");


    ALU ALU_INSTANCE (
    .CLK        (intf1.CLK),
    .RST        (intf1.RST), 
    .A          (intf1.A),
    .B          (intf1.B),
    .ALU_FUN    (intf1.ALU_FUN),
    .Arith_Flag (intf1.Arith_Flag),
    .ALU_OUT    (intf1.ALU_OUT)
    ) ; 
    initial begin 
        intf1.CLK = 1 ; 
    end  

    always  begin
       #5 intf1.CLK = ~ intf1.CLK ; 
    end

    initial begin
        uvm_config_db #(virtual alu_intf)::set(null,"*","alu_my_vif",intf1) ; 
        uvm_config_db #(alu_env_config)::set(null,"uvm_test_top.environment_instance","alu_env_config",alu_env_conf1) ; 
        uvm_config_db #(alu_agent_config)::set(null,"uvm_test_top.environment_instance.agent_instance","alu_agent_config",alu_agent_conf1) ; 
        run_test("alu_test") ; 
    end 
endmodule