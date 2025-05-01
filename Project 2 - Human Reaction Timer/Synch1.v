`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engeer: 
// 
// Create Date: 01/31/2025 03:10:42 PM
// Design Name: 
// Module Name: Synch1
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


module Synch1 #(parameter NUMBITS = 2)(
input clk, //clk for synchronizer
input [NUMBITS-1:0] in,
output reg [NUMBITS-1:0] out
    );
   
    reg [1:0] tempVal; 
 
 always@(posedge clk)
 begin
        tempVal <= in;
        out <= tempVal;
 end 
    
    
endmodule
