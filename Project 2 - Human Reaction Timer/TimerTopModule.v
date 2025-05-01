`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engeer: 
// 
// Create Date: 01/31/2025 03:33:56 PM
// Design Name: 
// Module Name: TimerTopModule
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module TimerTopModule(
//input [2:0] sw,
input clk,
input strtbtn,
input stpbtn,
input reset,
output [3:0] an,
output [7:0] seg
    );
    wire [1:0] SynchWire;
    wire DB1wire, DB2wire, OS1wire, OS2wire;
    wire [15:0] countMS;
    
    Synch1 #(.NUMBITS(2)) synch1 (.clk(clk),.in({strtbtn,stpbtn}),.out(SynchWire));
    
    Debouncer1 #(.CLKSPDMHZ(100), .DELAYMS(10)) db1(.clk(clk),.reset(reset),.in(SynchWire[1]),.out(DB1Wire));
    
    Debouncer2 #(.CLKSPDMHZ(100), .DELAYMS(10)) db2(.clk(clk),.reset(reset),.in(SynchWire[0]),.out(DB2Wire));
    
    OneShotOutput1 os1(.clk(clk),.reset(reset),.in(DB1Wire),.out(OS1wire));
    
    OneShotOutput2 os2(.clk(clk),.reset(reset),.in(DB2Wire),.out(OS2wire));
    
    msTimerModule msTimer(.clk(clk),.reset(reset),.start(OS1wire),.stop(OS2wire),.countMS(countMS));
    
    DispDriver dispDR(.clk(clk),.reset(reset),.indata(countMS),.sseg(seg),.latchAN(an));
    
endmodule
