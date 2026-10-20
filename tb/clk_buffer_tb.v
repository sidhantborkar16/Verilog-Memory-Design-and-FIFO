module clk_buffer_tb;
	reg clk_in;
	wire clk_out;
	
	clk_buffer dut(
		.clk_in(clk_in),
		.clk_out(clk_out)
	);
	
	time  t1 ,t2,t3 , t4, t5 ,t6;
	
	initial begin 
		clk_in =1'b0;
		forever begin 
			#5 clk_in = ~clk_in;
		end 
	end 
	
	task clk1_phase ;
		begin
			@(posedge clk_in)
			t1 = $time;
			@(posedge clk_in)
			t2 = $time;
		end 
	endtask 
	
	task clk2_phase ;
		begin
			@(posedge clk_out)
			t3 = $time;
			@(posedge clk_out)
			t4 = $time;
		end 
	endtask
	
	initial begin 
		fork 
			clk1_phase;
			clk2_phase;
		join 
		$display("%d" , t1);
		$display("%d" , t2);
		if (t1 == t3) begin 
			$display("Phase match");
		end 
		else 
			$display("phase not match");
		
		t5 = t2 - t1;
		t6 = t4 - t3;
		if (t5 == t6) begin 
			$display("same phase");
		end 
		else 
			$display("freq diff");
	end 
endmodule 
	
	