class reg2_sequencer extends uvm_sequencer #(reg2_sequence_item) ;
/*Register To The Factory Using object utils */
/************************************************************
* Dont Forget that this class isnt dummy class 
* this class has seq_item_imp which is connected to the 
* driver inside the agent and without it u cant send the 
* data from the sequence to the driver 
************************************************************/
`uvm_component_utils(reg2_sequencer)


function  new(string name = "REG2_SEQUENCER ", uvm_component parent = null);
    super.new(name,parent) ; 
endfunction

function void build_phase(uvm_phase phase);
    super.build_phase(phase) ;
    `uvm_info("SEQUENCER","WE Are Compiling The Sequencer",UVM_NONE);
endfunction

function void connect_phase(uvm_phase phase);
    super.connect_phase(phase) ; 
endfunction

task run_phase (uvm_phase phase) ; 
    `uvm_info("SEQUENCER","WE ARE RUNNING THE SEQUENCER",UVM_NONE);
endtask 


endclass