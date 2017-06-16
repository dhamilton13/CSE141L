//This file defines the parameters used in the alu
package definitions;
    
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
    
endpackage // defintions