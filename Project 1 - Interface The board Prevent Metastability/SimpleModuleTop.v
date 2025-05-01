`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/17/2025 03:39:52 PM
// Design Name: 
// Module Name: Lab1
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


module Lab1(
    input sw,
    input reset,
    input clk,
    output [3:0] an,
    output [7:0] seg
    );
    
    wire synchWire, dbWire, cntEn;
    wire [3:0] count;
    assign an = 4'b1110;
    
    Synchron #(.NUMBITS(1)) synch1 (.clkS(clk),.inS(sw),.outS(synchWire));
    
    Debouncer #(.CLKSPDMHZ(100), .DELAYMS(10)) db1(.clk(clk), .reset(reset), .in(synchWire), .out(dbWire));
    
    OneShot os1(.clkOS(clk),.inOS(dbWire),.out(cntEn),.resetOS(reset));
    
    SimpleCounter cntr1(.clk(clk),.reset(reset),.cntEn(cntEn),.count(count));
    
    DisplayDriver disp( .indata(count),.clk(clk),.sseg(seg),.reset(reset));
endmodule

