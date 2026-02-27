# ⏱ FPGA Digital Timer System (Verilog)

A fully modular **FPGA-based digital timer** designed using Verilog
HDL.\
The system integrates a clock divider, state machine, counter, and
multiplexed 7-segment display controller.

Designed for **Spartan-6 FPGA (ANVYL Board Compatible)**.

------------------------------------------------------------------------

## 🏗 System Architecture

                     +-------------------+
                     |   Clock Divider   |
                     +-------------------+
                               |
                               v
    +-------+      +-------------------+      +-----------+
    | BTN   | ---> |   State Machine   | ---> |  Counter  |
    +-------+      +-------------------+      +-----------+
                               |                    |
                               v                    v
                        +-------------------------------+
                        |  7-Segment Display Controller |
                        +-------------------------------+

------------------------------------------------------------------------

## 📦 Top Module: `main`

### Inputs

  Signal   Width   Description
  -------- ------- -----------------------
  clk      1-bit   FPGA system clock
  swt      1-bit   Display enable switch
  btn      4-bit   Control buttons

### Button Mapping

  Button     Function
  ---------- -----------
  btn\[0\]   Reset
  btn\[1\]   Start
  btn\[2\]   Stop
  btn\[3\]   Increment

### Outputs

  Signal   Width   Description
  -------- ------- ----------------------------------------
  an       6-bit   7-segment anode control (Active LOW)
  seg      8-bit   7-segment segment control (Active LOW)

------------------------------------------------------------------------

## 🧠 Module Breakdown

### 1️⃣ Clock Divider

Reduces high-frequency FPGA clock to a slower clock suitable for timer
operation.

### 2️⃣ State Machine

Controls timer behavior: - Start - Stop - Single increment - Reset

### 3️⃣ Counter

24-bit counter: - Enabled via FSM - Increments based on divided clock -
Reset capable

### 4️⃣ Seven Segment Controller

-   Multiplexed 6-digit display
-   Active LOW outputs
-   Decimal point configurable
-   Controlled by `dispEN`

------------------------------------------------------------------------

## 🔁 Functional Flow

1.  System powers ON.
2.  Press **Start** → Timer begins counting.
3.  Press **Stop** → Timer pauses.
4.  Press **Increment** → Counter increments once.
5.  Press **Reset** → Counter resets to zero.
6.  Switch `swt` enables/disables display.

------------------------------------------------------------------------

## 🛠 Hardware Compatibility

-   Spartan-6 FPGA
-   ANVYL Board
-   Compatible with Xilinx ISE

------------------------------------------------------------------------

## 📂 Project Structure

    /fpga_timer
    │
    ├── main.v
    ├── clock_divider.v
    ├── state_machine.v
    ├── counter.v
    ├── seven_seg_controller.v
    ├── constraints.ucf
    └── README.md

------------------------------------------------------------------------

## 🔬 Learning Outcomes

This project demonstrates:

-   Finite State Machine (FSM) design
-   Clock domain control
-   Modular Verilog coding style
-   Multiplexed display driving
-   FPGA synthesis workflow

------------------------------------------------------------------------

## 🚀 Future Improvements

-   Add debounce logic
-   Add lap timer mode
-   Add UART output
-   Add wireless configuration (ESP32 integration)
-   Add stopwatch precision scaling
-   Add FPGA power optimization

------------------------------------------------------------------------

## 📜 License

MIT License (Recommended for academic projects)

------------------------------------------------------------------------

## 👨‍💻 Author

Mr. S. Alwyn Rajiv\
FPGA & Embedded Systems Developer\
Spartan-6 \| IoT \| AI + Hardware Integration
