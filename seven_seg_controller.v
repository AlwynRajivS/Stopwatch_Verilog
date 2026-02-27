`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:24:38 02/24/2026 
// Design Name: 
// Module Name:    seven_seg_controller 
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
module seven_seg_controller (
    input  wire        rst,
    input  wire        cclk,
    input  wire        dispEN,
    input  wire [2:0]  dpSel,
    input  wire [23:0] cntr,
    output reg  [7:0]  seg,
    output reg  [5:0]  an
);

    // ------------------------------------------------------------
    // Internal Signals
    // ------------------------------------------------------------
    reg [2:0] sel;
    reg [3:0] segdat;

    // ------------------------------------------------------------
    // Digit Selector Counter (0-5)
    // ------------------------------------------------------------
    always @(posedge cclk or posedge rst) begin
        if (rst)
            sel <= 3'b000;
        else if (dispEN) begin
            if (sel == 3'b101)
                sel <= 3'b000;
            else
                sel <= sel + 1'b1;
        end
    end

    // ------------------------------------------------------------
    // Select Corresponding 4-bit BCD Digit
    // ------------------------------------------------------------
    always @(*) begin
        case (sel)
            3'b000: segdat = cntr[3:0];
            3'b001: segdat = cntr[7:4];
            3'b010: segdat = cntr[11:8];
            3'b011: segdat = cntr[15:12];
            3'b100: segdat = cntr[19:16];
            default: segdat = cntr[23:20];
        endcase
    end

    // ------------------------------------------------------------
    // 7-Segment Decoder (Active LOW)
    // seg[6:0] = {g,f,e,d,c,b,a}
    // ------------------------------------------------------------
    always @(*) begin
        case (segdat)
            4'h0: seg[6:0] = 7'b1000000;
            4'h1: seg[6:0] = 7'b1111001;
            4'h2: seg[6:0] = 7'b0100100;
            4'h3: seg[6:0] = 7'b0110000;
            4'h4: seg[6:0] = 7'b0011001;
            4'h5: seg[6:0] = 7'b0010010;
            4'h6: seg[6:0] = 7'b0000010;
            4'h7: seg[6:0] = 7'b1111000;
            4'h8: seg[6:0] = 7'b0000000;
            4'h9: seg[6:0] = 7'b0010000;
            4'hA: seg[6:0] = 7'b0001000;
            4'hB: seg[6:0] = 7'b0000011;
            4'hC: seg[6:0] = 7'b1000110;
            4'hD: seg[6:0] = 7'b0100001;
            4'hE: seg[6:0] = 7'b0000110;
            4'hF: seg[6:0] = 7'b0001110;
            default: seg[6:0] = 7'b0111111;
        endcase
    end

    // ------------------------------------------------------------
    // Anode Control (Active LOW)
    // ------------------------------------------------------------
    always @(*) begin
        if (dispEN) begin
            case (sel)
                3'b000: an = 6'b111110;
                3'b001: an = 6'b111101;
                3'b010: an = 6'b111011;
                3'b011: an = 6'b110111;
                3'b100: an = 6'b101111;
                3'b101: an = 6'b011111;
                default: an = 6'b111111;
            endcase
        end
        else
            an = 6'b111111;
    end

    // ------------------------------------------------------------
    // Decimal Point Control (Active LOW)
    // ------------------------------------------------------------
    always @(*) begin
        if ((dpSel[1:0] == sel[1:0]) && dpSel[2])
            seg[7] = 1'b0;   // Turn ON decimal point
        else
            seg[7] = 1'b1;   // Turn OFF decimal point
    end

endmodule
