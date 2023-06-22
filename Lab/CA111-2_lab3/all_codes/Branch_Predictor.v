module Branch_Predictor
(
    clk_i, 
    rst_i,

    ALUResult_i, 
    EX_Branch_i,
    EX_PC_i,
    EX_Predict_i,
    EX_immExtended_i, 

	Predict_o,
    PC_o, 
    IF_ID_EX_Flush_o,
);
input clk_i, rst_i;
input EX_Branch_i;
input EX_Predict_i;
input [31:0] ALUResult_i;
input [31:0] EX_PC_i;
input [31:0] EX_immExtended_i;
output Predict_o, IF_ID_EX_Flush_o;
output [31:0] PC_o;

reg [1:0] BHT;
  
assign Predict_o = (BHT[1] == 1) ? 1 : 0;
assign IF_ID_EX_Flush_o = (EX_Branch_i && (EX_Predict_i != (ALUResult_i == 0))) ? 1 : 0;
assign PC_o = (EX_Predict_i) ? EX_PC_i + 4 : EX_PC_i + (EX_immExtended_i << 1);

// TODO
always@(posedge clk_i or negedge rst_i) begin
    if(~rst_i) begin
        BHT <= 2'b11;
    end 
    else if(EX_Branch_i) begin
        if(EX_Predict_i == (ALUResult_i == 0)) begin // ALUResult == 0 : Taken
            if(BHT[1]) begin 
                BHT = 2'b11;
            end
            else begin
                BHT = 2'b00;
            end
        end
        else begin //Prediction Failed
            // Update the BHT
            if(BHT == 2'b11) begin
                BHT <= 2'b10;
            end
            else if(BHT == 2'b10) begin
                BHT <= 2'b01;
            end 
            else if(BHT == 2'b01) begin
                BHT <= 2'b10;
            end 
            else begin
                BHT <= 2'b01;
            end
        end
    end
end

endmodule
