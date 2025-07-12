# 🔢 Booth's Multiplier - FPGA Implementation (8-bit Verilog)

This project implements an **8-bit Booth's Multiplier** using Verilog HDL and integrates **VIO** (Virtual Input/Output) and **ILA** (Integrated Logic Analyzer) IP cores in Xilinx Vivado for real-time control and waveform observation.

---

## 🛠️ Features

- Signed 8-bit × 8-bit multiplication using **Booth’s Algorithm**
- 16-bit signed product output
- Controlled via **VIO inputs**
- Debugging via **ILA waveforms**
- Fully synchronous design

---

## 📁 Files Included

| File                        | Description                           |
|-----------------------------|---------------------------------------|
| `Booth_Multiplier.v`       | Booth’s multiplication logic          |
| `top.v`                    | Top module with VIO and ILA instances |
| `constraints.xdc`           | Pin mapping for clock and I/O         |
| `README.md`                 | Project overview (this file)          |

---

## 🧠 Booth’s Algorithm Summary

Booth's algorithm efficiently multiplies signed binary numbers using:

1. A = 0, Q = multiplier, M = multiplicand, Q-1 = 0  
2. For 8 cycles:
   - If Q[0]Q-1 = `01`: A = A + M  
   - If Q[0]Q-1 = `10`: A = A - M  
   - Then: Arithmetic Right Shift `{A, Q, Q-1}`
3. Result = `{A, Q}` → 16-bit signed product

---

## 🔌 Inputs (from VIO)

| Signal         | Width | Description                     |
|----------------|-------|---------------------------------|
| `clk`          | 1     | System clock                    |
| `start`        | 1     | Start signal to trigger process |
| `multiplicand` | 8     | 8-bit signed input              |
| `multiplier`   | 8     | 8-bit signed input              |

---

## 📤 Outputs (observed via ILA)

| Signal   | Width | Description                          |
|----------|-------|--------------------------------------|
| `product`| 16    | 16-bit signed result                 |
| `done`   | 1     | High when multiplication is complete |

---

## 🚦 How to Use (Vivado)

1. Create a Vivado project and add `Booths_Multiplier.v` and `top.v`.
2. Add **VIO IP** and configure:
   - `start` (1-bit), `multiplicand` (8-bit), `multiplier` (8-bit)
3. Add **ILA IP** and connect:
   - `start`, `multiplicand`, `multiplier`, `product`, `done`
4. Add `constraints.xdc` file with clock pin mapping
5. Generate Bitstream and Program the FPGA.
6. Use **Vivado Hardware Manager** to control inputs via VIO and observe waveforms in ILA.

---

## ✅ Example Test Case

| Multiplicand | Multiplier | Expected Product |
|--------------|------------|------------------|
| `-3` (11111101) | `5` (00000101) | `-15` (1111111111110001) |
