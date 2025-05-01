`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/07/2025 02:56:26 PM
// Design Name: 
// Module Name: UltraSonicTo
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


module UltraSonicTo(
input reset,
input start, 
input usPulse,
input clk,
output reg [2:0] state,
output [7:0] seg,
output [3:0] an,
output  reg measurement
    );
    
    wire SynchWire;
    wire dbFSMWire;
    wire OSWire;
    wire dn;
    

reg [31:0] count;
reg [13:0] usCount;
reg [13:0] displayVal;
wire en; 

wire [31:0] stateLength;

assign stateLength = 1100; 

localparam IDLE = 0,
           INIT = 1,
           WAIT = 2,
           MEASURE = 3,
           MEASUREDONE = 4;
    
    
Synchronizer #(.NUMBITS()) synch1(.clk(clk),.in(start),.out(SynchWire));  

Debounce #(.CLKSPDMHZ(100), .DELAYMS(10)) dbFSM(.clk(clk),.in(SynchWire),.reset(reset),.out(dbFSMWire));
    
Oneshotmod os1(.clk(clk),.reset(reset),.in(dbFSMWire),.out(OSWire)); 

assign en = (state == INIT);

fsmDelayCounter fsmCnt(.enable(en),.len(stateLength),.clk(clk),.dn(dn),.reset(reset));

DispDriver dd1(.clk(clk),.indata(displayVal),.sseg(seg),.latchAN(an),.reset(reset));



      
           
always @ (posedge clk) begin

if (reset) begin
    count <= 0;
    usCount <= 0;
    measurement <= 0;
    state <= IDLE;
    end
    else 
    begin 
        case(state)
        IDLE: 
            begin
               count <= 0;
               usCount <= 0;
               measurement <= 0;
                if(OSWire) begin
                state <= INIT; 
                end
            end
        INIT: 
            begin
                measurement <= 1;
                //en <= 1;
                if(dn) begin
                state <= WAIT;
                end
            end
         WAIT: 
            begin
                measurement <= 0;
                if(usPulse) begin
                state <= MEASURE; 
                end
            end
                
         MEASURE:
              begin 
                count <= count + 1;
                if(count == 99) begin
                    count <= 0;
                    usCount <= usCount + 1; 
                    end
                 if(usPulse == 0) begin
                 state <= MEASUREDONE; 
                 end
             end
         MEASUREDONE: 
                    begin 
                        displayVal <= usCount/58; 
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
