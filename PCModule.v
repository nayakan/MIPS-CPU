module MIPSPC(PCreset, clock, PCin, PCout, Address); 
	input clock, PCreset;
	input [31:0] PCin;
	output reg[31:0]Address; //new line
	output reg [31:0] PCout;
	always @(posedge clock) 
	begin 
		if (PCreset) 
			PCout <= 0;
		else 
			PCout <= PCin+1 ;
			Address <= PCin+1; 
	end
endmodule