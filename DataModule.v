module MIPSDM(Write_data,Read_data,Mem_write, Mem_read,DMaddress,clock, SWdata); 
	input[31:0]DMaddress,Write_data;
	input Mem_write,Mem_read,clock;
	output[31:0]Read_data;
	reg[31:0]Read_data; 
	reg[31:0]MIPSDM[511:0]; 
	output reg[31:0] SWdata;
	initial begin MIPSDM[5] <= 7; 
end

always @( negedge clock)
begin
	if(Mem_read && !Mem_write) Read_data<=MIPSDM[DMaddress]; end
always @(posedge clock)
begin
	if(Mem_write && !Mem_read ) MIPSDM[DMaddress]<=Write_data; SWdata <= MIPSDM[DMaddress]; end
endmodule