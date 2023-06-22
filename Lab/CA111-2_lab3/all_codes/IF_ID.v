module IF_ID(
    clk_i, 
    rst_i,
    Stall_i, 
    Flush_i, 
    PC_i, 
    instr_i, 
    PC_o, 
    instr_o
);

input clk_i;
input rst_i;
input Stall_i;
input Flush_i;
input [31:0] PC_i;
input [31:0] instr_i;
output [31:0] PC_o;
output [31:0] instr_o;

// define reg because it is used in always block regarding clock
reg [31:0] PC_o;
reg [31:0] instr_o;

always@(posedge clk_i or negedge rst_i) begin
    if(Flush_i | ~rst_i) begin
        PC_o <= 32'b0;
        instr_o <= 32'b0;
    end 
    else if(!Stall_i) begin
        PC_o <= PC_i;
        instr_o <= instr_i;
    end
end

endmodule 

