class uart_test extends uvm_test;
`uvm_component_utils(uart_test)
uart_environment            environment_instance; 
uart_parity_sequence        parity_sequence_instance;
uart_no_parity_sequence     no_parity_sequence_instance;
virtual uart_intf           test_intf;
int delay ;
function  new(string name = "TEST ", uvm_component parent = null);
    super.new(name,parent) ; 
endfunction

function void build_phase(uvm_phase phase);
    super.build_phase(phase) ;
    `uvm_info("TEST","WE Are Compiling The TEST",UVM_NONE);
    environment_instance               = uart_environment::type_id::create("environment_instance",this); 
    parity_sequence_instance           = uart_parity_sequence::type_id::create("reset_sequence_instance");
    no_parity_sequence_instance        = uart_no_parity_sequence::type_id::create("reset_sequence_instance");
    if(!uvm_config_db #(virtual uart_intf)::get(this,"","my_vif",test_intf))
        `uvm_info("Test","ERROR INSIDE Test",UVM_NONE);
endfunction

function void connect_phase(uvm_phase phase);
    super.connect_phase(phase) ; 
endfunction

task run_phase (uvm_phase phase) ; 

    phase.raise_objection(this,"STARTING TEST") ; 
        `uvm_info("TEST","WE ARE RUNNING THE TEST ",UVM_NONE)
        repeat (2) begin 
            parity_sequence_instance.start(environment_instance.agent_instance.sequencer_instance);
            delay = $urandom_range(0,120);
            #delay ; 
            no_parity_sequence_instance.start(environment_instance.agent_instance.sequencer_instance);
            #5000;
        end 
        // repeat (600) begin 
        //     no_parity_sequence_instance.start(environment_instance.agent_instance.sequencer_instance)         ;
        // end 
        @(negedge test_intf.CLK) 
        environment_instance.scoreboard_instance.display_test_cases_report()   ; 
        environment_instance.subscriber_inscance.display_coverage_percentage() ;
    phase.drop_objection(this,"FINSHING TEST")  ; 
endtask 

endclass