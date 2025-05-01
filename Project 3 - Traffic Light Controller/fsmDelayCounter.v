`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/26/2025 02:13:52 PM
// Design Name: 
// Module Name: fsmDelayCounter
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


module fsmDelayCounter(
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
