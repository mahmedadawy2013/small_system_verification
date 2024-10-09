class reg_monitor extends uvm_monitor;

/*Register To The Factory Using componenet utils */
`uvm_component_utils(reg_monitor)
virtual reg_intf moni_intf;
reg_sequence_item t_mon; 
uvm_analysis_port #(reg_sequence_item) mon_mail;

function  new(string name = "REG_MONITOR", uvm_component parent = null);
    super.new(name,parent) ; 
endfunction 

function void build_phase(uvm_phase phase);
    super.build_phase(phase) ;
    `uvm_info("MONITOR","WE Are Compiling The Monitor",UVM_NONE);
    /***************************************************************************
    * if(!uvm_config_db #(virtual intf)::get(this,"","my_vif",moni_intf))
    * if the name isnt my_vif u will not recieve the interface 
    * the name must match the sent interface with the same name 
    ***************************************************************************/
    if(!uvm_config_db #(virtual reg_intf)::get(this,"","reg_my_vif",moni_intf))
        `uvm_info("MONITOR","ERROR INSIDE MONITOR",UVM_NONE);
    t_mon = reg_sequence_item::type_id::create("t_mon"); 
    mon_mail = new("mon_mail",this); 
endfunction

function void connect_phase(uvm_phase phase);
    super.connect_phase(phase); 
endfunction

task run_phase (uvm_phase phase); 

    `uvm_info("MONITOR","WE ARE RUNNING THE MONITOR",UVM_NONE);
    `uvm_info("MONITOR","Monitor Starting To Recieve Data From the DUT",UVM_NONE);
    forever  begin 
      $display("Monitor Is Waiting For Packet ......");                                     
      @(posedge moni_intf.clk_intf)
      #1 
      t_mon.rst_tb             = moni_intf.rst_intf;    
      t_mon.Address_tb         = moni_intf.Address_intf; 
      t_mon.WrEn_tb            = moni_intf.WrEn_intf;  
      t_mon.RdEn_tb            = moni_intf.RdEn_intf; 
      t_mon.WrData_tb          = moni_intf.WrData_intf;
      t_mon.RdData_tb          = moni_intf.RdData_intf;
      t_mon.display_Sequence_item("Monitor");        
      `uvm_info("MONITOR","Monitor has Recieveed the datafrom the DUT",UVM_NONE);
      mon_mail.write(t_mon);  

    end 


endtask 


endclass