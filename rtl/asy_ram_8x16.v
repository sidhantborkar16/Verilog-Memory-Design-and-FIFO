module asy_ram_8x16( input clk_w, clk_r , reset,w_e , r_e,
	input [2:0]w_add ,r_add,
	input [15:0]data_in,
	output reg [15:0]data_out
);

	reg [15:0] mem [7:0];
	integer i;
	
	always @(posedge clk_w or posedge reset) begin 
		if(reset) begin 
			for(i=0 ; i < 8 ; i = i+1) begin 
				mem[i] <= 0;
			end 
		data_out <= 0;
		end 
		else begin 
			if(w_e) begin 
				mem[w_add] <= data_in;
			end
		end 
	end 
	 always @(posedge clk_r or posedge reset) begin 
		if(reset) begin 
			for(i=0 ; i < 8 ; i = i+1) begin 
				mem[i] <= 0;
			end 
		data_out <= 0;
		end 
		else begin 
			if(r_e) begin 
				data_out <= mem[r_add];
			end 
		end 
	end 
endmodule 