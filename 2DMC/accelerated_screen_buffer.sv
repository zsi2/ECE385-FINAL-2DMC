module accelerated_screen_buffer

(

	input logic Clk,
	
	input logic [63:0] row_0,row_1,row_2,row_3,row_4,row_5,row_6,row_7,row_8,row_9,row_10,row_11,
	
	input logic [3:0] x,y,
	
	input logic [3:0] x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,y1,y2,y3,y4,y5,y6,y7,y8,y9,y10,y11,y12,x11,x12,
	
	output logic [3:0] id,
	
	output logic left_en,right_en,top_en,down_en
	
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
	 
	 logic [3:0] id1,id2,id3,id4,id5,id6,id7,id8,id9,id10,id11,id12;
	
	 always_comb
	 begin
	 
id1=rows[y1][4*(16-x1)-1-:4];
id2=rows[y2][4*(16-x2)-1-:4];
id3=rows[y3][4*(16-x3)-1-:4];
id4=rows[y4][4*(16-x4)-1-:4];
id5=rows[y5][4*(16-x5)-1-:4];
id6=rows[y6][4*(16-x6)-1-:4];
id7=rows[y7][4*(16-x7)-1-:4];
id8=rows[y8][4*(16-x8)-1-:4];
id9=rows[y9][4*(16-x9)-1-:4];
id10=rows[y10][4*(16-x10)-1-:4];
id11=rows[y11][4*(16-x11)-1-:4];
id12=rows[y12][4*(16-x12)-1-:4];
	end
	
	assign left_en= ~(|(id1|id2|id3));
	assign right_en= ~(|(id4|id5|id6));
	assign top_en= ~(|(id7|id8|id9));
	assign down_en= ~(|(id10|id11|id12));
	 
	 

endmodule

	
	
	
	