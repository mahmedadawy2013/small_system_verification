class reg2_sequence_item extends uvm_sequence_item  ;
/*Register To The Factory Using object utils */
`uvm_object_utils(reg2_sequence_item)

/* declaration of the input output signals */
// This is the base transaction object Container that will be used 
// in the environment to initiate new transactions and // capture transactions at DUT interface
rand  bit        rst_tb;
rand  bit        WrEn_tb;
rand  bit        RdEn_tb;
randc bit [3:0]  Address_tb; 
rand  bit [19:0] WrData_tb; 
bit       [19:0] RdData_tb; 


/* declaration of the Constraints for input output signals */

      constraint un { unique {WrEn_tb,RdEn_tb} ;  }

function  new(string name = "REG2 SEQUENCE_ITEM ");
    super.new(name) ; 
endfunction

/* Function to display the transaction at any time*/

function void display_Sequence_item(input string name = "REG2 SEQUENCE ITEM" ); 
    `uvm_info("REG", $sformatf("*************** This is the REG2 %0s **********************", name), UVM_LOW)
    `uvm_info("REG", $sformatf(" rst_tb     = %0d WrEn_tb    =   %0d", rst_tb, WrEn_tb), UVM_LOW)
    `uvm_info("REG", $sformatf(" RdEn_tb    = %0d Address_tb =   %0d", RdEn_tb, Address_tb), UVM_LOW)
    `uvm_info("REG", $sformatf(" WrData_tb  = %0d RdData_tb  =   %0d", WrData_tb, RdData_tb), UVM_LOW)
    `uvm_info("REG", $sformatf(" OP         = %0d", RdData_tb[19:16]), UVM_LOW)
    `uvm_info("REG", $sformatf(" A          = %0d B = %0d", RdData_tb[7:0], RdData_tb[15:8]), UVM_LOW)
    `uvm_info("REG", "**********************************************************", UVM_LOW)
endfunction 

endclass
    

	  