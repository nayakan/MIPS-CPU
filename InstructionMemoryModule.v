module MIPSIM(clock, IMaddress, IMinstruction, Rs, Rt, Rd, Se,SignextShiftleft, Opcode, Funct);
	input [31:0]IMaddress;
	input clock;
	output reg[31:0]IMinstruction, SignextShiftleft, Se; 
	output reg[4:0] Rs, Rt, Rd;
	output reg[5:0]Opcode, Funct; 
	reg[31:0]mem[255:0];
	initial begin 
		$readmemh("Code.txt",mem); 
	end

	always@(posedge clock)
	begin
		IMinstruction = mem[IMaddress[31:0]]; Opcode = IMinstruction[31:26];
		Rs = IMinstruction[25:21];
		Rt = IMinstruction[20:16];
		Rd = IMinstruction[15:11];
		Se = {{15{IMinstruction[15]}},IMinstruction[15:0]}; //Sign Extend
		//Sign extend & shift left 2 Funct = IMinstruction[5:0];
		SignextShiftleft = {{16{IMinstruction[15]}},IMinstruction[15:0]}<<2; 
		Funct = IMinstruction[5:0];
	end

end endmodule