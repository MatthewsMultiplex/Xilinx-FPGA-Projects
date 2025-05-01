`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engeer: 
// 
// Create Date: 01/31/2025 03:23:22 PM
// Design Name: 
// Module Name: msTimerModule
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


module msTimerModule #(parameter CLKSPDMHZ = 100)(
input clk,
input reset,
input start,
input stop,
output reg [15:0] countMS 
    );
   
   reg enable; 
   reg [31:0] clkCount;
   
   localparam stopCount = 9999;
   localparam ONE_MS = CLKSPDMHZ * 1000 - 1;
   
   always@(posedge clk)
   begin
        if(reset) begin //Set all values to 0 on a reset
        enable <= 0;
        countMS <= 0;
        clkCount <= 0;
    end
    else begin
        if(enable) begin //If enable is 1 start the count
            clkCount <= clkCount + 1;
        end
        
        if(start) begin //If we press the start button, set enable to 1
            enable <= 1;
        end
        else if(stop) begin //If we press the stop button, set enable to 0
            enable <= 0;
        end
        
        if(clkCount == ONE_MS) begin //If clock is equal to a milisecond, add 1 to counter
            countMS <= countMS + 1;
            clkCount <= 0; // reset the count
            if (countMS == stopCount) begin 
                countMS <= 0;
            end
         end
      end
   end    
endmodule
