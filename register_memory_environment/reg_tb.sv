module tb ()  ;

    import uvm_pkg::*;  
    import pack1::*;
    reg_intf intf1(); 
    reg_env_config_local reg_env_conf1     = reg_env_config_local::type_id::create("reg_env_conf1");
    reg_agent_config_local reg_agent_conf1 = reg_agent_config_local::type_id::create("reg_agent_conf1");
    RegFile REG_TEST (
    .clk        (intf1.clk_intf),
    .rst        (intf1.rst_intf), 
    .WrEn       (intf1.WrEn_intf),
    .RdEn       (intf1.RdEn_intf),
    .Address    (intf1.Address_intf),
    .WrData     (intf1.WrData_intf),
    .RdData     (intf1.RdData_intf)
    ) ; 
    initial begin 
        intf1.clk_intf = 1 ; 
    end  

    always  begin
       #5 intf1.clk_intf = ~ intf1.clk_intf ; 
    end

    initial begin
        uvm_config_db #(virtual reg_intf)::set(null,"*","reg_my_vif",intf1) ; 
        uvm_config_db #(reg_env_config)::set(null,"uvm_test_top.environment_instance","reg_env_config",reg_env_conf1) ; 
        uvm_config_db #(reg_agent_config)::set(null,"uvm_test_top.environment_instance.agent_instance","reg_agent_config",reg_agent_conf1) ; 
        run_test("reg_test_custoum") ; 
    end 
endmodule