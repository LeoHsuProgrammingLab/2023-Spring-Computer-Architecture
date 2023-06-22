module ALU(
    ALUCtr_i, 
    RS1data_i, 
    RS2data_i,  
    RDdata_o
);

input [2:0] ALUCtr_i;
input signed [31:0] RS1data_i;
input [31:0] RS2data_i;
output [31:0] RDdata_o;

// case and if-else must be in an always block

assign RDdata_o = (ALUCtr_i == 3'b000) ? (RS1data_i & RS2data_i) : // and
                  (ALUCtr_i == 3'b001) ? (RS1data_i ^ RS2data_i) : // xor
                  (ALUCtr_i == 3'b010) ? (RS1data_i << RS2data_i) : // sll
                  (ALUCtr_i == 3'b011) ? (RS1data_i + RS2data_i) : // add, addi, lw, sw, beq(don't care)
                  (ALUCtr_i == 3'b100) ? (RS1data_i - RS2data_i) : // sub
                  (ALUCtr_i == 3'b101) ? (RS1data_i * RS2data_i) : (RS1data_i >>> RS2data_i[4:0]);// mul
                  // (ALUCtr_i == 3'b111) srai: https://nandland.com/shift-operator/

endmodule
