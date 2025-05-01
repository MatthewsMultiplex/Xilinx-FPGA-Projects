`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/12/2025 03:53:24 PM
// Design Name: 
// Module Name: DispDriver
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


module DispDriver #(parameter CLK_FREQ = 100, parameter DISP_FREQ = 75)(
        input clk,
        output reg[7:0] sseg,
        output reg[3:0] latchAN,
        input reset,
        input  [15:0] indata
    );
    
    
    reg[1:0] segselect;
    reg[15:0] data;
    //wire [3:0] hex0,hex1,hex2,hex3;
   //reg [3:0] hex0,hex1,hex2,hex3;
    wire [3:0] rom3,rom2,rom1,rom0;
  //  wire [3:0] ram3,ram2,ram1,ram0;
   // wire [3:0] pl3,pl2,pl1,pl0;
    //reg [3:0] dd3,dd2,dd1,dd0;
    // wire [3:0] temp3,temp2,temp1,temp0;
    reg [31:0]count;
    localparam hex0stop = $rtoi(0.25 * CLK_FREQ *1000000 / (DISP_FREQ + 4));
    localparam hex1stop = $rtoi(0.5 * CLK_FREQ *1000000 / (DISP_FREQ + 4));
    localparam hex2stop = $rtoi(0.75 * CLK_FREQ *1000000 / (DISP_FREQ + 4));
    localparam hex3stop = $rtoi(1.0 * CLK_FREQ *1000000 / (DISP_FREQ + 4));
    
    assign hex3 = indata[15:12];
    assign hex2 = indata[11:8];
    assign hex1 = indata[7:4];
    assign hex0 = indata[3:0];
    //reg startDD;
//wire doneDD;
    BCDRom romBCD(.addr(indata),.bcd3(rom3),.bcd2(rom2),.bcd1(rom1),.bcd0(rom0));
    
    //binaryToBCDDivideMod BCDDivMOD(.clk(clk),.val(indata),.bcd3(pl3),.bcd2(pl2),.bcd1(pl1),.bcd0(pl0));
    
    //BCDRam ramBCD(.addr(indata),.clk(clk),.bcd3(ram3),.bcd2(ram2),.bcd1(ram1),.bcd0(ram0)); 
    
    //DoubleDabble DD(.clk(clk),.start(startDD),.val(indata),.bcd3(temp3),.bcd2(temp2),.bcd1(temp1),.bcd0(temp0),.done(doneDD));

//reg [1:0] stateDD;

//localparam STARTON = 0;
//localparam STARTOFF = 1;
//localparam LATCH = 2;
 
//always@(posedge clk)
//begin
//    if (reset) begin
//        stateDD <= STARTON;
//        startDD <= 0;
//    end
//    case(stateDD)
//    STARTON: begin
//        startDD <= 1;
//        stateDD <= STARTOFF;
//    end
//    STARTOFF: begin
//        startDD <= 0;
//        if (doneDD) begin
//            stateDD <= LATCH;
//        end
//    end
//    LATCH: begin
//        hex0 <= dd0;
//        hex1 <= dd1;
//        hex2 <= dd2;
//        hex3 <= dd3;
//        if (~doneDD) begin
//            stateDD <= STARTON;
//        end
//    end
//    default: begin
//        startDD <= 0;
//        stateDD <= STARTON;
//    end
//    endcase
//end


    always@(posedge clk)
    begin 
        count <= count + 1;
        if(count<hex0stop)
            segselect <= 3;
        else if (count < hex1stop)
            segselect <= 2;
        else if (count < hex2stop)
            segselect <= 1;
        else if (count < hex3stop)
            segselect <= 0;
        else
            count <= 0;
    end
    reg [3:0] hexVal;
    reg [3:0] AN;
    always@(segselect,rom0,rom1,rom2,rom3)
    //always@(segselect,ram0,ram1,ram2,ram3)
    // always@(segselect,dd0,dd1,dd2,dd3)
      //always@(segselect,pl0,pl1,pl2,pl3)
     // always@(segselect,hex0,hex1,hex2,hex3)
    begin     
        case(segselect)
            0:begin
                hexVal = rom0;
                AN =  4'b1110;
              end
              1:begin 
                hexVal = rom1;
                AN = 4'b1101;
              end
              2:begin
                hexVal = rom2;
                AN = 4'b1011;
              end
              3:begin 
                hexVal = rom3;
                AN = 4'b0111;
              end 
        endcase
      end
    
    
     always @(posedge clk)
        begin
      latchAN <= AN;
           case (hexVal)
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