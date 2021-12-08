// PS/2 keyboard driver

// Implemented by Zhenzuo Si

module keyboard

(

	input logic Clk,PS2_CLK,PS2_DAT,Reset_h, //RESET, CLK,DAT
	
	
	output logic [7:0] keycode,
	
	output logic [1:0] state
	
);

	logic ps2_clk_negedge; // Detect the negative edge of PS/2 clock.
	
	logic [3:0] ps2_clk_buffer; //Buffer for detecting edge.
	
	always_ff @(posedge Clk)
	begin
		
		if(Reset_h)
			ps2_clk_buffer<=4'b0;
		else
			ps2_clk_buffer<={ps2_clk_buffer[2:0],PS2_CLK};
		
	end
	
	assign ps2_clk_negedge= (!ps2_clk_buffer[0])&(!ps2_clk_buffer[1])&ps2_clk_buffer[2]&ps2_clk_buffer[3];

	//counting bits
	
	logic [3:0] bit_counter; //which bit we are sampling
	
	always_ff @(posedge Clk)
	begin
		
		if(Reset_h)
			bit_counter<=4'b0;
		else if (bit_counter==4'd11) //11 is finish
			bit_counter<=4'b0;
		else if (ps2_clk_negedge)
			bit_counter<=bit_counter+4'b0001;
	
	end
	
	//receive mail
	
	//shift negedge signal for a clock.
	
	logic shifted_ps2_clk_negedge;
	
	always_ff @(posedge Clk)
	begin
		shifted_ps2_clk_negedge<=ps2_clk_negedge;
	end
	
	logic [7:0] Data;
	
	always_ff @(posedge Clk)
	begin
	
		if(Reset_h)
			Data<=7'b0;
		else if (shifted_ps2_clk_negedge)
		begin
			case(bit_counter)
				
				4'b0010:
					Data[0]<=PS2_DAT;
				4'b0011:
					Data[1]<=PS2_DAT;
				4'b0100:
					Data[2]<=PS2_DAT;
				4'b0101:
					Data[3]<=PS2_DAT;
				4'b0110:
					Data[4]<=PS2_DAT;
				4'b0111:
					Data[5]<=PS2_DAT;
				4'b1000:
					Data[6]<=PS2_DAT;
				4'b1001:
					Data[7]<=PS2_DAT;		
				default:
					Data<=Data;
			endcase
		end
		else
			Data<=Data;
	end
	
	//decode keys
	
	//if some keys released
	
	logic [7:0] detector; // interrupt detector
	
	 //0 wait, 1 released 1, 2 released 2 
	always_ff @(posedge Clk)
	begin
		if(bit_counter==4'd11)
		begin
			//when a pack fetched
			if(state==2'b0)
			begin
				if(Data!=8'b0)
					state=2'b01;
				else
					state=2'b0;
			end
			if(state==2'b01)
				detector<=Data;
			if(Data==8'hF0&state==2'b01)
				state=2'b10;
			if(Data==detector&state==2'b10)
				state=2'b0;
			
		end
	end
			
	always_comb
	begin
		if(state==2'b01)
			keycode=Data;
		else 
			keycode=8'b0;
	end



endmodule

