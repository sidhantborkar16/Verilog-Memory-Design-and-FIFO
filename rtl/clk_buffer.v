module clk_buffer(
	input clk_in,
	output clk_out
);

	buf B1(clk_out , clk_in);

endmodule 