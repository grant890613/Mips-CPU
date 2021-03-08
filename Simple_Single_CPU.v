// Author: 0717035 王偉軒

module Simple_Single_CPU(clk_i,rst_i);

// Input port
input clk_i;
input rst_i;


wire  [32-1:0]  data_o_PC_1;
wire  [32-1:0]  data_o_PC_2;
wire  [32-1:0]  data_o_PC_source;
wire  [32-1:0]  pc_out_o;
wire  [32-1:0]  sum_o_adder1;
wire  [32-1:0]  sum_o_adder2;
wire  [32-1:0]  instr_o;

wire           RegWrite_i;
wire  [5-1:0]  RSaddr_i;
wire  [5-1:0]  RTaddr_i;
wire  [5-1:0]  RDaddr_i;
wire  [32-1:0] RDdata_i;

wire  [32-1:0] RSdata_o;
wire  [32-1:0] RTdata_o;

wire           RegWrite_o;
wire           RegWrite1;
wire  [4-1:0]  ALU_op_o;
wire           ALUSrc_o;
wire           RegDst_o;
wire           Branch_o;

wire           Mux_write_address;
wire           PC_source_address;
wire           two_one_mux_memorycontrol;

wire           read_memory;
wire           write_memory;         
wire  [32-1:0] output_memory;
wire  [32-1:0] output_mux_1_memory;
wire  [32-1:0] output_mux_2_memory;

wire           lui_ctrl;
wire           sltiu_ctrl;
wire           zero_extend;
wire  [5-1:0]  shamp_o;

wire  [5-1:0]  data_o_Mux_Write;
wire  [5-1:0]  data_o_Mux_Write2;
wire  [32-1:0] data_o_Sign_Extend;
wire  [32-1:0] data_o_Zero_Filled_Extend;
wire  [32-1:0] data_o_Extend;
wire  [32-1:0] data_o_Mux_ALUSrc;
wire  [32-1:0] data_o_Shift1;
wire  [32-1:0] data_o_Shift2;
wire  [32-1:0] jump_data_1;
wire  [32-1:0] jump_data_2;

wire  [4-1:0]  ALUCtrl_o;
wire  [32-1:0] result_o;
wire  [32-1:0] mul_o;
wire  [32-1:0] m_or_a;

wire           zero_o;
wire           change_o;
wire           jr_control;
wire           cross_control;
wire           zero_data;//zero_data

wire           PC_sel_1;
wire           PC_sel_2;
wire           PC_sel_3;
wire           PC_sel_4;
wire           PC_sel;




ProgramCounter PC(
    .clk_i(clk_i),
    .rst_i (rst_i),
    .pc_in_i(data_o_PC_1),
    .pc_out_o(pc_out_o)
    );

Adder Adder1(
    .src1_i(pc_out_o),
    .src2_i(32'b00000000000000000000000000000100),  //+4
    .sum_o(sum_o_adder1)
    );

Instr_Memory IM(
    .pc_addr_i(pc_out_o),
    .instr_o(instr_o)
    );

assign jump_data_1={{6{1'b0}},instr_o[25:0]};
assign jump_data_2={sum_o_adder1[31:28],data_o_Shift1[27:0]};

Shift_Left_Two_32 Shifter1(
    .data_i(jump_data_1),
    .data_o(data_o_Shift1)
    );

MUX_2to1 #(.size(5)) Mux_Write_Reg(
    .data0_i(instr_o[20:16]),
    .data1_i(instr_o[15:11]),
    .select_i(RegDst_o),
    .data_o(data_o_Mux_Write)
    );

MUX_2to1 #(.size(5)) Mux_Write_Reg_2(
    .data0_i(data_o_Mux_Write),
    .data1_i(5'b11111),
    .select_i(Mux_write_address),
    .data_o(data_o_Mux_Write2)
    );

assign RegWrite_o = (~jr_control) & RegWrite1;

Reg_File RF(
    .clk_i(clk_i),
    .rst_i(rst_i),
    .RSaddr_i(instr_o[25:21]) ,
    .RTaddr_i(instr_o[20:16]) ,
    .RDaddr_i(data_o_Mux_Write2) ,
    .RDdata_i(output_mux_2_memory) ,
    .RegWrite_i(RegWrite_o),
    .RSdata_o(RSdata_o) ,
    .RTdata_o(RTdata_o)
    );

Decoder decode_01(
    .instr_op_i(instr_o[31:26]),
    .RegWrite_o(RegWrite1),
    .ALU_op_o(ALU_op_o),
    .ALUSrc_o(ALUSrc_o),
    .RegDst_o(RegDst_o),
    .Branch_o(Branch_o),
    .zero_extend(zero_extend),
    .lui_ctrl(lui_ctrl),
    .sltiu_ctrl(sltiu_ctrl),
    .shamp_i(instr_o[10:6]),
    .shamp_o(shamp_o),
    .PC_source_address(PC_source_address),
    .Mux_write_address(Mux_write_address),
    .two_one_mux_memorycontrol(two_one_mux_memorycontrol),
    .read_memory(read_memory),
    .write_memory(write_memory)
    );

ALU_Ctrl a_c(
    .funct_i(instr_o[5:0]),
    .ALUOp_i(ALU_op_o),
    .ALUCtrl_o(ALUCtrl_o),
    .change_o(change_o),
    .jr_control(jr_control),
    .cross_control(cross_control)
    );

Sign_Extend SE(
    .data_i(instr_o[15:0]),
    .data_o(data_o_Sign_Extend)
    );

Zero_Filled_Extend ZFE(
    .data_i(instr_o[15:0]),
    .data_o(data_o_Zero_Filled_Extend)
    );

MUX_2to1 #(.size(32)) Mux_Signed_or_Unsigned(
    .data0_i(data_o_Sign_Extend),
    .data1_i(data_o_Zero_Filled_Extend),
    .select_i(zero_extend),
    .data_o(data_o_Extend)
    );

MUX_2to1 #(.size(32)) Mux_ALUSrc(
    .data0_i(RTdata_o),
    .data1_i(data_o_Extend),
    .select_i(ALUSrc_o),
    .data_o(data_o_Mux_ALUSrc)
    );

ALU alu_01(
    .src1_i(RSdata_o),
    .src2_i(data_o_Mux_ALUSrc),
    .ctrl_i(ALUCtrl_o),
    .sltiu_ctrl(sltiu_ctrl),
    .lui_ctrl(lui_ctrl),
    .shamp(shamp_o),
    .change(change_o),
    .result_o(result_o),
    .zero_o(zero_o)
    );


Cross cross(.cross_data_01(RSdata_o),.cross_data_02(RTdata_o),.cross_answer(mul_o));


MUX_2to1 #(.size(32)) Mul_or_ALU(
    .data0_i(result_o),
    .data1_i(mul_o),
    .select_i(cross_control),
    .data_o(m_or_a)
    );

Adder Adder2(
    .src1_i(sum_o_adder1),
    .src2_i(data_o_Shift2),
    .sum_o(sum_o_adder2)
    );

Shift_Left_Two_32 Shifter2(
    .data_i(data_o_Sign_Extend),
    .data_o(data_o_Shift2)
    );


assign zero_data = ~|RSdata_o;
assign PC_sel_1 = Branch_o && zero_o;
assign PC_sel_2 = Branch_o && (~zero_o);
assign PC_sel_3 = Branch_o && (RSdata_o[31]||zero_data);
assign PC_sel_4 = Branch_o && (~RSdata_o[31]&&~zero_data);


MUX_4to1 #(.size(1)) mux(
    .data0(PC_sel_1),
    .data1(PC_sel_2),
    .data2(PC_sel_3),
    .data3(PC_sel_4),
    .switch(instr_o[27:26]),
    .mux_4_out(PC_sel)
    );

MUX_2to1 #(.size(32)) PC_mux_source_1(
    .data0_i(sum_o_adder1),
    .data1_i(sum_o_adder2),    
    .select_i(PC_sel),
    .data_o(data_o_PC_source)
    );

MUX_2to1 #(.size(32)) PC_mux_source_2(
    .data0_i(data_o_PC_source),
    .data1_i(jump_data_2),   
    .select_i(PC_source_address),
    .data_o(data_o_PC_2)
    );

MUX_2to1 #(.size(32)) PC_mux_source_3(
    .data0_i(data_o_PC_2),
    .data1_i(RSdata_o),    
    .select_i(jr_control),
    .data_o(data_o_PC_1)
    );

//memory
Data_Memory Data_Memory(
    .clk_i(clk_i),
    .addr_i(result_o),
    .data_i(RTdata_o),
    .MemRead_i(read_memory),
    .MemWrite_i(write_memory),
    .data_o(output_memory)
    );

MUX_2to1 #(.size(32)) memory_mux_1(
    .data0_i(m_or_a),
    .data1_i(output_memory),
    .select_i(two_one_mux_memorycontrol),
    .data_o(output_mux_1_memory)
    );

MUX_2to1 #(.size(32)) memory_mux_2(
    .data0_i(output_mux_1_memory),
    .data1_i(data_o_PC_source),
    .select_i(Mux_write_address),
    .data_o(output_mux_2_memory)
    );

endmodule



