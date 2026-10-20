module asy_ram_8x16_tb();
	reg clk_w, clk_r , reset,w_e , r_e;
	reg [2:0]w_add , r_add;
	reg [15:0]data_in;
	wire [15:0]data_out;
	
	asy_ram_8x16 dut(
		.clk_r(clk_r),
		.clk_w(clk_w),
		.reset(reset),
		.w_e(w_e),
		.r_e(r_e),
		.w_add(w_add),
		.r_add(r_add),
		.data_in(data_in),
		.data_out(data_out)
	);
	
	integer i , j;
	
	initial begin 
		clk_r = 1'b0;
		forever begin 
			#5 clk_r = ~clk_r;
		end 
	end 
	
	initial begin 
		clk_w = 1'b0;
		forever begin 
			#10 clk_w = ~clk_w;
		end 
	end
	
	task RESET();
		begin 
			@(negedge clk_r)
			reset = 1'b1;
			@(negedge clk_r)
			reset =1'b0;
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
	
	task write(input [2:0]W_ADD , input[15:0]DATA);
		begin
			@(negedge clk_w)
			w_add = W_ADD;
			data_in = DATA;
		end 
	endtask 
	
	task read(input [2:0]R_ADD);
		begin
			@(negedge clk_r)
			r_add = R_ADD;
		end 
	endtask 
	
	initial begin 
		RESET();
		WE(1'b1);
		RE(1'b0);
		for(i = 0; i < 8 ; i = i+1) begin 
			write(i , {$random} %50);
		end 
		WE(1'b0);
		RE(1'b1);
		for(j = 0; j < 8 ; j = j + 1) begin 
			read(j);
		end 
		#50
		$finish;
	end 
endmodule 
	