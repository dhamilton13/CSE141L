module instr_ROM #(parameter A=16, W=9) (
  input		[A-1:0] InstAddress,
  output logic[W-1:0] InstrOut);
  
  logic[W-1:0] inst_rom[2**(A)];
  initial begin
    $readmemb("BinaryCode.txt",inst_rom);
   end

  assign instrOut = inst_rom[InstAddress];

endmodule
