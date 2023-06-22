module Adder(
    Data1_i,
    Data2_i,
    Data_o
);

input [31:0] Data1_i;
input [31:0] Data2_i;
output [31:0] Data_o;

assign Data_o = Data1_i + Data2_i;

endmodule