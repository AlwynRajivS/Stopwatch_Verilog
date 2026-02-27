`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:21:44 02/24/2026 
// Design Name: 
// Module Name:    main 
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
module main (
    input  wire        clk,
    input  wire        swt,
    input  wire [3:0]  btn,
    output wire [5:0]  an,
    output wire [7:0]  seg
);

    // ------------------------------------------------------------
    // Internal Signals
    // ------------------------------------------------------------
    wire cclk;
    wire rst;
    wire startBtn;
    wire stopBtn;
    wire incBtn;
    wire timerEN;
    wire dispEN;

    wire [23:0] cntr;
    wire [7:0]  seven_seg_d;
    wire [5:0]  an_d;

    // ------------------------------------------------------------
    // Signal Assignments (Equivalent to VHDL concurrent assigns)
    // ------------------------------------------------------------
    assign rst      = btn[0];   // Reset button
    assign startBtn = btn[1];   // Start
    assign stopBtn  = btn[2];   // Stop
    assign incBtn   = btn[3];   // Increment once
    assign dispEN   = swt;      // Display enable switch

    // Active LOW outputs (same as VHDL "not")
    assign seg = ~seven_seg_d;
    assign an  = ~an_d;

    // ------------------------------------------------------------
    // Module Instantiations
    // ------------------------------------------------------------

    clock_divider Inst_clock_divider (
        .rst  (rst),
        .clk  (clk),
        .cclk (cclk)
    );

    state_machine Inst_state_machine (
        .rst      (rst),
        .cclk     (cclk),
        .startBtn (startBtn),
        .stopBtn  (stopBtn),
        .incBtn   (incBtn),
        .timerEN  (timerEN)
    );

    counter Inst_counter (
        .rst     (rst),
        .cclk    (cclk),
        .timerEN (timerEN),
        .cntr    (cntr)
    );

    seven_seg_controller Inst_seven_seg_controller (
        .rst    (rst),
        .cclk   (cclk),
        .dispEN (dispEN),
        .dpSel  (3'b111),
        .cntr   (cntr),
        .seg    (seven_seg_d),
        .an     (an_d)
    );

endmodule