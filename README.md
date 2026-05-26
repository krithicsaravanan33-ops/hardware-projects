# Hardware Projects
A collection of hardware designs built in Verilog/SystemVerilog
as part of my journey toward computer architecture and AI hardware engineering.

---

## Project 1 — 4-bit ALU

### What it is
A 4-bit Arithmetic Logic Unit (ALU) implemented in Verilog.
The ALU is the fundamental computational unit of every CPU —
it performs arithmetic and logic operations on binary data.

### Operations supported
| Op Code | Operation | Example |
|---------|-----------|---------|
| 000 | Addition | 5 + 3 = 8 |
| 001 | Subtraction | 9 - 4 = 5 |
| 010 | Bitwise AND | 6 AND 3 = 2 |
| 011 | Bitwise OR | 6 OR 3 = 7 |
| 100 | Bitwise XOR | 6 XOR 3 = 5 |

### Files
- `alu.v` — ALU module
- `alu_tb.v` — Testbench

### How to run
```
iverilog -o alu_tb alu_tb.v alu.v
vvp alu_tb
gtkwave alu_tb.vcd
```

### Simulation output
<img width="1919" height="1127" alt="Screenshot 2026-05-24 220828" src="https://github.com/user-attachments/assets/4b8e02ee-92ee-4430-a791-427b0be965b3" />


---

## Project 2 — 32x32 Register File

### What it is
A register file with 32 registers of 32 bits each.
This is the register file used inside a RISC-V CPU.
Two simultaneous read ports, one clocked write port.
Register x0 is hardwired to zero per the RISC-V specification.

### Files
- `reg_file.v` — Register file module
- `reg_file_tb.v` — Testbench

### How to run
```
iverilog -o reg_file_tb reg_file_tb.v reg_file.v
vvp reg_file_tb
gtkwave reg_file_tb.vcd
```
