
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

	 
module ALU(
  input [4:0] OP,
  input [7:0] inOne,
  input [7:0] inTwo,
  output logic [7:0] res,
  output logic ZERO
    );
	 
	
  always_comb begin
	
	case(OP)
	  ADD : res = inOne+inTwo;
	  SUB : res = inOne-inTwo;
	  SLL : res = inOne << inTwo;
	  SRL : res = inOne >> inTwo;
	  SLT:  res = (inOne < inTwo) ? 8'b00000001 : 8'b0;
	  SUBU: res = inOne - $unsigned (inTwo);
          ADDU: res = inOne + $unsigned (inTwo);
	  AND:  res = inOne & inTwo;
	  SEZ:  res = 8'b0;
	  SEQ:  res = (inOne == inTwo) ? 8'b00000001 : 8'b0;
	  MOD:  res = inOne % inTwo;
	  ADDI: res = inOne+inTwo;
	  default: res = 0;
	endcase
	 
	case(res)
	  8'b0 :   ZERO = 1'b1;
	  default : ZERO = 1'b0;
	endcase


  end

endmodule
