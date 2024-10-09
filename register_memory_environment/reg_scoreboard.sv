class reg_scoreboard extends uvm_scoreboard;
`uvm_component_utils(reg_scoreboard)

uvm_analysis_export #(reg_sequence_item) reg_score_mail ; 
reg_sequence_item reg_score;
uvm_tlm_analysis_fifo #(reg_sequence_item) reg_mem_analysis_fifo;


`include "reg_scoreboard_lib.sv"  

function  new(string name = "REG_SCOREBOARD", uvm_component parent = null);
    super.new(name,parent) ; 
endfunction 

function void build_phase(uvm_phase phase);
    super.build_phase(phase) ;
    `uvm_info("SCOREBOARD","WE Are Compiling The Scoreboard",UVM_NONE);
    reg_score_mail = new("reg_score_mail",this) ;
    reg_score   = reg_sequence_item::type_id::create("reg_score");
    reg_mem_analysis_fifo = new("reg_mem_analysis_fifo", this);
    
endfunction

function void connect_phase(uvm_phase phase);
    super.connect_phase(phase) ; 
    reg_score_mail.connect(reg_mem_analysis_fifo.analysis_export) ; 

endfunction

task run_phase (uvm_phase phase) ; 
    super.run_phase(phase);

    `uvm_info("SCOREBOARD","WE ARE RUNNING THE SCOREBOARD",UVM_NONE);
     
     forever begin

        fork 
            begin  
              reg_mem_analysis_fifo.get(reg_score);
            end 
            begin 
                // for multible sender 
                // get from the fifo here but in single thread 
            end 
        join 

      `include "reg_scoreboard_comparison.sv"
     end 
endtask 
task display_test_cases_report () ;

    $display("The Number of REG1 Passed test cases is :%0P " , reg_passed_test_cases ); 
    $display("The Number of REG1 Failed test cases is :%0P " , reg_failed_test_cases ); 
    $display("The Number of REG1 TOTAL  test cases is :%0P " , reg_failed_test_cases+reg_passed_test_cases ); 

endtask 
// task write (reg_sequence_item reg_score);
    
// endtask 


endclass