module MIPSMainctrl( opfield, beq, Aluop, memread, memwrite, memtoreg, regdst, regwrite, alusrc);
	input [5:0] opfield;
	output reg beq;
	output reg [1:0] Aluop;
	output reg memread, memwrite, memtoreg;
	output reg regdst, regwrite, alusrc;

	always @(*) begin
	/* defaults*/
		Aluop[1:0] <= 2'b10;
		alusrc <= 1'b0;
		beq <= 1'b0;
		memread <= 1'b0;
		memtoreg <= 1'b0;
		memwrite <= 1'b0;
		regdst <= 1'b1;

		case (opfield)
			6'b100011: begin /* lw */
				memread <= 1'b1;
				regdst <= 1'b0; 
				memtoreg <= 1'b1; 
				alusrc <= 1'b1; 
				regwrite <= 1'b1; 
				memwrite <= 1'b0; 
				beq <= 1'b0; 
				Aluop[1] <= 1'b0; 
				Aluop[0] <= 1'b0;
			end

			6'b101011: begin /* sw */
					regdst <= 1'b0;
					memwrite <= 1'b1; 
					alusrc <= 1'b1; 
					regwrite <= 1'b0; 
					memread <= 1'b0; 
					beq <= 1'b0; 
					Aluop[1] <= 1'b0; 
					Aluop[0] <= 1'b0;
			end

			6'b000100: begin /* beq */ 
					Aluop[0] <= 1'b1;
					Aluop[1] <= 1'b0; 
					beq <= 1'b1; 
					regwrite <= 1'b0;
			end

			6'b000000: begin /* R type instruction */ 
					Aluop[0] <= 1'b0;
					Aluop[1] <= 1'b1; 
					regdst <= 1'b1; 
					alusrc <= 1'b0; 
					memtoreg <= 1'b0; 
					regwrite <= 1'b1; 
					memread <= 1'b0; 
					memwrite <= 1'b0; 
					beq <= 1'b0;
			end
		endcase
	end
endmodule

