module Control(
    opcode_i, 
    ALUOp_o, 
    ALUSrc_o,
    RegWrite_o, 
);

input [6:0] opcode_i;
output [1:0] ALUOp_o;
output ALUSrc_o;
output RegWrite_o;

assign RegWrite_o = 1;

assign ALUSrc_o = (opcode_i == 7'b0110011 ) ? 0 : 1;
assign ALUOp_o = (opcode_i == 7'b0110011) ? 2'b01 : 2'b00;

endmodule