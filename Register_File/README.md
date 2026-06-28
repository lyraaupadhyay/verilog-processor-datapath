# Register File

## Overview

This project implements a parameterized multi-port register file in Verilog HDL.

The register file supports:

- Two synchronous read ports
- One synchronous write port
- Register forwarding
- Hardwired zero register (R0)

---

## Features

- Parameterized width
- Parameterized depth
- Two read ports
- One write port
- Synchronous read
- Synchronous write
- Read-after-write forwarding
- Hardwired Register 0

---

## Architecture

```
          +------------------+
rs1 ----->|                  |
rs2 ----->|  Register File   |----> r1_data
rd  ----->|                  |----> r2_data
w_data -->|                  |
we  ----->|                  |
clk ----->|                  |
          +------------------+
```

---

## Files

```
register_file2.v
register_file_tb2.v
register_file.vcd
```

---

## Verification

The testbench verifies:

- Reset
- Single register write
- Single register read
- Simultaneous dual-port read
- Read-after-write forwarding
- Hardwired R0
- Write enable operation
- Same-cycle read/write behavior

---

## Tools Used

- Verilog HDL
- Icarus Verilog
- GTKWave
- Yosys

---

## Learning Outcomes

- Multi-port register file architecture
- Synchronous read behavior
- Write enable logic
- Forwarding (bypass) logic
- Register initialization
- RTL synthesis
