module rxycalc 
(
	input logic [9:0] DrawX,DrawY,
	
	
	output logic [3:0]x,y,
	
	output logic  [5:0] relx,rely

);

	logic [9:0] tempx,tempy;
	
	always_comb
	begin
		if((DrawX>=0)&(DrawX<40))
		begin
			x=0;
			tempx=DrawX;
		end
		else if((DrawX>=40)&(DrawX<80))
		begin
			x=1;
			tempx=(DrawX-10'b0000101000);
	
		end
		else if((DrawX>=80)&(DrawX<120))
		begin
			x=2;
			tempx=(DrawX-10'b0001010000);

		end
		else if((DrawX>=120)&(DrawX<160))
		begin
			x=3;
			tempx=(DrawX-10'b0001111000);

		end
		else if((DrawX>=160)&(DrawX<200))
		begin
			x=4;
			tempx=(DrawX-10'b0010100000);

		end
		else if((DrawX>=200)&(DrawX<240))
		begin
			x=5;
			tempx=(DrawX-10'b0011001000);

		end
		else if((DrawX>=240)&(DrawX<280))
		begin
			x=6;
			tempx=(DrawX-10'b0011110000);

		end
		else if((DrawX>=280)&(DrawX<320))
		begin
			x=7;
			tempx=(DrawX-10'b0100011000);

		end
		else if((DrawX>=320)&(DrawX<360))
		begin
			x=8;
			tempx=(DrawX-10'b0101000000);

		end
		else if((DrawX>=360)&(DrawX<400))
		begin
			x=9;
			tempx=(DrawX-10'b0101101000);

		end
		else if((DrawX>=400)&(DrawX<440))
		begin
			x=10;
			tempx=(DrawX-10'b0110010000);

		end
		else if((DrawX>=440)&(DrawX<480))
		begin
			x=11;
			tempx=(DrawX-10'b0110111000);

		end
		else if((DrawX>=480)&(DrawX<520))
		begin
			x=12;
			tempx=(DrawX-10'b0111100000);

		end
		else if((DrawX>=520)&(DrawX<560))
		begin
			x=13;
			tempx=(DrawX-10'b1000001000);
		end
		else if((DrawX>=560)&(DrawX<600))
		begin
			x=14;
			tempx=(DrawX-10'b1000110000);
		end
		else if((DrawX>=600)&(DrawX<640))
		begin
			x=15;
			tempx=(DrawX-10'b1001011000);
		end
		else
		begin
			x=0;
			tempx=10'b0;
		end
	end

	always_comb
	begin
		if((DrawY>=0)&(DrawY<40))
		begin
			y=0;
			tempy=DrawY;
		end
		else if((DrawY>=40)&(DrawY<80))
		begin
			y=1;
			tempy=(DrawY-10'b0000101000);
		end
		else if((DrawY>=80)&(DrawY<120))
		begin
			y=2;
			tempy=(DrawY-10'b0001010000);
		end
		else if((DrawY>=120)&(DrawY<160))
		begin
			y=3;
			tempy=(DrawY-10'b0001111000);
		end
		else if((DrawY>=160)&(DrawY<200))
		begin
			y=4;
			tempy=(DrawY-10'b0010100000);
		end
		else if((DrawY>=200)&(DrawY<240))
		begin
			y=5;
			tempy=(DrawY-10'b0011001000);
		end
		else if((DrawY>=240)&(DrawY<280))
		begin
			y=6;
			tempy=(DrawY-10'b0011110000);
		end
		else if((DrawY>=280)&(DrawY<320))
		begin
			y=7;
			tempy=(DrawY-10'b0100011000);
		end
		else if((DrawY>=320)&(DrawY<360))
		begin
			y=8;
			tempy=(DrawY-10'b0101000000);
		end
		else if((DrawY>=360)&(DrawY<400))
		begin
			y=9;
			tempy=(DrawY-10'b0101101000);
		end
		else if((DrawY>=400)&(DrawY<440))
		begin
			y=10;
			tempy=(DrawY-10'b0110010000);
		end
		else if((DrawY>=440)&(DrawY<480))
		begin
			y=11;
			tempy=(DrawY-10'b0110111000);
		end
		else
		begin
			y=0;
			tempy=10'b0;
		end
	end

	assign relx=tempx[5:0];
	assign rely=tempy[5:0];

endmodule