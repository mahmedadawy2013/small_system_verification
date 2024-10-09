class top_agent extends uvm_agent;
`uvm_component_utils(top_agent)
top_monitor   monitor_instance;
top_driver    driver_instance;
top_sequencer sequencer_instance; 
uvm_analysis_port #(top_sequence_item) top_analysis_port_env_to_fifo;


function  new(string name = "AGENT", uvm_component parent = null);
    super.new(name,parent) ; 
endfunction 

function void build_phase(uvm_phase phase);
    super.build_phase(phase) ;
    `uvm_info("AGENT","WE Are Compiling The agent",UVM_NONE) ;

    top_analysis_port_env_to_fifo = new("top_analysis_port_env_to_fifo",this);
    monitor_instance              = top_monitor::type_id::create("monitor_instance",this); 
    driver_instance               = top_driver::type_id::create("driver_instance",this); 
    sequencer_instance            = top_sequencer::type_id::create("sequencer_instance",this); 
endfunction

function void connect_phase(uvm_phase phase);
    super.connect_phase(phase) ; 
    driver_instance.seq_item_port.connect(sequencer_instance.seq_item_export);
    monitor_instance.mon_mail.connect(top_analysis_port_env_to_fifo); 

endfunction

task run_phase (uvm_phase phase) ; 

    `uvm_info("AGENT","WE ARE RUNNING THE AGENT",UVM_NONE);

endtask 




endclass