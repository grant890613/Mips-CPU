// Author: 0717035 王偉軒

module Decoder(
    instr_op_i,
    RegWrite_o,
    ALU_op_o,
    ALUSrc_o,
    RegDst_o,
    Branch_o,
    zero_extend,
    lui_ctrl,
    sltiu_ctrl,
    shamp_i,
    shamp_o,
    PC_source_address,
    Mux_write_address,
    two_one_mux_memorycontrol,
    read_memory,
    write_memory,
    );

//I/O ports
input  [6-1:0] instr_op_i;
input  [5-1:0] shamp_i;

output         RegWrite_o;
output [4-1:0] ALU_op_o;
output         ALUSrc_o;
output         RegDst_o;
output         Branch_o;

output         sltiu_ctrl;
output         lui_ctrl;
output         zero_extend;
output  [5-1:0] shamp_o;

/////////////////new output/////////////////////////
output		   PC_source_address;
output		   Mux_write_address;
output		   two_one_mux_memorycontrol;
output		   read_memory;
output		   write_memory;


//Internal Signals
reg    [4-1:0] ALU_op_o;
reg            ALUSrc_o;
reg            RegWrite_o;
reg            RegDst_o;
reg            Branch_o;
reg            zero_extend;
reg            lui_ctrl;
reg            sltiu_ctrl;
reg    [5-1:0] shamp_o;

/////////////////new reg/////////////////////////
reg		        PC_source_address;
reg    		    Mux_write_address;
reg		   		two_one_mux_memorycontrol;
reg		   		read_memory;
reg		  		write_memory;



always @(*) begin
	
	if(instr_op_i==6'b000000)begin   //R-types
		RegDst_o = 1'b1;
		Branch_o = 1'b0;
		ALUSrc_o = 1'b0;
		RegWrite_o = 1'b1;
		zero_extend = 1'b0;
		lui_ctrl = 1'b0;
		sltiu_ctrl = 1'b0;
		ALU_op_o = 4'b0000;
		shamp_o = shamp_i;		
		///////////////////////////////////
		Mux_write_address = 1'b0;
		PC_source_address = 1'b0;
		two_one_mux_memorycontrol = 1'b0;
		read_memory = 1'b0;
		write_memory = 1'b0;
	end else if(instr_op_i==6'b001000)begin  //addi
		RegDst_o = 1'b0;
		Branch_o = 1'b0;
		ALUSrc_o = 1'b1;
		RegWrite_o = 1'b1;
		zero_extend = 1'b0;
		lui_ctrl = 1'b0;
		sltiu_ctrl = 1'b0;
		ALU_op_o = 4'b0001;
		shamp_o = 5'b00000;
		///////////////////////////////////
		Mux_write_address = 1'b0;
		PC_source_address = 1'b0;
		two_one_mux_memorycontrol = 1'b0;
		read_memory = 1'b0;
		write_memory = 1'b0;
	end else if(instr_op_i==6'b000100)begin  //beq
		RegDst_o = 1'bx;
		Branch_o = 1'b1;
		ALUSrc_o = 1'b0;
		RegWrite_o = 1'b0;
		zero_extend = 1'b0;
		lui_ctrl = 1'b0;
		sltiu_ctrl = 1'b0;
		ALU_op_o = 4'b0010;
		shamp_o = 5'b00000;
		///////////////////////////////////
		Mux_write_address = 1'b0;
		PC_source_address = 1'b0;
		two_one_mux_memorycontrol = 1'bx;
		read_memory = 1'b0;
		write_memory = 1'b0;
	end else if(instr_op_i==6'b000101)begin  //bne
		RegDst_o = 1'bx;
		Branch_o = 1'b1;
		ALUSrc_o = 1'b0;
		RegWrite_o = 1'b0;
		zero_extend = 1'b0;
		lui_ctrl = 1'b0;
		sltiu_ctrl = 1'b0;
		ALU_op_o = 4'b0011;
		shamp_o = 5'b00000;
		///////////////////////////////////
		Mux_write_address = 1'b0;
		PC_source_address = 1'b0;
		two_one_mux_memorycontrol = 1'bx;
		read_memory = 1'b0;
		write_memory = 1'b0;
	end else if(instr_op_i==6'b001111)begin  //lui
		RegDst_o = 1'b0;
		Branch_o = 1'b0;
		ALUSrc_o = 1'b1;
		RegWrite_o = 1'b1;
		zero_extend = 1'b0;
		lui_ctrl = 1'b1;
		sltiu_ctrl = 1'b0;
		ALU_op_o = 4'b0100;
		shamp_o = 5'b00000;
		///////////////////////////////////
		Mux_write_address = 1'b0;
		PC_source_address = 1'b0;
		two_one_mux_memorycontrol = 1'b0;
		read_memory = 1'b0;
		write_memory = 1'b0;
	end else if(instr_op_i==6'b001101)begin  //ori
		RegDst_o = 1'b0;
		Branch_o = 1'b0;
		ALUSrc_o = 1'b1;
		RegWrite_o = 1'b1;
		zero_extend = 1'b1;
		lui_ctrl = 1'b0;
		sltiu_ctrl = 1'b0;
		ALU_op_o = 4'b0101;
		shamp_o = 5'b00000;
		///////////////////////////////////
		Mux_write_address = 1'b0;
		PC_source_address = 1'b0;
		two_one_mux_memorycontrol = 1'b0;
		read_memory = 1'b0;
		write_memory = 1'b0;
	end else if(instr_op_i==6'b001011)begin  //sltiu
		RegDst_o = 1'b0;
		Branch_o = 1'b0;
		ALUSrc_o = 1'b1;
		RegWrite_o = 1'b1;
		zero_extend = 1'b1;
		lui_ctrl = 1'b0;
		sltiu_ctrl = 1'b1;
		ALU_op_o = 4'b0110;
		shamp_o = 5'b00000;
		///////////////////////////////////
		Mux_write_address = 1'b0;
		PC_source_address = 1'b0;
		two_one_mux_memorycontrol = 1'b0;
		read_memory = 1'b0;
		write_memory = 1'b0;
	end else if(instr_op_i==6'b000010)begin  //jump
		RegDst_o = 1'b0;
		Branch_o = 1'b0;
		ALUSrc_o = 1'b0;
		RegWrite_o = 1'b0;
		zero_extend = 1'b0;
		lui_ctrl = 1'b0;
		sltiu_ctrl = 1'b0;
		ALU_op_o = 4'b0111;
		shamp_o = 5'b00000;
		///////////////////////////////////
		Mux_write_address = 1'b0;
		PC_source_address = 1'b1;
		two_one_mux_memorycontrol = 1'b0;
		read_memory = 1'b0;
		write_memory = 1'b0;
	end else if(instr_op_i==6'b000011)begin  //jal
		RegDst_o = 1'b0;
		Branch_o = 1'b0;
		ALUSrc_o = 1'b0;
		RegWrite_o = 1'b1;
		zero_extend = 1'b0;
		lui_ctrl = 1'b0;
		sltiu_ctrl = 1'b0;
		ALU_op_o = 4'b1000;
		shamp_o = 5'b00000;
		///////////////////////////////////
		Mux_write_address = 1'b1;
		PC_source_address = 1'b1;
		two_one_mux_memorycontrol = 1'b0;
		read_memory = 1'b0;
		write_memory = 1'b0;
	end else if(instr_op_i==6'b000110)begin  //blez
		RegDst_o = 1'b0;
		Branch_o = 1'b1;
		ALUSrc_o = 1'b0;
		RegWrite_o = 1'b0;
		zero_extend = 1'b0;
		lui_ctrl = 1'b0;
		sltiu_ctrl = 1'b0;
		ALU_op_o = 4'b1110;
		shamp_o = 5'b00000;
		///////////////////////////////////
		Mux_write_address = 1'b0;
		PC_source_address = 1'b0;
		two_one_mux_memorycontrol = 1'b0;
		read_memory = 1'b0;
		write_memory = 1'b0;
	end else if(instr_op_i==6'b000111)begin  //bgtz
		RegDst_o = 1'b0;
		Branch_o = 1'b1;
		ALUSrc_o = 1'b0;
		RegWrite_o = 1'b0;
		zero_extend = 1'b0;
		lui_ctrl = 1'b0;
		sltiu_ctrl = 1'b0;
		ALU_op_o = 4'b1111;
		shamp_o = 5'b00000;
		///////////////////////////////////
		Mux_write_address = 1'b0;
		PC_source_address = 1'b0;
		two_one_mux_memorycontrol = 1'b0;
		read_memory = 1'b0;
		write_memory = 1'b0;
	end else if(instr_op_i==6'b100011)begin  //lw
		RegDst_o = 1'b0;
		ALUSrc_o = 1'b1;
		RegWrite_o = 1'b1;
		Branch_o = 1'b0;
		ALU_op_o = 4'b1010;
		zero_extend = 1'b0;
		lui_ctrl = 1'b0;
		sltiu_ctrl = 1'b0;
		shamp_o = 5'b00000;
		///////////////////////////////////
		Mux_write_address = 1'b0;
		PC_source_address = 1'b0;
		two_one_mux_memorycontrol = 1'b1;
		read_memory = 1'b1;
		write_memory = 1'b0;
	end else if(instr_op_i==6'b101011)begin  //sw
		RegDst_o = 1'bx;
		ALUSrc_o = 1'b1;
		RegWrite_o = 1'b0;
		Branch_o = 1'b0;
		ALU_op_o = 4'b1011;		
		zero_extend = 1'b0;
		lui_ctrl = 1'b0;
		sltiu_ctrl = 1'b0;
		shamp_o = 5'b00000;
		///////////////////////////////////
		Mux_write_address = 1'b0;
		PC_source_address = 1'b0;
		two_one_mux_memorycontrol = 1'bx;
		read_memory = 1'b0;
		write_memory = 1'b1;
	end
end




endmodule
