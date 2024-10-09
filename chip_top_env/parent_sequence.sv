class parent_sequence extends uvm_sequence;
/*Register To The Factory Using object utils */
`uvm_object_utils(parent_sequence)
/*Create an instance from the sequence item to be the transaction data*/
parent_sequencer    parent_sequencer_instance;
reg_reset_sequence  reset_sequence_instance;
reg_write_sequence  write_sequence_instance;
reg_read_sequence   read_sequence_instance;  

reg2_reset_sequence  reset_sequence_instance2;
reg2_write_sequence  write_sequence_instance2;
reg2_read_sequence   read_sequence_instance2;

top_sel_sequence top_sel_sequence_instance ; 

function  new(string name = "PARENT_SEQUENCE ");
    super.new(name) ; 
endfunction

/* Pre body and body called by the start function which has been called from the test */

/* pre body function to act like the build phase  */
task pre_body();
    /*Create a handle from the sequence item to be the transaction data*/
    $cast(parent_sequencer_instance,m_sequencer);
    reset_sequence_instance = reg_reset_sequence::type_id::create("reset_sequence_instance"); 
    write_sequence_instance = reg_write_sequence::type_id::create("write_sequence_instance");
    read_sequence_instance  = reg_read_sequence::type_id::create("read_sequence_instance"); 

    reset_sequence_instance2 = reg2_reset_sequence::type_id::create("reset_sequence_instance2"); 
    write_sequence_instance2 = reg2_write_sequence::type_id::create("write_sequence_instance2");
    read_sequence_instance2  = reg2_read_sequence::type_id::create("read_sequence_instance2");

    top_sel_sequence_instance = top_sel_sequence::type_id::create("top_sel_sequence_instance"); 
endtask
/* body function to act like the run phase  */
task body();

fork 
    begin 
        reset_sequence_instance.start(parent_sequencer_instance.reg_sequencer_instance); 
        write_sequence_instance.start(parent_sequencer_instance.reg_sequencer_instance); 
        read_sequence_instance.start(parent_sequencer_instance.reg_sequencer_instance);  
    end 
    begin 
        reset_sequence_instance2.start(parent_sequencer_instance.reg2_sequencer_instance); 
        write_sequence_instance2.start(parent_sequencer_instance.reg2_sequencer_instance);
        read_sequence_instance2.start(parent_sequencer_instance.reg2_sequencer_instance); 
    end 
    begin 
        top_sel_sequence_instance.start(parent_sequencer_instance.top_sequencer_insatnce); 
    end 
join 

endtask

endclass
