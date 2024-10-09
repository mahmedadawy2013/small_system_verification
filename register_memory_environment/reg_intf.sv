interface  reg_intf(

    output  logic clk_intf,
    output logic rst_intf, 
    output logic WrEn_intf, 
    output logic RdEn_intf,
    output logic [3:0]  Address_intf, 
    output logic [19:0] WrData_intf, 
    input  bit  [19:0] RdData_intf 

);
// bit force_enable;

// function  drive_stimilus(/* signals */);
//     driv_intf.rst_intf      = t_drive.rst_tb; 
//     driv_intf.Address_intf  = t_drive.Address_tb;
//     driv_intf.WrEn_intf     = t_drive.WrEn_tb;  
//     driv_intf.RdEn_intf     = t_drive.RdEn_tb; 
//     driv_intf.WrData_intf   = t_drive.WrData_tb;
// endfunction

endinterface
