class reg_environment extends uvm_env;
`uvm_component_utils(reg_environment)
reg_scoreboard scoreboard_instance;
reg_subscriber subscriber_inscance; 
reg_agent      agent_instance; 
reg_env_config reg_env_config_instance;
// uvm_analysis_port #(reg_sequence_item) analysis_port_env_to_fifo;



function  new(string name = "REG_ENVIRONMENT", uvm_component parent = null);
    super.new(name,parent) ; 
endfunction 

function void build_phase(uvm_phase phase);
    super.build_phase(phase) ;
    `uvm_info("ENVIRONMENT","WE Are Compiling The Environment",UVM_NONE);

    // analysis_port_env_to_fifo = new("analysis_port_env_to_fifo",this);
    
    if(!uvm_config_db #(reg_env_config)::get(this,"","reg_env_config",reg_env_config_instance))
        `uvm_info("ENV","ERROR INSIDE ENVIRONMENT",UVM_NONE);

    if (reg_env_config_instance.has_scoreboard == 1 ) begin 
        scoreboard_instance = reg_scoreboard::type_id::create("scoreboard_instance",this); 
    end 
    if (reg_env_config_instance.has_subscriber == 1) begin 
        subscriber_inscance = reg_subscriber::type_id::create("subscriber_inscance",this); 
    end 
    agent_instance      = reg_agent::type_id::create("agent_instance",this)            ; 

endfunction

function void connect_phase(uvm_phase phase);
    super.connect_phase(phase) ; 
    if (reg_env_config_instance.has_scoreboard == 1 ) begin 
        agent_instance.analysis_port_env_to_fifo.connect(scoreboard_instance.reg_score_mail);
    end 
    if (reg_env_config_instance.has_subscriber == 1) begin 
        agent_instance.monitor_instance.mon_mail.connect(subscriber_inscance.subs_mail)  ; 
    end 
endfunction

task run_phase (uvm_phase phase) ; 

    `uvm_info("ENVIRONMENT","WE ARE RUNNING THE ENVIRONMENT",UVM_NONE);

endtask 



endclass

