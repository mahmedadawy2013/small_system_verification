class top_test extends uvm_test;
`uvm_component_utils(top_test)
top_environment     environment_instance; 
parent_sequence     parent_sequence_instance;
virtual top_intf    test_intf;

function  new(string name = "TEST ", uvm_component parent = null);
    super.new(name,parent) ; 
endfunction

function void build_phase(uvm_phase phase);
    super.build_phase(phase) ;
    `uvm_info("TEST","WE Are Compiling The TEST",UVM_NONE);
    parent_sequence_instance = parent_sequence::type_id::create("parent_sequence_instance");
    environment_instance     = top_environment::type_id::create("environment_instance",this); 
    if(!uvm_config_db #(virtual top_intf)::get(this,"","my_vif",test_intf))
        `uvm_info("Test","ERROR INSIDE Test",UVM_NONE);
endfunction

function void connect_phase(uvm_phase phase);
    super.connect_phase(phase) ; 
endfunction

task run_phase (uvm_phase phase) ; 

    phase.raise_objection(this,"STARTING TEST") ; 
        `uvm_info("TEST","WE ARE RUNNING THE TEST ",UVM_NONE)
        repeat(20) begin 
            parent_sequence_instance.start(environment_instance.parent_sequencer_instance);
        end
        @(negedge test_intf.clk_top_intf) 
        environment_instance.scoreboard_instance.display_reg_test_cases_report();
        environment_instance.scoreboard_instance.display_reg2_test_cases_report();
        environment_instance.scoreboard_instance.display_alu_test_cases_report();
        environment_instance.scoreboard_instance.display_top_test_cases_report();
        environment_instance.scoreboard_instance.display_uart_test_cases_report();
    phase.drop_objection(this,"FINSHING TEST")  ; 
endtask 

endclass