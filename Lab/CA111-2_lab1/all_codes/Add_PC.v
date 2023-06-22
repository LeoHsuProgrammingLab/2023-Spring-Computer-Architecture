module Adder(
    pc_base_i,
    pc_offset_i,
    pc_o
);

input [31:0] pc_base_i;
input [31:0] pc_offset_i;
output [31:0] pc_o;

assign pc_o = pc_base_i + pc_offset_i;

endmodule