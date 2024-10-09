class alu_monitor extends uvm_monitor;

/*Register To The Factory Using componenet utils */
`uvm_component_utils(alu_monitor)
virtual alu_intf moni_intf;
alu_sequence_item t_mon; 
alu_agent_config alu_agent_config_mon_instance;
uvm_analysis_port #(alu_sequence_item) mon_mail;

function  new(string name = "ALU_MONITOR", uvm_component parent = null);
    super.new(name,parent); 
endfunction 

function void build_phase(uvm_phase phase);
    super.build_phase(phase) ;
    `uvm_info("MONITOR","WE Are Compiling The Monitor",UVM_NONE);
    /***************************************************************************
    * if(!uvm_config_db #(virtual intf)::get(this,"","my_vif",moni_intf))
    * if the name isnt my_vif u will not recieve the interface 
    * the name must match the sent interface with the same name 
    ***************************************************************************/
    if(!uvm_config_db #(virtual alu_intf)::get(this,"","alu_my_vif",moni_intf))
        `uvm_info("MONITOR","ERROR INSIDE MONITOR",UVM_NONE);

    if(!uvm_config_db #(alu_agent_config)::get(this,"","simulation_config",alu_agent_config_mon_instance))
        `uvm_info("MON","ERROR INSIDE MON",UVM_NONE);

    t_mon = alu_sequence_item::type_id::create("t_mon"); 
    mon_mail = new("mon_mail",this); 
endfunction

function void connect_phase(uvm_phase phase);
    super.connect_phase(phase) ; 
endfunction

task run_phase (uvm_phase phase) ; 

    `uvm_info("MONITOR","WE ARE RUNNING THE MONITOR",UVM_NONE);
    `uvm_info("MONITOR","Monitor Starting To Recieve Data From the DUT",UVM_NONE);
    forever  begin 
      `uvm_info("MONITOR", "Monitor Is Waiting For Packet ......", UVM_MEDIUM);       
      if (alu_agent_config_mon_instance.is_active == UVM_ACTIVE) begin 
         @(posedge moni_intf.CLK);
         #1;
      end else begin                      
        @(negedge moni_intf.CLK)
        #2; 
      end 
      t_mon.A          = moni_intf.A;    
      t_mon.B          = moni_intf.B; 
      t_mon.ALU_FUN    = moni_intf.ALU_FUN;  
      t_mon.RST        = moni_intf.RST; 
      t_mon.Arith_Flag = moni_intf.Arith_Flag;
      if (alu_agent_config_mon_instance.is_active == UVM_PASSIVE) begin 
        @(posedge moni_intf.CLK);
        #1;
      end 
      t_mon.ALU_OUT    = moni_intf.ALU_OUT;
      t_mon.display_Sequence_item("Monitor");    
      `uvm_info("MONITOR","Monitor has Recieveed the data from the DUT",UVM_NONE);
      mon_mail.write(t_mon);  

    end 


endtask 


endclass