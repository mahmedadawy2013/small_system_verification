
class top_sequence_item extends uvm_sequence_item  ;
/*Register To The Factory Using object utils */
`uvm_object_utils(top_sequence_item)

/* declaration of the input output signals */
// This is the base transaction object Container that will be used 
// in the environment to initiate new transactions and // capture transactions at DUT interface
rand  bit  sel_top; 
rand  bit  data_valid_top;
      bit  tx_out_top;
      bit  busy_top;   
      bit  [19:0] mux_out_top; 


function  new(string name = "SEQUENCE_ITEM ");
    super.new(name) ; 
endfunction

/* Function to display the transaction at any time*/



function void display_Sequence_item(input string name = "SEQUENCE ITEM");
    `uvm_info("TOP_PRINT", $sformatf("*************** This is the TOP %0s **********************", name), UVM_LOW)
    `uvm_info("TOP_PRINT", $sformatf(" sel_top     = %0d    mux_out_top    =   %0d", sel_top, mux_out_top), UVM_LOW)
    `uvm_info("TOP_PRINT", "**********************************************************", UVM_LOW)
endfunction


endclass
    

	  