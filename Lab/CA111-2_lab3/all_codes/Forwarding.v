module Forwarding(
    MEM_RegWrite_i, 
    MEM_RDaddr_i, 
    WB_RegWrite_i, 
    WB_RDaddr_i,
    EX_RS1addr_i, 
    EX_RS2addr_i, 
    Forward_A_o, 
    Forward_B_o  
);

input MEM_RegWrite_i; 
input [4:0] MEM_RDaddr_i; 
input WB_RegWrite_i; 
input [4:0] WB_RDaddr_i;
input [4:0] EX_RS1addr_i; 
input [4:0] EX_RS2addr_i;

output [1:0] Forward_A_o;
output [1:0] Forward_B_o;

assign Forward_A_o = (MEM_RegWrite_i && (MEM_RDaddr_i != 4'b0) && (MEM_RDaddr_i == EX_RS1addr_i)) ? 2'b10 : 
                     (WB_RegWrite_i && (WB_RDaddr_i != 4'b0) && (WB_RDaddr_i == EX_RS1addr_i)) ? 2'b01 : 2'b00;
assign Forward_B_o = (MEM_RegWrite_i && (MEM_RDaddr_i != 4'b0) && (MEM_RDaddr_i == EX_RS2addr_i)) ? 2'b10 : 
                     (WB_RegWrite_i && (WB_RDaddr_i != 4'b0) && (WB_RDaddr_i == EX_RS2addr_i)) ? 2'b01 : 2'b00;

endmodule