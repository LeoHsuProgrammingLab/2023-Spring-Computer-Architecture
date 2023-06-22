module MUX32(
    Data1_i, 
    Data2_i, 
    Choose_i, 
    Data_o
);

input [31:0] Data1_i;
input [31:0] Data2_i;
input Choose_i;
output [31:0] Data_o;

assign Data_o = (Choose_i) ? Data2_i : Data1_i;
 
endmodule

module MUX32_4(
    Data1_i, 
    Data2_i, 
    Data3_i, 
    Data4_i, 
    Choose_i,
    Data_o
);

input [31:0] Data1_i;
input [31:0] Data2_i;
input [31:0] Data3_i;
input [31:0] Data4_i;
input [1:0] Choose_i;
output [31:0] Data_o;

assign Data_o = (Choose_i == 2'b00) ? Data1_i : 
                   (Choose_i == 2'b01) ? Data2_i :
                   (Choose_i == 2'b10) ? Data3_i : Data4_i;

endmodule