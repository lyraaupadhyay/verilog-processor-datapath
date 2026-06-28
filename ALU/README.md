# Arithmetic Logic Unit (ALU)

## Overview

This project implements a parameterized 8-bit Arithmetic Logic Unit (ALU) in Verilog HDL.

The ALU performs arithmetic, logical, comparison, and shift operations while generating the appropriate status flags.

---

## Features

- Parameterized data width (default: 8 bits)
- Combinational design
- Arithmetic operations
- Logical operations
- Shift operations
- Equality comparison
- Status flag generation

---

## Supported Operations

| Opcode | Operation |
|---------|-----------|
|0000|Addition|
|0001|Subtraction|
|0010|AND|
|0011|OR|
|0100|XOR|
|0101|NOT|
|0110|Logical Left Shift|
|0111|Logical Right Shift|
|1000|Equality Comparison|

---

## Status Flags

- Carry
- Overflow
- Zero
- Negative

---

## Files

```
alu.v
alu_tb.v
alu.vcd
```

---

## Verification

The testbench verifies:

- Arithmetic operations
- Logical operations
- Shift operations
- Equality operation
- Carry flag
- Overflow flag
- Zero flag
- Negative flag

---

## Tools Used

- Verilog HDL
- Icarus Verilog
- GTKWave
- Yosys

---

## Learning Outcomes

- Combinational circuit design
- ALU architecture
- Opcode implementation
- Status flag generation
- RTL simulation
- RTL synthesis
