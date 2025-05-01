`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/25/2025 04:09:45 PM
// Design Name: 
// Module Name: fsm1
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


module fsm1(
input clk,
input reset,
input [15:0] inData,
output reg [15:0] outData
    );
    
 reg [1:0] state; 
 reg [31:0] count; 
    
 localparam IDLE = 0, 
            WAIT = 1,
            LATCH = 2; 
            
 always @ (posedge clk) begin
 if(reset) begin
    state <= IDLE; 
end 
else begin
    case(state)
        IDLE: begin
            count <= 0;
            state <= WAIT;
            end
        WAIT: begin
           
            if(count > 50000000) begin
            state <= LATCH; 
            end
            else begin
            state <= WAIT;
            count <= count + 1;
            end
            end
            LATCH: begin
            outData <= {4'b0000, inData[15:4]};
            state <= IDLE;
            end
            default: state <= IDLE;
        
        endcase
 end
 end
  
endmodule
