class reg_subscriber extends uvm_component ;
`uvm_component_utils(reg_subscriber)
uvm_analysis_imp #(reg_sequence_item,reg_subscriber) subs_mail ; 
reg_sequence_item t_subscriber_groub   ; 

int covered            ;
int total              ; 

covergroup groub1 ; 
    coverpoint t_subscriber_groub.RdData_tb {bins All[] = { [0:$] } ; } 
endgroup 


function  new(string name = "SUBSCRIBER", uvm_component parent = null);
    super.new(name,parent) ; 
    groub1    = new()                 ; 
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

task write (reg_sequence_item t_subs);
    t_subs.display_Sequence_item("SUBSCRIBER") ; 
    t_subscriber_groub = t_subs                ; 
    groub1.sample()                            ; 
endtask


task display_coverage_percentage() ; 
    $display("The Coverage is :%0P ",groub1.get_coverage(covered,total));
    $display("The covered  is :%0P ",covered);
    $display("The total    is :%0P ",total);
endtask

endclass