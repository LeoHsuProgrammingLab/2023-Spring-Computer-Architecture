module Hazard_Detection(
    RS1addr_i, 
    RS2addr_i, 
    RDaddr_i, 
    MemRead_i, 
    NoOp_o, 
    Stall_o, 
    PCWrite_o
);

input [4:0] RS1addr_i;
input [4:0] RS2addr_i;
input [4:0] RDaddr_i;
input MemRead_i;
output NoOp_o;
output Stall_o;
output PCWrite_o;

assign NoOp_o = (MemRead_i && ((RDaddr_i == RS1addr_i) || (RDaddr_i == RS2addr_i))) ? 1 : 0; // For control of PC
assign Stall_o = (MemRead_i && ((RDaddr_i == RS1addr_i) || (RDaddr_i == RS2addr_i))) ? 1 : 0; // For control of IF/ID & Instruction Memory
assign PCWrite_o = (MemRead_i && ((RDaddr_i == RS1addr_i) || (RDaddr_i == RS2addr_i))) ? 0 : 1; // For control of Control 


endmodule