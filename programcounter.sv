module program_counter 
(
  input init,
        jump,
        branch,
        CLK,
  input [7:0] address,
  output logic[15:0] PC);

always @(posedge CLK)
  if(init)
    PC <= 0;
  else if(branch & jump)
    PC <= address;
  else
    PC <= PC + 1; 

endmodule