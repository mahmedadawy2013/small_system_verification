class reg2_scoreboard extends uvm_scoreboard;
`uvm_component_utils(reg2_scoreboard)

uvm_analysis_export #(reg2_sequence_item) reg2_score_mail ; 
reg2_sequence_item reg2_score;
uvm_tlm_analysis_fifo #(reg2_sequence_item) reg2_mem_analysis_fifo;


`include "reg2_scoreboard_lib.sv"  

function  new(string name = "REG2_SCOREBOARD", uvm_component parent = null);
    super.new(name,parent) ; 
endfunction 

function void build_phase(uvm_phase phase);
    super.build_phase(phase) ;
    `uvm_info("SCOREBOARD","WE Are Compiling The Scoreboard",UVM_NONE);
    reg2_score_mail = new("reg2_score_mail",this) ;
    reg2_score   = reg2_sequence_item::type_id::create("reg2_score");
    reg2_mem_analysis_fifo = new("reg2_mem_analysis_fifo", this);
    
endfunction

function void connect_phase(uvm_phase phase);
    super.connect_phase(phase) ; 
    reg2_score_mail.connect(reg2_mem_analysis_fifo.analysis_export) ; 

endfunction

task run_phase (uvm_phase phase) ; 
    super.run_phase(phase);

    `uvm_info("SCOREBOARD","WE ARE RUNNING THE SCOREBOARD",UVM_NONE);
     
     forever begin

        fork 
            begin  
              reg2_mem_analysis_fifo.get(reg2_score);
            end 
            begin 
                // for multible sender 
                // get from the fifo here but in single thread 
            end 
        join 

      `include "reg2_scoreboard_comparison.sv"
     end 
endtask 

task display_test_cases_report () ;

    $display("The Number of REG2 Passed test cases is :%0P " , reg2_passed_test_cases ); 
    $display("The Number of REG2 Failed test cases is :%0P " , reg2_failed_test_cases ); 
    $display("The Number of REG2 TOTAL  test cases is :%0P " , reg2_failed_test_cases+reg2_passed_test_cases ); 

endtask 



endclass