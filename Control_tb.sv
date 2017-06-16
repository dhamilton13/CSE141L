////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:42:06 02/16/2012
// Design Name:   Control
// Module Name:   /department/home/leporter/Desktop/basic_processor/Control_tb.v
// Project Name:  basic_processor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Control
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////
import definitions::*;

module Control_tb;

// Inputs
  bit [8:0] OPCODE;

// Outputs
  wire [4:0] ALU_OP;
  wire [1:0] ALU_SRC_A;
  wire [3:0] ALU_SRC_B;
  wire R_Type;
  wire REG_WRITE;
  wire BRANCH;
  wire MEM_WRITE;
  wire MEM_READ;
  wire [3:0] REG_DST;
  wire MEM_TO_REG;
  wire HALT;

	// Instantiate the Unit Under Test (UUT)
	Control uut (
		.OPCODE    , 
		.ALU_OP    , 
 		.ALU_SRC_A ,
		.ALU_SRC_B , 
		.R_Type    , 
		.REG_WRITE , 
 		.BRANCH    ,
		.MEM_WRITE , 
		.MEM_READ  , 
		.REG_DST   , 
		.MEM_TO_REG, 
		.HALT
	);

	initial begin
// Wait 20 ns for global reset to finish
		#20ns;
		// Add stimulus here
		#10ns OPCODE = 9'b000000000;//add
		#10ns OPCODE = 9'b000011100;//sub
		#10ns OPCODE = 9'b000100011;//sll
		#10ns OPCODE = 9'b000111000;//srl
		#10ns OPCODE = 9'b001000010;//lw
		#10ns OPCODE = 9'b001011010;//sw
		#10ns OPCODE = 9'b001100000;//hlt
		#10ns OPCODE = 9'b001110101;//breg
		#10ns OPCODE = 9'b010001111;//subu
		#10ns OPCODE = 9'b010010000;//addu
		#10ns OPCODE = 9'b010100000;//and
		#10ns OPCODE = 9'b010110000;//slra
		#10ns OPCODE = 9'b011000000;//seq
		#10ns OPCODE = 9'b011010000;//sreg
		#10ns OPCODE = 9'b011100000;//lreg
		#10ns OPCODE = 9'b011110000;//mod
		#10ns OPCODE = 9'b100110000;//addi
		#10ns OPCODE = 9'b101110000;//bne
		#10ns OPCODE = 9'b110110000;//bez
		#10ns OPCODE = 9'b111110000;//mv
		#10ns;
	end
      
endmodule

