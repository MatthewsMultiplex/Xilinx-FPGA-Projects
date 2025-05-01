`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/22/2025 03:00:57 PM
// Design Name: 
// Module Name: SimpleCounter
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


module SimpleCounter(
    input clk,
    input cntEn,
    input reset,
    output reg[3:0] count
    );
    
    always @(posedge clk)
    begin 
        if(reset)
            count <= 0;
        else if(cntEn)
            count <= count + 1;
    end
endmodule
