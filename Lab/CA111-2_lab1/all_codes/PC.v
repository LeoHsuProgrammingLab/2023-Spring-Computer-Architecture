module PC
(
    clk_i,
    rst_i,
    pc_i,
    pc_o
);

// Ports
input               clk_i;
input               rst_i;
input   [31:0]      pc_i;
output  [31:0]      pc_o;

// Wires & Registers
reg     [31:0]      pc_o;

// When rst_i is 0, the reset is activated: reset to 0
// On the contrary, when rst_i is 1, the reset is deactivated: not reset, simply update
always@(posedge clk_i or negedge rst_i) begin /* 
If I simply define clk_i or rst_i, then the hardware will think it should do the block whenever clk_i change from 0 to 1 or 1 to 0
 */
    if(~rst_i) begin
        pc_o <= 32'b0;
    end
    else begin
        pc_o <= pc_i;
    end
end

endmodule
