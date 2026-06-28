`timescale 1ns/1ps
module alu_rf_top #(
    parameter WIDTH = 8,
    parameter DEPTH = 8,
    parameter ADDRESS_WID = $clog2(DEPTH))

   (input clk,
    input reset,

    input [ADDRESS_WID-1:0] rs1,
    input [ADDRESS_WID-1:0] rs2,
    input [ADDRESS_WID-1:0] rd,

    input we,

    input load_mode,
    input[WIDTH-1:0] load_data,

    input [3:0]alu_code,

    output carry,
    output overflow,
    output negative,
    output zero,

    output [WIDTH-1:0]op_a_debug,
    output [WIDTH-1:0]op_b_debug,
    output [WIDTH-1:0]alu_result_debug); 
    

    wire [WIDTH-1:0]op_a;
    wire [WIDTH-1:0]op_b;
    wire [WIDTH-1:0]alu_result;
    wire [WIDTH-1:0]rf_w_data;

    localparam ADD = 4'b0000;
    localparam SUB = 4'b0001;
    localparam AND = 4'b0010;
    localparam OR  = 4'b0011;
    localparam XOR = 4'b0100;
    localparam NOT = 4'b0101;
    localparam SLL = 4'b0110;
    localparam SRL = 4'b0111;
    localparam EQ  = 4'b1000;

    register_file2#(
        .WIDTH(WIDTH),
        .DEPTH(DEPTH)
    ) rf_inst(
        .clk(clk),
        .reset(reset),
        .we(we),
        .w_data(rf_w_data),
        .w_address(rd),
        .r1_address(rs1),
        .r2_address(rs2),
        .r1_data(op_a),
        .r2_data(op_b)
    );

    alu #(
        .WIDTH(WIDTH)
    ) alu_inst(
        .A(op_a),
        .B(op_b),
        .opcode(alu_code),
        .result(alu_result),
        .carry(carry),
        .overflow(overflow),
        .zero(zero),
        .negative(negative)
    );

    assign rf_w_data = (load_mode)? load_data:alu_result;

    assign op_a_debug = op_a;
    assign op_b_debug = op_b;
    assign alu_result_debug = alu_result;

endmodule