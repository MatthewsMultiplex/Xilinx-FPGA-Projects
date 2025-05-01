`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/26/2025 02:29:39 PM
// Design Name: 
// Module Name: Lab3Top
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


module Lab3Top(
    input clk,
    input init,
    input reset,
    output reg [3:0] state,
    output [3:0] an,
    output [7:0] seg,
    input MainTurnReg,
    input SideTurnReg
     );
   
     reg [3:0] mainFace1, mainFace2, sideFace1, sideFace2;
     
     localparam GREEN = 0, 
                YELLOW = 1, 
                RED = 2,
                LFTGREEN = 3,
                LFTYELLOW = 4,
                ALLOFF = 5;
                
      localparam sMGSR = 0,
                 sMYSR = 1,
                 sMRSR = 2,
                 sMRSG = 3,
                 sMRSY = 4,
                 sMRSR2 = 5,
                 sMTGSR = 6,
                 sMTYSR = 7,
                 sMRSTG = 8,
                 sMRSTY = 9,
                 sINITOFF = 10,
                 sINITON = 11;
                 
                 
       wire dn;
       
       reg [31:0] stateCountVal;
       
       wire [15:0] lightVector = {sideFace1, sideFace2, mainFace1, mainFace2};
       
       fsmDelayCounter counter(.clk(clk),.dn(dn),.reset(reset),.len(stateCountVal));
       
       DispDriver theLight(.indata(lightVector),.clk(clk),.sseg(seg),.latchAN(an),.reset(reset));
       
       always @(state) begin
            case(state)
                sINITOFF: stateCountVal = 50000000;
                sINITON:  stateCountVal = 50000000;
                sMRSR: stateCountVal = 50000000;
                sMYSR: stateCountVal = 100000000;
                sMRSR2: stateCountVal = 50000000;
                sMRSG: stateCountVal = 300000000;
                sMGSR: stateCountVal = 500000000;
                sMRSY: stateCountVal = 100000000;
                sMRSTG: stateCountVal = 200000000;
                sMRSTY: stateCountVal = 100000000;
                sMTGSR: stateCountVal = 200000000;
                sMTYSR: stateCountVal = 100000000;
            default: stateCountVal = 100000000;
            endcase
            end
            
       always @(posedge clk)
            if (reset) begin
                state = sINITON;
                end
            else begin
                case(state) 
               sINITOFF: 
                    if(dn&&~init) begin
                    state <= sINITON;
                    end
                    else if (dn&&init) begin
                    state <= sMGSR;
                    end
               sINITON:
                    if(dn&&~init) begin
                    state <= sINITON; 
                    end
                    else if (dn&&init) begin
                    state <= sMGSR;
                    end
                    
               sMGSR: 
                    if(dn) begin
                        state <= sMYSR;
                        end
               sMYSR: 
                    if(dn) begin 
                        state <= sMRSR;
                        end
               sMRSR:
                    if(dn && ~SideTurnReg) begin
                        state <= sMRSG;
                        end
                    else if (dn && SideTurnReg) begin
                        state <= sMRSTG;
                        end
               sMRSG:
                    if(dn) begin
                        state <= sMRSY;
                        end
               sMRSY:
                    if (dn) begin
                        state <= sMRSR2;
                        end
               sMRSR2: 
                    if (dn && ~SideTurnReg) begin
                        state <= sMGSR;
                        end
                    else if (dn && MainTurnReg) begin
                        state <= sMTGSR;
                        end
               sMTGSR: 
                    if (dn) begin
                        state <= sMTYSR;
                     end
               sMTYSR: 
                    if (dn) begin
                        state <= sMGSR;
                        end
               sMRSTG:
                     if (dn) begin
                        state <= sMRSTY;
                       end
               sMRSTY:
                     if (dn) begin 
                        state <= sMRSG;
                        end
                 default: state <= sINITOFF;
                 
                endcase
                end
              
//              GREEN = 0, 
//                YELLOW = 1, 
//                RED = 2,
//                LFTGREEN = 3,
//                LFTYELLOW = 4,
//                ALLOFF = 5;

//                sMGSR = 0,
//                 sMYSR = 1,
//                 sMRSR = 2,
//                 sMRSG = 3,
//                 sMRSY = 4,
//                 sMRSR2 = 5;
              
              
              always @(state)
              
              case(state)
              sMRSR, sMRSR2: begin
                        mainFace1 = RED;
                        mainFace2 = RED;
                        sideFace1 = RED;
                        sideFace2 = RED;
                        end
                     sMGSR: begin
                        mainFace1 = GREEN;
                        mainFace2 = GREEN;
                        sideFace1 = RED;
                        sideFace2 = RED;
                        end
                     sMYSR: begin
                        mainFace1 = YELLOW;
                        mainFace2 = YELLOW;
                        sideFace1 = RED;
                        sideFace2 = RED;
                        end
                     sMRSG: begin
                        mainFace1 = RED;
                        mainFace2 = RED;
                        sideFace1 = GREEN;
                        sideFace2 = GREEN;
                        end
                     sMRSY: begin
                        mainFace1 = RED;
                        mainFace2 = RED;
                        sideFace1 = YELLOW;
                        sideFace2 = YELLOW;
                        end
                     sMTGSR: begin
                        mainFace1 = LFTGREEN;
                        mainFace2 = LFTGREEN;
                        sideFace1 = RED;
                        sideFace2 = RED;
                     end
                     sMTYSR: begin
                            mainFace1 = LFTYELLOW;
                        mainFace2 =  LFTYELLOW;
                        sideFace1 = RED;
                        sideFace2 = RED;
                        end
                     sMRSTG: begin
                         mainFace1 = RED;
                        mainFace2 = RED;
                        sideFace1 = LFTGREEN;
                        sideFace2 = LFTGREEN;
                        end
                     sMRSTY: begin
                         mainFace1 = RED;
                        mainFace2 = RED;
                        sideFace1 = LFTYELLOW;
                        sideFace2 = LFTYELLOW;
                        end
                     sINITOFF: begin
                        mainFace1 = RED;
                        mainFace2 = RED;
                        sideFace1 = RED;
                        sideFace2 = RED;
                        end
                     sINITON: begin
                        mainFace1 = RED;
                        mainFace2 = RED;
                        sideFace1 = RED;
                        sideFace2 = RED;
                        end
                      default: 
                      begin
                      mainFace1 = ALLOFF; 
                      mainFace2 = ALLOFF;
                      sideFace1 = ALLOFF;
                      sideFace2 = ALLOFF; 
                       end
                        //localparam sMGSR = 0,
//                 sMYSR = 1,
//                 sMRSR = 2,
//                 sMRSG = 3,
//                 sMRSY = 4,
//                 sMRSR2 = 5,
//                 sMTGSR = 6,
//                 sMTYSR = 7,
//                 sMRSTG = 8,
//                 sMRSTY = 9,
//                 sINITOFF = 10,
//                 sINITON = 11;
                    endcase
endmodule
