`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/22/2025 03:37:25 PM
// Design Name: 
// Module Name: DisplayDriver
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


module DisplayDriver(
        input [3:0] indata,
        input clk,
        output reg[7:0] sseg,
        
        input reset
    );
    
    always @(posedge clk)
    begin
        if (reset)
            sseg <= 8'b11000000;
        else
            case (indata)
                4'b0000: sseg <= 8'b11000000;
                4'b0001: sseg <= 8'b11111001;
                4'b0010: sseg <= 8'b10100100;
                4'b0011: sseg <= 8'b10110000;
                4'b0100: sseg <= 8'b10011001;
                4'b0101: sseg <= 8'b10010010;
                4'b0110: sseg <= 8'b10000010;
                4'b0111: sseg <= 8'b11111000;
                4'b1000: sseg <= 8'b10000000;
                4'b1001: sseg <= 8'b10011000;
                4'b1010: sseg <= 8'b10001000;
                4'b1011: sseg <= 8'b10000011;
                4'b1100: sseg <= 8'b10100111;
                4'b1101: sseg <= 8'b10100001;
                4'b1110: sseg <= 8'b10000110;
                4'b1111: sseg <= 8'b10001110;
                
                default: sseg = 8'b11111111;
           endcase
         end
endmodule
