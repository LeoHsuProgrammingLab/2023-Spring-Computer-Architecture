module Control(
    NoOp_i,
    opcode_i, 
    ALUOp_o, 
    ALUSrc_o,
    RegWrite_o, 
    MemtoReg_o, 
    MemRead_o, 
    MemWrite_o, 
    Branch_o
);

input [6:0] opcode_i;
input NoOp_i;
output [1:0] ALUOp_o;
output ALUSrc_o;
output RegWrite_o;
output MemtoReg_o;
output MemRead_o;
output MemWrite_o;
output Branch_o;

// Define the different type of instructions
assign RegWrite_o = NoOp_i ? 0 : (opcode_i == 7'b0100011) ? 0 : (opcode_i == 7'b1100011) ? 0 : 1;
// sw = 0100011, beq = 1100011. Aside from the two, all are 1

assign ALUSrc_o = NoOp_i ? 0 : (opcode_i == 7'b0110011 ) ? 0 : 1;
// R-format = 0, beq = don't care

assign ALUOp_o = NoOp_i ? 2'b00 : 
                 (opcode_i == 7'b0110011) ? 2'b10 : 
                 (opcode_i == 7'b1100011) ? 2'b01 : 2'b00;
// R-format = 10, beq = 01, i-type & s-type = 00

assign MemtoReg_o = NoOp_i ? 0 : (opcode_i == 7'b0000011) ? 1 : 0;
// only lw is 1

assign MemRead_o = NoOp_i ? 0 : (opcode_i == 7'b0000011) ? 1 : 0;
// only lw is 1

assign MemWrite_o = NoOp_i ? 0 : (opcode_i == 7'b0100011) ? 1 : 0;
// only sw is 1

assign Branch_o = NoOp_i ? 0 : (opcode_i == 7'b1100011) ? 1 : 0;

endmodule