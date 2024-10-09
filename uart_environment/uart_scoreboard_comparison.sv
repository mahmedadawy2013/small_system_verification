begin 
    //uart_score.display_Sequence_item("SCOREBOARD") ; 
    golden_Start = 0 ; 
    golden_end   = 1 ;
    if (uart_score.RST == 0) begin 
        if (uart_score.TX_OUT == 0 )
            passed_test_cases += 1 ; 
            golden_counter = 0 ;
            q_data = 0;
    end 
    else if (uart_score.Data_Valid == 1 && golden_counter == 0 ) begin 
        golden_P_Data = uart_score.P_DATA ;  
    end 
    if (uart_score.busy == 1 && golden_counter == 0) begin  
        if (uart_score.TX_OUT == golden_Start) begin 
            passed_test_cases += 1 ;
        end else  begin
            failed_test_cases += 1  ;
            $display("TEST CASE START Failed");
        end
        golden_counter += 1 ; 
    end
    else if (uart_score.busy == 1 && golden_counter == 1) begin  
        if (uart_score.TX_OUT == golden_P_Data[0] ) begin 
            passed_test_cases += 1 ;
            q_data[0] = uart_score.TX_OUT;
        end else  begin
            failed_test_cases += 1  ;
            $display("TEST CASE GOLDEN 0 Failed");
        end
        golden_counter += 1 ; 
    end
    else if (uart_score.busy == 1 && golden_counter == 2) begin  
        if (uart_score.TX_OUT == golden_P_Data[1] ) begin 
            passed_test_cases += 1 ;
            q_data[1] = uart_score.TX_OUT;
        end else  begin
            failed_test_cases += 1  ;
            $display("TEST CASE GOLDEN 1 Failed");
        end
        golden_counter += 1 ; 
    end
    else if (uart_score.busy == 1 && golden_counter == 3) begin  
        if (uart_score.TX_OUT == golden_P_Data[2] ) begin 
            passed_test_cases += 1 ;
            q_data[2] = uart_score.TX_OUT;;
        end else  begin
            failed_test_cases += 1  ;
            $display("TEST CASE GOLDEN 2 Failed");
        end
        golden_counter += 1 ; 
    end
    else if (uart_score.busy == 1 && golden_counter == 4) begin  
        if (uart_score.TX_OUT == golden_P_Data[3] ) begin 
            passed_test_cases += 1 ;
            q_data[3] = uart_score.TX_OUT;
        end else  begin
            failed_test_cases += 1  ;
            $display("TEST CASE GOLDEN 3 Failed");
        end
        golden_counter += 1 ; 
    end
    else if (uart_score.busy == 1 && golden_counter == 5) begin  
        if (uart_score.TX_OUT == golden_P_Data[4] ) begin 
            passed_test_cases += 1 ;
            q_data[4] = uart_score.TX_OUT;
        end else  begin
            failed_test_cases += 1  ;
            $display("TEST CASE GOLDEN 4 Failed"); 
        end
        golden_counter += 1 ; 
    end
    else if (uart_score.busy == 1 && golden_counter == 6) begin  
        if (uart_score.TX_OUT == golden_P_Data[5] ) begin 
            passed_test_cases += 1 ;
            q_data[5] = uart_score.TX_OUT;
        end else  begin
            failed_test_cases += 1  ;
            $display("TEST CASE GOLDEN 5 Failed");
        end
        golden_counter += 1 ; 
    end
    else if (uart_score.busy == 1 && golden_counter == 7) begin  
        if (uart_score.TX_OUT == golden_P_Data[6] ) begin 
            passed_test_cases += 1 ;
            q_data[6] = uart_score.TX_OUT;
        end else  begin
            failed_test_cases += 1  ;
            $display("TEST CASE GOLDEN 6 Failed"); 
        end
        golden_counter += 1 ; 
    end
    else if (uart_score.busy == 1 && golden_counter == 8) begin  
        if (uart_score.TX_OUT == golden_P_Data[7] ) begin 
            passed_test_cases += 1 ;
            q_data[7] = uart_score.TX_OUT;
        end else  begin
            failed_test_cases += 1  ;
            $display("TEST CASE GOLDEN 7 Failed"); 
        end
        golden_counter += 1 ; 
    end
    else if (uart_score.busy == 1 && uart_score.parity_enable == 1 && golden_counter == 9 ) begin  
        if (uart_score.parity_type == 0) 
            golden_parity = ^golden_P_Data     ;         // Even Parity
        else 
	        golden_parity = ~^golden_P_Data   ;         // Odd Parity

        if (uart_score.TX_OUT == golden_parity  ) begin 
            passed_test_cases += 1 ;
        end else  begin
            failed_test_cases += 1  ;
            $display("TEST CASE Parity Failed");
        end
        golden_counter += 1 ; 
    end
    else if (uart_score.busy == 1 && uart_score.parity_enable == 0 && golden_counter == 9 ) begin  

        if (uart_score.TX_OUT == golden_end  ) begin 
            passed_test_cases += 1 ;
        end else  begin
            failed_test_cases += 1  ;
            $display("TEST CASE END Failed"); 
        end
        golden_counter = 0 ;
        finish = 1 ; 
    end
    else if (uart_score.busy == 1 && uart_score.parity_enable == 1 && golden_counter == 10 ) begin  
        
        if (uart_score.TX_OUT == golden_end  ) begin 
            passed_test_cases += 1 ;
        end else  begin
            failed_test_cases += 1  ;
            $display("TEST CASE END AFTER PARITY Failed");
        end
        golden_counter = 0 ;
        finish = 1 ; 
    end
    if (finish == 1 ) begin 
            $display("q_data : %08b " , q_data);
            $display("golden : %08b " , golden_P_Data);
            if (golden_P_Data != q_data )  begin 
                $display("TEST CASE Failed");
            end else begin 
                $display("TEST CASE PASSED");
            end 
            finish = 0  ; 
    end 
    /**************************************  Reset Test Case ********************************************/
end 