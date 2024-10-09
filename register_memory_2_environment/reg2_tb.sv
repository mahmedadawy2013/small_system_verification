module tb ()  ;

    import uvm_pkg::*;  
    import pack1::*;
    reg2_intf intf1(); 
    reg2_env_config_local reg2_env_conf1     = reg2_env_config_local::type_id::create("reg2_env_conf1");
    reg2_agent_config_local reg2_agent_conf1 = reg2_agent_config_local::type_id::create("reg2_agent_conf1");
    RegFile REG_TEST (
    .clk        (intf1.clk_intf)     ,
    .rst        (intf1.rst_intf)     , 
    .WrEn       (intf1.WrEn_intf)    ,
    .RdEn       (intf1.RdEn_intf)    ,
    .Address    (intf1.Address_intf) ,
    .WrData     (intf1.WrData_intf)  ,
    .RdData     (intf1.RdData_intf)
    ) ; 
    initial begin 
        intf1.clk_intf = 1 ; 
    end  

    always  begin
       #5 intf1.clk_intf = ~ intf1.clk_intf ; 
    end

    initial begin
        uvm_config_db #(virtual reg2_intf)::set(null,"*","reg2_my_vif",intf1) ; 
        uvm_config_db #(reg2_env_config)::set(null,"uvm_test_top.environment_instance","reg2_env_config",reg2_env_conf1) ; 
        uvm_config_db #(reg2_agent_config)::set(null,"uvm_test_top.environment_instance.agent_instance","reg2_agent_config",reg2_agent_conf1) ; 
        run_test("reg2_test") ; 
    end 
endmodule