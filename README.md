# CHIP8_FPGA_ZyboZ7


A cycle-accurate, physical implementation of the CHIP-8 virtual machine instruction set synthesized in **SystemVerilog** for the Digilent Zybo Z7 (Zynq-7000) FPGA.

---

## 🎯 Project Overview
Unlike traditional software emulators, this project implements a dedicated hardware CPU datapath and control unit directly in silicon to execute classic CHIP-8 binaries without an underlying OS or microcoded processor.

* **Target Device:** Digilent Zybo Z7-20 / Z7-10 (Xilinx Zynq-7000)
* **HDL:** SystemVerilog (IEEE 1800-2012)
* **Toolchain:** AMD/Xilinx Vivado ML

---

## 🧱 Architecture & Modules
- **Clock Divider & Enable:** Generates the ~600 Hz CPU tick and 60 Hz timer ticks from the 125 MHz board clock.
- **Memory (RAM 4 KB):** Single-cycle synchronous RAM preloaded with fontset and ROM using `$readmemh`.
- **Register File & Stack:** 16x 8-bit general registers (`V0`-`VF`), 16-bit `PC`, 12-bit index register `I`, and a 16-level call stack.
- **ALU:** Purely combinational arithmetic and logic unit handling `8xy0` through `8xyE` opcodes with carry/borrow flag support.
- **Control Unit (FSM):** Multi-cycle state machine implementing standard `FETCH -> DECODE -> EXECUTE` stages.
- **Draw Engine & Framebuffer:** 64x32 monochrome display engine with XOR pixel toggling and `VF` collision detection.
- **Peripherals:** Delay and Sound timers (60 Hz countdown) and video output controller.

---

## 🗺️ Roadmap & Milestones
- [ ] Setup repository structure and Vivado template project
- [ ] Design and test **ALU** combinational module (`8xy0`–`8xyE`) in Vivado simulator
- [ ] Implement **Register File** (`V0`-`VF`, `I`, `PC`) and hardware **Stack**
- [ ] Implement 4 KB **RAM** with `$readmemh` ROM initialization
- [ ] Build multi-cycle **Control Unit FSM**
- [ ] Verify core execution with the *Timendus CHIP-8 Test Suite*
- [ ] Implement 64x32 monochrome **Framebuffer** and display output
- [ ] Connect input keys and audio/timers
