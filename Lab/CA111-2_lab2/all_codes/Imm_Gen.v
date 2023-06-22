module Imm_Gen(
    instr_i, 
    immExtended_o
);

input [31:0] instr_i;
output [31:0] immExtended_o;

assign immExtended_o = (instr_i[6:5] == 2'b00) ? ((instr_i[14:12] == 3'b101) ? { {27{instr_i[24]}}, instr_i[24:20]} : {{20{instr_i[31]}}, instr_i[31:20]}) :
                       (instr_i[14:12] == 3'b010) ? {{20{instr_i[31]}}, instr_i[31:25], instr_i[11:7]} :
                       {{20{instr_i[31]}}, instr_i[31], instr_i[7], instr_i[30:25], instr_i[11:8]};



endmodule