class top_driver extends uvm_driver #(top_sequence_item);
/**************************************************************************
* Dont Forget To make the Class parametrized with th sequence Item 
* to avoid the error at TLM Synchornization 
**************************************************************************/
/*Register To The Factory Using componenet utils */

`uvm_component_utils(top_driver)

virtual top_intf top_driv_intf;
top_sequence_item t_drive; 

function  new(string name = "TOP_DRIVER ", uvm_component parent = null);
    super.new(name,parent); 
endfunction

function void build_phase(uvm_phase phase);
    super.build_phase(phase) ;
    `uvm_info("DRIVER","WE Are Compiling The Driver",UVM_NONE);
    /***************************************************************************
    * if(!uvm_config_db #(virtual intf)::get(this,"","my_vif",top_driv_intf))
    * if the name isnt my_vif u will not recieve the interface 
    * the name must match the sent interface with the same name 
    ***************************************************************************/
    if(!uvm_config_db #(virtual top_intf)::get(this,"","my_vif",top_driv_intf))
        `uvm_info("DRIVER","ERROR INSIDE DRIVER",UVM_NONE);
    t_drive = top_sequence_item::type_id::create("t_drive");
    
endfunction

function void connect_phase(uvm_phase phase);
    super.connect_phase(phase) ; 
endfunction

task run_phase (uvm_phase phase) ; 
    `uvm_info("DRIVER","WE ARE RUNNING THE DRIVER",UVM_NONE);
    forever begin 
    seq_item_port.get_next_item(t_drive); 
    @(negedge top_driv_intf.clk_top_intf)
    t_drive.display_Sequence_item("DRIVER");
    `uvm_info("DRIVER","Drive has insert the data into the DUT ",UVM_NONE) ;
    top_driv_intf.sel_top_intf         = t_drive.sel_top; 
    top_driv_intf.data_valid_top_intf  = t_drive.data_valid_top;  
    if (t_drive.data_valid_top == 1 ) begin 
        @ (posedge top_driv_intf.clk_top_intf);
        @(negedge top_driv_intf.clk_top_intf)
        top_driv_intf.data_valid_top_intf     = 0; 
    end 
    seq_item_port.item_done(); 
    end 
endtask 
endclass