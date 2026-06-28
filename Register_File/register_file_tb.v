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

        $display("reset starting");
        reset =1;
        @(posedge clk);
	@(posedge clk);
        reset =0;
        $display("reset done");

        r1_address = 1; #2; $display("After reset R1=%0d", r1_data);
        r1_address = 2; #2; $display("After reset R2=%0d", r1_data);
        r1_address = 3; #2; $display("After reset R3=%0d", r1_data);
        r1_address = 4; #2; $display("After reset R4=%0d", r1_data);
        r1_address = 5; #2; $display("After reset R5=%0d", r1_data);
        r1_address = 6; #2; $display("After reset R6=%0d", r1_data);
        r1_address = 7; #2; $display("After reset R7=%0d", r1_data);

	
        we =1;
	@(negedge clk);

        w_address =3;
        w_data = 8'd50;
        @(posedge clk);
	@(posedge clk);
        we = 0;
        r1_address =3;
        #2
        $display("r3 = %0d", r1_data);

        we = 1;
	@(negedge clk);


        w_address=1;
        w_data= 8'd10;
        @(posedge clk);
	
	@(negedge clk);

        w_address =2;
        w_data = 8'd45;
        @(posedge clk);

	@(negedge clk);

        w_address =4;
        w_data = 8'd56;
        @(posedge clk);
	@(posedge clk);

        we = 0;

        r1_address = 1;
        #2;
        $display("R1 = %0d", r1_data);

        r1_address = 2;
        #2;
        $display("R2 = %0d", r1_data);

        r1_address = 4;
        #2;
        $display("R4 = %0d", r1_data);

        

        r1_address = 2;
        r2_address = 4;

        #2;

        $display("R2 = %0d | R4 = %0d", r1_data, r2_data);


        

        we      = 0;
	@(negedge clk);

        w_address   = 5;
        w_data   = 8'd99;

        @(posedge clk);

        r1_address = 5;

        #2;

        $display("R5 = %0d (Should be 0)", r1_data);

        
        we      = 1;
	@(negedge clk);

        w_address   = 0;
        w_data   = 8'd255;

        @(posedge clk);

        we = 0;

        r1_address = 0;

        #2;

        $display("R0 = %0d (Should always be 0)", r1_data);


        we = 1;
	@(negedge clk);


        w_address = 1;
        w_data = 8'd11;
        @(posedge clk);
	@(negedge clk);


        w_address = 2;
        w_data = 8'd22;
        @(posedge clk);
	@(negedge clk);


        w_address = 3;
        w_data = 8'd33;
        @(posedge clk);
	@(negedge clk);


        w_address = 4;
        w_data = 8'd44;
        @(posedge clk);
	@(negedge clk);


        w_address = 5;
        w_data = 8'd55;
        @(posedge clk);
	@(negedge clk);


        w_address = 6;
        w_data = 8'd66;
        @(posedge clk);
	@(negedge clk);


        w_address = 7;
        w_data = 8'd77;
        @(posedge clk);
	@(posedge clk);

        we = 0;

        
        r1_address = 0; #2;
        $display("R0 = %0d", r1_data);

        r1_address = 1; #2;
        $display("R1 = %0d", r1_data);

        r1_address = 2; #2;
        $display("R2 = %0d", r1_data);

        r1_address = 3; #2;
        $display("R3 = %0d", r1_data);

        r1_address = 4; #2;
        $display("R4 = %0d", r1_data);

        r1_address = 5; #2;
        $display("R5 = %0d", r1_data);

        r1_address = 6; #2;
        $display("R6 = %0d", r1_data);

        r1_address = 7; #2;
        $display("R7 = %0d", r1_data);

        

        $display("Simulation Completed");

        #10;

        $finish;

    end

endmodule