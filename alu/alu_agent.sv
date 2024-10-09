class alu_agent extends uvm_agent;
`uvm_component_utils(alu_agent)
alu_monitor   monitor_instance;
alu_driver    driver_instance;
alu_sequencer sequencer_instance; 
alu_agent_config alu_agent_config_instance;
uvm_analysis_port #(alu_sequence_item) alu_analysis_port_env_to_fifo;

function  new(string name = "ALU_AGENT", uvm_component parent = null);
    super.new(name,parent) ; 
endfunction 

function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("AGENT","WE Are Compiling The agent",UVM_NONE) ;

    alu_analysis_port_env_to_fifo = new("alu_analysis_port_env_to_fifo",this);

    if(!uvm_config_db #(alu_agent_config)::get(this,"","alu_agent_config",alu_agent_config_instance))
        `uvm_info("AGENT","ERROR INSIDE AGENT",UVM_NONE);

    uvm_config_db #(alu_agent_config )::set(this,"monitor_instance","simulation_config",alu_agent_config_instance) ; 

    monitor_instance   = alu_monitor::type_id::create("monitor_instance",this); 

    if (alu_agent_config_instance.is_active == UVM_ACTIVE ) begin 
        driver_instance    = alu_driver::type_id::create("driver_instance",this); 
        sequencer_instance = alu_sequencer::type_id::create("sequencer_instance",this); 
    end 
endfunction

function void connect_phase(uvm_phase phase);
    super.connect_phase(phase); 
    monitor_instance.mon_mail.connect(alu_analysis_port_env_to_fifo); 
    
    if (alu_agent_config_instance.is_active == UVM_ACTIVE ) begin 
        driver_instance.seq_item_port.connect(sequencer_instance.seq_item_export);

    
    end 
endfunction

task run_phase (uvm_phase phase) ; 

    `uvm_info("AGENT","WE ARE RUNNING THE AGENT",UVM_NONE);

endtask 




endclass