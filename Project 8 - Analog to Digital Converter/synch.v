`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/20/2025 10:36:57 PM
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


module synch #(parameter NUMBITS = 2)(
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
