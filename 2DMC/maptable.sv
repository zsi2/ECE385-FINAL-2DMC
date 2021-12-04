module maptable
(
	input logic [3:0] x,y, // x:0-15,y:0-11
	
	input logic Clk, //write enable
	
	input logic [3:0] id_in, //block id
	
	output logic [3:0] id

);


	logic [3:0] map [15:0][11:0] ;
	
	always_ff @ (posedge Clk)
	
	begin
	
			map[x][y]<= id_in;

	end
	
	assign id = map[x][y];
	
endmodule


module maptable_mux
(
	input logic we,
	input logic [3:0] id_in1,id_in2,
	output logic [3:0] id_in
	
)

	always_comb
	begin
		if (we==1'b0)
			id_in=id_in1;
		else
			id_in=id_in2;
	end
	
endmodule