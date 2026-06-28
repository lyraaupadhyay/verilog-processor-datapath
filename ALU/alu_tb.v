`timescale 1ns/1ps

module alu_tb;

    parameter WIDTH = 8;


    reg  [WIDTH-1:0] A;
    reg  [WIDTH-1:0] B;
    reg  [3:0] opcode;

    wire [WIDTH-1:0] result;
    wire carry;
    wire overflow;
    wire zero;
    wire negative;

   
    localparam OP_ADD = 4'b0000;
    localparam OP_SUB = 4'b0001;
    localparam OP_AND = 4'b0010;
    localparam OP_OR  = 4'b0011;
    localparam OP_XOR = 4'b0100;
    localparam OP_NOT = 4'b0101;
    localparam OP_SLL = 4'b0110;
    localparam OP_SRL = 4'b0111;
    localparam OP_EQ  = 4'b1000;

    
    // DUT Instantiation

    alu #(
        .WIDTH(WIDTH)
    ) dut (

        .A(A),
        .B(B),
        .opcode(opcode),

        .result(result),
        .carry(carry),
        .overflow(overflow),
        .zero(zero),
        .negative(negative)

    );

    
    // Test Sequence
    

    initial begin

        
        // Waveform Dump
        

        $dumpfile("alu.vcd");
        $dumpvars(0, alu_tb);

        

        A = 0;
        B = 0;
        opcode = 0;

        #10;

        
        // ADD Test

        A = 32'd10;
        B = 32'd5;
        opcode = OP_ADD;

        #10;

        
        // ADD Overflow Test

        A = 32'h7FFFFFFF;
        B = 32'd1;
        opcode = OP_ADD;

        #10;

        
        // SUB Test

        A = 32'd20;
        B = 32'd8;
        opcode = OP_SUB;

        #10;

        
        // AND Test
        A = 32'hF0F0F0F0;
        B = 32'h0F0F0F0F;
        opcode = OP_AND;

        #10;

        
        // OR Test
        
        A = 32'hF0F0F0F0;
        B = 32'h0F0F0F0F;
        opcode = OP_OR;

        #10;

        
        // XOR Test
       

        A = 32'hAAAA5555;
        B = 32'h5555AAAA;
        opcode = OP_XOR;

        #10;

        
        // NOT Test

        A = 32'h0000FFFF;
        B = 0;
        opcode = OP_NOT;

        #10;

        
        // Shift Left Logical Test
        
        A = 32'd4;
        B = 32'd2;
        opcode = OP_SLL;

        #10;

        
        // Shift Right Logical Test

        A = 32'd32;
        B = 32'd3;
        opcode = OP_SRL;

        #10;

        
        // Equality TRUE Test
        
        A = 32'd100;
        B = 32'd100;
        opcode = OP_EQ;

        #10;

        
        // Equality FALSE Test
        

        A = 32'd100;
        B = 32'd200;
        opcode = OP_EQ;

        #10;

        
        // Zero Flag Test
        
        A = 32'd5;
        B = 32'd5;
        opcode = OP_SUB;

        #10;

        
        // Negative Flag Test
        

        A = 32'd5;
        B = 32'd10;
        opcode = OP_SUB;

        #10;

        

        $finish;

    end

endmodule