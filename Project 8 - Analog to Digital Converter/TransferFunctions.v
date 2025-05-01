`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/30/2025 02:00:53 PM
// Design Name: 
// Module Name: TransferFunctions
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


module TransferFunctions(
    input clk,
    input [15:0] dataIn,
    output reg [15:0] bTempC,
    output reg [15:0] bTempF,
    output reg [15:0] bVcc
    );
    
    reg [31:0] p1,p2,p4,p5,p7;
    always@(posedge clk)
    begin
    
    p1 <= dataIn * 504;
    p2 <= p1/4096;
    bTempC <= p2 - 273;
    
    p4 <= dataIn * 907;
    p5 <= p4 / 4096;
    bTempF <= p5 - 460;
    
    p7 <= dataIn * 3000;
    bVcc <= p7 /4096;
    
    end
    
endmodule
