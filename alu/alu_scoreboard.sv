class alu_scoreboard extends uvm_scoreboard;
`uvm_component_utils(alu_scoreboard)

uvm_analysis_export #(alu_sequence_item) alu_score_mail; 
alu_sequence_item alu_score;
uvm_tlm_analysis_fifo #(alu_sequence_item) alu_analysis_fifo;

`include "alu_scoreboard_lib.sv"   


function  new(string name = "ALU_SCOREBOARD", uvm_component parent = null);
    super.new(name,parent); 
endfunction 

function void build_phase(uvm_phase phase);
    super.build_phase(phase) ;
    `uvm_info("SCOREBOARD","WE Are Compiling The Scoreboard",UVM_NONE);
    
    alu_score_mail        = new("alu_score_mail",this) ;
    alu_score             = alu_sequence_item::type_id::create("alu_score");
    alu_analysis_fifo     = new("alu_analysis_fifo", this);

endfunction

function void connect_phase(uvm_phase phase);
    super.connect_phase(phase) ; 
    alu_score_mail.connect(alu_analysis_fifo.analysis_export) ; 

endfunction

task run_phase (uvm_phase phase) ; 

    `uvm_info("SCOREBOARD","WE ARE RUNNING THE SCOREBOARD",UVM_NONE);
    forever begin

        fork 
            begin  
                alu_analysis_fifo.get(alu_score);
            end 
            begin 
               // for more threading
            end 
        join 

        `include "alu_scoreboard_comparison.sv"

    
    end

endtask 
 
task display_alu_test_cases_report () ;

    $display("The Number of Passed ALU test cases is :%0P " , alu_passed_test_cases ) ; 
    $display("The Number of Failed ALU test cases is :%0P " , alu_failed_test_cases ) ; 
    $display("The Number of Total  ALU test cases is :%0P " , alu_failed_test_cases+alu_passed_test_cases ) ; 

  
endtask 

endclass