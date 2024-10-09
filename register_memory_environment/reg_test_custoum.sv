class reg_test_custoum extends uvm_test;
`uvm_component_utils(reg_test_custoum)
reg_environment     environment_instance; 
reg_reset_sequence  reset_sequence_instance;
reg_write_custoum_sequence#(0,20'b01)  write_sequence_instance;
reg_read_custoum_sequence#(0,20'b01)  read_sequence_instance;  

virtual reg_intf    test_intf;

function  new(string name = "TEST ", uvm_component parent = null);
    super.new(name,parent) ; 
endfunction

function void build_phase(uvm_phase phase);
    super.build_phase(phase) ;
    `uvm_info("TEST","WE Are Compiling The TEST",UVM_NONE)                               ;
    environment_instance    = reg_environment::type_id::create("environment_instance",this)  ; 
    reset_sequence_instance = reg_reset_sequence::type_id::create("reset_sequence_instance") ; 
    write_sequence_instance = reg_write_custoum_sequence#(0,20'b01)::type_id::create("write_sequence_instance") ;
    read_sequence_instance  = reg_read_custoum_sequence#(0,20'b01)::type_id::create("read_sequence_instance")   ; 
    if(!uvm_config_db #(virtual reg_intf)::get(this,"","reg_my_vif",test_intf))
        `uvm_info("Test","ERROR INSIDE Test",UVM_NONE);
endfunction

function void connect_phase(uvm_phase phase);
    super.connect_phase(phase) ; 
endfunction

task run_phase (uvm_phase phase) ; 

    phase.raise_objection(this,"STARTING TEST") ; 
        `uvm_info("TEST","WE ARE RUNNING THE TEST ",UVM_NONE)
        reset_sequence_instance.start(environment_instance.agent_instance.sequencer_instance) ;
        repeat (1) begin 
        write_sequence_instance.start(environment_instance.agent_instance.sequencer_instance) ;
        read_sequence_instance.start(environment_instance.agent_instance.sequencer_instance)  ;  
        end 
        @(negedge test_intf.clk_intf) 
        environment_instance.scoreboard_instance.display_test_cases_report()    ; 
        environment_instance.subscriber_inscance.display_coverage_percentage()  ;
    phase.drop_objection(this,"FINSHING TEST")  ; 
endtask 

endclass