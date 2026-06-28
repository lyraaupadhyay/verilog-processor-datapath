`timescale 1ns/1ps
module register_file_tb;

    parameter WIDTH = 8;
    parameter DEPTH =8;
    parameter ADDRESS_WID = $clog2(DEPTH);

    reg clk;
    reg reset;
    reg we;
    reg [WIDTH-1:0] w_data;
    reg [ADDRESS_WID-1:0] w_address;
    reg [ADDRESS_WID-1:0] r1_address;
    reg [ADDRESS_WID-1:0] r2_address;

    wire [WIDTH-1:0] r1_data;
    wire [WIDTH-1:0] r2_data;

    register_file #(
        .WIDTH(WIDTH),
        .DEPTH(DEPTH)
    ) dut (
        .clk(clk),
        .reset(reset),

        .we(we),
        .w_address(w_address),
        .w_data(w_data),

        .r1_address(r1_address),
        .r2_address(r2_address),

        .r1_data(r1_data),
        .r2_data(r2_data)
    );

    always #5 clk = ~clk;
    initial begin

        $dumpfile("register_file.vcd");
        $dumpvars(0, register_file_tb);

        clk = 0 ;
        reset = 0;
        we = 0;
        w_data = 0;
        w_address = 0;
        r1_address = 0;
        r2_address = 0;


        //reset test
        $display("reset starting");
        reset =1;
        @(posedge clk);
	    @(posedge clk);
        reset =0;
        $display("reset done");

        //test-1
        we=1;
        @(negedge clk);
        w_address = 3;
        w_data = 50;
        @(posedge clk);
        @(negedge clk);
        we = 0;

       

        //test-2
        r1_address = 3;
        #2
        $display("r3 = %0d(expected = old value(0))", r1_data);
        @(posedge clk);
        #1
        $display("r3 = %0d(expected = new value(50))", r1_data);

        //test-3
        we = 1;
        @(negedge clk);
        w_address = 4;
        w_data = 79;
        @(posedge clk);
        @(negedge clk);
        we=0;
        r1_address = 4;
        @(posedge clk);
        #1
        $display("r4 = %0d(expected = 79)",r1_data);

        //test-4
        we =1;
        @(negedge clk);
        w_address = 2;
        w_data = 23;
        @(posedge clk);
        @(negedge clk);
        we = 0;
        r1_address = 2;
        r2_address = 4;
        @(posedge clk);
        #1
        $display("r2 = %0d | r4 = %0d(expected = 23 | 79)",r1_data,r2_data);

        //test-5
        we =1;
        @(negedge clk);
        w_address = 0;
        w_data = 45;
        @(posedge clk);
        @(negedge clk);
        we = 0;
        r1_address = 0;
        @(posedge clk);
        #1
        $display("r0 = %0d(expected = 0)", r1_data);

        //test-6
        we = 0;
        @(negedge clk);
        w_address =1;
        w_data = 86;
        @(posedge clk);
        @(negedge clk);
        r1_address = 1;
        @(posedge clk);
        #1
        $display("r1 = %0d(expected = no write)", r1_data);

        //test- 7
        we= 1;
        @(negedge clk);
        w_address = 3;
        w_data = 33;
        r1_address = 3;
        @(posedge clk);
        #1
        $display("r3 = %0d(expected = 33)", r1_data);


        //test-8
        we= 1;
        @(negedge clk);
        w_address = 5;
        w_data = 55;
        r1_address = 5;
        r2_address = 5;
        @(posedge clk);
        #1
        $display("r5 = %0d | r5' = %0d(expected = 55 | 55)",r1_data, r2_data);



        $display("Simulation Completed");

        #10;

        $finish;

    end

endmodule