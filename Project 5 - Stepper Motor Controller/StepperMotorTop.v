`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/26/2025 03:43:09 PM
// Design Name: 
// Module Name: StepperMotorTop
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


module StepperMotorTop(
input clk, 
input reset,
//input dir,
input run, 
output reg [3:0] state,
output reg [3:0] stepOut
    );
    
    
 wire dn; 
 reg [31:0] StateCountVal = 500000;
 
 
 localparam STEP1 = 0,   
            STEP2 = 1,
            STEP3 = 2, 
            STEP4 = 3;
    
    FSMDelayCounter counter(.clk(clk),.reset(reset),.dn(dn),.len(StateCountVal));
    
    always @(posedge clk)
        if (reset) begin
            state <= STEP1;
            end
        else begin
            case(state)
                STEP1:
                    if(run && dn) begin
                    state <= STEP2; 
                    end
                STEP2:
                    if(run && dn) begin
                    state <= STEP3;
                    end
                STEP3: 
                    if(run && dn) begin
                    state <= STEP4;
                    end
                STEP4: 
                    if(run && dn) begin
                    state <= STEP1;
                    end
                default: state <= STEP1;
                endcase
             end
    
    
    always @(state) begin
        case(state)
            STEP1: stepOut = 4'b0101;
            STEP2: stepOut = 4'b0110;
            STEP3: stepOut = 4'b1010;
            STEP4: stepOut = 4'b1001;
        endcase
        end
endmodule
