module backpack
(
	input logic [1:0] operation,  //00 no, 01 inc ,10 dec
	
	input logic [5:0] things,

	output [5:0] handin,
	
	output [23:0] backpack_rgb,
	
	output logic success,
	
	input [9:0] MouseX,MouseY,
	
	input [7:0] mouse_click,
	
	input Clk

);

	//backpack
	
	
	logic [3:0] backpack [29:0] //amounts, index is id
	
	
	//operations
	
	always_ff @(posedge Clk)
	begin
		if(operation==2'b01)
		begin
			if(backpack[things]!=4'd15)
			begin
			backpack[things]<=backpack[things]+1;
			success<=1'b1;
			end
			else
			success<=1'b0;
		end
			
		else if (operation==2'b10)
		begin
			if(backpack[things]!=0)
			begin
			backpack[things]<=backpack[things]-1;
			success<=1'b1;
			end
			else
			success<=1'b0;
		end		
		
	
	end
	
	/*blocks_dict_3 = {
    "__Air__": "00000",
    "Bedrock": "00001",
    "_Chest_": "01110",
    "CoalOre": "01011",
    "Crafting_Table": "01100",
    "Dia_Ore": "00101",
    "Furnace": "00110",
    "GoldOre": "00111",
    "_Grass_": "01000",
    "IronOre": "01001",
    "_Leaves": "01010",
    "__Rock_": "00011",
     "__Soil_": "00100",
    "CobRock": "01101",
    "__Wood_": "00010",
    "WoodPlk": "01111",
    "Pickaxe Diamond": "10000",
    "Pickaxe Gold": "10001",
    "Pickaxe Iron": "10010",
    "Pickaxe Stone": "10011",
    "Pickaxe Wood": "10100",
    "Axe Diamond": "10101",
    "Axe Gold": "10110",
    "Axe Iron": "10111",
    "Axe Stone": "11000",
    "Axe Wood": "11001",
    "Diamond Ingot": "11010",
    "Gold Ingot": "11011",
    "Iron Ingot": "11100",
    "Coal Ingot": "11101",
    "Stick": "11110"
}*/









endmodule