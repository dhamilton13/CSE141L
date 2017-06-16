// Create Date:    18:08:46 02/16/2012
// Design Name:
// Module Name:    Control
// Project Name:
// Description:
//
// Dependencies:
//
// Revision: 	  2017.02.25
// Revision 0.01 - File Created
// Additional Comments:
//
import definitions::*;
module Control(
    input        [8:0] OPCODE,
    output logic [4:0] ALU_OP,
    output logic [1:0] ALU_SRC_A,
    output logic [3:0] ALU_SRC_B,
    output logic       R_Type,
    output logic       REG_WRITE,
    output logic       BRANCH,
    output logic       MEM_WRITE,
    output logic       MEM_READ,
    output logic [3:0] REG_DST,
    output logic       MEM_TO_REG,
    output logic       HALT
    );

	always_comb begin
		case(OPCODE[8])
			0 : begin //R type
				case(OPCODE[7:4])
					0: //add
						begin
							ALU_OP     = ADD;
							ALU_SRC_A  = OPCODE[3:2];
							ALU_SRC_B  = OPCODE[1:0];
							R_Type     = 1;
							REG_WRITE  = 1;
							BRANCH     = 0;
							MEM_WRITE  = 0;
							MEM_READ   = 0;
							REG_DST    = OPCODE[3:2];
							MEM_TO_REG = 0;
							HALT       = 0;
						end
					1: //sub
						begin
							ALU_OP     = SUB;
							ALU_SRC_A  = OPCODE[3:2];
							ALU_SRC_B  = OPCODE[1:0];
							R_Type     = 1;
							REG_WRITE  = 1;
							BRANCH     = 0;
							MEM_WRITE  = 0;
							MEM_READ   = 0;
							REG_DST    = OPCODE[3:2];
							MEM_TO_REG = 0;
							HALT       = 0;
						end
					2: //sll
						begin
							ALU_OP     = SLL;
							ALU_SRC_A  = OPCODE[3:2];
							ALU_SRC_B  = OPCODE[1:0];
							R_Type     = 1;
							REG_WRITE  = 1;
							BRANCH     = 0;
							MEM_WRITE  = 0;
							MEM_READ   = 0;
							REG_DST    = OPCODE[3:2];
							MEM_TO_REG = 0;
							HALT       = 0;
						end
					3: //srl
						begin
							ALU_OP     = SRL;
							ALU_SRC_A  = OPCODE[3:2];
							ALU_SRC_B  = OPCODE[1:0];
							R_Type     = 1;
							REG_WRITE  = 1;
							BRANCH     = 0;
							MEM_WRITE  = 0;
							MEM_READ   = 0;
							REG_DST    = OPCODE[3:2];
							MEM_TO_REG = 0;
							HALT       = 0;
						end
					4: //lw
						begin
							ALU_OP     = LW;
							ALU_SRC_A  = OPCODE[3:2];
							ALU_SRC_B  = OPCODE[1:0];
							R_Type     = 1;
							REG_WRITE  = 1;
							BRANCH     = 0;
							MEM_WRITE  = 0;
							MEM_READ   = 1;
							REG_DST    = OPCODE[3:2];
							MEM_TO_REG = 1;
							HALT       = 0;
						end
					5: //sw
						begin
							ALU_OP     = SW;
							ALU_SRC_A  = OPCODE[3:2];
							ALU_SRC_B  = OPCODE[1:0];
							R_Type     = 1;
							REG_WRITE  = 0;
							BRANCH     = 0;
							MEM_WRITE  = 1;
							MEM_READ   = 0;
							REG_DST    = 0;
							MEM_TO_REG = 0;
							HALT       = 0;
						end
					6: //ht
						begin
							ALU_OP     = 0;
							ALU_SRC_A  = 0;
							ALU_SRC_B  = 0;
							R_Type     = 0;
							REG_WRITE  = 0;
							BRANCH     = 0;
							MEM_WRITE  = 0;
							MEM_READ   = 0;
							REG_DST    = 0;
							MEM_TO_REG = 0;
							HALT       = 1;
						end
					7: //breg
						begin
							ALU_OP     = BREG;
							ALU_SRC_A  = 0;
							ALU_SRC_B  = OPCODE[3:0];
							R_Type     = 0;
							REG_WRITE  = 1;
							BRANCH     = 0;
							MEM_WRITE  = 0;
							MEM_READ   = 0;
							REG_DST    = 4'b1000;
							MEM_TO_REG = 0;
							HALT       = 1;
						end
					8: //subu skip for now
						begin
							ALU_OP     = 0;
							ALU_SRC_A  = 0;
							ALU_SRC_B  = 0;
							R_Type     = 0;
							REG_WRITE  = 0;
							BRANCH     = 0;
							MEM_WRITE  = 0;
							MEM_READ   = 0;
							REG_DST    = 0;
							MEM_TO_REG = 0;
							HALT       = 1;
						end
					9: //addu skip for now
						begin
							ALU_OP     = 0;
							ALU_SRC_A  = 0;
							ALU_SRC_B  = 0;
							R_Type     = 0;
							REG_WRITE  = 0;
							BRANCH     = 0;
							MEM_WRITE  = 0;
							MEM_READ   = 0;
							REG_DST    = 0;
							MEM_TO_REG = 0;
							HALT       = 1;
						end
					10: //and
						begin
							ALU_OP     = AND;
							ALU_SRC_A  = OPCODE[3:2];
							ALU_SRC_B  = OPCODE[1:0];
							R_Type     = 1;
							REG_WRITE  = 1;
							BRANCH     = 0;
							MEM_WRITE  = 0;
							MEM_READ   = 0;
							REG_DST    = OPCODE[3:2];
							MEM_TO_REG = 0;
							HALT       = 0;
						end
					11: //slra
						begin
							ALU_OP     = SLRA;
							ALU_SRC_A  = 4'b1000;
							ALU_SRC_B  = OPCODE[3:0];
							R_Type     = 0;
							REG_WRITE  = 1;
							BRANCH     = 0;
							MEM_WRITE  = 0;
							MEM_READ   = 0;
							REG_DST    = 4'b1000;
							MEM_TO_REG = 0;
							HALT       = 0;
						end
					12: //seq skip for now
						begin
							ALU_OP     = 0;
							ALU_SRC_A  = OPCODE[3:2];
							ALU_SRC_B  = OPCODE[1:0];
							R_Type     = 1;
							REG_WRITE  = 1;
							BRANCH     = 0;
							MEM_WRITE  = 0;
							MEM_READ   = 0;
							REG_DST    = OPCODE[1:0];
							MEM_TO_REG = 0;
							HALT       = 0;
						end
					13: //sreg
						begin
							ALU_OP     = SREG;
							ALU_SRC_A  = OPCODE[3:2];
							ALU_SRC_B  = OPCODE[1:0];
							R_Type     = 1;
							REG_WRITE  = 1;
							BRANCH     = 0;
							MEM_WRITE  = 0;
							MEM_READ   = 0;
							REG_DST    = (OPCODE[1:0] + 3'b100); //add 4 to access reg4-7
							MEM_TO_REG = 0;
							HALT       = 0;
						end
					14: //lreg
						begin
							ALU_OP     = LREG;
							ALU_SRC_A  = OPCODE[3:2];
							ALU_SRC_B  = (OPCODE[1:0] + 3'b100); //add 4 to access reg4-7
							R_Type     = 1;
							REG_WRITE  = 1;
							BRANCH     = 0;
							MEM_WRITE  = 0;
							MEM_READ   = 0;
							REG_DST    = OPCODE[3:2];
							MEM_TO_REG = 0;
							HALT       = 0;
						end
					15: //mod
						begin
							ALU_OP     = MOD;
							ALU_SRC_A  = OPCODE[3:2];
							ALU_SRC_B  = (OPCODE[1:0]);
							R_Type     = 1;
							REG_WRITE  = 1;
							BRANCH     = 0;
							MEM_WRITE  = 0;
							MEM_READ   = 0;
							REG_DST    = OPCODE[3:2];
							MEM_TO_REG = 0;
							HALT       = 0;
						end
				endcase
			end
			1: begin //I type
				case(OPCODE[7:6])
					0:
						begin //addi
							ALU_OP     = 5'b10000;//hardcoded because XX value in definitions
							ALU_SRC_A  = OPCODE[5:4];
							ALU_SRC_B  = OPCODE[3:0];
							R_Type     = 0;
							REG_WRITE  = 1;
							BRANCH     = 0;
							MEM_WRITE  = 0;
							MEM_READ   = 0;
							REG_DST    = OPCODE[5:4];
							MEM_TO_REG = 0;
							HALT       = 0;
						end
					1:
						begin //bez
							ALU_OP     = 5'b10100;//hardcoded because XX value in definitions
							ALU_SRC_A  = OPCODE[1:0];
							ALU_SRC_B  = 4'b1000;
							R_Type     = 0;
							REG_WRITE  = 0;
							BRANCH     = 1;
							MEM_WRITE  = 0;
							MEM_READ   = 0;
							REG_DST    = 0;
							MEM_TO_REG = 0;
							HALT       = 0;
						end
					2:
						begin //bne
							ALU_OP     = 5'b11000;//hardcoded because XX value in definitions
							ALU_SRC_A  = OPCODE[1:0];
							ALU_SRC_B  = 4'b1000;
							R_Type     = 0;
							REG_WRITE  = 0;
							BRANCH     = 1;
							MEM_WRITE  = 0;
							MEM_READ   = 0;
							REG_DST    = 0;
							MEM_TO_REG = 0;
							HALT       = 0;
						end
					3:
						begin //mv
							ALU_OP     = 5'b11100;//hardcoded because XX value in definitions
							ALU_SRC_A  = OPCODE[5:4];
							ALU_SRC_B  = OPCODE[3:0];
							R_Type     = 0;
							REG_WRITE  = 1;
							BRANCH     = 0;
							MEM_WRITE  = 0;
							MEM_READ   = 0;
							REG_DST    = OPCODE[5:4];
							MEM_TO_REG = 0;
							HALT       = 0;
						end
				endcase
			end
		endcase
	end
endmodule
