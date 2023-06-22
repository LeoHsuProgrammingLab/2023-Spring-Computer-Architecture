module ALU_Control(
    ALUOp_i,
    func3_i,
    func7_i,
    ALUCtr_o
);

input [1:0] ALUOp_i;
input [2:0] func3_i;
input [6:0] func7_i;
output [2:0] ALUCtr_o;

// define ALUCtr:
// and : 0000
// xor : 0001
// sll : 010
// add : 011
// sub : 100
// mul : 101
// addi : 011
// srai : 111


assign ALUCtr_o = (ALUOp_i == 2'b01 && func3_i == 3'b111) ? 3'b000 : //and 
                  (ALUOp_i == 2'b01 && func3_i == 3'b100) ? 3'b001 : //xor
                  (ALUOp_i == 2'b01 && func3_i == 3'b001) ? 3'b010 : //sll
                  (ALUOp_i == 2'b01 && func3_i == 3'b000 && func7_i == 7'b0000000) ? 3'b011 : //add
                  (ALUOp_i == 2'b01 && func3_i == 3'b000 && func7_i == 7'b0100000) ? 3'b100 : //sub
                  (ALUOp_i == 2'b01 && func3_i == 3'b000 && func7_i == 7'b0000001) ? 3'b101 : //mul
                  (ALUOp_i == 2'b00 && func3_i == 3'b000) ? 3'b011 : 3'b111; //addi & srai

endmodule