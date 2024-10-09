class uart_environment extends uvm_env;
`uvm_component_utils(uart_environment)
uart_scoreboard scoreboard_instance;
uart_subscriber subscriber_inscance; 
uart_agent      agent_instance; 
uart_env_config uart_env_config_instance;

function  new(string name = "ENVIRONMENT", uvm_component parent = null);
    super.new(name,parent) ; 
endfunction 

function void build_phase(uvm_phase phase);
    super.build_phase(phase) ;
    `uvm_info("ENVIRONMENT","WE Are Compiling The Environment",UVM_NONE);
    if(!uvm_config_db #(uart_env_config)::get(this,"","uart_env_config",uart_env_config_instance))
        `uvm_info("ENV","ERROR INSIDE ENVIRONMENT",UVM_NONE);

    if (uart_env_config_instance.has_scoreboard == 1 ) begin 
        scoreboard_instance = uart_scoreboard::type_id::create("scoreboard_instance",this); 
    end 
    if (uart_env_config_instance.has_subscriber == 1) begin 
        subscriber_inscance = uart_subscriber::type_id::create("subscriber_inscance",this); 
    end 
    agent_instance      = uart_agent::type_id::create("agent_instance",this); 


endfunction

function void connect_phase(uvm_phase phase);
    super.connect_phase(phase); 
    if (uart_env_config_instance.has_scoreboard == 1 ) begin 
        agent_instance.uart_analysis_port_env_to_fifo.connect(scoreboard_instance.uart_score_mail);
    end 
    if (uart_env_config_instance.has_subscriber == 1) begin 
        agent_instance.monitor_instance.mon_mail.connect(subscriber_inscance.subs_mail); 
    end 
endfunction

task run_phase (uvm_phase phase) ; 

    `uvm_info("ENVIRONMENT","WE ARE RUNNING THE ENVIRONMENT",UVM_NONE);

endtask 



endclass