module time_generator
(

	input logic Clk,

	output logic [31:0] time_in_sec //from 0 to 1200

);

	
	logic [31:0] counter,counter_time;
	
	always_ff @(posedge Clk)
	begin
		if(counter>=32'd50000000)
		begin
			if(counter_time>=32'd1200)
				counter_time<=0;
			else
				counter_time<=counter_time+1;
			counter<=0;
		end
		else
			counter<=counter+1;
			
	end
	
	assign time_in_sec=counter_time;
			
	
	endmodule