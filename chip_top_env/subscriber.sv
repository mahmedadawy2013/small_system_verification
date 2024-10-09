class top_subscriber extends uvm_component ;
`uvm_component_utils(top_subscriber)
uvm_analysis_imp #(top_sequence_item,top_subscriber) subs_mail ; 



function  new(string name = "SUBSCRIBER", uvm_component parent = null);
    super.new(name,parent) ; 
endfunction 

function void build_phase(uvm_phase phase);
    super.build_phase(phase) ;
    `uvm_info("SUBSCRIBER","WE Are Compiling The Subscriber",UVM_NONE);
    subs_mail = new("subs_mail",this) ; 


endfunction

function void connect_phase(uvm_phase phase);
    super.connect_phase(phase) ; 
endfunction

task run_phase (uvm_phase phase) ; 

    `uvm_info("SUBSCRIBER","WE ARE RUNNING THE SUBSCRIBER",UVM_NONE);

endtask 

task write (top_sequence_item t_subs);

endtask



endclass