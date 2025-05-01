`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/12/2025 02:13:22 PM
// Design Name: 
// Module Name: Debounce
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


module Debounce #(parameter CLKSPDMHZ = 100 , parameter DELAYMS = 10) (
input in,
input clk,
input reset,
output reg out);

 wire [20:0] dbCountEnd;
    assign dbCountEnd = CLKSPDMHZ * DELAYMS * 1000;
    reg cntDone;
    reg [1:0] state;
    
 localparam OUTPUT0 = 0;
 localparam DETECT1 = 1;
 localparam OUTPUT1 = 2;
 localparam DETECT0 = 3;
    
always @(posedge clk) //Start State Mache
begin
if(reset) begin
    state <= OUTPUT0; //First State
end
    else begin
        case(state)
        OUTPUT0: 
            begin
                if(in)  //Exit OUTPUT0 on a 1
                begin
                    state <= DETECT1;
                end
             end
         DETECT1: //Second State
            begin
                if(cntDone) 
                state <= OUTPUT1;
            end
         OUTPUT1: //Third State
            begin
                if(~in) //Exit OUPUT 1 on a 0
                state <= DETECT0;
            end
         DETECT0: //Fourth State
            begin
                if(cntDone)
                state <= OUTPUT0;
            end
         default:
            begin
                state <= OUTPUT0; //Startg State so its default
            end
            endcase
        end
    end      
    
        
    reg [21:0] count;
    always@(posedge clk)
    begin
        if(reset)
        begin
            count <= 0;
            cntDone <= 0;
        end
        else
        begin
            if (state == OUTPUT1 || state == OUTPUT0)
            begin
                count <= 0;
            end
            else if (state == DETECT1 || state == DETECT0)
            begin
                count <= count + 1;
            end
            if (count > dbCountEnd)
            begin
                cntDone <= 1;
            end
            else
            begin
                cntDone <= 0;
            end
        end
    end
    always@(state)
    begin
        case(state)
        OUTPUT0: out = 0;
        DETECT1: out = 0;
        OUTPUT1: out = 1;
        DETECT0: out = 1;
        default: out = 0;
        endcase
        
    end
    
endmodule
