`timescale 1ns/1ps
module alu_rf_top_tb;
    parameter WIDTH = 8;
    parameter DEPTH = 8;
    parameter ADDRESS_WID = $clog2(DEPTH);

    reg clk;
    reg reset;

    reg [ADDRESS_WID-1:0] rs1;
    reg [ADDRESS_WID-1:0] rs2;
    reg [ADDRESS_WID-1:0] rd;

    reg we;

    reg load_mode;
    reg [WIDTH-1:0] load_data;

    reg [3:0] alu_code;

    wire carry;
    wire overflow;
    wire negative;
    wire zero;

    /*Since your register file read ports are not directly visible from the testbench,
     your debug outputs become extremely valuable*/

    wire [WIDTH-1:0] op_a_debug;
    wire [WIDTH-1:0] op_b_debug;
    wire [WIDTH-1:0] alu_result_debug;

    localparam ADD = 4'b0000;
    localparam SUB = 4'b0001;
    localparam AND = 4'b0010;
    localparam OR  = 4'b0011;
    localparam XOR = 4'b0100;
    localparam NOT = 4'b0101;
    localparam SLL = 4'b0110;
    localparam SRL = 4'b0111;
    localparam EQ  = 4'b1000;
    

    alu_rf_top #(
        .WIDTH(WIDTH),
        .DEPTH(DEPTH)
    ) dut(
        .clk(clk),
        .reset(reset),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .we(we),
        .load_mode(load_mode),
        .load_data(load_data),
        .alu_code(alu_code),
        .carry(carry),
        .overflow(overflow),
        .negative(negative),
        .zero(zero),
        .op_a_debug(op_a_debug),
        .op_b_debug(op_b_debug),
        .alu_result_debug(alu_result_debug)
    );

    always #5 clk = ~clk;
    initial begin

        $dumpfile("alu_rf_top.vcd");
        $dumpvars(0,alu_rf_top_tb);

        clk = 0;
        reset = 0;
        rs1 = 0 ;
        rs2 = 0;
        rd = 0;
        we = 0;
        load_mode = 0;
        load_data = 0;
        alu_code = 0;

        //test-1
        $display("reset starting");
        reset =1;
        @(posedge clk);
        @(posedge clk);
        reset = 0;
        $display("rest done");

        //test-2
        load_mode = 1;
        we = 1;
        rd = 1;
        load_data = 10;
        @(posedge clk);
        @(negedge clk);
        we = 0;
        rs1 = 1;
        @(posedge clk);
        #2
        $display("r1 = %0d(expected = 10)",op_a_debug);

        //test-3
        load_mode = 1;
        we = 1;
        rd = 2;
        load_data = 20;
        @(posedge clk);
        @(negedge clk);
        we =0;
        rs1 = 2;
        @(posedge clk);
        #2
        $display("r2 = %0d(expected = 20)",op_a_debug);

        //test-4
        load_mode = 0;
        we = 1;
        rs1 = 1;
        rs2 = 2;
        rd = 3;
        alu_code = ADD;
        @(posedge clk);  // read operands
        #2
        $display("r1 = %0d | r2 = %0d | r1+r2 = %0d(expected = r1 = 10 | r2 = 20 | r1+r2 = 30)",op_a_debug,op_b_debug, alu_result_debug);
        
        
        @(posedge clk); // write r3
        @(negedge clk);
        we = 0;



        rs1 = 3;
        @(posedge clk); // read r3
        #2
        $display("r3 = %0d(expected = r3 = 30)",op_a_debug);

        //test-5
        load_mode = 0;
        we = 1;
        rs1 = 1;
        rs2 = 2;
        rd = 4;
        alu_code = SUB;
        @(posedge clk);  // read operands
        #2
        $display("r1 = %0d | r2 = %0d | r1-r2 = %0d(expected = r1 = 10 | r2 = 20 | r1-r2 = -10)",op_a_debug,op_b_debug, alu_result_debug);
        $display("negative = %0d(expected => negative =1)",negative);
        
        @(posedge clk); // write r3
        @(negedge clk);
        we = 0;



        rs1 = 4;
        @(posedge clk); // read r3
        #2
        $display("r4 = %0d(expected = r4 = -10)",op_a_debug);

        //test-6
        load_mode = 0;
        we = 1;
        rs1 = 1;
        rs2 = 1;
        rd = 5;
        alu_code = ADD;
        @(posedge clk);
        #2
        $display("r1 = %0d | r1 = %0d | r1+r1 = %0d",op_a_debug,op_b_debug,alu_result_debug);
        @(posedge clk);
        @(negedge clk);
        we = 0;
        rs1 = 5;
        @(posedge clk);
	#2
        $display("r5 = %0d",op_a_debug);



        //test-7
        load_mode = 0;
        we = 1;
        rs1 = 1;
        rs2 = 2;
        rd = 2;
        alu_code = ADD;
        @(posedge clk);
        #2
        $display("r1 = %0d | r2 = %0d | r1+r2 = %0d",op_a_debug,op_b_debug,alu_result_debug);
        @(posedge clk);
        @(negedge clk);
        we = 0;
        rs1 = 2;
        @(posedge clk);
	#2
        $display("r2 = %0d",op_a_debug);

        //test-8
        load_mode = 1;
        we = 1;
        rd = 6;
        load_data = 127;
        @(posedge clk);
        @(negedge clk);
        load_mode = 0;
        we =1;
        rs1 = 1;
        rs2 = 6;
        rd = 2;
        alu_code = ADD;
        @(posedge clk);
        #2
        $display("r1 = %0d | r6 = %0d | r1+r6 = %0d",op_a_debug,op_b_debug, alu_result_debug);
        $display("overflow = %0d",overflow);


	//test-9
        load_mode = 0;
        we = 1;
        rs1 = 1;
        rs2 = 2;
        rd = 3;
        alu_code = AND;
        @(posedge clk);
        #2
        $display("r1 = %0d | r2 = %0d | r1 & r2 = %0d",op_a_debug,op_b_debug,alu_result_debug);
        $display("zero = %0d",zero);
        @(posedge clk);
        @(negedge clk);
        we = 0;
        rs1 = 3;
        @(posedge clk);
        #2
        $display("r3 = %0d",op_a_debug);



        

        $display("Simulation Completed");

        #10;

        $finish;

    end
endmodule