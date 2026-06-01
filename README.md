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
<img width="1919" height="1127" alt="ALU Waveform" src="https://github.com/user-attachments/assets/4b8e02ee-92ee-4430-a791-427b0be965b3" />

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

### Simulation output
<img width="1919" height="1127" alt="Register File Waveform" src="https://github.com/user-attachments/assets/1754ab4c-3d6b-47c0-a71b-fcaee5d2f25c" />

---

## Project 3 — Vending Machine FSM

### What it is
A finite state machine implementing a vending machine in Verilog.
Accepts 5 cent and 10 cent coins, dispenses an item when 20 cents
is reached, and gives change if overpaid.

### States
| State | Meaning |
|-------|---------|
| IDLE | 0 cents inserted |
| S5 | 5 cents inserted |
| S10 | 10 cents inserted |
| S15 | 15 cents inserted |
| DISP | Dispense item |
| DISP_CHG | Dispense item and give change |

### Files
- `vending.v` — FSM module
- `vending_tb.v` — Testbench

### How to run
```
iverilog -o vending_tb vending_tb.v vending.v
vvp vending_tb
gtkwave vending_tb.vcd
```

### Simulation output
<img width="1919" height="1127" alt="Vending Machine Waveform" src="https://github.com/user-attachments/assets/e27605b9-2997-4995-acb6-66459462f543" />

---

## Project 4 — UART Transmitter

### What it is
A UART (Universal Asynchronous Receiver Transmitter) transmitter
implemented in Verilog. Sends an 8-bit byte serially with a start
bit and stop bit at 9600 baud.

### Files
- `uart_tx.v` — UART transmitter module
- `uart_tx_tb.v` — Testbench

### How to run
iverilog -o uart_tx_tb uart_tx_tb.v uart_tx.v
vvp uart_tx_tb
gtkwave uart_tx_tb.vcd

### Simulation output
<img width="1919" height="1131" alt="image" src="https://github.com/user-attachments/assets/7da8d900-bffd-4a21-a203-382b092cd84c" />
