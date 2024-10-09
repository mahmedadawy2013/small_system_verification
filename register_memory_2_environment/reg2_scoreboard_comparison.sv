begin 
        reg2_score.display_Sequence_item("SCOREBOARD") ; 
      /************************  Reset Test Case ************************/
      if (reg2_score.rst_tb == 0) begin 
        for (int i=0 ; i < 16 ; i = i +1)
          begin
            reg2_golden_memory[i] = 0 ;
          end
        reg2_golgen_output = 0 ; 
        if (reg2_score.RdData_tb == reg2_golgen_output)
          begin 
           $display("Reset Test Case Passed At time : %0P",$realtime()) ; 
           reg2_passed_test_cases++  ; 
          end
          else  begin
            $display("Reset Test Case Failed At time : %0P",$realtime()) ; 
            reg2_failed_test_cases++ ; 
          end
      end  
      /*******************************************************************/
      /************************  Write Test Case *************************/
      else if (reg2_score.WrEn_tb == 1) begin 
        reg2_golden_memory[reg2_score.Address_tb] = reg2_score.WrData_tb   ; 
        if (reg2_score.RdData_tb == reg2_golgen_output)
          begin 
           $display("Write Test Case Passed At time : %0P",$realtime()) ; 
            `uvm_info("WR_TC_PASSED", $sformatf("Value Inside Golden MEM %0d ",reg2_golden_memory[reg2_score.Address_tb]),UVM_LOW)
            reg2_passed_test_cases++  ; 
          end
          else  begin
            $display("Write Test Case Failed At time : %0P",$realtime()) ; 
            `uvm_error("WR_TC_FAILED", $sformatf("Value is %0d & Expected :%0P  ",reg2_score.RdData_tb,reg2_golgen_output));
            reg2_failed_test_cases++ ; 
          end
      end  
      /*******************************************************************/
      /************************  Read Test Case **************************/
      else if (reg2_score.RdEn_tb == 1) begin 
        reg2_golgen_output = reg2_golden_memory[reg2_score.Address_tb]   ; 
        if (reg2_score.RdData_tb == reg2_golgen_output)
          begin 
           $display("Read Test Case Passed At time : %0P",$realtime()) ; 
           reg2_passed_test_cases++  ; 
          end
          else  begin
            $display("Read Test Case Failed At time : %0P",$realtime()) ;
            `uvm_error("RD_TC_FAILED", $sformatf("Value is %0d & Expected :%0P  ",reg2_score.RdData_tb,reg2_golgen_output));
            reg2_failed_test_cases++ ; 
          end
      end  
      /*******************************************************************/
end 

