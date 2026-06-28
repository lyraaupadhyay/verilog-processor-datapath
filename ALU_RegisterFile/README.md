# ALU + Register File Integration

## Overview

This project integrates the parameterized ALU and Register File into a simple processor datapath.

The design demonstrates operand fetch, ALU execution, and write-back to the register file.

---

## Datapath

```
            Register File
           /             \
        Operand A     Operand B
             \          /
              \        /
                 ALU
                  |
            ALU Result
                  |
           Writeback MUX
                  |
            Register File
```

---

## Features

- Register operand fetch
- ALU execution
- Write-back path
- Load mode
- ALU mode
- Debug outputs
- Status flags

---


---

## Files

```
alu_rf_top.v
alu_rf_top_tb.v
alu_rf_top.vcd
```

---

## Verification

The integrated testbench verifies:

- Register loading
- Operand fetch
- Addition
- Subtraction
- Logical operations
- Write-back
- Destination register update
- Zero flag
- Carry flag
- Negative flag
- Overflow flag

---

## Synthesis

RTL synthesized using Yosys.

Generated resources include:

- Register file
- ALU
- Writeback multiplexer

---

## Learning Outcomes

- Datapath design
- Module integration
- Processor write-back path
- RTL verification
- Hardware synthesis
