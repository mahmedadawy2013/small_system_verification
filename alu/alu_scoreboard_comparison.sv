
 begin 


alu_score.display_Sequence_item("SCOREBOARD") ; 
    /************************  Reset Test Case ************************/
      if (alu_score.RST == 0) begin 
        alu_golgen_output = 0 ; 
        if (alu_score.ALU_OUT == alu_golgen_output)
          begin 
           `uvm_info("RESET_TC_PASSED", $sformatf("Reset Test Case Passed At time: %0t", $realtime), UVM_LOW);
           alu_passed_test_cases++  ; 
          end
          else  begin
            `uvm_error("RESET_TC_FAILED", $sformatf("Reset Test Case Failed At time: %0t", $realtime));
            `uvm_error("RESET_TC_FAILED", $sformatf("Value is %0d & Expected :%0P  ",alu_score.ALU_OUT,alu_golgen_output));

            alu_failed_test_cases++ ; 
          end
      end  
      /*******************************************************************/
      /************************  Addition Test Case *************************/
      else if (alu_score.ALU_FUN == 0) begin 
        alu_golgen_output = alu_score.A + alu_score.B   ; 
        if (alu_score.ALU_OUT == alu_golgen_output)
          begin 
           `uvm_info("ADD_TC_PASSED", $sformatf("add Test Case Passed At time: %0t", $realtime), UVM_LOW);
           alu_passed_test_cases++  ; 
          end
          else  begin
            `uvm_error("ADD_TC_FAILED", $sformatf("add Test Case Failed At time: %0t", $realtime));
            `uvm_error("ADD_TC_FAILED", $sformatf("Value is %0d & Expected :%0P  ",alu_score.ALU_OUT,alu_golgen_output));

            alu_failed_test_cases++ ; 
          end
      end  
      /*******************************************************************/
      /************************  sub Test Case **************************/
      else if (alu_score.ALU_FUN == 1) begin 
        alu_golgen_output = alu_score.A - alu_score.B   ; 
        if (alu_score.ALU_OUT == alu_golgen_output)
          begin 
           `uvm_info("SUB_TC_PASSED", $sformatf("sub Test Case Passed At time: %0t", $realtime), UVM_LOW);
           alu_passed_test_cases++  ; 
          end
          else  begin
            `uvm_error("SUB_TC_FAILED", $sformatf("sub Test Case Failed At time: %0t", $realtime));
            `uvm_error("SUB_TC_FAILED", $sformatf("Value is %0d & Expected :%0P  ",alu_score.ALU_OUT,alu_golgen_output));

            alu_failed_test_cases++ ; 
          end
      end  

      /************************  mult Test Case **************************/
      else if (alu_score.ALU_FUN == 2) begin 
        alu_golgen_output = alu_score.A * alu_score.B   ; 
        if (alu_score.ALU_OUT == alu_golgen_output)
          begin 
           `uvm_info("MULT_TC_PASSED", $sformatf("MULT Test Case Passed At time: %0t", $realtime), UVM_LOW);
           alu_passed_test_cases++  ; 
          end
          else  begin
            `uvm_error("MULT_TC_FAILED", $sformatf("MULT Test Case Failed At time: %0t", $realtime));
            `uvm_error("MULT_TC_FAILED", $sformatf("Value is %0d & Expected :%0P  ",alu_score.ALU_OUT,alu_golgen_output));
            
            alu_failed_test_cases++ ; 
          end
      end  
    /************************  div Test Case **************************/
      else if (alu_score.ALU_FUN == 3) begin 
        alu_golgen_output = alu_score.A / alu_score.B   ; 
        if (alu_score.ALU_OUT == alu_golgen_output)
          begin 
           `uvm_info("DIV_TC_PASSED", $sformatf("DIV Test Case Passed At time: %0t", $realtime), UVM_LOW);
           alu_passed_test_cases++  ; 
          end
          else  begin
            `uvm_error("DIV_TC_FAILED", $sformatf("DIV Test Case Failed At time: %0t", $realtime));
            `uvm_error("DIV_TC_FAILED", $sformatf("Value is %0d & Expected :%0P  ",alu_score.ALU_OUT,alu_golgen_output));

            alu_failed_test_cases++ ; 
          end
      end  
      /*******************************************************************/
      else if (alu_score.ALU_FUN > 3) begin 
        alu_golgen_output = 0;
        if (alu_score.ALU_OUT == alu_golgen_output)
          begin 
           `uvm_info("DEF_TC_PASSED", $sformatf("DEF Test Case Passed At time: %0t", $realtime), UVM_LOW);
           alu_passed_test_cases++  ; 
          end
          else  begin
            `uvm_error("DEF_TC_FAILED", $sformatf("DEF Test Case Failed At time: %0t", $realtime));
            `uvm_error("DEF_TC_FAILED", $sformatf("Value is %0d & Expected :%0P  ",alu_score.ALU_OUT,alu_golgen_output));

            alu_failed_test_cases++ ; 
          end
      end  
      /*******************************************************************/


 end 