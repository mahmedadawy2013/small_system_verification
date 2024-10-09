class reg2_reset_sequence extends uvm_sequence;
/*Register To The Factory Using object utils */
`uvm_object_utils(reg2_reset_sequence)
/*Create an instance from the sequence item to be the transaction data*/
reg2_sequence_item t ; 

function  new(string name = "SEQUENCE ");
    super.new(name) ; 
endfunction

/* Pre body and body called by the start function which has been called from the test */

/* pre body function to act like the build phase  */
task pre_body();
    /*Create a handle from the sequence item to be the transaction data*/
    t = reg2_sequence_item::type_id::create("t") ; 
endtask
/* body function to act like the run phase  */
task body();
      start_item(t)                               ;
        t.randomize() with {t.rst_tb  == 1'b0  ;} ; 
        t.display_Sequence_item("SEQUENCE")       ;
      finish_item(t)                              ; 
endtask

endclass

class reg2_write_sequence extends uvm_sequence;
/*Register To The Factory Using object utils */
`uvm_object_utils(reg2_write_sequence)
/*Create an instance from the sequence item to be the transaction data*/
reg2_sequence_item t ; 

function  new(string name = "SEQUENCE ");
    super.new(name) ; 
endfunction

/* Pre body and body called by the start function which has been called from the test */

/* pre body function to act like the build phase  */
task pre_body();
    /*Create a handle from the sequence item to be the transaction data*/
    t = reg2_sequence_item::type_id::create("t") ; 
endtask
/* body function to act like the run phase  */
task body();
      for (int i=0; i<16; ++i) begin
      start_item(t)                               ;
        t.randomize() with {t.rst_tb  == 1'b1  ;
                            t.WrEn_tb == 1'b1  ;  }  ; 
        t.display_Sequence_item("SEQUENCE")       ;
      finish_item(t)                              ;
      end                                         ; 
endtask

endclass

class reg2_read_sequence extends uvm_sequence;
/*Register To The Factory Using object utils */
`uvm_object_utils(reg2_read_sequence)
/*Create an instance from the sequence item to be the transaction data*/
reg2_sequence_item t ; 

function  new(string name = "SEQUENCE ");
    super.new(name) ; 
endfunction

/* Pre body and body called by the start function which has been called from the test */

/* pre body function to act like the build phase  */
task pre_body();
    /*Create a handle from the sequence item to be the transaction data*/
    t = reg2_sequence_item::type_id::create("t") ; 
endtask
/* body function to act like the run phase  */
task body();
      for (int i=0; i<16; ++i) begin
      start_item(t)                               ;
        t.randomize() with {t.rst_tb  == 1'b1  ;
                            t.RdEn_tb == 1'b1  ;  }  ; 
        t.display_Sequence_item("SEQUENCE")       ;
      finish_item(t)                              ;
      end                                         ; 
endtask

endclass