module hearts
(

	input logic [9:0] DrawX,DrawY,
	
	input logic [19:0] hearts,
	
	output [23:0] heart_rgb,
	
	output logic is_heart
	
);

logic [1:0] full_heart [399:0];
logic [1:0] half_heart [399:0];
logic [1:0] no_heart [399:0];

initial begin

$readmemb("resources/ui/FullHeart.txt",full_heart);
$readmemb("resources/ui/HalfHeart.txt",half_heart);
$readmemb("resources/ui/NoHeart.txt",no_heart);

end

int relx,rely;

assign relx=DrawX-70;
assign rely=DrawY-420;

logic [3:0] whichheart;

always_comb
begin
	if((relx>=0)&&(relx<20))
	begin
		whichheart=4'd1;
	end
	else if((relx>=20)&&(relx<40))
	begin
		whichheart=4'd2;
	end
	else if((relx>=40)&&(relx<60))
	begin
		whichheart=4'd3;
	end
	else if((relx>=60)&&(relx<80))
	begin
		whichheart=4'd4;
	end
	else if((relx>=80)&&(relx<100))
	begin
		whichheart=4'd5;
	end
	else if((relx>=100)&&(relx<120))
	begin
		whichheart=4'd6;
	end
	else if((relx>=120)&&(relx<140))
	begin
		whichheart=4'd7;
	end
	else if((relx>=140)&&(relx<160))
	begin
		whichheart=4'd8;
	end
	else if((relx>=160)&&(relx<180))
	begin
		whichheart=4'd9;
	end
	else if((relx>=180)&&(relx<200))
	begin
		whichheart=4'd10;
	end
	else
		whichheart=4'b0;

end
int relx_in_a_heart;
logic [1:0] color_id;

always_comb
begin
				case(color_id)
				2'b00:
				begin
					//transparent
					is_heart=1'b0;
					heart_rgb=0;
				end
				2'b01:
				begin
					
					is_heart=1'b1;
					heart_rgb=24'h000000;
				end
				2'b10:
				begin
					
					is_heart=1'b1;
					heart_rgb=24'hff1313;
				end
				2'b11:
				begin
					
					is_heart=1'b1;
					heart_rgb=24'hbb1313;
				end
				endcase
end
assign relx_in_a_heart=relx-(whichheart-1)*20;

always_comb
begin
if((rely>=0)&&(rely<20))
begin
	if(whichheart>0)
	begin
		case(hearts[20-2*whichheart+1-:2])
			2'b10: //full
			color_id=full_heart[20*(rely)+relx_in_a_heart];
			2'b01: //half
			color_id=half_heart[20*(rely)+relx_in_a_heart];
			2'b00:
			color_id=no_heart[20*(rely)+relx_in_a_heart];
			default:
			color_id=0;
		endcase
	end
	
	else
		color_id=0;

end

else
	color_id=0;

end




endmodule