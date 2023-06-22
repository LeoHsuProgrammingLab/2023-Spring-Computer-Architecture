module CPU
(
    clk_i, 
    rst_i,
);

// Ports
input               clk_i;
input               rst_i;

parameter adder_const = {{29{1'b0}}, {3'b100}};

// TODO: Noted that if I don't specify inputs in each module, it will follow the top module.
PC PC(
    .clk_i(clk_i),
    .rst_i(rst_i),
    .pc_i(Add_PC.pc_o)
);

Instruction_Memory Instruction_Memory(
    .addr_i(PC.pc_o)
);

Registers Registers(
    .clk_i(clk_i),
    .rst_i(rst_i),
    .RS1addr_i(Instruction_Memory.instr_o[19:15]),
    .RS2addr_i(Instruction_Memory.instr_o[24:20]),
    .RDaddr_i(Instruction_Memory.instr_o[11:7]), 
    .RDdata_i(ALU.RDdata_o),
    .RegWrite_i(Control.RegWrite_o) 
);

//Hints

Control Control(
    .opcode_i(Instruction_Memory.instr_o[6:0])
);

Adder Add_PC(
    .pc_base_i(PC.pc_o),
    .pc_offset_i(adder_const),
    .pc_o(PC.pc_i)
);

MUX32 MUX_ALUSrc(
    .ALUSrc_i(Control.ALUSrc_o), 
    .RS2data_i(Registers.RS2data_o),
    .imm_i(Sign_Extend.extendimm_o)
);

Sign_Extend Sign_Extend(
    .imm_i(Instruction_Memory.instr_o[31:20])
);
  
ALU ALU(
    .ALUCtr_i(ALU_Control.ALUCtr_o), 
    .RS1data_i(Registers.RS1data_o), 
    .RS2data_i(MUX_ALUSrc.RS2data_o)
);

ALU_Control ALU_Control(
    .ALUOp_i(Control.ALUOp_o),
    .func3_i(Instruction_Memory.instr_o[14:12]),
    .func7_i(Instruction_Memory.instr_o[31:25])
);

endmodule

