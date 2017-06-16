// Create Date:    19:25:24 11/16/2006
// Design Name:
// Module Name:    DataRAM
// Project Name:
// Description:
//
// Dependencies:
//
// Revision:  2017.02.25
// Revision 0.01 - File Created
// Additional Comments:
// default width = 8 bits; depth = 256 elements (8-bit address)
module DataRAM (
  input                CLK,			      // writes (stores) are clocked
  input        [7:0] AddressValue,
  input                MEM_WRITE,
                       MEM_READ,
  input        [7:0] DataIn,
  output logic [7:0] DataOut);

  logic [7:0] core [0:255];	      // 2-D array:  W x (2**D)

//  could put internal pre-load here -- handled by test bench
//    initial 
//        $readmemh("dataram_init.list", my_memory);

  always_comb			                  // reads are combinational
    if(MEM_READ) begin
		DataOut = core[AddressValue];
//  	  $display("Memory read M[%d] = %d",DataAddress,DataOut);
    end 
    else 
      DataOut = 8'b0;              		  // automatically sizes string of hi-Z to width W

  always_ff @ (posedge CLK)				  // writes are clocked (sequential)
    if(MEM_WRITE) begin
		core[AddressValue] = DataIn;
//  	$display("Memory write M[%d] = %d",DataAddress,DataIn);
    end

endmodule
