class alu_environment extends uvm_env;
`uvm_component_utils(alu_environment)
alu_scoreboard scoreboard_instance;
alu_subscriber subscriber_inscance; 
alu_agent      agent_instance; 
alu_env_config alu_env_config_instance;


function  new(string name = "REG_ENVIRONMENT", uvm_component parent = null);
    super.new(name,parent) ; 
endfunction 

function void build_phase(uvm_phase phase);
    super.build_phase(phase) ;
    `uvm_info("ENVIRONMENT","WE Are Compiling The Environment",UVM_NONE);

    if(!uvm_config_db #(alu_env_config)::get(this,"","alu_env_config",alu_env_config_instance))
        `uvm_info("ENV","ERROR INSIDE ENVIRONMENT",UVM_NONE);

    if (alu_env_config_instance.has_scoreboard == 1 ) begin 
        scoreboard_instance = alu_scoreboard::type_id::create("scoreboard_instance",this); 
    end 
    if (alu_env_config_instance.has_subscriber == 1) begin 
        subscriber_inscance = alu_subscriber::type_id::create("subscriber_inscance",this); 
    end 
    agent_instance      = alu_agent::type_id::create("agent_instance",this); 


endfunction

function void connect_phase(uvm_phase phase);
    super.connect_phase(phase) ; 
    if (alu_env_config_instance.has_scoreboard == 1 ) begin 
        agent_instance.alu_analysis_port_env_to_fifo.connect(scoreboard_instance.alu_score_mail);
    end 
    if (alu_env_config_instance.has_subscriber == 1) begin 
        // agent_instance.monitor_instance.mon_mail.connect(subscriber_inscance.subs_mail)  ; 
    end 

endfunction

task run_phase (uvm_phase phase) ; 

    `uvm_info("ENVIRONMENT","WE ARE RUNNING THE ENVIRONMENT",UVM_NONE);

endtask 



endclass