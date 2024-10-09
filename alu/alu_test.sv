class alu_test extends uvm_test;
`uvm_component_utils(alu_test)
alu_environment     environment_instance; 
alu_reset_sequence  reset_sequence_instance;
alu_add_sequence    add_sequence_instance;
alu_sub_sequence    sub_sequence_instance; 
alu_mult_sequence   mult_sequence_instance;
alu_div_sequence    div_sequence_instance;
alu_default_sequence default_sequence_instance;
virtual alu_intf    test_intf;

function  new(string name = "TEST ", uvm_component parent = null);
    super.new(name,parent) ; 
endfunction

function void build_phase(uvm_phase phase);
    super.build_phase(phase) ;
    `uvm_info("TEST","WE Are Compiling The TEST",UVM_NONE);
    environment_instance    = alu_environment::type_id::create("environment_instance",this); 
    reset_sequence_instance = alu_reset_sequence::type_id::create("reset_sequence_instance"); 
    add_sequence_instance   = alu_add_sequence::type_id::create("add_sequence_instance");
    sub_sequence_instance   = alu_sub_sequence::type_id::create("sub_sequence_instance"); 
    mult_sequence_instance  = alu_mult_sequence::type_id::create("mult_sequence_instance"); 
    div_sequence_instance   = alu_div_sequence::type_id::create("mult_sequence_instance");
    default_sequence_instance = alu_default_sequence::type_id::create("mult_sequence_instance");
    if(!uvm_config_db #(virtual alu_intf)::get(this,"","alu_my_vif",test_intf))
        `uvm_info("Test","ERROR INSIDE Test",UVM_NONE);
endfunction

function void connect_phase(uvm_phase phase);
    super.connect_phase(phase) ; 
endfunction

task run_phase (uvm_phase phase) ; 

    phase.raise_objection(this,"STARTING TEST") ; 
        `uvm_info("TEST","WE ARE RUNNING THE TEST ",UVM_NONE)
        reset_sequence_instance.start(environment_instance.agent_instance.sequencer_instance) ;
        repeat (20) begin 
        add_sequence_instance.start(environment_instance.agent_instance.sequencer_instance);
        sub_sequence_instance.start(environment_instance.agent_instance.sequencer_instance);  
        mult_sequence_instance.start(environment_instance.agent_instance.sequencer_instance);
        div_sequence_instance.start(environment_instance.agent_instance.sequencer_instance);
        default_sequence_instance.start(environment_instance.agent_instance.sequencer_instance);
        end 
        @(negedge test_intf.CLK) 
        environment_instance.scoreboard_instance.display_alu_test_cases_report(); 
        environment_instance.subscriber_inscance.display_coverage_percentage();
    phase.drop_objection(this,"FINSHING TEST")  ; 
endtask 

endclass