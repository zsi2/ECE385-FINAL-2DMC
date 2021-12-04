module  Steve ( input         Clk,                // 50 MHz clock
                             Reset,              // Active-high reset signal
                             frame_clk,          // The clock indicating a new frame (~60Hz)
               //input [9:0]   DrawX, DrawY,       // Current pixel coordinates
					input [7:0]   keycode,
               //output logic  is_ball             // Whether current pixel belongs to ball or background
					output logic [6:0] corner_x,corner_y
              );
    
    parameter [6:0] Steve_x = 6'b001100;  // Center position on the X axis
    parameter [6:0] Steve_y = 6'b100000;  // Center position on the Y axis
	 
	 logic [6:0] x,y,xin,yin; //xy in map

    //////// Do not modify the always_ff blocks. ////////
    // Detect rising edge of frame_clk
    logic frame_clk_delayed, frame_clk_rising_edge;
    always_ff @ (posedge Clk) begin
        frame_clk_delayed <= frame_clk;
        frame_clk_rising_edge <= (frame_clk == 1'b1) && (frame_clk_delayed == 1'b0);
    end
    // Update registers
    always_ff @ (posedge Clk)
    begin
        if (Reset)
        begin
            x <= Steve_x;
            y <= Steve_y;

        end
        else
        begin
				x<=xin;
				y<=yin;
        end
    end
    //////// Do not modify the always_ff blocks. ////////
    
    // You need to modify always_comb block.
    always_comb
    begin
        // By default, keep motion and position unchanged
			xin=x;
			yin=y;
        

        // Update position and motion only at rising edge of frame clock
        if (frame_clk_rising_edge)
        begin
            // Be careful when using comparators with "logic" datatype because compiler treats 
            //   both sides of the operator as UNSIGNED numbers.
            // e.g. Ball_Y_Pos - Ball_Size <= Ball_Y_Min 
            // If Ball_Y_Pos is 0, then Ball_Y_Pos - Ball_Size will not be -4, but rather a large positive number.

				
            // Update the ball's position with its motion

				if (keycode==8'h1a)// up
					begin
						if(y>6)
						yin=y-6'b000001;
					end
				if (keycode==8'h16) //down
				begin
						if(y<94)
						yin=y+6'b000001;
					 end
				if (keycode==8'h04) //left
					 begin
						if(x>8)
						xin=x-6'b000001;
					 end
				if (keycode==8'h07) //right
				begin
						if(x<15)
						xin=x+6'b000001;
				end

        end
        
        /**************************************************************************************
            ATTENTION! Please answer the following quesiton in your lab report! Points will be allocated for the answers!
            Hidden Question #2/2:
               Notice that Ball_Y_Pos is updated using Ball_Y_Motion. 
              Will the new value of Ball_Y_Motion be used when Ball_Y_Pos is updated, or the old? 
              What is the difference between writing
                "Ball_Y_Pos_in = Ball_Y_Pos + Ball_Y_Motion;" and 
                "Ball_Y_Pos_in = Ball_Y_Pos + Ball_Y_Motion_in;"?
              How will this impact behavior of the ball during a bounce, and how might that interact with a response to a keypress?
              Give an answer in your Post-Lab.
        **************************************************************************************/
    end
    
   // Compute whether the pixel corresponds to ball or background
    /* Since the multiplicants are required to be signed, we have to first cast them
       from logic to int (signed by default) before they are multiplied. */
  /*   int DistX, DistY, Size;
    assign DistX = DrawX - Ball_X_Pos;
    assign DistY = DrawY - Ball_Y_Pos;
    assign Size = Ball_Size;
    always_comb begin
        if ( ( DistX*DistX + DistY*DistY) <= (Size*Size) ) 
            is_ball = 1'b1;
        else
            is_ball = 1'b0;

    end*/
	 
	 //assign
	 
	 assign corner_x=x-6'b000111;
	 assign corner_y=y-6'b000101;
    
endmodule
