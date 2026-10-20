//16x8 FIFO
module FIFO(
	input clk,reset,w_e,r_e,
	input [7:0]data_in,
	output reg [7:0]data_out,
	output full, empty
);
	reg [7:0] mem [15:0];
	
	integer i;
	
	reg [4:0] wr_ptr  = 4'd0;
	reg [4:0] rd_ptr = 4'd0;
	always @(posedge clk or negedge reset) begin 
		if(!reset) begin 
			wr_ptr <= 4'd0;
			rd_ptr <= 4'd0;
			data_out <= 8'd0;
			for(i = 0 ; i < 16 ; i = i+1) begin 
				mem[i] <= 8'd0;
			end 
		end 
		
		else begin
			if(w_e && full == 0) begin
				mem[wr_ptr[3:0]] <= data_in;
				wr_ptr <= wr_ptr + 1;
			end 
			
			if(r_e && empty == 0) begin 
				data_out <= mem[rd_ptr[3:0]];
				rd_ptr <= rd_ptr + 1;
			end 
		end 
	end 
	
	//assign full = ((wr_ptr + 1)== rd_ptr) ? 1'b1 : 1'b0;
	assign empty = (wr_ptr == rd_ptr) ? 1'b1 : 1'b0;
	assign full = (wr_ptr[4] != rd_ptr[4] && wr_ptr[3:0] == rd_ptr[3:0]) ? 1'b1 : 1'b0;
endmodule 