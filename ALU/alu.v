module alu #(
    parameter WIDTH = 8
)(
    input  [WIDTH-1:0] A,
    input  [WIDTH-1:0] B,
    input  [3:0] opcode,

    output reg [WIDTH-1:0] result,
    output reg carry,
    output reg overflow,
    output reg zero,
    output reg negative
);
    localparam OP_ADD = 4'b0000;
    localparam OP_SUB = 4'b0001;
    localparam OP_AND = 4'b0010;
    localparam OP_OR  = 4'b0011;
    localparam OP_XOR = 4'b0100;
    localparam OP_NOT = 4'b0101;
    localparam OP_SLL = 4'b0110;
    localparam OP_SRL = 4'b0111;
    localparam OP_EQ  = 4'b1000;

     reg [WIDTH:0] sum_ext;

     reg [WIDTH-1:0] and_res;
     reg [WIDTH-1:0] or_res;
     reg [WIDTH-1:0] xor_res;
     reg [WIDTH-1:0] not_res;

     reg [WIDTH-1:0] sll_res;
     reg [WIDTH-1:0] srl_res;

     reg [WIDTH-1:0] eq_res;

     always @(*) begin
         result   = 0;
         carry    = 0;
         overflow = 0;
         zero     = 0;
         negative = 0;

         sum_ext  = 0;

         and_res  = A & B;
         or_res   = A | B;
         xor_res  = A ^ B;
         not_res  = ~A;

         sll_res  = A << B[4:0];
         srl_res  = A >> B[4:0];

         eq_res   = (A == B) ? 32'd1 : 32'd0;

         case(opcode) 
             OP_ADD: begin

                 sum_ext = A + B;

                 result = sum_ext[WIDTH-1:0];

                 carry = sum_ext[WIDTH];

                 overflow =
                     (~A[WIDTH-1] & ~B[WIDTH-1] & result[WIDTH-1]) |
                     ( A[WIDTH-1] &  B[WIDTH-1] & ~result[WIDTH-1]);

             end
             OP_SUB: begin

                 sum_ext = A + (~B) + 1'b1;

                 result = sum_ext[WIDTH-1:0];

                 carry = sum_ext[WIDTH];

                 overflow =
                     (~A[WIDTH-1] &  B[WIDTH-1] & result[WIDTH-1]) |
                     ( A[WIDTH-1] & ~B[WIDTH-1] & ~result[WIDTH-1]);

             end
             OP_AND: begin
                 result = and_res;
             end
             OP_OR: begin
                 result = or_res;
             end
             OP_XOR: begin
                 result = xor_res;
             end
             OP_NOT: begin
                 result = not_res;
             end
             OP_SLL: begin
                 result = sll_res;
             end
             OP_SRL: begin
                 result = srl_res;
             end
             OP_EQ: begin
                 result = eq_res;
             end
             default: begin
                 result = 0;
             end
         
         endcase

         zero = (result == 0);

         negative = result[WIDTH-1];
     end
endmodule