module MIPSALU (ALUctrl, A, B, ALUOut,Zero); input[3:0] ALUctrl;
	input[31:0] A,B;
	output reg[31:0] ALUOut; 
	output Zero;

	assign Zero =(ALUOut==0);
	always @( ALUctrl, A, B) //re­evaluate if these change
		case( ALUctrl)
			0: ALUOut <= A&B;
			1: ALUOut <= A|B;
			2: ALUOut <= A+B;
			6: ALUOut <= A­B;
			7: ALUOut <= (A<B)?1:0;
			12:ALUOut <= ~(A|B);
			default: ALUOut <=0; //default to zero, should not happen
		endcase 
endmodule