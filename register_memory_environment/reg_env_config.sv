//  Class: env_config
//
class reg_env_config extends uvm_object;
    `uvm_object_utils(reg_env_config);

    //  Group: Variables
    bit has_scoreboard = 1'b1 ;
    bit has_subscriber = 1'b1 ;


    //  Constructor: new
    function new(string name = "ALU_ENV_CONFIG");
        super.new(name);
    endfunction: new
    
endclass: reg_env_config

class reg_env_config_local extends reg_env_config;
    `uvm_object_utils(reg_env_config_local);

    //  Constructor: new
    function new(string name = "ALU_ENV_CONFIG_LOCAL");
        super.new(name);
        has_scoreboard = 1'b1;
        has_subscriber = 1'b1;
    endfunction: new
    
endclass: reg_env_config_local