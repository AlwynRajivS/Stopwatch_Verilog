`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:22:52 02/24/2026 
// Design Name: 
// Module Name:    clock_divider 
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
module clock_divider (
    input  wire rst,
    input  wire clk,
    output wire cclk
);

    // Constant equivalent to: "1100001101010000"
    localparam [15:0] KILLCLK = 16'b1100001101010000;

    reg [15:0] clkdiv;
    reg dividedClk;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            clkdiv     <= 16'b0;
            dividedClk <= 1'b0;
        end else begin
            clkdiv <= clkdiv + 1'b1;

            if (clkdiv == KILLCLK) begin
                dividedClk <= ~dividedClk;
                clkdiv     <= 16'b0;
            end
        end
    end

    assign cclk = dividedClk;

endmodule

