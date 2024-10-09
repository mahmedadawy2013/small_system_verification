
begin 
    top_score.display_Sequence_item("SCOREBOARD") ; 
      /************************  Reset Test Case ************************/
      if (top_score.sel_top == 0) begin 
        if (top_score.mux_out_top == reg2_golgen_output)
          begin 
           $display("TOP REG Test Case Passed At time : %0P",$realtime()) ; 
           top_passed_test_cases++  ; 
          end
          else  begin
            $display("TOP REG Test Case Failed At time : %0P",$realtime()) ; 
            top_failed_test_cases++ ; 
          end
      end 
      else  if (top_score.sel_top == 1) begin
        if (top_score.mux_out_top == alu_golgen_output)
          begin 
           $display("TOP ALU Test Case Passed At time : %0P",$realtime()) ; 
           top_passed_test_cases++  ; 
          end
          else  begin
            $display("TOP ALU Test Case Failed At time : %0P",$realtime()) ; 
            top_failed_test_cases++ ; 
          end
      end 
      /*******************************************************************/
end 