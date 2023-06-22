module MUX32(
    ALUSrc_i, 
    RS2data_i,
    imm_i, 
    RS2data_o
);

input ALUSrc_i;
input [31:0] RS2data_i;
input [31:0] imm_i;
output [31:0] RS2data_o;

assign RS2data_o = (ALUSrc_i) ? imm_i : RS2data_i;

endmodule