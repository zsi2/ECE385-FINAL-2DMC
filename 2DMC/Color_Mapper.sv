//-------------------------------------------------------------------------
//    Color_Mapper.sv                                                    --
//    Stephen Kempf                                                      --
//    3-1-06                                                             --
//                                                                       --
//    Modified by David Kesler  07-16-2008                               --
//    Translated by Joe Meng    07-07-2013                               --
//    Modified by Po-Han Huang  10-06-2017                               --
//                                                                       --
//    Fall 2017 Distribution                                             --
//                                                                       --
//    For use with ECE 385 Lab 8                                         --
//    University of Illinois ECE Department                              --
//-------------------------------------------------------------------------

// color_mapper: Decide which color to be output to VGA for each pixel.
module  color_mapper ( //input              is_ball,            // Whether current pixel belongs to ball 
                       input Clk,                                      //   or background (computed in ball.sv)
							  input        [6:0] corner_x,corner_y,
                       input        [9:0] DrawX, DrawY,       // Current pixel coordinates
                       output logic [7:0] VGA_R, VGA_G, VGA_B // VGA RGB output
                     );
    
    logic [7:0] Red, Green, Blue;
    
    // Output colors to VGA
    assign VGA_R = Red;
    assign VGA_G = Green;
    assign VGA_B = Blue;
    
    // Calculate relative pixels
	 logic [23:0] rgb;
	 logic [3:0] x,y;
	 logic [5:0] relx,rely;
	 
	 rxycalc r (.*);
	 
	 logic [3:0] id;
	 logic [63:0] row_0,row_1,row_2,row_3,row_4,row_5,row_6,row_7,row_8,row_9,row_10,row_11;
	 
	 false_map f0(.*);
	 
	 accelerated_screen_buffer sb (.*);
	 
	 
	 artrom a0 (.id(id),.relx(relx),.rely(rely),.rgb(rgb));
	 
    always_comb
    begin
        if (DrawX<640&DrawY<480) 
        begin
				if(id!=4'b0)
				begin
            // White ball
            Red = rgb[23:16];
            Green =rgb[15:8];
            Blue = rgb[7:0];
				end
				else
				begin
				Red = 8'hd2; 
            Green = 8'he6;
            Blue = 8'hff;
				
				end
        end
        else 
        begin
            // Background with nice color gradient
            Red = 8'hd2; 
            Green = 8'he6;
            Blue = 8'hff;
        end
    end 
    
endmodule
