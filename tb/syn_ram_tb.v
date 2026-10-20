module syn_ram_tb;
	reg clk, reset, w_e, r_e;
	reg [3:0] w_add , r_add;
	reg [7:0] data_in;
	wire [7:0] data_out;
	
	//reg [7:0] data;
	
	//assign data_out = (r_e) ? data : 8'bz;  
	
	integer i ,j;
	
	syn_ram dut(
		.clk(clk),
		.reset(reset),
		.w_e(w_e),
		.r_e(r_e),
		.w_add(w_add),
		.r_add(r_add),
		.data_in(data_in),
		.data_out(data_out)
	);
	
	initial begin 
		clk = 1'b0;
		forever begin 
			#5 clk = ~clk;
		end 
	end 
	
	task RESET;
		begin 
			@(negedge clk)
			reset =1'b1;
			@(negedge clk)
			reset = 1'b0;
		end 
	endtask 
	
	task WE(input w_enable);
		begin 
			//@(negedge clk)
			w_e = w_enable;
		end 
	endtask
	
	task RE(input r_enable);
		begin 
			//@(negedge clk)
			r_e = r_enable;
		end 
	endtask
	
	task write(input [3:0]W_add , input [7:0]DATA_IN);
		begin 
			@(negedge clk);
			//fork
			w_add = W_add;
			data_in = DATA_IN;
			//join
		end 
	endtask
	
	task read(input [3:0]R_add);
		begin
			@(negedge clk);
			//fork
			r_add = R_add;
			//data = DATA_OUT;
			//join
		end 
	endtask
	
	initial begin 
		RESET();
		@(negedge clk);
		WE(1'b1);
		RE(1'b0);
		//fork
		for( i = 0 ; i<16; i = i+1) begin
			write(i,{$random} % 50);
		end
		@(negedge clk);
		WE(1'b0);
		RE(1'b1);		
		for( j = 0 ; j<16; j = j+1) begin
			read(j);
		end
		//join
		@(negedge clk);
		WE(1'b1);
		RE(1'b1);
		#50;
		$finish;
	end 
	
endmodule 
	