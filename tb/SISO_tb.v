module SISO_tb;
	reg Din,reset,clk;
	wire Qout;
	
	SISO dut(
		.Din(Din),
		.reset(reset),
		.clk(clk),
		.Qout(Qout)
	);
	
	initial begin 
		clk = 1'b0;
		forever begin 
			#5 clk = ~clk;
		end 
	end
	
	task inputs(input din);
		begin
			@(negedge clk)
			Din = din;
		end 
	endtask 
	
	task RESET();
		begin 
			@(negedge clk)
			reset = 1'b1;
			@(negedge clk)
			reset = 1'b0;
		end 
	endtask
	
	initial begin
		Din = 1'b0;
        reset = 1'b0;
		RESET();
		inputs(1'b1);
		//inputs(1'b0);
	end 
endmodule 