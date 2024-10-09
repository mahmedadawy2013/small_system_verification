class uart_scoreboard extends uvm_scoreboard;
`uvm_component_utils(uart_scoreboard)

uvm_analysis_export #(uart_sequence_item) uart_score_mail; 
uart_sequence_item uart_score;
uvm_tlm_analysis_fifo #(uart_sequence_item) uart_analysis_fifo;

`include "uart_scoreboard_lib.sv" 

function  new(string name = "SCOREBOARD", uvm_component parent = null);
    super.new(name,parent); 
endfunction 

function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("SCOREBOARD","WE Are Compiling The Scoreboard",UVM_NONE);
    uart_score_mail        = new("uart_score_mail",this) ;
    uart_score             = uart_sequence_item::type_id::create("uart_score");
    uart_analysis_fifo = new("uart_analysis_fifo", this);
endfunction

function void connect_phase(uvm_phase phase);
    super.connect_phase(phase); 
    uart_score_mail.connect(uart_analysis_fifo.analysis_export) ; 
endfunction

task run_phase (uvm_phase phase) ; 

    `uvm_info("SCOREBOARD","WE ARE RUNNING THE SCOREBOARD",UVM_NONE);
    forever begin
        fork 
            begin  
                uart_analysis_fifo.get(uart_score);
                uart_score.display_Sequence_item("SCOREBOARD") ; 
            end 
        join 
        `include "uart_scoreboard_comparison.sv"
    end 
endtask 



task display_test_cases_report () ;

    $display("The Number of Passed test cases is :%0P " , passed_test_cases ) ; 
    $display("The Number of Failed test cases is :%0P " , failed_test_cases ) ; 
  
endtask 
endclass