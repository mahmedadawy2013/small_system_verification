class top_environment extends uvm_env;
`uvm_component_utils(top_environment)
top_scoreboard   scoreboard_instance;
top_subscriber   subscriber_inscance; 
top_agent        agent_instance; 
reg_agent        reg_agent_instance;
reg2_agent       reg2_agent_instance;
alu_agent        alu_agent_instance;
parent_sequencer parent_sequencer_instance;

function  new(string name = "ENVIRONMENT", uvm_component parent = null);
    super.new(name,parent) ; 
endfunction 

function void build_phase(uvm_phase phase);
    super.build_phase(phase) ;
    `uvm_info("ENVIRONMENT","WE Are Compiling The Environment",UVM_NONE);

    agent_instance              = top_agent::type_id::create("agent_instance",this); 
    reg_agent_instance          = reg_agent::type_id::create("reg_agent_instance",this);
    reg2_agent_instance         = reg2_agent::type_id::create("reg2_agent_instance",this);
    alu_agent_instance          = alu_agent::type_id::create("alu_agent_instance",this);
    parent_sequencer_instance   = parent_sequencer::type_id::create("parent_sequencer_instance",this);
    scoreboard_instance         = top_scoreboard::type_id::create("scoreboard_instance",this); 
    subscriber_inscance         = top_subscriber::type_id::create("subscriber_inscance",this); 

endfunction

function void connect_phase(uvm_phase phase);
    super.connect_phase(phase) ; 
    parent_sequencer_instance.reg_sequencer_instance  = reg_agent_instance.sequencer_instance;
    parent_sequencer_instance.reg2_sequencer_instance = reg2_agent_instance.sequencer_instance;
    parent_sequencer_instance.top_sequencer_insatnce  = agent_instance.sequencer_instance;

    reg_agent_instance.analysis_port_env_to_fifo.connect(scoreboard_instance.reg_score_mail);
    reg2_agent_instance.analysis_port_env_to_fifo.connect(scoreboard_instance.reg2_score_mail);
    alu_agent_instance.alu_analysis_port_env_to_fifo.connect(scoreboard_instance.alu_score_mail);
    agent_instance.top_analysis_port_env_to_fifo.connect(scoreboard_instance.top_score_mail);
endfunction

task run_phase (uvm_phase phase) ; 

    `uvm_info("ENVIRONMENT","WE ARE RUNNING THE ENVIRONMENT",UVM_NONE);

endtask 



endclass