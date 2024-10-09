class alu_reset_sequence extends uvm_sequence;
/*Register To The Factory Using object utils */
`uvm_object_utils(alu_reset_sequence)
/*Create an instance from the sequence item to be the transaction data*/
alu_sequence_item t ; 

function  new(string name = "SEQUENCE ");
    super.new(name) ; 
endfunction

/* Pre body and body called by the start function which has been called from the test */

/* pre body function to act like the build phase  */
task pre_body();
    /*Create a handle from the sequence item to be the transaction data*/
    t = alu_sequence_item::type_id::create("t") ; 
endtask
/* body function to act like the run phase  */
task body();
      start_item(t);
      // $display(t.get_sequencer());
        t.randomize() with {t.RST  == 1'b0  ;}; 
        t.display_Sequence_item("SEQUENCE");
      finish_item(t); 
endtask

endclass

class alu_add_sequence extends uvm_sequence;
/*Register To The Factory Using object utils */
`uvm_object_utils(alu_add_sequence)
/*Create an instance from the sequence item to be the transaction data*/
alu_sequence_item t ; 

function  new(string name = "SEQUENCE ");
    super.new(name) ; 
endfunction

/* Pre body and body called by the start function which has been called from the test */

/* pre body function to act like the build phase  */
task pre_body();
    /*Create a handle from the sequence item to be the transaction data*/
    t = alu_sequence_item::type_id::create("t") ; 
endtask
/* body function to act like the run phase  */
task body();
      for (int i=0; i<16; ++i) begin
      start_item(t)                               ;
        t.randomize() with {t.RST  == 1'b1  ;
                            t.ALU_FUN == 4'b0000  ;  }  ; 
        t.display_Sequence_item("SEQUENCE")       ;
      finish_item(t)                              ;
      end                                         ; 
endtask

endclass

class alu_sub_sequence extends uvm_sequence;
/*Register To The Factory Using object utils */
`uvm_object_utils(alu_sub_sequence)
/*Create an instance from the sequence item to be the transaction data*/
alu_sequence_item t ; 

function  new(string name = "SEQUENCE ");
    super.new(name) ; 
endfunction

/* Pre body and body called by the start function which has been called from the test */

/* pre body function to act like the build phase  */
task pre_body();
    /*Create a handle from the sequence item to be the transaction data*/
    t = alu_sequence_item::type_id::create("t") ; 
endtask
/* body function to act like the run phase  */
task body();
      for (int i=0; i<16; ++i) begin
      start_item(t)                               ;
        t.randomize() with {t.RST  == 1'b1  ;
                            t.ALU_FUN == 4'b0001  ;  
                            t.A > t.B ; }  ; 
        t.display_Sequence_item("SEQUENCE")       ;
      finish_item(t)                              ;
      end                                         ; 
endtask

endclass

class alu_mult_sequence extends uvm_sequence;
/*Register To The Factory Using object utils */
`uvm_object_utils(alu_mult_sequence)
/*Create an instance from the sequence item to be the transaction data*/
alu_sequence_item t ; 

function  new(string name = "SEQUENCE ");
    super.new(name) ; 
endfunction

/* Pre body and body called by the start function which has been called from the test */

/* pre body function to act like the build phase  */
task pre_body();
    /*Create a handle from the sequence item to be the transaction data*/
    t = alu_sequence_item::type_id::create("t") ; 
endtask
/* body function to act like the run phase  */
task body();
      for (int i=0; i<16; ++i) begin
      start_item(t)                               ;
        t.randomize() with {t.RST  == 1'b1  ;
                            t.ALU_FUN == 4'b0010  ;  }  ; 
        t.display_Sequence_item("SEQUENCE")       ;
      finish_item(t)                              ;
      end                                         ; 
endtask

endclass

class alu_div_sequence extends uvm_sequence;
/*Register To The Factory Using object utils */
`uvm_object_utils(alu_div_sequence)
/*Create an instance from the sequence item to be the transaction data*/
alu_sequence_item t ; 

function  new(string name = "SEQUENCE ");
    super.new(name) ; 
endfunction

/* Pre body and body called by the start function which has been called from the test */

/* pre body function to act like the build phase  */
task pre_body();
    /*Create a handle from the sequence item to be the transaction data*/
    t = alu_sequence_item::type_id::create("t") ; 
endtask
/* body function to act like the run phase  */
task body();
      for (int i=0; i<16; ++i) begin
      start_item(t)                               ;
        t.randomize() with {t.RST  == 1'b1  ;
                            t.ALU_FUN == 4'b0011  ;  }  ; 
        t.display_Sequence_item("SEQUENCE")       ;
      finish_item(t)                              ;
      end                                         ; 
endtask

endclass

class alu_default_sequence extends uvm_sequence;
/*Register To The Factory Using object utils */
`uvm_object_utils(alu_default_sequence)
/*Create an instance from the sequence item to be the transaction data*/
alu_sequence_item t ; 

function  new(string name = "SEQUENCE ");
    super.new(name) ; 
endfunction

/* Pre body and body called by the start function which has been called from the test */

/* pre body function to act like the build phase  */
task pre_body();
    /*Create a handle from the sequence item to be the transaction data*/
    t = alu_sequence_item::type_id::create("t") ; 
endtask
/* body function to act like the run phase  */
task body();
      for (int i=0; i<16; ++i) begin
      start_item(t)                               ;
        t.randomize() with {t.RST  == 1'b1  ;
                            t.ALU_FUN >3  ;    }  ; 
        t.display_Sequence_item("SEQUENCE")       ;
      finish_item(t)                              ;
      end                                         ; 
endtask

endclass