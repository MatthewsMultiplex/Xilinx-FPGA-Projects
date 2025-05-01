`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/25/2025 03:16:06 PM
// Design Name: 
// Module Name: AtoDTop
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


module AtoDTop(
input reset,
input clk,
input [1:0] sw,
output [3:0] an,
output [7:0] seg,
output reg [15:0] dispData
    );

 wire [1:0] swWire1, swWire2; 
 wire en, ready;
 reg Address_in;
 reg [1:0] state;
 wire [15:0] convertedData;
 wire [15:0] digitalReadData;
 
 wire [15:0] btempC, btempF, bVcc;

 
 
synch #(.NUMBITS(2)) synch(.clk(clk),.in(sw),.out(swWire1));
db0 db0(.clk(clk),.reset(reset),.in(swWire1[0]),.out(swWire2[0]));
db1 db1(.clk(clk),.reset(reset),.in(swWire1[1]),.out(swWire2[1]));
fsm1 fsm1(.clk(clk),.reset(reset),.inData(convertedData),.outData(digitalReadData));
TransferFunctions Transfer(.clk(clk),.dataIn(digitalReadData),.bTempC(btempC),.bTempF(btempF),.bVcc(bVcc));
dispDriver disp1(.clk(clk),.reset(reset),.count(dispData),.sseg(seg),.an(an));

xadc_wiz_0 your_instance_name (
  .di_in(0),              // input wire [15 : 0] di_in
  .daddr_in(Address_in),        // input wire [6 : 0] daddr_in
  .den_in(en),            // input wire den_in
  .dwe_in(0),            // input wire dwe_in
  .drdy_out(ready),        // output wire drdy_out
  .do_out(convertedData),            // output wire [15 : 0] do_out
  .dclk_in(clk),          // input wire dclk_in
  .reset_in(reset),        // input wire reset_in
  .vp_in(0),              // input wire vp_in
  .vn_in(0),              // input wire vn_in
  .channel_out(),  // output wire [4 : 0] channel_out
  .eoc_out(en),          // output wire eoc_out
  .alarm_out(),      // output wire alarm_out
  .eos_out(),          // output wire eos_out
  .busy_out()        // output wire busy_out
);
    
    always@ (swWire2, btempC, btempF, bVcc)
    begin
        case(swWire2)
        0: begin
        Address_in = 8'h00;
        dispData = btempC;
        end
        1: begin
        Address_in = 8'h00;
        dispData = btempF;
        end
        2: begin
        Address_in = 8'h01;
        dispData = bVcc;
        end
        3: begin
        Address_in = 8'h02;
        dispData = bVcc; 
        end
        default: begin
        Address_in = 8'h00;
        dispData = 9999; 
        end
    endcase
 end
    
    
endmodule
