interface  reg2_intf(

    output  logic clk_intf,
    output logic rst_intf, 
    output logic WrEn_intf, 
    output logic RdEn_intf,
    output logic [3:0]  Address_intf, 
    output logic [19:0] WrData_intf, 
    input  bit  [19:0] RdData_intf 
);
endinterface
