//  Class: agent_config
//
class uart_agent_config extends uvm_object;
    `uvm_object_utils(uart_agent_config);

    //  Group: Variables
    uvm_active_passive_enum is_active = UVM_PASSIVE;

    //  Constructor: new
    function new(string name = "UART_AGENT_CONFIG");
        super.new(name);
    endfunction: new
    
endclass: uart_agent_config

class uart_agent_config_local extends uart_agent_config;
    `uvm_object_utils(uart_agent_config_local);

    //  Group: Variables

    //  Constructor: new
    function new(string name = "UART_AGENT_CONFIG_LOCAL");
        super.new(name);
        is_active = UVM_ACTIVE;
    endfunction: new
    
endclass: uart_agent_config_local

