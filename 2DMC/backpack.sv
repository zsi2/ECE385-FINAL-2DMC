module backpack

(

	input logic Clk,
	
	input logic [9:0] DrawX,DrawY,
	
	input logic [3:0] state,
	
	output logic is_bp,
	
	output logic is_handon,
	
	output logic [23:0] bp_rgb,handon_rgb,
	
	input logic [9:0] mousex,mousey,
	
	input logic [1:0] operation,
	
	output logic [4:0] hand
	
	//output logic hb
	
	//input logic id,
	
	//input logic [1:0] op
	
);

	logic clock;
	
	assign clock=Clk;
	
	 parameter left=2'd1;
	 parameter right=2'd2;

	 parameter start_menu=4'd0;
	 parameter main_game=4'd1;
	 parameter backpack=4'd2;
	 parameter craft=4'd3;
	 parameter furnace=4'd4;
	 parameter pause=4'd5;
	 
	 //region decision
	 
	 //backpack
	 
	 always_comb
	 begin
	 
	 if((DrawX>119)&&(DrawX<519)&&(DrawY<399)&&(DrawY>279)&&((state==backpack)|(state==craft)|(state==furnace)))
		is_bp=1;
	 else
		is_bp=0;
	
	 end
	 
	 //handitems
	 
	 always_comb
	 begin
	 
	 if((DrawX>119)&&(DrawX<519)&&(DrawY<479)&&(DrawY>439)&&((state==backpack)|(state==craft)|(state==furnace)|(state==main_game)))
		is_handon=1;
	 else
		is_handon=0;
	
	 end	 
	 

/*handon_pointers	handon_pointers_inst (
	.address_a ( raddr ),
	.address_b ( addrb ),
	.clock ( clock),
	.data_a ( waddr ),
	.data_b ( 0 ),
	.wren_a ( wren ),
	.wren_b (0 ),
	.q_a ( q ),
	.q_b ( qb )
	);

	 logic [4:0] q,qb;
	 logic [3:0] raddr,waddr,addrb;
	 logic wren;
	 logic [4:0] data;
	 
	 
	 assign raddr=relx/40;
	 assign waddr=mouse_rx/40;
	 assign wren=(operation==left)&&(mousex>119)&&(mousex<519)&&(mousey>279)&&(mousey<399)&&(state==backpack);
	 assign data=(mouse_ry/40)*10+(mouse_rx/40)+1;*/
	 
	parameter bit [4:0] handon_pointers [9:0]='{
		5'd10,
		5'd7,
		5'd8,
		5'd4,
		5'd5,
		5'd6,
		5'd3,
		5'd9,
		5'd1,
		5'd11
	
	
	};
	
	 
	 
	 
	 
	 //shader
	 
	 logic [9:0] relx,rely,relyhand;
	 
	 assign relx= DrawX-119;
	 
	 assign rely= DrawY-279;
	 
	 assign relyhand = DrawY-439;
	 
	 logic [9:0] x,y;
	 
	 logic [9:0] x_inblock,y_inblock,y_inhand;
	 
	 assign x=relx/40;
	 
	 assign y=rely/40;
	 
	 assign x_inblock=relx%40;
	 
	 assign y_inblock=rely%40;
	 
	 assign y_inhand= relyhand%40;
	 
	 logic [9:0] address;
	 
	 assign address=(y_inblock-7)*26+(x_inblock-7);
	 
	 logic [23:0] shader_buffer [24:0];
	 wire [1:0] bg_buffer;
	 
	 logic [10:0] bg_addr;
	 
	 assign bg_addr=y_inblock*40+x_inblock;
	 
	hand_chest z0(.*,.q(shader_buffer[0]));
	hand_coal z1(.*,.q(shader_buffer[1]));
	hand_craftingtable z2(.*,.q(shader_buffer[2]));
	hand_furnace z3(.*,.q(shader_buffer[3]));
	hand_goldore z4(.*,.q(shader_buffer[4]));
	hand_ironore z5(.*,.q(shader_buffer[5]));
	hand_rock z6(.*,.q(shader_buffer[6]));
	hand_soil z7(.*,.q(shader_buffer[7]));
	hand_cobblestone z8(.*,.q(shader_buffer[8]));
	hand_wood z9(.*,.q(shader_buffer[9]));
	hand_woodenplanks z10(.*,.q(shader_buffer[10]));
	hand_pickaxediamond z11(.*,.q(shader_buffer[11]));
	hand_pickaxegold z12(.*,.q(shader_buffer[12]));
	hand_pickaxeiron z13(.*,.q(shader_buffer[13]));
	hand_pickaxestone z14(.*,.q(shader_buffer[14]));
	hand_pickaxewood z15(.*,.q(shader_buffer[15]));
	hand_axediamond z16(.*,.q(shader_buffer[16]));
	hand_axegold z17(.*,.q(shader_buffer[17]));
	hand_axeiron z18(.*,.q(shader_buffer[18]));
	hand_axestone z19(.*,.q(shader_buffer[19]));
	hand_axewood z20(.*,.q(shader_buffer[20]));
	hand_diamond z21(.*,.q(shader_buffer[21]));
	hand_goldingot z22(.*,.q(shader_buffer[22]));
	hand_ironingot z23(.*,.q(shader_buffer[23]));
	hand_stick z24(.*,.q(shader_buffer[24]));
	hand_bg h25(.*,.q(bg_buffer),.address(bg_addr));
	
		//pixel decision mux
		
	logic [23:0] bg_pixel,item_pixel;
	
	always_comb
	begin
		if(bg_buffer==2'b00)
			bg_pixel=24'ha1b29d;
		else if(bg_buffer==2'b01)
			bg_pixel=24'h777777;
		else if(bg_buffer==2'b10)
			bg_pixel=24'h5f6d5c;
		else
			bg_pixel=24'h8b8b8b;
	end
	
	logic [9:0] index;
	assign index = y*10'd10+x;
	
	always_comb
	begin
	
		if((x_inblock>6)&&(x_inblock<32)&&(y_inblock>6)&&(y_inblock<32))// item
		begin
			if((index>25)||(shader_buffer[index]==24'h00ffff))
				bp_rgb=bg_pixel;
			else
				bp_rgb=shader_buffer[index];
		end
		
		else
			
			bp_rgb=bg_pixel;
			
	end
	
	
	always_comb
	begin
	
		if((x_inblock>6)&&(x_inblock<32)&&(y_inhand>6)&&(y_inhand<32))// item
		begin
			if((handon_pointers[x]>26)||(handon_pointers[x]<1)||(shader_buffer[handon_pointers[x]-1]==24'h00ffff))
				handon_rgb=bg_pixel;
			else
				handon_rgb=shader_buffer[handon_pointers[x]-1];
		end
		
		else
			
			handon_rgb=bg_pixel;
			
	end		
	
	
		
	//assign handon_pixel=0;
	
	
	//transitions between 2 ends
	//calculating position of mouse
	logic [9:0] mouse_rx,mouse_ry,mouse_ryhand;
	
	assign mouse_rx=mousex-119;
	assign mouse_ry=mousey-279;
	assign mouse_ryhand=mousey-439;
	
	//handon and backpack  transition
	
	logic [4:0] temp_id,temp_id_in;
	
	//step 1
	
	
	
	

			
						
	assign hand=temp_id;		
	
	 

endmodule


