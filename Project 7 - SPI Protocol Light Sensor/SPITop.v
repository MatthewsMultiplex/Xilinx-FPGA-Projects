`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/16/2025 04:37:18 PM
// Design Name: 
// Module Name: SPITop
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


module SPITop(
input clk,
input reset,
input start,
input MISO,
output SCLK,
output CS,
output [15:0] led,
output [3:0] an,
output [7:0] seg);

wire synchWire, dbWire, osWire;
wire [7:0] dispVal;
wire [15:0] wordReg;

synch synch(.clk(clk), .in(start), .out(synchWire));
debounce db(.clk(clk), .reset(reset), .in(synchWire), .out(dbWire));
OneShotOutput os(.clk(clk), .reset(reset), .in(dbWire), .out(osWire));
spiMaster spi(.clk(clk),
              .reset(reset),
              .start(osWire),
              .MISO(MISO),
              .SCLK(SCLK),
              .CS(CS),
              .wordReg(wordReg));

assign led = wordReg;
assign dispVal = wordReg[11:4]; // strip off top and bottom 4 bits

dispDriver dd(.clk(clk), .reset(reset), .count(dispVal), .an(an), .sseg(seg));
           
endmodule
