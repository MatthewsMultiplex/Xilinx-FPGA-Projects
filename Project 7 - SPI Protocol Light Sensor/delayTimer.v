`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/26/2025 02:28:52 PM
// Design Name: 
// Module Name: delayTimer
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


module delayTimer(
input clk,
input reset,
input enable,
input [31:0] length,
output reg done);

reg [31:0] count;

always@(posedge clk)
begin
    if(reset) begin
        count <= 0;
        done <= 0;
    end
    else if (count == length) begin
        done <= 1;
        count <= 0;
    end
    else if (enable == 0) begin
        count <= 0;
        done <= 0;
    end
    else begin
        if (enable) begin
            count <= count + 1;
        end
        done <= 0;
    end
end

endmodule