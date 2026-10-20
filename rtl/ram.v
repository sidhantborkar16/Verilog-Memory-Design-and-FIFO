//16*8 ram 
module ram(
	input we , enable,
	input[3:0] add,
	inout[7:0]data
);
	reg [7:0] mem [15:0];
	
	always @(*) 
	begin
		if(we && enable) begin 
			mem[add] = data;
		end 
		/*if(!we && enable) begin 
			data = mem[add];
		end */
	end 
	assign data =(!we && enable)? mem[add] : 8'bz;
endmodule 

