module tb ()  ;

    import uvm_pkg::*;  
    import pack1::*;
    uart_intf intf1(); 
    uart_env_config_local uart_env_conf     = uart_env_config_local::type_id::create("uart_env_conf");
    uart_agent_config_local uart_agent_conf = uart_agent_config_local::type_id::create("uart_agent_conf");
    UART_TX UART_TX_INSTANCE (
        .CLK           (intf1.CLK),
        .RST           (intf1.RST),
        .P_DATA        (intf1.P_DATA),
        .Data_Valid    (intf1.Data_Valid),
        .parity_enable (intf1.parity_enable),
        .parity_type   (intf1.parity_type),
        .TX_OUT        (intf1.TX_OUT),
        .busy          (intf1.busy)          
    ); 

    initial begin 
        intf1.CLK = 1 ; 
    end  

    always  begin
       #5 intf1.CLK= ~ intf1.CLK; 
    end

    initial begin
        uvm_config_db #(virtual uart_intf)::set(null,"*","my_vif",intf1) ; 
        uvm_config_db #(uart_env_config)::set(null,"uvm_test_top.environment_instance","uart_env_config",uart_env_conf); 
        uvm_config_db #(uart_agent_config)::set(null,"uvm_test_top.environment_instance.agent_instance","uart_agent_config",uart_agent_conf); 
        run_test("uart_test") ; 
    end 
endmodule