module accelerated_screen_buffer

(

	input logic Clk,
	
	input logic [63:0] row_0,row_1,row_2,row_3,row_4,row_5,row_6,row_7,row_8,row_9,row_10,row_11,
	
	input logic [3:0] x,y,
	
	output logic [3:0] id
	
	
);


	 logic [63:0] rows [0:11];
	 
	 //refresh
	 
	 always_ff @(posedge Clk)
	 
	 begin
	 
		rows[ 0 ]<=row_0 ;
		rows[ 1 ]<=row_1 ;
		rows[ 2 ]<=row_2 ;
		rows[ 3 ]<=row_3 ;
		rows[ 4 ]<=row_4 ;
		rows[ 5 ]<=row_5 ;
		rows[ 6 ]<=row_6 ;
		rows[ 7 ]<=row_7 ;
		rows[ 8 ]<=row_8 ;
		rows[ 9 ]<=row_9 ;
		rows[ 10 ]<=row_10 ;
		rows[ 11 ]<=row_11 ;
		
	 
	 
	 end
	 
	 assign id= rows[y][4*(16-x)-1-:4];

	 

endmodule

	
	
	
	