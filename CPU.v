// Wire all the modules

module MIPS_Ctrl_PC_IM_REG_ALU_DM( 
	//Inputs
	clock, PCreset,
	//Outputs
	IMinstruction, Address, RV, SWdata 
);

//IO's
input clock;
input PCreset;
output[31:0]IMinstruction, Address, RV, SWdata;

//Interconnections
wire[31:0]Alu_A, Reg_data2, Mux2OP, Alu_O, DMRead_D, Mux3OP, Mux0OP, PCOutput; wire[4:0] LineRs, LineRt, LineRd, Mux1OP;
wire[31:0]SeOP;
wire RegisterDest, MemorytoReg, AluSource, Ctrlbranch, Writememory, Readmemory, Writeregister;
wire[1:0]OPvalue;
wire [5:0]OPinput, CInput;
wire [31:0]AltaluIP;
wire[3:0]alucontrol;
wire AluZero;

MIPSMUX0 mux0_0(
	.PCplus1(PCOutput), 
	.offset( SeOP ), 
	.Mux0Out( Mux0OP), 
	.AluZeroOP(AluZero), 
	.branch(Ctrlbranch)
);

MIPSMainctrl Mainctrl_0( 
	.opfield(OPinput), 
	.beq(Ctrlbranch), 
	.Aluop(OPvalue), 
	.memread(Readmemory), 
	.memwrite(Writememory), 
	.memtoreg(MemorytoReg), 
	.regdst(RegisterDest), 
	.regwrite(Writeregister), 
	.alusrc(AluSource)
);

MIPSALUctrl ALUctrl_0( 
	.FuncCode(CInput), 
	.ALUOp(OPvalue), 
	.ALUCtl(alucontrol),
);

MIPSIM im_0(
	.clock(clock), 
	.IMinstruction(IMinstruction), 
	.IMaddress(PCOutput), 
	.Opcode(OPinput),
	.Rs( LineRs), 
	.Rt(LineRt), 
	.Rd(LineRd), 
	.SignextShiftleft(SeOP), 
	.Funct(CInput), 
	.Se(AltaluIP)
);

MIPSPC pc_0( 
	.Address(Address), 
	.PCin(Mux0OP),
	.PCout(PCOutput), 
	.clock(clock)
);

MIPSMUX1 mux1_0(
	// inputs 
	.Mux1Sel(RegisterDest ), 
	.Mux1In0( LineRt ), 
	.Mux1In1( LineRd ),
	// outputs
	.Mux1Out( Mux1OP) 
);

MIPSREG reg_0(
	//inputs
	.clock( clock ), 
	.ReadReg1( LineRs ), 
	.ReadReg2( LineRt ), 
	.WriteReg( Mux1OP), 
	.WriteData( Mux3OP ), 
	.RegWrite (Writeregister),
	// outputs
	.Data1( Alu_A ), .Data2(Reg_data2) 
);

MIPSMUX2 mux2_0(
	// inputs 
	.Mux2Sel(AluSource ), 
	.Mux2In0( Reg_data2 ), 
	.Mux2In1( AltaluIP ),
	// outputs
	.Mux2Out( Mux2OP ) 
);

MIPSALU alu_0( 
	//inputs 
	.ALUctrl(alucontrol), 
	.A( Alu_A ),
	.B( Mux2OP ),
	// outputs 
	.ALUOut( Alu_O ), 
	.Zero( AluZero )
);

MIPSDM dm_0(
	//inputs .DMaddress(Alu_O), 
	.Write_data(Reg_data2), 
	.clock(clock), 
	.Read_data(DMRead_D), 
	.Mem_write(Writememory), 
	.Mem_read(Readmemory), 
	.SWdata(SWdata)
);

MIPSMUX3 mux3_0(
	// inputs 
	.Mux3Sel(MemorytoReg ), 
	.Mux3In0( Alu_O ), 
	.Mux3In1( DMRead_D ), 
	// outputs
	.Mux3Out( Mux3OP), .RV(RV)
);

endmodule




