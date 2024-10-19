class top_scoreboard extends uvm_scoreboard;
`uvm_component_utils(top_scoreboard)

uvm_analysis_export #(reg_sequence_item) reg_score_mail; 
reg_sequence_item reg_score;
uvm_tlm_analysis_fifo #(reg_sequence_item) reg_mem_analysis_fifo;

uvm_analysis_export #(reg2_sequence_item) reg2_score_mail ; 
reg2_sequence_item reg2_score;
uvm_tlm_analysis_fifo #(reg2_sequence_item) reg2_mem_analysis_fifo;

uvm_analysis_export #(alu_sequence_item) alu_score_mail; 
alu_sequence_item alu_score;
uvm_tlm_analysis_fifo #(alu_sequence_item) alu_analysis_fifo;


uvm_analysis_export #(top_sequence_item) top_score_mail; 
top_sequence_item top_score;
uvm_tlm_analysis_fifo #(top_sequence_item) top_mem_analysis_fifo;

uvm_analysis_export #(uart_sequence_item) uart_score_mail; 
uart_sequence_item uart_score;
uvm_tlm_analysis_fifo #(uart_sequence_item) uart_analysis_fifo;

`include "../register_memory_environment/reg_scoreboard_lib.sv" 
`include "../register_memory_2_environment/reg2_scoreboard_lib.sv" 
`include "../alu/alu_scoreboard_lib.sv"   
`include "../uart_environment/uart_scoreboard_lib.sv" 
`include "scoreboard_lib.sv"   


function  new(string name = "SCOREBOARD", uvm_component parent = null);
    super.new(name,parent) ; 
endfunction 

function void build_phase(uvm_phase phase);
    super.build_phase(phase) ;
    `uvm_info("SCOREBOARD","WE Are Compiling The Scoreboard",UVM_NONE);

    reg_score_mail        = new("reg_score_mail",this) ;
    reg_score             = reg_sequence_item::type_id::create("reg_score");
    reg_mem_analysis_fifo = new("reg_mem_analysis_fifo", this);

    reg2_score_mail        = new("reg2_score_mail",this) ;
    reg2_score             = reg2_sequence_item::type_id::create("reg2_score");
    reg2_mem_analysis_fifo = new("reg2_mem_analysis_fifo", this);

    alu_score_mail        = new("alu_score_mail",this) ;
    alu_score             = alu_sequence_item::type_id::create("alu_score");
    alu_analysis_fifo     = new("alu_analysis_fifo", this);

    top_score_mail        = new("top_score_mail",this) ;
    top_score             = top_sequence_item::type_id::create("top_score");
    top_mem_analysis_fifo = new("top_mem_analysis_fifo", this);

    uart_score_mail        = new("uart_score_mail",this) ;
    uart_score             = uart_sequence_item::type_id::create("uart_score");
    uart_analysis_fifo     = new("uart_analysis_fifo", this);

endfunction

function void connect_phase(uvm_phase phase);
    super.connect_phase(phase) ; 

    reg_score_mail.connect(reg_mem_analysis_fifo.analysis_export) ; 
    reg2_score_mail.connect(reg2_mem_analysis_fifo.analysis_export) ; 
    alu_score_mail.connect(alu_analysis_fifo.analysis_export) ; 
    top_score_mail.connect(top_mem_analysis_fifo.analysis_export) ; 
    uart_score_mail.connect(uart_analysis_fifo.analysis_export) ; 

endfunction

task run_phase (uvm_phase phase) ; 

    `uvm_info("SCOREBOARD","WE ARE RUNNING THE SCOREBOARD",UVM_NONE);
    forever begin
        fork 
            begin  
                reg_mem_analysis_fifo.get(reg_score);
                reg_score.display_Sequence_item("SCOREBOARD") ; 
            end 
            begin 
                reg2_mem_analysis_fifo.get(reg2_score);
                reg2_score.display_Sequence_item("SCOREBOARD") ; 
            end 
            begin 
                alu_analysis_fifo.get(alu_score);
                alu_score.display_Sequence_item("SCOREBOARD") ; 
            end 
            begin 
                top_mem_analysis_fifo.get(top_score);
            end 
            begin 
                uart_analysis_fifo.get(uart_score);
            end 
        join 
        `include "../register_memory_environment/reg_scoreboard_comparison.sv"
        `include "../register_memory_2_environment/reg2_scoreboard_comparison.sv"
        `include "../alu/alu_scoreboard_comparison.sv"
        `include "scoreboard_comparison.sv"
        `include "../uart_environment/uart_scoreboard_comparison.sv"




    
    end 

endtask 

task display_reg_test_cases_report () ;

    $display("The Number of REG1 Passed test cases is :%0P " , reg_passed_test_cases ); 
    $display("The Number of REG1 Failed test cases is :%0P " , reg_failed_test_cases ); 
    $display("The Number of REG1 TOTAL  test cases is :%0P " , reg_failed_test_cases+reg_passed_test_cases ); 

endtask 

task display_alu_test_cases_report () ;

    $display("The Number of ALU Passed test cases is :%0P " , alu_passed_test_cases ); 
    $display("The Number of ALU Failed test cases is :%0P " , alu_failed_test_cases ); 
    $display("The Number of ALU Total  test cases is :%0P " , alu_failed_test_cases+alu_passed_test_cases ); 

endtask 

task display_reg2_test_cases_report () ;

    $display("The Number of REG2 Passed test cases is :%0P " , reg2_passed_test_cases ); 
    $display("The Number of REG2 Failed test cases is :%0P " , reg2_failed_test_cases ); 
    $display("The Number of REG2 TOTAL  test cases is :%0P " , reg2_failed_test_cases+reg2_passed_test_cases ); 

endtask 

task display_top_test_cases_report () ;

    $display("The Number of TOP Passed test cases is :%0P " , top_passed_test_cases ); 
    $display("The Number of TOP Failed test cases is :%0P " , top_failed_test_cases ); 
    $display("The Number of TOP TOTAL  test cases is :%0P " , top_failed_test_cases+top_passed_test_cases ); 

endtask 

task display_uart_test_cases_report () ;

    $display("The Number of uart Passed test cases is :%0P " , uart_passed_test_cases ) ; 
    $display("The Number of uart Failed test cases is :%0P " , uart_failed_test_cases ) ; 
  
endtask 

endclass