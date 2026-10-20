module FIFO_tb();
	reg clk ,reset , w_e , r_e;
	reg [7:0] data_in;
	wire full ,empty;
	wire [7:0]data_out;
	
	integer i;
	
	FIFO dut(
		.clk(clk),
		.reset(reset),
		.w_e(w_e),
		.r_e(r_e),
		.data_in(data_in),
		.data_out(data_out),
		.full(full),
		.empty(empty)
	);
	
	initial begin 
		clk = 1'b0;
		forever begin 
			#5 clk = ~clk;
		end 
	end 
	
	task RESET();
		begin 
			@(negedge clk)
			reset = 1'b0;
			@(negedge clk)
			reset = 1'b1;
		end 
	endtask 
	
	task WE(input w_enable);
		begin 
			w_e = w_enable;
		end 
	endtask 
	
	task RE(input r_enable);
		begin 
			r_e = r_enable;
		end 
	endtask
	
	task write(input [7:0]DATA_IN);
		begin 
			@(negedge clk)
			data_in = DATA_IN;
		end 
	endtask 
	
	initial begin 
		RESET();
		WE(1'b1);
		RE(1'b0);
		for(i = 0 ; i < 16 ; i = i+1) begin 
			write($random);
		end 
		
		repeat(2)
		@(negedge clk);
		
		write($random);
		
		@(negedge clk);
		WE(1'b0);
		RE(1'b1);
		
		
		
		#1000;
		$finish;
	end 
endmodule 