`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/31/2025 03:28:32 PM
// Design Name: 
// Module Name: dispDR
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


module dispDriver #(parameter CLKSPD = 100, parameter DISPFREQ = 75)(
input clk,
input reset,
input [15:0] count,
output reg [3:0] an,
output reg [7:0] sseg);

localparam hex0stop = $rtoi(0.25*CLKSPD*1000000/(DISPFREQ*4));
localparam hex1stop = $rtoi(0.5*CLKSPD*1000000/(DISPFREQ*4));
localparam hex2stop = $rtoi(0.75*CLKSPD*1000000/(DISPFREQ*4));
localparam hex3stop = $rtoi(1.0*CLKSPD*1000000/(DISPFREQ*4));

// Use below for all displays other than Double Dabble
wire [3:0] hex0, hex1, hex2, hex3;
//wire [3:0] dd0, dd1, dd2, dd3;
// Use below for Double Dabble (reg)
//reg [3:0] hex0, hex1, hex2, hex3;
reg [1:0] segment;
reg [31:0] freqcount;

// Use below for basic hex display
//assign hex0 = count[3:0];
//assign hex1 = count[7:4];
//assign hex2 = count[11:8];
//assign hex3 = count[15:12];

//BCDLookupROM rom (.val(count), .dig0(hex0), .dig1(hex1), .dig2(hex2), .dig3(hex3));
//BCDTableRAM ram (.clk(clk), .val(count), .dig0(hex0), .dig1(hex1), .dig2(hex2), .dig3(hex3));
BCDMathDIV div (.clk(clk), .val(count), .dig0(hex0), .dig1(hex1), .dig2(hex2), .dig3(hex3));
//BCDDoubleDabble dd (.clk(clk), .reset(reset), .val(count), .start(startDD), .bcd0(dd0), .bcd1(dd1), .bcd2(dd2), .bcd3(dd3), .done(doneDD));

// Double Dabble Polling Circuit
reg [1:0] stateDD;
reg startDD;
wire doneDD;
localparam STARTON = 0;
localparam STARTOFF = 1;
localparam LATCH = 2;

/*always@(posedge clk)
begin
    if (reset) begin
        stateDD <= STARTON;
        startDD <= 0;
    end
    case(stateDD)
    STARTON: begin
        startDD <= 1;
        stateDD <= STARTOFF;
    end
    STARTOFF: begin
        startDD <= 0;
        if (doneDD) begin
            stateDD <= LATCH;
        end
    end
    LATCH: begin
        hex0 <= dd0;
        hex1 <= dd1;
        hex2 <= dd2;
        hex3 <= dd3;
        if (~doneDD) begin
            stateDD <= STARTON;
        end
    end
    default: begin
        startDD <= 0;
        stateDD <= STARTON;
    end
    endcase
end*/

always@(posedge clk)
begin
    freqcount <= freqcount + 1;
    if (freqcount < hex0stop) begin
        segment <= 0;
    end
    else if (freqcount < hex1stop) begin
        segment <= 1;
    end
    else if (freqcount < hex2stop) begin
        segment <= 2;
    end
    else if (freqcount < hex3stop) begin
        segment <= 3;
    end
    else begin
        freqcount <= 0;
    end
end

reg [3:0] hexVal;
reg [3:0] AN;

always@(segment, hex0, hex1, hex2, hex3)
begin
    case(segment)
    0: begin
        hexVal <= hex0;
        AN <= 4'b1110;
    end
    1: begin
        hexVal <= hex1;
        AN <= 4'b1101;
    end
    2: begin
        hexVal <= hex2;
        AN <= 4'b1011;
    end
    3: begin
        hexVal <= hex3;
        AN <= 4'b0111;
    end
    endcase
end   

always@(posedge clk)
begin
    an <= AN;
    case(hexVal)
            4'b0000: sseg <= 8'b11000000;
            4'b0001: sseg <= 8'b11111001;
            4'b0010: sseg <= 8'b10100100;
            4'b0011: sseg <= 8'b10110000;
            4'b0100: sseg <= 8'b10011001;
            4'b0101: sseg <= 8'b10010010;
            4'b0110: sseg <= 8'b10000010;
            4'b0111: sseg <= 8'b11111000;
            4'b1000: sseg <= 8'b10000000;
            4'b1001: sseg <= 8'b10011000;
            4'b1010: sseg <= 8'b10001000;
            4'b1011: sseg <= 8'b10000011;
            4'b1100: sseg <= 8'b10100111;
            4'b1101: sseg <= 8'b10100001;
            4'b1110: sseg <= 8'b10000110;
            4'b1111: sseg <= 8'b10001110;
            default: sseg <= 8'b11000000;
        endcase
end  
endmodule
