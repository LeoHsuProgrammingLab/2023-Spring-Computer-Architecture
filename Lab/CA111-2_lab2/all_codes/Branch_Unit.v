module Branch_Unit(
    RS1data_i, 
    RS2data_i, 
    Branch_i, 
    pc_addr_i, 
    immExtended_i, 
    Flush_o, 
    PCbranch_o
);

input [31:0] RS1data_i;
input [31:0] RS2data_i;
input Branch_i;
input [31:0] pc_addr_i;
input [31:0] immExtended_i;
output Flush_o;
output [31:0] PCbranch_o;

assign PCbranch_o = pc_addr_i + (immExtended_i << 1);
assign Flush_o = (RS1data_i == RS2data_i && Branch_i) ? 1 : 0;

endmodule