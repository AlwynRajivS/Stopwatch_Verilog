`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:23:19 02/24/2026 
// Design Name: 
// Module Name:    state_machine 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module state_machine (
    input  wire rst,
    input  wire cclk,
    input  wire startBtn,
    input  wire stopBtn,
    input  wire incBtn,
    output reg  timerEN
);

    // ------------------------------------------------------------
    // State Encoding
    // ------------------------------------------------------------
    parameter START = 2'b00,
              STOP  = 2'b01,
              INC   = 2'b10,
              TRAP  = 2'b11;

    reg [1:0] currState = STOP;
    reg [1:0] nextState;

    // ------------------------------------------------------------
    // Combinational Logic (Next State + Output Logic)
    // ------------------------------------------------------------
    always @(*) begin
        case (currState)

            STOP: begin
                timerEN = 1'b0;
                if (startBtn)
                    nextState = START;
                else if (incBtn)
                    nextState = INC;
                else
                    nextState = STOP;
            end

            START: begin
                timerEN = 1'b1;
                if (stopBtn)
                    nextState = STOP;
                else
                    nextState = START;
            end

            INC: begin
                timerEN = 1'b1;
                nextState = TRAP;
            end

            TRAP: begin
                timerEN = 1'b0;
                if (!incBtn)
                    nextState = STOP;
                else
                    nextState = TRAP;
            end

            default: begin
                timerEN = 1'b0;
                nextState = STOP;
            end

        endcase
    end

    // ------------------------------------------------------------
    // Sequential Logic (State Register)
    // ------------------------------------------------------------
    always @(posedge cclk or posedge rst) begin
        if (rst)
            currState <= STOP;
        else
            currState <= nextState;
    end

endmodule
