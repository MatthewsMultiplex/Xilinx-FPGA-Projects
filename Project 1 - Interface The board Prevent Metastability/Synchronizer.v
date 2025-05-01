`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/17/2025 03:35:13 PM
// Design Name: 
// Module Name: Sync
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


module Synchron #(parameter NUMBITS = 1) (
 input clkS, //clk for synchronizer
 input [NUMBITS-1:0] inS,
 output reg [NUMBITS-1:0] outS
    );
    
 reg tempVal; 
 
 always@(posedge clkS)
 begin
        tempVal <= inS;
        outS <= tempVal;
 end
 
endmodule
