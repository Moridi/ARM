module TB();

	reg clk = 1'b0, rst = 1'b0;
	
	ARM ARM(.clk(clk), .rst(rst));
	
	initial repeat(10000) #100 clk = ~clk;
	
	initial begin
		#250
		rst = 1'b1;
		#100
		rst = 1'b0;
	end
	
endmodule
