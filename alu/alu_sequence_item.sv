class alu_sequence_item extends uvm_sequence_item  ;
/*Register To The Factory Using object utils */
`uvm_object_utils(alu_sequence_item)

/* declaration of the input output signals */
// This is the base transaction object Container that will be used 
// in the environment to initiate new transactions and // capture transactions at DUT interface
  rand  bit  [7:0]  A;
  rand  bit  [7:0]  B;
  rand  bit  [3:0]  ALU_FUN;
  rand  bit         RST;
  bit               Arith_Flag; 
  bit  [15:0]       ALU_OUT;

/* declaration of the Constraints for input output signals */
// constraint op {ALU_FUN <4 ;}

function  new(string name = "SEQUENCE_ITEM ");
    super.new(name) ; 
endfunction

/* Function to display the transaction at any time*/

function void display_Sequence_item(input string name = "SEQUENCE ITEM" ); 

    `uvm_info("ALU_INFO", $sformatf("*************** This is the ALU %0P **********************", name), UVM_MEDIUM);
    `uvm_info("ALU_INFO", $sformatf("rst_tb     = %0d ALU_FUN    =   %0d", RST, ALU_FUN), UVM_MEDIUM);
    `uvm_info("ALU_INFO", $sformatf("A          = %0d B          =   %0d", A  , B       ), UVM_MEDIUM);
    `uvm_info("ALU_INFO", $sformatf("Arith_Flag = %0d ALU_OUT    =   %0d", Arith_Flag, ALU_OUT), UVM_MEDIUM);
    `uvm_info("ALU_INFO", "**********************************************************", UVM_MEDIUM);

        
endfunction 

endclass
    

	  