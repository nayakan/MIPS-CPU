// Multiplexor for calculating branch address
module MIPSMUX0(offset, PCplus1,AluZeroOP,branch,Mux0Out); 
	input[31:0]offset,PCplus1;
	input AluZeroOP, branch;
	wire Mux0Sel;
	output reg[31:0]Mux0Out;
	assign Mux0Sel = branch & AluZeroOP; 
	always@(Mux0Sel, offset, PCplus1) 
	begin
		case(Mux0Sel)
			0:Mux0Out <= PCplus1; 
			1:Mux0Out = offset + PCplus1;
		endcase 
	end 
endmodule

// Multiplexor to select destination register in Register Module
module MIPSMUX1(Mux1In0,Mux1In1,Mux1Sel,Mux1Out); 
	input[4:0]Mux1In0,Mux1In1;
	input Mux1Sel;
	output reg[4:0]Mux1Out;
	always@(Mux1Sel, Mux1In1, Mux1In0) 
	begin
		case(Mux1Sel)
			0:Mux1Out <= Mux1In0;
			1:Mux1Out <= Mux1In1; endcase
	end 
endmodule

// Multiplexor to select input to ALU input B
module MIPSMUX2(Mux2In0,Mux2In1,Mux2Sel,Mux2Out); 
	input[31:0]Mux2In0,Mux2In1;
	input Mux2Sel;
	output reg[31:0]Mux2Out;
	always@(Mux2Sel, Mux2In1, Mux2In0) 
	begin
		case(Mux2Sel)
			0:Mux2Out <= Mux2In0;
			1:Mux2Out <= Mux2In1; endcase
	end 
endmodule

// Multiplexor from Data memory to Register module write data line
module MIPSMUX3(Mux3In0,Mux3In1,Mux3Sel,Mux3Out, RV); 
	input[31:0]Mux3In0,Mux3In1;
	input Mux3Sel;
	output reg[31:0]Mux3Out, RV;
	always@(Mux3Sel, Mux3In1, Mux3In0) 
	begin
		case(Mux3Sel)
			0:begin Mux3Out <= Mux3In0;
					RV <= Mux3In0; end
			1:begin Mux3Out <= Mux3In1;
					RV <= Mux3In1; end
		endcase 
	end 
endmodule
