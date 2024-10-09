class uart_agent extends uvm_agent;
`uvm_component_utils(uart_agent)
uart_monitor   monitor_instance;
uart_driver    driver_instance;
uart_sequencer sequencer_instance; 
uart_agent_config uart_agent_config_instance;
uvm_analysis_port #(uart_sequence_item) uart_analysis_port_env_to_fifo;

function  new(string name = "AGENT", uvm_component parent = null);
    super.new(name,parent) ; 
endfunction 

function void build_phase(uvm_phase phase);
    super.build_phase(phase) ;
    `uvm_info("AGENT","WE Are Compiling The agent",UVM_NONE) ;

    uart_analysis_port_env_to_fifo = new("uart_analysis_port_env_to_fifo",this);

    if(!uvm_config_db #(uart_agent_config)::get(this,"","uart_agent_config",uart_agent_config_instance))
        `uvm_info("AGENT","ERROR INSIDE AGENT",UVM_NONE);
    monitor_instance   = uart_monitor::type_id::create("monitor_instance",this); 
    if (uart_agent_config_instance.is_active == UVM_ACTIVE ) begin 
        driver_instance    = uart_driver::type_id::create("driver_instance",this); 
        sequencer_instance = uart_sequencer::type_id::create("sequencer_instance",this); 
    end 
endfunction

function void connect_phase(uvm_phase phase);
    super.connect_phase(phase) ; 
    if (uart_agent_config_instance.is_active == UVM_ACTIVE ) begin 
        driver_instance.seq_item_port.connect(sequencer_instance.seq_item_export);
    end 
    monitor_instance.mon_mail.connect(uart_analysis_port_env_to_fifo) ; 
endfunction

task run_phase (uvm_phase phase) ; 

    `uvm_info("AGENT","WE ARE RUNNING THE AGENT",UVM_NONE);

endtask 




endclass