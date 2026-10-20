module syn_ram(
	input clk,reset, w_e, r_e,
	input [3:0] w_add , r_add,
	input [7:0] data_in,
	output reg [7:0] data_out
);

	reg [7:0] mem [0:15];
	integer i;
	always @(posedge clk or posedge reset) begin 
		if(reset) begin 
			for(i = 0 ; i < 16 ; i = i + 1) begin 
				mem[i] <= 8'b0;
				data_out <= 8'b0;
			end 
		end 
		else begin
			if(w_e) begin 
				mem[w_add] <= data_in;
			end 
			if(r_e) begin 
				data_out <= mem[r_add];
			end
		end 
	end 
endmodule 