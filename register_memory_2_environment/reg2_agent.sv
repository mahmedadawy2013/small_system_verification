class reg2_agent extends uvm_agent;
`uvm_component_utils(reg2_agent)
reg2_monitor   monitor_instance;
reg2_driver    driver_instance;
reg2_sequencer sequencer_instance; 
reg2_agent_config reg_agent_config_instance;
uvm_analysis_port #(reg2_sequence_item) analysis_port_env_to_fifo;

function  new(string name = "REG2_AGENT", uvm_component parent = null);
    super.new(name,parent) ; 
endfunction 

function void build_phase(uvm_phase phase);
    super.build_phase(phase) ;
    `uvm_info("AGENT","WE Are Compiling The agent",UVM_NONE) ;
    analysis_port_env_to_fifo = new("analysis_port_env_to_fifo",this);

    if(!uvm_config_db #(reg2_agent_config)::get(this,"","reg2_agent_config",reg_agent_config_instance))
        `uvm_info("AGENT","ERROR INSIDE AGENT",UVM_NONE);

    monitor_instance   = reg2_monitor::type_id::create("monitor_instance",this); 
    if (reg_agent_config_instance.is_active == UVM_ACTIVE ) begin 
        driver_instance    = reg2_driver::type_id::create("driver_instance",this); 
        sequencer_instance = reg2_sequencer::type_id::create("sequencer_instance",this); 
    end 
endfunction

function void connect_phase(uvm_phase phase);
    super.connect_phase(phase) ; 
    if (reg_agent_config_instance.is_active == UVM_ACTIVE ) begin 
        driver_instance.seq_item_port.connect(sequencer_instance.seq_item_export);
    end 
    monitor_instance.mon_mail.connect(analysis_port_env_to_fifo) ; 

endfunction

task run_phase (uvm_phase phase) ; 

    `uvm_info("AGENT","WE ARE RUNNING THE AGENT",UVM_NONE);

endtask 




endclass