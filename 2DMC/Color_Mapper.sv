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
module  color_mapper ( 
                       input Clk,                                      //   or background (computed in ball.sv)
							  input        [6:0] corner_x,corner_y,
							  input        [6:0] steve_relx,steve_rely,
                       input        [9:0] DrawX, DrawY, MouseX, MouseY,      // Current pixel coordinates
                       output logic [7:0] VGA_R, VGA_G, VGA_B, // VGA RGB output
							  output logic left_en,right_en,top_en,down_en,
							  input logic is_steve,
							  input logic [3:0] x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,y1,y2,y3,y4,y5,y6,y7,y8,y9,y10,y11,y12,x11,x12
                     );
    
    logic [7:0] Red, Green, Blue;
    
	 int DistX,DistY,size;
	 assign DistX=DrawX-MouseX;
	 assign DistY=DrawY-MouseY;
	 assign size=2;
    // Output colors to VGA
    assign VGA_R = Red;
    assign VGA_G = Green;
    assign VGA_B = Blue;
    
    // Calculate relative pixels
	 logic [23:0] rgb,steve_rgb;
	 logic [3:0] x,y;
	 logic [5:0] relx,rely;
	 
	 rxycalc r (.*);
	 
	 logic [3:0] id;
	 logic [63:0] row_0,row_1,row_2,row_3,row_4,row_5,row_6,row_7,row_8,row_9,row_10,row_11;
	 
	 false_map f0(.*);
	 
	 accelerated_screen_buffer sb (.*);
	 
	 artrom a0 (.id(id),.relx(relx),.rely(rely),.rgb(rgb),.steve_relx(steve_relx),.steve_rely(steve_rely),.steve_rgb(steve_rgb));
	 
    always_comb
    begin
        if (DrawX<640&DrawY<480) 
        begin
			if((DistX*DistX)+(DistY*DistY)<=(size*size))
			begin
				Red=8'hff;
				Green=8'h00;
				Blue=8'h00;
			end
			else
			begin
					if(is_steve)
					begin
						if(steve_rgb==24'hffffff)
						begin
							Red = 8'hd2; 
							Green = 8'he6;
							Blue = 8'hff;
						end
						else
						begin
							Red = steve_rgb[23:16];
							Green =steve_rgb[15:8];
							Blue = steve_rgb[7:0];
						end
					end
					
					else
					begin
						if(id!=4'b0)
						begin
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
