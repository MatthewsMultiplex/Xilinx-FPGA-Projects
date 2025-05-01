`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/04/2025 03:12:21 PM
// Design Name: 
// Module Name: Lab6Top
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


module Lab6Top(
input clk,
input reset,
input [11:0] sw,
input dir,
//output reg [1:0] pulse_out,
output reg [1:0] motorOut

    );
    
wire clk_out1;
wire [11:0] R;
reg [11:0] count;
assign R = sw;
    
    
       clk_wiz_0 instance_name
   (
    // Clock out ports
    .clk_out1(clk_out1),     // output clk_out1
    // Status and control signals
    .reset(reset), // input reset
   // Clock in ports
    .clk_in1(clk)      // input clk_in1
);

  
//  always @ (posedge clk_out1) begin
//    count = count + 1;
//    if (count < R) begin
//        pulse_out <= 1;
//        end
//    else begin
//        count <= 0;
//    end
//   end 
    
    always @ (posedge clk_out1) begin
        count = count + 1;
        if (count < R && dir) begin
            motorOut <= 2'b01;
            end
         else if (count < R && ~dir) begin
            motorOut <= 2'b10;
        end
        else begin
            motorOut <= 2'b00; 
        end
        end
    
    
    
   
endmodule
