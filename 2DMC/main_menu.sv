module main_menu

(

	input [9:0] DrawX,DrawY,
	
	output [23:0] main_rgb
	
);

logic [1:0] mc_rom [20399:0];
logic [1:0] button_rom [15999:0];

initial begin
	$readmemb("resources/ui/2dmc.txt",mc_rom);
	$readmemb("resources/ui/Menu.txt",button_rom);

end

int rely,relx,rely1;

assign rely=DrawY-59;
assign relx=DrawX-119;
assign rely1=DrawY-211;
always_comb
begin

	if((DrawX>119)&&(DrawX<519)&&(DrawY>60)&&(DrawY<111)) //Minecraft
	begin
		if(mc_rom[(rely)*400+(relx)]==2'b00)
			main_rgb=24'hd2e6ff;
		else if (mc_rom[(rely)*400+(relx)]==2'b01)
			main_rgb=24'h000000;
		else
			main_rgb=24'h777777;
		
	end
	
	else if((DrawX>119)&&(DrawX<519)&&(DrawY>211)&&(DrawY<251))
	begin
		if(button_rom[(rely1)*400+(relx)]==2'b00)
			main_rgb=24'h000000;
		else if (button_rom[(rely1)*400+(relx)]==2'b01)
			main_rgb=24'hd8d8d8;
		else if (button_rom[(rely1)*400+(relx)]==2'b10)
			main_rgb=24'h777777;
		else
			main_rgb=24'hffffff;
	end
	else
		main_rgb=24'hd2e6ff;
end

endmodule