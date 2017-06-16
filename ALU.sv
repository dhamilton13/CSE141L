import definitions::*;

module ALU(
  input [4:0] OP,
  input [7:0] inOne,
  input [7:0] inTwo,
  output logic [7:0] result,
  output logic branchCompPass,
  output logic fourShift
    );

  always_comb begin

	case(OP)
		ADD : result = inOne+inTwo;
		SUB : result = inOne-inTwo;
		SLL : result = (fourShift == 1)? (inOne << 4'b0100) : (inOne << inTwo);
		SRL : result = (fourShift == 1)? (inOne >> 4'b0100) : (inOne >> inTwo);
		BREG : result = inTwo;
		SUBU: result = inOne - $unsigned (inTwo);
		ADDU: result = inOne + $unsigned (inTwo);
		AND : result = inOne & inTwo;
		SLRA : result = (inOne << 4) + $unsigned (inTwo);
		SEQ : result = (inOne == inTwo) ? 8'b00000001 : 8'b0;
		MOD : result = inOne % inTwo;
		ADDI: result = inOne+inTwo;
		BNE : begin
			  result = (inOne != 0) ? inTwo : 8'b0;
			  branchCompPass = (inOne != 0) ? 1'b1 : 1'b0;
			  end
		BEZ : begin
			  result = (inOne == 0) ? inTwo : 8'b0;
			  branchCompPass = (inOne == 0) ? 1'b1 : 1'b0;
			  end
		MV  : result = inTwo;
		default: result = 0;
	endcase
  end

endmodule
