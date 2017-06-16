binaryMappings = {
'add' : '00000',
'sub' : '00001',
'sll' : '00010',
'srl' : '00011',
'lw' : '00100',
'sw' : '00101',
'ht' : '001100000',
'slt' : '00111',
'subu' : '01000',
'addu' : '01001',
'and' : '01010',
'sez' : '0101100',
'seq' : '01100',
'sreg' : '01101',
'lreg' : '01110',
'mod' : '01111',
'addi' : '100',
'bez' : '1010000',
'bne' : '1100000',
'mv' : '111',
'r0' : '00',
'r1' : '01',
'r2' : '10',
'r3' : '11',
'r4' : '00',
'r5' : '01',
'r6' : '10',
'r7' : '11',
'0' : '0000',
'1' : '0001',
'2' : '0010',
'3' : '0011',
'4' : '0100',
'5' : '0101',
'6' : '0110',
'7' : '0111',
'-8' : '1000',
'-7' : '1001',
'-6' : '1010',
'-5' : '1011',
'-4' : '1100',
'-3' : '1101',
'-2' : '1110',
'-1' : '1111'
}


commentChar = "#"
jmpChar = ":"
inputFile = open("stringmatch.txt", "r")
outputFile = open("bin-stringmatch.txt", "w")
for line in inputFile:
    formatted = line.replace(",", "").replace("[", "").replace("]", "").replace("$","").lower().split()
    if len(formatted) == 0 or commentChar in formatted[0] or jmpChar in formatted[0]:
        continue
    for word in formatted:
        if jmpChar in word or commentChar in word:
            break
        #if any(char in commentChar for char in word):
            #break
        #if any(char in jmpChar for char in word):
            #outputFile.write(word)
            #break
        if word in binaryMappings.keys():
            outputFile.write(binaryMappings[word])
        else:
            print("Word is not a key: " + word)
            break
    outputFile.write("    //{}".format(line))


inputFile.close();
outputFile.close();
