//
// Create Date:    18:37:58 02/16/2012
// Design Name:
// Module Name:    TopLevel
// Project Name:
// Description:
//
// Dependencies:
//
// Revision: 	   2017.02.25
// Revision 0.01 - File Created
// Additional Comments:
module TopLevel(
  input     start,
  input     CLK,
  output    halt    );

	//program counter values
    wire[7:0] PCBranchAddr;
	wire jumpCheck;

	// control values
  	wire[8:0] Instruction;		//taken from program_counter module
  	wire[4:0] ALU_OP;     		//set in Control bits from Instruction
  	wire[3:0] inA;		  		//the bits coming out of control representing regA
  	wire[3:0] inB;		  		//the bits coming out of control representing regB/Immediate
  	wire R_Type,          		//flag if R type (except for our weird branch r types)
	REG_WRITE,            		//flag for write to register
	BRANCH,               		//flag for if a branch might be taken
	MEM_WRITE,            		//flag for write to dataRam
	MEM_READ,             		//flag for read from dataRam
	MEM_TO_REG,           		//flag if data from mem needs to go to reg
	HALT;                 		//done flag
	wire[3:0] REG_DST;    		//destination register to write to

	// register values
	//inputs
	wire[3:0] regA;		  		//aka which register to target
	wire[3:0] regB;       		//aka which register to target
	//as well as REG_WRITE and REG_DST
	//outputs
	wire[7:0] regValueA;  		//value we got from regA
	wire[7:0] regValueB;  		//value we got from regB
	wire[7:0] regWriteValue; 	//what value to write to REG_DST
	wire fourShift;				//used for auto 4 shift if both regs are same during sll or srl


	//ALU values
	wire [7:0] ALUInputA; 		//InputA going into ALU
	logic [7:0] ALUInputB; 		//InputB going into ALU
	//takes ALU_OP as well
	wire [7:0] ALUOutput;     	//output coming from ALU

  	logic[15:0] InstCounter;  	//adds up total instructions executed at bottom

  	// Data mem wires
  	wire [7:0] MemOut;			//Value coming out of memory from location regValueB


	//program counter it also handles Instr_Rom, we may want to split it?
	program_counter if_module (
	.init    (start)        ,   //links start command to our program
	.branch  (BRANCH)       ,   //checks if a branch might happen
	.CLK     (CLK)          ,
	.jump    (jumpCheck)    ,   //says if branch actually needs to occur
	.address (ALUOutput)    ,   //address to branch to set from ALU on a bez/bne from value in reg 8 coded in control
	.Instruction (Instruction)
	);

	//Control module sets the flags for other modules to do things with.
	Control control_module (
		.OPCODE    (Instruction), //the 9 bit instruction
		.ALU_OP    (ALU_OP)     , //the first 5 bit opcode to be sent to ALU
    .ALU_SRC_A (inA)        , //
		.ALU_SRC_B (inB)        ,
		.R_Type	   (R_Type)     ,
		.REG_WRITE (REG_WRITE)  ,
		.BRANCH    (BRANCH)     ,
		.MEM_WRITE (MEM_WRITE)  ,
		.MEM_READ  (MEM_READ)   ,
		.REG_DST   (REG_DST)    ,
		.MEM_TO_REG (MEM_TO_REG),
		.HALT (halt)
	);


	//assign regA and regB which registers to get vals from
	assign regA = inA;		//regA will always be assigned to the output from Control
	assign regB = R_Type ? inB : 'b1111;  //regB will either be output from Control or a dummy value

	reg_file #(.W(8),.D(4)) reg_file (
		.CLK                       ,
		.RegWrite  (REG_WRITE)     ,
		.srcA      (regA)          ,
		.srcB      (regB)          ,
		.writeReg  (REG_DST)       ,
		.writeValue(regWriteValue) , //either aluoutput or Memout from dataRam
		.ReadA     (regValueA)     ,
		.ReadB	   (regValueB)	   ,
		.FourShift (fourShift)		//when we sll or srl using same register it auto shifts 4, this is the flag for ALU
	);


	assign ALUInputA = regValueA;  //ALUInputA is always registerValueA
	//if R type it gets the value given from the register
	//else it gives the immediate value sent from Control

  always_comb begin
      if(R_Type)
           assign ALUInputB = regValueB;
      else
          begin
          if (ALU_OP == 5'b10000)
              assign ALUInputB = {{4{inB[3]}}, {inB[3:0]}};
          else
              assign ALUInputB = inB[3:0];
          end
  end

	 ALU ALU_Module (
		.OP       (ALU_OP)     ,
		.inOne    (ALUInputA)  ,
		.inTwo    (ALUInputB)  ,
		.result   (ALUOutput)  ,
		.branchCompPass (jumpCheck),
		.fourShift(fourShift)
	);

	//Above modules been updated for final test bench string search

	DataRAM data_mem(
		.AddressValue  (regValueB),
		.MEM_READ     (MEM_READ),
		.MEM_WRITE    (MEM_WRITE),
		.DataIn       (ALUOutput),
		.DataOut      (MemOut),
		.CLK
	);

	assign regWriteValue = (MEM_TO_REG == 1) ?  MemOut : ALUOutput;

	always@(posedge CLK)
	if (start == 1)	begin
	  InstCounter <= 1'b0;
	end
	else if(halt == 0) begin
	  InstCounter <= InstCounter+1;
	end
endmodule
