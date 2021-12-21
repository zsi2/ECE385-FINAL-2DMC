module  Steve ( input         Clk,                // 50 MHz clock
                             Reset,              // Active-high reset signal
                             frame_clk,          // The clock indicating a new frame (~60Hz)
               input [9:0]   DrawX, DrawY,       // Current pixel coordinates
					input [7:0]   keycode,
               output logic  is_steve,            // Whether current pixel belongs to layer steve
					output logic [9:0] corner_x,corner_y,
					output logic [3:0] x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,y1,y2,y3,y4,y5,y6,y7,y8,y9,y10,y11,y12,x11,x12,
					output logic [6:0] steve_relx,steve_rely,
					output logic [9:0] pixelyd,pixelxr,
					output logic [9:0] x,y,
					output logic [19:0] hearts,
					input logic left_en,right_en,top_en,down_en
              );
    
	 //Steve's feet
    parameter [9:0] Steve_x = 9'd10;  // Center position on the X axis
    parameter [9:0] Steve_y = 9'd30;  // Center position on the Y axis
	 parameter [9:0] pixelxl0=10'd279;
	 parameter [9:0] pixelxr0=10'd320;
	 parameter [9:0] pixelyu0=10'd159;
	 parameter [9:0] pixelyd0=10'd240;

	 logic [9:0] xin,yin; //xy in map
	 
	 logic [9:0] pixelxl, pixelyu ; //consider feet
	 
	 logic [9:0] pixelxl_in,pixelxr_in,pixelyu_in,pixelyd_in; //newones
	 


    //////// Do not modify the always_ff blocks. ////////
    // Detect rising edge of frame_clk
    logic frame_clk_delayed, frame_clk_rising_edge;
    always_ff @ (posedge Clk) begin
        frame_clk_delayed <= frame_clk;
        frame_clk_rising_edge <= (frame_clk == 1'b1) && (frame_clk_delayed == 1'b0);
    end
    // Update registers
	 //hearts
	 
	 logic [4:0] hp;
	 
	 always_ff @ (posedge frame_clk)
	 begin
		if(Reset)
			hp<=5'd20;
		else
		begin
			if(keycode==8'h1a)
				hp<=hp-5'd1;
			else
				hp<=hp;
		
		end
	 
	 end
	 
	 always_comb
	 begin
		case(hp)
			5'd20:
				hearts=20'haaaaa;
			5'd19:
				hearts=20'haaaa9;
			5'd18:
				hearts=20'haaaa8;
			5'd17:
				hearts=20'haaaa4;
			5'd16:
				hearts=20'haaaa0;
			5'd15:
				hearts=20'haaa90;
			5'd14:
				hearts=20'haaa80;
			5'd13:
				hearts=20'haaa40;
			5'd12:
				hearts=20'haaa00;
			5'd11:
				hearts=20'haa900;
			5'd10:
				hearts=20'haa800;
			5'd9:
				hearts=20'haa400;
			5'd8:
				hearts=20'haa000;
			5'd7:
				hearts=20'ha9000;
			5'd6:
				hearts=20'ha8000;
			5'd5:
				hearts=20'ha4000;
			5'd4:
				hearts=20'ha0000;
			5'd3:
				hearts=20'h90000;
			5'd2:
				hearts=20'h80000;
			5'd1:
				hearts=20'h40000;
			5'd0:
				hearts=20'h00000;
			default:
				hearts=20'h00000;
			endcase
	 end
	 
    always_ff @ (posedge Clk)
    begin
        if (Reset)
        begin
            x <= Steve_x;
            y <= Steve_y;
				pixelxl<= pixelxl0;
				pixelxr<= pixelxr0;
				pixelyu<= pixelyu0;
				pixelyd<= pixelyd0;

        end
        else
		  begin
				x<=xin;
				y<=yin;
				pixelyu<=pixelyu_in;
				pixelyd<=pixelyd_in;
				pixelxl<=pixelxl_in;
				pixelxr<=pixelxr_in;		
        end
    end
	 
	 //generate checkpoints
	 
	 logic [9:0] checkxl,checkxr,checkyu,checkyd,checkyhead,checkyfoot,checkyheadfoot;
	 logic [9:0] xav,yav; //used to /2
	 assign yav=pixelyu+pixelyd;
	 assign xav=pixelxl+pixelxr;
	 always_comb
	 begin
		checkxl=pixelxl;
		checkxr=pixelxr;
		checkyheadfoot={1'b0,yav[9:1]};
		checkyu=pixelyu+10'd2;
		checkyd=pixelyd-10'd2;
		checkyhead=pixelyu;
		checkyfoot=pixelyd;
	 end
	 
	 //we need to check 10 points:
	 //(checkxl,checkyu),(checkxl,checkyd),(checkxr,checkyu),(checkxr,checkyd),(checkxl,checkyheadfoot),(checkxr,checkyheadfoot),(checkxl,checkyhead),
	 //(checkxr,checkyhead),(checkxl,checkyfoot),(checkxr,checkyfoot).
	 //3 generate left_en, 3 generate right_en, 2 generate up_en and down_en.
	 
	 // generate corresponding id, generate control signals.
	 
	// logic [3:0] x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,y1,y2,y3,y4,y5,y6,y7,y8,y9,y10;
	 
	 rxycalc r1(.DrawX(checkxl),.DrawY(checkyu),.x(x1),.y(y1));
	 rxycalc r2(.DrawX(checkxl),.DrawY(checkyd),.x(x2),.y(y2));
	 rxycalc r3(.DrawX(checkxl),.DrawY(checkyheadfoot),.x(x3),.y(y3)); //1-3 left
	 rxycalc r4(.DrawX(checkxr),.DrawY(checkyu),.x(x4),.y(y4));
	 rxycalc r5(.DrawX(checkxr),.DrawY(checkyd),.x(x5),.y(y5));
	 rxycalc r6(.DrawX(checkxr),.DrawY(checkyheadfoot),.x(x6),.y(y6)); //4-6 right
	 rxycalc r7(.DrawX(checkxl+10'd1),.DrawY(checkyhead),.x(x7),.y(y7));
	 rxycalc r8(.DrawX(checkxr-10'd1),.DrawY(checkyhead),.x(x8),.y(y8));   //7-9 head
	 rxycalc r9(.DrawX({1'b0,xav[8:0]}),.DrawY(checkyhead),.x(x9),.y(y9));
	 rxycalc r10(.DrawX(checkxl+10'd1),.DrawY(checkyfoot),.x(x10),.y(y10)); //10-12 foot
	 rxycalc r11(.DrawX(checkxr-10'd1),.DrawY(checkyfoot),.x(x11),.y(y11)); 
	 rxycalc r12(.DrawX({1'b0,xav[8:0]}),.DrawY(checkyfoot),.x(x12),.y(y12)); 
	 //generate xin,yin
	 logic [2:0] y_counter; //fall
    //////// Do not modify the always_ff blocks. ////////
	 // Motion eq.

    
    // You need to modify always_comb block.
	 //calculate vision change
    always_comb
    begin
        // By default, keep motion unchanged
        // Update position and motion only at rising edge of frame clock
		  xin=x;
		  yin=y;
		  pixelxl_in=pixelxl;
		  pixelxr_in=pixelxr;
		  pixelyu_in=pixelyu;
		  pixelyd_in=pixelyd;
        if (frame_clk_rising_edge)
        begin
				if (keycode==8'h29)// jmp
					begin
					if(top_en)
					begin
						pixelyu_in=pixelyu-10'd80;
						pixelyd_in=pixelyd-10'd80;
					end
					end
				if (keycode==8'h1c) //left
					 begin
					 if(left_en)
					 begin
					 		pixelxl_in=pixelxl-10'd10;
							pixelxr_in=pixelxr-10'd10;
					 end
				end
				if (keycode==8'h23) //right
				begin
					if(right_en)
					 begin
					 		pixelxl_in=pixelxl+10'd10;
							pixelxr_in=pixelxr+10'd10;
					 end
				end
				
				if(down_en)
				begin
					
					pixelyu_in=pixelyu+10'd40;
					pixelyd_in=pixelyd+10'd40;
				
				end
				if(pixelyu>=10'd199)
				begin
					pixelyu_in=10'd159;
					pixelyd_in=10'd240;
					yin=y+6'b1;
				end
				
				if(pixelyd<=10'd200)
				begin
					pixelyu_in=10'd159;
					pixelyd_in=10'd240;
					yin=y-6'b1;
				end
				
				if(pixelxl<=10'd239)
				begin
					pixelxl_in=10'd279;
					pixelxr_in=10'd320;
					xin=x-6'b1;
				end
				
				if(pixelxr>=10'd360)
				begin
					pixelxl_in=10'd279;
					pixelxr_in=10'd320;
					xin=x+6'b1;
				end
				

				
        end

    end
    
	 //calculate is steve
	 
	 logic [9:0] tempx,tempy;
	 
	 assign tempx=DrawX-pixelxl-10'b1;
	 assign tempy=DrawY-pixelyu-10'b1;
	 assign steve_relx=tempx[6:0];
	 assign steve_rely=tempy[6:0];
	 
	 always_comb
	 begin
		if((DrawX>pixelxl)&&(DrawX<pixelxr)&&(DrawY>pixelyu)&&(DrawY<pixelyd)==1'b1)
		begin
			is_steve=1'b1;			
		end
		else
		begin
			is_steve=1'b0;
		end
	end
	 
	 //assign
	 
	 assign corner_x=x-6'b000111;
	 assign corner_y=y-6'b000101;
	 

endmodule
