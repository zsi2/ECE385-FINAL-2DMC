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
                       input Clk, VGA_VS,    Reset_h,                                 //   or background (computed in ball.sv)
							  input logic [3:0] state,
							  input        [9:0] corner_x,corner_y,
							  input        [6:0] steve_relx,steve_rely,
                       input        [9:0] DrawX, DrawY, MouseX, MouseY,      // Current pixel coordinates
                       output logic [7:0] VGA_R, VGA_G, VGA_B, // VGA RGB output
							  output logic left_en,right_en,top_en,down_en,
							  input logic is_steve,
							  input logic [3:0] x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,y1,y2,y3,y4,y5,y6,y7,y8,y9,y10,y11,y12,x11,x12,
							  input logic [1:0] operation,
							  input logic [3:0] push_id,
							  input logic [9:0] changex,changey,
							  input logic [3:0] mouse_relx,mouse_rely,
							  input logic [19:0] hearts,
							  input logic [23:0] back_rgb,
							  output logic [4:0] hand

							  
                     );
    
    logic [7:0] Red, Green, Blue;
    logic [9:0] mousex,mousey;
	 always_ff @(posedge VGA_VS)
	 begin
		mousex<=MouseX;
		mousey<=MouseY;
	 end
	 int DistX,DistY,size;
	 assign DistX=DrawX-mousex;
	 assign DistY=DrawY-mousey;
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
	 
	 //ohchip mem
	 
	 logic mem_clk;
	 
	 memclk clkm (.inclk0(Clk),.c0(mem_clk));
	 
	 
	 logic [3:0] id,pointing_id;
	 logic [63:0] row_0,row_1,row_2,row_3,row_4,row_5,row_6,row_7,row_8,row_9,row_10,row_11;
	 
	 false_map f0(.*,.Clk(Clk));
	 
	 accelerated_screen_buffer sb (.*);
	 
	 artrom a0 (.id(id),.relx(relx),.rely(rely),.rgb(rgb),.steve_relx(steve_relx),.steve_rely(steve_rely),.steve_rgb(steve_rgb),.Clk(mem_clk));
	 
	 parameter start_menu=4'd0;
	 parameter main_game=4'd1;
	 parameter backpack=4'd2;
	 parameter craft=4'd3;
	 parameter furnace=4'd4;
	 parameter pause=4'd5;
	 
	 logic [23:0] main_rgb;
	 
	 main_menu menu0 (.*);
	 
	 hearts heart(.*);
	 
	 logic is_heart;
	 logic[23:0] heart_rgb;
	 
	 //bp
	 
	 logic [23:0] bp_rgb,handon_rgb;
	 logic [1:0] op;
	 logic is_bp,is_handon;
	 
	 backpack bp(.*);
	 
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
			case(state)
			start_menu:
			begin
				Red=main_rgb[23:16];
				Green=main_rgb[15:8];
				Blue=main_rgb[7:0];
			end
			main_game:
			begin
					if(is_steve)
					begin
						if(steve_rgb==24'h00ffff)
						begin
							Red=back_rgb[23:16];
							Green=back_rgb[15:8];
							Blue=back_rgb[7:0];
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
						if(is_heart)
						begin
							Red =heart_rgb[23:16];
							Green=heart_rgb[15:8];
							Blue =heart_rgb[7:0];	
						end
						else if (is_handon)
						begin
							Red =handon_rgb[23:16];
							Green=handon_rgb[15:8];
							Blue =handon_rgb[7:0];						
						
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
							Red=back_rgb[23:16];
							Green=back_rgb[15:8];
							Blue=back_rgb[7:0];
							end
						end
					end
					

					
					
			end
			
			backpack:
			begin
				/*			Red=back_rgb[23:16];
							Green=back_rgb[15:8];
							Blue=back_rgb[7:0];*/
				if((DrawX>79)&&(DrawX<559))
				begin
					if(is_bp)
					begin
//						Red=back_rgb[23:16];
//							Green=back_rgb[15:8];
//							Blue=back_rgb[7:0];
						Red=bp_rgb[23:16];
						Green=bp_rgb[15:8];
						Blue=bp_rgb[7:0];
					end
					else if (is_handon)
					begin
						Red =handon_rgb[23:16];
						Green=handon_rgb[15:8];
						Blue =handon_rgb[7:0];						
					
					end
					else
					begin
						Red=8'hc6;
						Green=8'hc6;
						Blue=8'hc6;
					end
				
				end
				else
				begin
							Red=back_rgb[23:16];
							Green=back_rgb[15:8];
							Blue=back_rgb[7:0];				
				end
				
			end
			
			default:
			begin
							Red=back_rgb[23:16];
							Green=back_rgb[15:8];
							Blue=back_rgb[7:0];
			end

		 endcase
	 end
	 end
	 else
	 begin
							Red=back_rgb[23:16];
							Green=back_rgb[15:8];
							Blue=back_rgb[7:0];
	 end
    end 
    
endmodule
