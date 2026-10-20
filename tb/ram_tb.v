module ram_tb();
	reg we;
	reg enable;
	reg [3:0]add;
	wire [7:0]data;
	
	reg [7:0] DATA;
	
	integer i ,j;
	ram dut(
		.we(we),
		.enable(enable),
		.add(add),
		.data(data)
	);
	
	assign data = (we && enable)? DATA : 8'bz;
	
	task EN(input e);
		begin 
			enable = e;
		end 
	endtask 
	
	task WE(input w);
		begin 
			we = w;
		end 
	endtask 
	
	task inputs(input [3:0]ADD , [7:0] Data);
		begin 
			add = ADD;
			DATA = Data;
		end 
	endtask 
	
	task delay();
		begin
			#10;
		end
	endtask 
	
	initial begin 
		EN(1'b1);
		WE(1'b1);
		for(i = 0 ; i <16 ; i =i+1) begin 
			inputs(i,i);
			delay();
		end 
		WE(1'b0);
		for(j=0 ; j <16 ; j =j +1) begin 
			inputs(j ,j);
			delay();
		end 
	end 
endmodule 