class parent_sequencer extends uvm_sequencer;
/*Register To The Factory Using object utils */
/************************************************************
* Dont Forget that this class isnt dummy class 
* this class has seq_item_imp which is connected to the 
* driver inside the agent and without it u cant send the 
* data from the sequence to the driver 
************************************************************/
`uvm_component_utils(parent_sequencer)


function  new(string name = "PARENT SEQUENCER ", uvm_component parent = null);
    super.new(name,parent) ; 
endfunction

top_sequencer  top_sequencer_insatnce;
reg_sequencer  reg_sequencer_instance; 
reg2_sequencer reg2_sequencer_instance; 


endclass