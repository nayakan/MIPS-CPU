module MIPSREG(ReadReg1, ReadReg2, WriteReg, WriteData, RegWrite, Data1, Data2, clock);
	input[4:0]ReadReg1, ReadReg2, WriteReg; //Register numbers to read or write
	input[31:0]WriteData;	//Data to write
	input RegWrite, clock;	// the write control and clock to trigger write 	 
	output[31:0]Data1, Data2;	//the register values read	
	reg[31:0] RF[31:0];	// 32 registers each 32 bit long
	initial begin 
		RF[0]<=5; 
		RF[1]<=4; 
		RF[2]<=10; 
		RF[5]<=5; 
	end

	always begin @(posedge clock) 
		if (RegWrite)RF[WriteReg]<= WriteData; 
	end

	assign Data1 = RF[ReadReg1];
	assign Data2 = RF[ReadReg2];
	
endmodule