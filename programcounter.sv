module program_counter #(parameter numInstr=300)
(
  input init,
  input branch,
  input CLK,
  input jump,
  input [7:0] address,
  output logic[8:0] Instruction);

   logic [7:0] PC;
   logic [8:0] Instructions[numInstr];

initial begin
 $readmemb("bin-stringmatch.txt", Instructions);
 end

always @(posedge CLK)
  if(init)
    PC <= 0;
  else if(branch & jump)
    PC <= address;
  else
    PC <= PC + 1;

  always_comb Instruction = Instructions[PC];
endmodule
