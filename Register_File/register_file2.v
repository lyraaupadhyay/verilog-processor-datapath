`timescale 1ns/1ps
module register_file2 #(
    parameter WIDTH = 8,
    parameter DEPTH =8,
    parameter ADDRESS_WID = $clog2(DEPTH)
)(
    input clk,
    input reset,
    input we,
    input [WIDTH-1:0] w_data,
    input [ADDRESS_WID-1:0] w_address,
    input [ADDRESS_WID-1:0] r1_address,
    input [ADDRESS_WID-1:0] r2_address,

    output reg [WIDTH-1:0] r1_data,
    output reg [WIDTH-1:0] r2_data
);
    reg[WIDTH-1:0]register[0:DEPTH-1];
    
    integer i;

    

    
    always@(posedge clk) begin

	   /* $display("time=%0t reset=%b we=%b waddr=%0d",
             $time, reset, we, w_address);*/

        //reset logic
        if(reset)begin

	       // $display("%0t : RESET EXECUTED", $time);

            for(i=0; i<DEPTH; i=i+1) begin
                register[i] <= {WIDTH{1'b0}};
            end

            r1_data <= {WIDTH{1'b0}};
            r2_data <= {WIDTH{1'b0}};
	    
    	    
        end

        else begin
            //write logic
            if(we && w_address != 0)begin
                register[w_address] <= w_data;
            end

            //read logic-1
            if(r1_address == 0)begin
                r1_data <= {WIDTH{1'b0}};
            end

            else if ((r1_address == w_address) && (r1_address != 0) && we)begin
                r1_data <= w_data;
            end

            else begin
                r1_data <= register[r1_address];
            end

            //read logic-2
            if(r2_address == 0)begin
                r2_data <= {WIDTH{1'b0}};
            end

            else if ((r2_address == w_address) && (r2_address != 0) && we)begin
                r2_data <= w_data;
            end

            else begin
                r2_data <= register[r2_address];
            end
        end
    



    end
endmodule