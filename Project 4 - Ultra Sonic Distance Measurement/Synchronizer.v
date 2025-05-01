`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/12/2025 02:12:04 PM
// Design Name: 
// Module Name: Synchronizer
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


module Synchronizer #(parameter NUMBITS = 1) (
 input clk, //clk for synchronizer
 input [NUMBITS-1:0] in,
 output reg [NUMBITS-1:0] out
    );
    
 reg tempVal; 
 
 always@(posedge clk)
 begin
        tempVal <= in;
        out <= tempVal;
 end
 
endmodule