`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/17/2025 03:55:26 PM
// Design Name: 
// Module Name: OneShot
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


module OneShot(
input inOS,
input resetOS,
input clkOS,
output reg out
); 

reg[1:0] state; 

localparam IDLE = 0;
localparam OUTPUT1 = 1;
localparam WAITFOR0 = 2;

always @(posedge clkOS)
begin
    if(resetOS)
    begin
        state <= IDLE;
    end
    else
    begin
        case(state)
        IDLE:
            begin
                if(inOS)
                begin
                    state <= OUTPUT1;
                end
             end 
        OUTPUT1:
           begin
               state <= WAITFOR0;
           end
        WAITFOR0:
            begin
                if(~inOS)
                begin
                    state <= IDLE;
                end
             end   
         default:
         begin
            state <= IDLE;
         end
         endcase
      end
  end
  
  always @(state)
  begin
    case(state)  
        IDLE:out = 0;
        OUTPUT1: out = 1;
        WAITFOR0: out = 0;
        default: out = 0;
    endcase
 end
endmodule

