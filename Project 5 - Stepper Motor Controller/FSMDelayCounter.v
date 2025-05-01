`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/26/2025 03:48:00 PM
// Design Name: 
// Module Name: FSMDelayCounter
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


module FSMDelayCounter(
input clk,
input [31:0] len,
input reset,
output reg dn
    );
reg [31:0] count;    
    
always @(posedge clk)  
        begin
            if(reset) begin
                dn <= 0;
                count <= 0;
            end
            else if(count == len) begin
                dn = 1;
                count = 0;
            end
            else begin
                dn = 0;
                count = count + 1;
            end
         end    
endmodule