//  Class: env_config
//
class uart_env_config extends uvm_object;
    `uvm_object_utils(uart_env_config);

    //  Group: Variables
    bit has_scoreboard = 1'b1 ;
    bit has_subscriber = 1'b1 ;


    //  Constructor: new
    function new(string name = "UART_ENV_CONFIG");
        super.new(name);
    endfunction: new
    
endclass: uart_env_config

class uart_env_config_local extends uart_env_config;
    `uvm_object_utils(uart_env_config_local);

    //  Constructor: new
    function new(string name = "UART_ENV_CONFIG_LOCAL");
        super.new(name);
        has_scoreboard = 1'b1;
        has_subscriber = 1'b1;
    endfunction: new
    
endclass: uart_env_config_local