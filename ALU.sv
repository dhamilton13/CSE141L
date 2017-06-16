import definitions::*;

module ALU(
  input [4:0] OP,
  input [7:0] inOne,
  input [7:0] inTwo,
  output logic [7:0] result,
  output logic branchCompPass,
  input fourShift
    );

  always_comb begin

	case(OP)
		ADD : result = inOne+inTwo;
		SUB : result = inOne-inTwo;
		SLL : result = (fourShift == 1)? (inOne << 4'b0100) : (inOne << inTwo);
		SRL : result = (fourShift == 1)? (inOne >> 4'b0100) : (inOne >> inTwo);
    SW  : result = inOne;
		BREG : result = inTwo;
		SUBU: result = inOne - $unsigned (inTwo);
		ADDU: result = inOne + $unsigned (inTwo);
		AND : result = inOne & inTwo;
		SLRA : result = (inOne << 4'b0100) + $unsigned (inTwo);
		SEQ : result = (inOne == inTwo) ? 8'b00000001 : 8'b0;
		SREG: result = inOne;
		LREG: result = inTwo;
		MOD : result = inOne % inTwo;
		5'b10000: result = inOne + inTwo;
		5'b10100 : begin
			  result = (inOne == 8'b0) ? inTwo : 8'b0;
			  branchCompPass = (inOne == 8'b0) ? 1'b1 : 1'b0;
			  end
		5'b11000 : begin
			  result = (inOne != 8'b0) ? inTwo : 8'b0;
			  branchCompPass = (inOne != 8'b0) ? 1'b1 : 1'b0;
			  end
		5'b11100  : result = (inTwo);
		default: result = 0;
	endcase
  end

endmodule
