module artrom
(
	input logic [3:0] id,
	
	input logic [5:0] relx,rely,
	
	input logic [6:0] steve_relx,steve_rely,
	
	
	output logic [23:0] rgb,steve_rgb,
	
	input Clk
	
);

logic [10:0] addr;
assign addr=(39-rely)*11'd40+relx;
logic [23:0] bedrock_pixel,wood_pixel,stone_pixel,dirt_pixel,diamond_ore_pixel,furnace_pixel,gold_ore_pixel,
grass_pixel,iron_ore_pixel,leaves_pixel,coal_ore_pixel,crafting_table_pixel,chest_pixel,cobblestone_pixel,wooden_planks_pixel,steve_pixel;

logic [11:0] steve_addr;

assign steve_addr=(steve_rely)*12'd40+steve_relx;

rom_bedrock bedrock (.*,.pixel(bedrock_pixel));
rom_wood wood (.*,.pixel(wood_pixel));
rom_stone stone (.*,.pixel(stone_pixel));
rom_dirt dirt (.*,.pixel(dirt_pixel));
rom_diamond_ore diamond_ore (.*,.pixel(diamond_ore_pixel));
rom_furnace furnace (.*,.pixel(furnace_pixel));
rom_gold_ore gold_ore (.*,.pixel(gold_ore_pixel));
rom_grass grass (.*,.pixel(grass_pixel));
rom_iron_ore iron_ore (.*,.pixel(iron_ore_pixel));
rom_leaves leaves (.*,.pixel(leaves_pixel));
rom_coal_ore coal_ore (.*,.pixel(coal_ore_pixel));
rom_crafting_table crafting_table (.*,.pixel(crafting_table_pixel));
rom_chest chest (.*,.pixel(chest_pixel));
rom_wooden_planks wooden_planks (.*,.pixel(wooden_planks_pixel));
rom_cobblestone cobblestone (.*,.pixel(cobblestone_pixel));
rom_steve teve (.*,.addr(steve_addr),.pixel(steve_pixel));
always_comb
begin
 if(rely<40&relx<40)	
 begin
	case(id)

	4'd1:
		rgb= bedrock_pixel;
	4'd2:
		rgb= wood_pixel;
	4'd3:
		rgb= stone_pixel;
	4'd4:
		rgb= dirt_pixel;
	4'd5:
		rgb= diamond_ore_pixel;
	4'd6:
		rgb= furnace_pixel;
	4'd7:
		rgb= gold_ore_pixel;
	4'd8:
		rgb= grass_pixel;
	4'd9:
		rgb= iron_ore_pixel;
	4'd10:
		rgb= leaves_pixel;
	4'd11:
		rgb= coal_ore_pixel;
	4'd12:
		rgb= crafting_table_pixel;
	4'd13:
		rgb= cobblestone_pixel;
	4'd14:
		rgb= chest_pixel;
	4'd15:
		rgb= wooden_planks_pixel;
	default:
		rgb=0;
	endcase
	
 end
 else
 
 rgb=24'b0;
 
end

always_comb
begin
	if((steve_relx!=6'b0)&(steve_rely!=6'b0))
	begin
		steve_rgb=steve_pixel;
	end
	
	else
		steve_rgb=24'hd2e6ff;
end

endmodule


module rom_bedrock
(
	input [10:0] addr,
	input Clk,
	output logic [23:0] pixel

);

	logic [23:0] rom [2047:0];
	
	initial begin
	
	$readmemh("resources/block/bedrock.txt",rom);
	
	end
	
	always_ff @(posedge Clk)
	begin
		pixel<=rom[addr];
		
	end
	
endmodule

module rom_wood
(
	input [10:0] addr,
	input Clk,
	output logic [23:0] pixel

);

	logic [23:0] rom [2047:0];
	
	initial begin
	
	$readmemh("resources/block/wood.txt",rom);
	
	end
	
	always_ff @(posedge Clk)
	begin
		pixel<=rom[addr];
		
	end
	
endmodule

module rom_stone
(
	input [10:0] addr,
	input Clk,
	output logic [23:0] pixel

);

	logic [23:0] rom [2047:0];
	
	initial begin
	
	$readmemh("resources/block/rock.txt",rom);
	
	end
	
	always_ff @(posedge Clk)
	begin
		pixel<=rom[addr];
		
	end
	
endmodule

module rom_dirt
(
	input [10:0] addr,
	input Clk,
	output logic [23:0] pixel

);

	logic [23:0] rom [2047:0];
	
	initial begin
	
	$readmemh("resources/block/soil.txt",rom);
	
	end
	
	always_ff @(posedge Clk)
	begin
		pixel<=rom[addr];
		
	end
	
endmodule

module rom_diamond_ore
(
	input [10:0] addr,
	input Clk,
	output logic [23:0] pixel

);

	logic [23:0] rom [2047:0];
	
	initial begin
	
	$readmemh("resources/block/diamondore.txt",rom);
	
	end
	
	always_ff @(posedge Clk)
	begin
		pixel<=rom[addr];
		
	end
	
endmodule

module rom_furnace
(
	input [10:0] addr,
	input Clk,
	output logic [23:0] pixel

);

	logic [23:0] rom [2047:0];
	
	initial begin
	
	$readmemh("resources/block/furnace.txt",rom);
	
	end
	
	always_ff @(posedge Clk)
	begin
		pixel<=rom[addr];
		
	end
	
endmodule

module rom_gold_ore
(
	input [10:0] addr,
	input Clk,
	output logic [23:0] pixel

);

	logic [23:0] rom [2047:0];
	
	initial begin
	
	$readmemh("resources/block/goldore.txt",rom);
	
	end
	
	always_ff @(posedge Clk)
	begin
		pixel<=rom[addr];
		
	end
	
endmodule

module rom_grass
(
	input [10:0] addr,
	input Clk,
	output logic [23:0] pixel

);

	logic [23:0] rom [2047:0];
	
	initial begin
	
	$readmemh("resources/block/grass.txt",rom);
	
	end
	
	always_ff @(posedge Clk)
	begin
		pixel<=rom[addr];
		
	end
	
endmodule

module rom_iron_ore
(
	input [10:0] addr,
	input Clk,
	output logic [23:0] pixel

);

	logic [23:0] rom [2047:0];
	
	initial begin
	
	$readmemh("resources/block/ironore.txt",rom);
	
	end
	
	always_ff @(posedge Clk)
	begin
		pixel<=rom[addr];
		
	end
	
endmodule

module rom_leaves
(
	input [10:0] addr,
	input Clk,
	output logic [23:0] pixel

);

	logic [23:0] rom [2047:0];
	
	initial begin
	
	$readmemh("resources/block/leaves.txt",rom);
	
	end
	
	always_ff @(posedge Clk)
	begin
		pixel<=rom[addr];
		
	end
	
endmodule

module rom_coal_ore
(
	input [10:0] addr,
	input Clk,
	output logic [23:0] pixel

);

	logic [23:0] rom [2047:0];
	
	initial begin
	
	$readmemh("resources/block/coalore.txt",rom);
	
	end
	
	always_ff @(posedge Clk)
	begin
		pixel<=rom[addr];
		
	end
	
endmodule

module rom_crafting_table
(
	input [10:0] addr,
	input Clk,
	output logic [23:0] pixel

);

	logic [23:0] rom [2047:0];
	
	initial begin
	
	$readmemh("resources/block/craftingtable.txt",rom);
	
	end
	
	always_ff @(posedge Clk)
	begin
		pixel<=rom[addr];
		
	end
	
endmodule

module rom_cobblestone
(
	input [10:0] addr,
	input Clk,
	output logic [23:0] pixel

);

	logic [23:0] rom [2047:0];
	
	initial begin
	
	$readmemh("resources/block/cobblestone.txt",rom);
	
	end
	
	always_ff @(posedge Clk)
	begin
		pixel<=rom[addr];
		
	end
	
endmodule

module rom_chest
(
	input [10:0] addr,
	input Clk,
	output logic [23:0] pixel

);

	logic [23:0] rom [2047:0];
	
	initial begin
	
	$readmemh("resources/block/chest.txt",rom);
	
	end
	
	always_ff @(posedge Clk)
	begin
		pixel<=rom[addr];
		
	end
	
endmodule

module rom_wooden_planks
(
	input [10:0] addr,
	input Clk,
	output logic [23:0] pixel

);

	logic [23:0] rom [2047:0];
	
	initial begin
	
	$readmemh("resources/block/water.txt",rom);
	
	end
	
	always_ff @(posedge Clk)
	begin
		pixel<=rom[addr];
		
	end
	
endmodule

module rom_steve
(
	input [11:0] addr,
	input Clk,
	output logic [23:0] pixel

);

	logic [23:0] rom [4095:0];
	
	initial begin
	
	$readmemb("resources/block/steve.txt",rom,0,3199);
	
	end
	
	always_ff @(posedge Clk)
	begin
		pixel<=rom[addr];
		
	end
	
endmodule