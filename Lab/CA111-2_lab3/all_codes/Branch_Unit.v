module Branch_Unit(
    Branch_i,
    Predict_i,  
    ID_PC_i, 
    ID_immExtended_i,
    IF_ID_EX_Flush_i, 
    PC_Correct_i,
    
    Flush_o, 
    PCbranch_o
);

input Predict_i;
input Branch_i;
input [31:0] ID_PC_i;
input [31:0] ID_immExtended_i;
input IF_ID_EX_Flush_i; 
input [31:0] PC_Correct_i;
output Flush_o;
output [31:0] PCbranch_o;

assign PCbranch_o = IF_ID_EX_Flush_i ? PC_Correct_i : (ID_PC_i + (ID_immExtended_i << 1));
assign Flush_o = ((Predict_i && Branch_i) || IF_ID_EX_Flush_i ) ? 1 : 0;

endmodule