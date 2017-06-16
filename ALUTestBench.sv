

module ALUTestBench();

// Inputs
  bit [4:0] OP;
  bit [7:0] inOne;
  bit [7:0] inTwo;

// Outputs
  wire [7:0] res;
  wire       ZERO;


ALU	b2v_inst(
	.inOne(inOne),
	.inTwo(inTwo),
	.OP(OP),
	.ZERO(ZERO),
	.res (res));

const logic [4:0]ADD = 5'b00000;
const logic [4:0]SUB = 5'b00001;
const logic [4:0]SLL = 5'b00010;
const logic [4:0]SRL = 5'b00011;
const logic [4:0]SLT = 5'b00111;
const logic [4:0]SUBU = 5'b01000;
const logic [4:0]ADDU = 5'b01001;
const logic [4:0]AND = 5'b01010;
const logic [4:0]SEZ = 5'b01011;
const logic [4:0]SEQ = 5'b01100;
const logic [4:0]MOD = 5'b01111;
const logic [4:0]ADDI = 5'b100XX;

initial begin
// Wait 10 ns for global reset to finish
  #10
  inOne = 8'b00000001;
  inTwo = 8'b00000010;
  #10	 OP = ADD;
  inOne = 8'b00000001;
  inTwo = 8'b00000010;
  #10	 OP = SUB;
  inOne = 8'b00000001;
  inTwo = 8'b00000010;
  #10	 OP = SLL;
  inOne = 8'b00000001;
  inTwo = 8'b00000010;
  #10	 OP = SRL;
  inOne = 8'b00001000;
  inTwo = 8'b00000010;
  #10	 OP = SLT;
  inOne = 8'b00000001;
  inTwo = 8'b10000010;
  #10 OP = SUBU;
  inOne = 8'b00000001;
  inTwo = 8'b10000010;
  #10	 OP = ADDU;
  inOne = 8'b00000001;
  inTwo = 8'b00000010;
  #10	 OP = AND;
  inOne = 8'b00000001;
  inTwo = 8'b00000010;
  #10	 OP = SEZ;
  inOne = 8'b00000001;
  inTwo = 8'b00000010;
  #10	 OP = SEQ;
  inOne = 8'b00000101;
  inTwo = 8'b00000010;
  #10	 OP = MOD;
  inOne = 8'b00000001;
  inTwo = 8'b00000010;
  #10    OP = ADDI;
  inOne = 8'b00000001;
  inTwo = 8'b00000010;

  
  
end

endmodule