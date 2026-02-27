`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:23:48 02/24/2026 
// Design Name: 
// Module Name:    counter 
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
module counter (
    input  wire        rst,
    input  wire        cclk,
    input  wire        timerEN,
    output reg [23:0]  cntr
);

    // ------------------------------------------------------------
    // Enable and Terminal Count Signals
    // ------------------------------------------------------------
    wire C1en, C2en, C3en, C4en, C5en, C6en;
    wire C1tc, C2tc, C3tc, C4tc, C5tc, C6tc;

    // ------------------------------------------------------------
    // Sequential Logic (BCD Counters)
    // ------------------------------------------------------------
    always @(posedge cclk or posedge rst) begin
        if (rst)
            cntr <= 24'd0;
        else begin

            // Digit 1 (LSB)
            if (C1en) begin
                if (cntr[3:0] == 4'd9)
                    cntr[3:0] <= 4'd0;
                else
                    cntr[3:0] <= cntr[3:0] + 1'b1;
            end

            // Digit 2
            if (C2en) begin
                if (cntr[7:4] == 4'd9)
                    cntr[7:4] <= 4'd0;
                else
                    cntr[7:4] <= cntr[7:4] + 1'b1;
            end

            // Digit 3
            if (C3en) begin
                if (cntr[11:8] == 4'd9)
                    cntr[11:8] <= 4'd0;
                else
                    cntr[11:8] <= cntr[11:8] + 1'b1;
            end

            // Digit 4
            if (C4en) begin
                if (cntr[15:12] == 4'd9)
                    cntr[15:12] <= 4'd0;
                else
                    cntr[15:12] <= cntr[15:12] + 1'b1;
            end

            // Digit 5
            if (C5en) begin
                if (cntr[19:16] == 4'd9)
                    cntr[19:16] <= 4'd0;
                else
                    cntr[19:16] <= cntr[19:16] + 1'b1;
            end

            // Digit 6 (MSB)
            if (C6en) begin
                if (cntr[23:20] == 4'd9)
                    cntr[23:20] <= 4'd0;
                else
                    cntr[23:20] <= cntr[23:20] + 1'b1;
            end

        end
    end

    // ------------------------------------------------------------
    // Terminal Count Detection (Detect 9)
    // ------------------------------------------------------------
    assign C1tc = (cntr[3:0]   == 4'd9);
    assign C2tc = (cntr[7:4]   == 4'd9);
    assign C3tc = (cntr[11:8]  == 4'd9);
    assign C4tc = (cntr[15:12] == 4'd9);
    assign C5tc = (cntr[19:16] == 4'd9);
    assign C6tc = (cntr[23:20] == 4'd9);

    // ------------------------------------------------------------
    // Enable Chain Logic
    // ------------------------------------------------------------
    assign C1en = timerEN;
    assign C2en = C1tc & C1en;
    assign C3en = C2tc & C1tc & C1en;
    assign C4en = C3tc & C2tc & C1tc & C1en;
    assign C5en = C4tc & C3tc & C2tc & C1tc & C1en;
    assign C6en = C5tc & C4tc & C3tc & C2tc & C1tc & C1en;

endmodule
