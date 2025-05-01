`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/16/2025 04:37:56 PM
// Design Name: 
// Module Name: spiMaster
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


module spiMaster(
input clk,
input reset,
input start,
input MISO,
output reg SCLK,
output reg CS,
output reg [15:0] wordReg);

reg [2:0] state;
reg [31:0] delay; 
reg [15:0] bitCnt;
reg en, inReg;
wire dn;

localparam INIT = 0,
           A = 1,
           B = 2,
           C = 3,
           D = 4,
           E = 5,
           F = 6,
           G = 7;

delayTimer timer(.clk(clk), .reset(reset), .enable(en), .length(delay), .done(dn));

// inReg Latching
always@(posedge clk)
begin
    if(reset) begin
        inReg <= 0;
    end
    else if(state == C) begin
        inReg <= MISO;
    end
end

// wordReg Latching
always@(negedge clk)
begin
    if(reset) begin
        wordReg <= 0;
    end
    else if(state == E) begin
        wordReg <= {wordReg[14:0], inReg};
    end
end

// bitCnt Counter
always@(posedge clk)
begin
    if(state == INIT || reset) begin
        bitCnt <= 0;
    end
    else if(state == C) begin
        bitCnt = bitCnt + 1;
    end
end

// Output Mapping
always@(state)
begin
    case(state)
        INIT: begin
            CS = 1;
            SCLK = 0;
            delay = 0;
            en = 0;
        end
        A: begin
            CS = 0;
            SCLK = 0;
            delay = 100;
            en = 1;
        end
        B: begin
            CS = 0;
            SCLK = 0;
            delay = 25; // or 50
            en = 1;
        end
        C: begin
            CS = 0;
            SCLK = 0;
            delay = 0;
            en = 0;
        end
        D: begin
            CS = 0;
            SCLK = 1;
            delay = 25;
            en = 1;
        end
        E: begin
            CS = 0;
            SCLK = 1;
            delay = 0;
            en = 0;
        end
        F: begin
            CS = 0;
            SCLK = 0;
            delay = 50;
            en = 1;
        end
        G: begin
            CS = 0;
            SCLK = 0;
            delay = 100;
            en = 1;
        end
    endcase
end

// State Mapping
always@(posedge clk)
begin
    if (reset) begin
        state <= INIT;
    end
    else begin
        case(state)
            INIT: begin
                if(start) begin
                    state <= A;
                end
            end
            A: begin
                if(dn) begin
                    state <= B;
                end
            end
            B: begin
                if(dn) begin
                    state <= C;
                end
            end
            C: begin
                state <= D;
            end
            D: begin
                if(dn) begin
                    state <= E;
                end
            end
            E: begin
                if(bitCnt == 8) begin
                    state <= F;
                end
                else if(bitCnt == 16) begin
                    state <= G;
                end
                else begin
                    state <= B;
                end
            end
            F: begin
                if(dn) begin
                    state <= A;
                end    
            end
            G: begin
                if(dn) begin
                    state <= INIT;
                end
            end
        endcase
    end
end
        
endmodule
