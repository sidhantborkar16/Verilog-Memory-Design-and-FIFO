module SISO(input Din, reset,
	input clk,
	output reg Qout
);

	reg Q0,Q1,Q2;
	always @(posedge clk) begin 
		if(reset) begin 
			{Q0 , Q1 , Q2 , Qout} <= 0;
		end 
		else begin
			Q0 <= Din;
			Q1 <= Q0;
			Q2 <= Q1;
			Qout <= Q2;
		end 
	end 
endmodule
