`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/12/2025 02:37:09 PM
// Design Name: 
// Module Name: BCDMathDIV
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


module BCDMathDIV( 
input [15:0] val,
input clk,
output reg [3:0] dig0,
output reg [3:0] dig1,
output reg [3:0] dig2,
output reg [3:0] dig3);

reg [15:0] a1, a2;

always@(posedge clk)
begin
    dig3 <= val/1000;

    a2 <= val%1000;
    dig2 <= a2/100;

    a1 <= val%100;
    dig1 <= a1/10;

    dig0 <= val%10;
end
endmodule
