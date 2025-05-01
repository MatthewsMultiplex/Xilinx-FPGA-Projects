`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/23/2025 08:15:41 PM
// Design Name: 
// Module Name: debounce
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


module debounce #(parameter CLKSPEED = 100, DELAY = 5) (
input in,
input clk,
input reset,
output reg out);

localparam OUTPUT0 = 0;
localparam DETECT1 = 1;
localparam OUTPUT1 = 2;
localparam DETECT0 = 3;

reg [20:0] count;
wire [20:0] dbCount;
assign dbCount = CLKSPEED * DELAY * 1000;
reg [1:0] cs;
reg done;

always @(posedge clk)
begin
if (reset) begin
    cs <= OUTPUT0;
end
else begin
    case(cs)
        OUTPUT0: begin
            if (in) begin
                cs <= DETECT1;
            end
        end
        DETECT1: begin
            if (done) begin
                cs <= OUTPUT1;
            end
        end
        OUTPUT1: begin
            if (~in) begin
                cs <= DETECT0;
            end
        end
        DETECT0: begin
            if (done) begin
                cs <= OUTPUT0;
            end
        end
        default: begin
            cs <= OUTPUT0;
        end
    endcase
    end
end

always@(posedge clk)
begin
    if(reset) begin
        count <= 0;
        done <= 0;
    end
    else begin
        if (cs == OUTPUT0 || cs == OUTPUT1) begin
            count <= 0;
        end
        else if (cs == DETECT1 || cs == DETECT0) begin
            count <= count + 1;
        end
        
        if (count > dbCount) begin
            done <= 1;
        end
        else begin
            done <= 0;
        end
    end
end

always@(cs)
    begin
    case(cs)
        OUTPUT0: out = 0;
        DETECT1: out = 0;
        OUTPUT1: out = 1;
        DETECT0: out = 1;
        default: out = 0;
    endcase
    end
endmodule
