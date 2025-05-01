`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/14/2025 04:12:21 PM
// Design Name: 
// Module Name: binaryToBCDDivideMod
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


module binaryToBCDDivideMod(
        input clk,
        input [13:0] val,
        output reg [3:0] bcd3,
        output reg [3:0] bcd2,
        output reg [3:0] bcd1,
        output reg [3:0] bcd0
    );
    
    reg [15:0] p1,p2;
    always @ (posedge clk)
    begin
        bcd3 <= val/1000;
     //bcd2 <= (val%1000)/100;   
            p1 <= val%1000;
            bcd2 <= p1/100;
            
            p2 <= p1%100;
            bcd1 <= p2/10;
            
            bcd0 <= p2%10;
    //bcd1 <= ((val%1000)%100)/10;
    //bcd0 <= ((val
    end
endmodule
