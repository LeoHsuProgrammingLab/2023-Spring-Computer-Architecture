module Sign_Extend(
    imm_i,
    extendimm_o
);

input [11:0] imm_i;
output [31:0] extendimm_o;

assign extendimm_o = { {20{imm_i[11]}}, imm_i};

endmodule