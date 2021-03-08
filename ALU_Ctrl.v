// Author: 0717035 王偉軒

module ALU_Ctrl(
        funct_i,
        ALUOp_i,
        ALUCtrl_o,
        change_o,
        jr_control,
        cross_control
        );

//I/O ports
input      [6-1:0] funct_i;
input      [4-1:0] ALUOp_i;

output     [4-1:0] ALUCtrl_o;
output			   change_o;
output			   jr_control;
output			   cross_control;

//Internal Signals
reg        [4-1:0] ALUCtrl_o;
reg			   	   change_o;
reg 			   jr_control;
reg			   	   cross_control;

//Select exact operation
always @(*) begin
	if(ALUOp_i==4'b0001)begin           //addi
			ALUCtrl_o=4'b0010;
			change_o=1'b0;
			jr_control=1'b0;
			cross_control=1'b0;
	end else if(ALUOp_i==4'b0010)begin  //beq
			ALUCtrl_o=4'b0110;
			change_o=1'b0;
			jr_control=1'b0;
			cross_control=1'b0;
	end else if(ALUOp_i==4'b0011)begin  //bne
			ALUCtrl_o=4'b0110;
			change_o=1'b0;
			jr_control=1'b0;
			cross_control=1'b0;
	end else if(ALUOp_i==4'b0100)begin  //lui
			ALUCtrl_o=4'b1111;
			change_o=1'b0;
			jr_control=1'b0;
			cross_control=1'b0;
	end else if(ALUOp_i==4'b0101)begin  //ori
			ALUCtrl_o=4'b0001;
			change_o=1'b0;
			jr_control=1'b0;
			cross_control=1'b0;
	end else if(ALUOp_i==4'b0110)begin  //sltiu
			ALUCtrl_o=4'b0111;
			change_o=1'b0;
			jr_control=1'b0;
			cross_control=1'b0;
	end else if(ALUOp_i==4'b1110)begin   //blez
			ALUCtrl_o=4'b0110;
			change_o=1'b0;
			jr_control=1'b0;
			cross_control=1'b0;
	end else if(ALUOp_i==4'b1111)begin   //bgtz
			ALUCtrl_o=4'b0110;
			change_o=1'b0;
			jr_control=1'b0;
			cross_control=1'b0;
	end else if(ALUOp_i==4'b0111)begin   //jump
			ALUCtrl_o=4'bxxxx;
			change_o=1'bx;
			jr_control=1'b0;
			cross_control=1'b0;
	end else if(ALUOp_i==4'b1000)begin   //jal
			ALUCtrl_o=4'bxxxx;
			change_o=1'bx;
			jr_control=1'b0;
			cross_control=1'b0;
	end else if(ALUOp_i==4'b1010)begin   //lw
			ALUCtrl_o=4'b0010;
			change_o=1'bx;
			jr_control=1'b0;
			cross_control=1'b0;
	end else if(ALUOp_i==4'b1011)begin   //sw
			ALUCtrl_o=4'b0010;
			change_o=1'bx;
			jr_control=1'b0;
			cross_control=1'b0;
	end else if(ALUOp_i==4'b0000 && funct_i==6'b100001)begin  //addu
			ALUCtrl_o=4'b0010;
			change_o=1'b0;
			jr_control=1'b0;
			cross_control=1'b0;
	end else if(ALUOp_i==4'b0000 && funct_i==6'b100100)begin  //and
			ALUCtrl_o=4'b0000;
			change_o=1'b0;
			jr_control=1'b0;
			cross_control=1'b0;
	end else if(ALUOp_i==4'b0000 && funct_i==6'b000111)begin  //srav
			ALUCtrl_o=4'b1111;
			change_o=1'b0;
			jr_control=1'b0;
			cross_control=1'b0;
	end else if(ALUOp_i==4'b0000 && funct_i==6'b100101)begin  //or
			ALUCtrl_o=4'b0001;
			change_o=1'b0;
			jr_control=1'b0;
			cross_control=1'b0;
	end else if(ALUOp_i==4'b0000 && funct_i==6'b101010)begin  //slt
			ALUCtrl_o=4'b0111;
			change_o=1'b0;
			jr_control=1'b0;
			cross_control=1'b0;
	end else if(ALUOp_i==4'b0000 && funct_i==6'b000011)begin  //sra
			ALUCtrl_o=4'b1111;
			change_o=1'b0;
			jr_control=1'b0;
			cross_control=1'b0;
	end else if(ALUOp_i==4'b0000 && funct_i==6'b000000)begin  //sll
			ALUCtrl_o=4'b1111;
			change_o=1'b1;
			jr_control=1'b0;
			cross_control=1'b0;
	end else if(ALUOp_i==4'b0000 && funct_i==6'b100011)begin  //subu
			ALUCtrl_o=4'b0110;
			change_o=1'b0;
			jr_control=1'b0;
			cross_control=1'b0;
	end else if(ALUOp_i==4'b0000 && funct_i==6'b001000)begin  //jr
			ALUCtrl_o=4'bxxxx;
			change_o=1'bx;
			jr_control=1'b1;
			cross_control=1'b0;
	end else if(ALUOp_i==4'b0000 && funct_i==6'b011000)begin  //mul
			ALUCtrl_o=4'bxxxx;
			change_o=1'bx;
			jr_control=1'b0;
			cross_control=1'b1;
	end
end


endmodule
