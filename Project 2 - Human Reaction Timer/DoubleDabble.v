`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/21/2025 02:48:46 PM
// Design Name: 
// Module Name: DoubleDabble
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


module DoubleDabble(
input reset,
input [13:0] val,
input start,
input clk,
output reg done,
output  [3:0] bcd3,
output  [3:0] bcd2,
output  [3:0] bcd1,
output  [3:0] bcd0
    );
reg [29:0] workreg = 0;   
reg [2:0] state; 
reg [3:0] shiftCnt;  

assign {bcd3,bcd2,bcd1,bcd0} = workreg[29:14];


localparam IDLE = 0;
localparam SHIFT = 1;
localparam CHECK = 2;
localparam ADD = 3;
localparam DONE = 4;
    
always @(posedge clk)
begin     
    if(reset)
    begin
        state <= IDLE;
    end
    else
    begin 
        case(state)
        IDLE:
            begin 
            shiftCnt <= 0;
            done <= 0;
                if(start == 1)
                    begin
                    workreg <= {16'h0000, val};
                    state <= SHIFT;
                   end
                end
         SHIFT:
                begin
                workreg <= workreg << 1;
                state <= CHECK;
                end
         CHECK: 
                begin 
                    shiftCnt <= shiftCnt + 1;
                    if (shiftCnt < 13)
                    begin
                    state <= ADD;
                    end
                    else if (shiftCnt == 13)
                    begin
                 
                    state <= DONE;
                    end
                 end
        
           ADD:
                begin
                    state <= SHIFT;
                    if(workreg[29:26] > 4) begin
                       workreg[29:26] <= workreg[29:26] + 3;
                       end
                    if(workreg[25:22] > 4) begin
                        workreg[25:22] <= workreg[25:22] + 3;
                        end
                    if(workreg[21:18] > 4) begin
                        workreg[21:18] <= workreg[21:18] + 3;
                        end
                    if(workreg[17:14] >4) begin
                        workreg[17:14] <= workreg[17:14] + 3;
                    end
                    state <= SHIFT;
                    end
                DONE: 
                begin
                    done <= 1;
                state <= IDLE;
                 end
                 
                default:
                 begin
                    state <= IDLE;
                    end
           endcase     
          end 
        end
    
endmodule
