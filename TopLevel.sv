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

	//general PC to take from program_counter
    wire[7:0] PCBranchAddr;
	wire jumpCheck;	
			
	// control signals not defined as outputs
  	wire[8:0] Instruction;
  	wire[4:0] ALU_OP;
  	wire[1:0] inA;
  	wire[3:0] inB;
  	wire R_Type,
	REG_WRITE,
	BRANCH,
	MEM_WRITE,
	MEM_READ,
	MEM_TO_REG,
	HALT;
	wire[3:0] REG_DST;
	
	// register values
	//inputs
	wire[3:0] regA;//aka which register to target
	wire[3:0] regB;//aka which register to target
	//as well as REG_WRITE and REG_DST
	//outputs
	wire[7:0] regValueA;//value we got from regA
	wire[7:0] regValueB;//value we got from regB
	
	
	//ALU values
	wire [7:0] ALUInputA;
	wire [7:0] ALUInputB;
	//takes ALU_OP as well
	wire [7:0] ALUOutput;
	
	
  	logic[15:0] InstCounter;//adds up total instructions executed at bottom
	
	//only vars above is guarenteed needed //below is random stuff
	
  	// Data mem wires
  	wire [ 7:0] MemOut;
	 


	//// manage the write register and write data muxes
	//assign write_register = (REG_DST==1)?{1'b0,Instruction[2:0]}:{1'b0,Instruction[5:3]};
	////assign regWriteValue = (MEM_TO_REG==1)?ALUOut:MemOut;
	//assign regWriteValue = ALUOut;
	
	//// manage ALU SRC MUX
	//assign SE_Immediate = {{13{Instruction[2]}}, Instruction[2:0]};
	//assign IntermediateMux = (ALU_SRC_B==2'b01)?SE_Immediate:ReadB;
	//assign ALUInputB = (ALU_SRC_B==2'b10)?0  : IntermediateMux;
	
	//// assign input to memory
	//assign memWriteValue = ReadB;
	
	// Fetch Module (really just PC, we could have incorporated InstRom here as well)
	program_counter if_module (
	.init    (start)        , 
	.branch  (BRANCH)       , 
	.CLK     (CLK)          , 
	.jump    (jumpCheck)    ,
	.address (ALUOutput)    , 
	.halt    (halt)         , 
	.Instruction (Instruction)
	);

	// Control module
	Control control_module (
		.OPCODE    (Instruction), 
		.ALU_OP    (ALU_OP)     , 
        .ALU_SRC_A (inA)        ,
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
	
	assign regA = inA;
	assign regB = R_Type? inB : 'b1111;
	
	reg_file #(.W(8),.D(4)) register_module (
		.CLK                   , 
		.RegWrite  (REG_WRITE) , 
		.srcA      (regA)      ,
		.srcB      (regB)      , 
		.writeReg  (REG_DST)   , 
		.writeValue(ALUOutput) , //value from output sent to be written if REG_WRITE
		.ReadA     (regValueA) , 
		.ReadB	   (regValueB)
	);
	
	
	assign ALUInputA = regValueA;
	//if R type it gets the value given from the register
	//else it gives the immediate value sent from Control
	assign ALUInputB = R_Type? regValueB : inB;
	
	
	 ALU ALU_Module (
		.OP    (ALU_OP)     , 
		.inOne (ALUInputA)  , 
		.inTwo (ALUInputB)  , 
		.res   (ALUOutput)  , 
		.branchCompPass (jumpCheck)
	);

	
	//Above modules been updated for final test bench string search
	
	DataRAM Data_Module(
		.DataAddress  (ReadA), 
		.ReadMem      (MEM_READ), 
		.WriteMem     (MEM_WRITE), 
		.DataIn       (memWriteValue), 
		.DataOut      (MemOut), 
		.CLK 
	);
	

	always@(posedge CLK)
	if (start == 1)	begin
	  InstCounter <= 1'b0;
	end
	else if(halt == 0) begin
	  InstCounter <= InstCounter+1;
	end
endmodule
