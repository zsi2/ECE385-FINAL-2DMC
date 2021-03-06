//-------------------------------------------------------------------------
//      lab8.sv                                                          --
//      Christine Chen                                                   --
//      Fall 2014                                                        --
//                                                                       --
//      Modified by Po-Han Huang                                         --
//      10/06/2017                                                       --
//                                                                       --
//      Fall 2017 Distribution                                           --
//                                                                       --
//      For use with ECE 385 Lab 8                                       --
//      UIUC ECE Department                                              --
//-------------------------------------------------------------------------


module lab8( input               CLOCK_50,
				 input PS2_CLK,PS2_DAT,
             input        [3:0]  KEY,          //bit 0 is set up as Reset
             output logic [6:0]  HEX0, HEX1, HEX2, HEX3, HEX4, HEX5,
				 output logic [9:0]  LEDR,
             // VGA Interface 
             output logic [7:0]  VGA_R,        //VGA Red
                                 VGA_G,        //VGA Green
                                 VGA_B,        //VGA Blue
             output logic        VGA_CLK,      //VGA Clock
                                 VGA_SYNC_N,   //VGA Sync signal
                                 VGA_BLANK_N,  //VGA Blank signal
                                 VGA_VS,       //VGA virtical sync signal
                                 VGA_HS,       //VGA horizontal sync signal
             // CY7C67200 Interface
             inout  wire  [15:0] OTG_DATA,     //CY7C67200 Data bus 16 Bits
             output logic [1:0]  OTG_ADDR,     //CY7C67200 Address 2 Bits
             output logic        OTG_CS_N,     //CY7C67200 Chip Select
                                 OTG_RD_N,     //CY7C67200 Write
                                 OTG_WR_N,     //CY7C67200 Read
                                 OTG_RST_N,    //CY7C67200 Reset
             input     [1:0]          OTG_INT,      //CY7C67200 Interrupt
             // SDRAM Interface for Nios II Software
             output logic [12:0] DRAM_ADDR,    //SDRAM Address 13 Bits
             inout  wire  [31:0] DRAM_DQ,      //SDRAM Data 32 Bits
             output logic [1:0]  DRAM_BA,      //SDRAM Bank Address 2 Bits
             output logic [3:0]  DRAM_DQM,     //SDRAM Data Mast 4 Bits
             output logic        DRAM_RAS_N,   //SDRAM Row Address Strobe
                                 DRAM_CAS_N,   //SDRAM Column Address Strobe
                                 DRAM_CKE,     //SDRAM Clock Enable
                                 DRAM_WE_N,    //SDRAM Write Enable
                                 DRAM_CS_N,    //SDRAM Chip Select
                                 DRAM_CLK      //SDRAM Clock
                    );
    
    logic Reset_h, Clk;
    logic [7:0] keycode,keycode_tmp;
    
    assign Clk = CLOCK_50;
    always_ff @ (posedge Clk) begin
        Reset_h <= ~(KEY[0]);        // The push buttons are active low
    end
    
/*    logic [1:0] hpi_addr;
    logic [15:0] hpi_data_in, hpi_data_out;
    logic hpi_r, hpi_w, hpi_cs, hpi_reset;*/
	 
	 logic is_ball;
	 logic [9:0] DrawX,DrawY,MouseX,MouseY;
	 
	 logic [1:0]press;
    
	 assign press=state;
	 assign MouseX=mouse_x[9:0];
	 assign MouseY=mouse_y[9:0];
	 keyboard key1 (.*);

	 logic [7:0] mouse_click;
	 logic [15:0] mouse_x,mouse_y;
	

	lab8_soc u0 (
		.clk_clk                (Clk),                //             clk.clk
		.cy7c67200_DATA     (OTG_DATA),     //   cy7c67200.DATA
		.cy7c67200_ADDR     (OTG_ADDR),     //            .ADDR
		.cy7c67200_RD_N     (OTG_RD_N),     //            .RD_N
		.cy7c67200_WR_N     (OTG_WR_N),     //            .WR_N
		.cy7c67200_CS_N     (OTG_CS_N),     //            .CS_N
		.cy7c67200_RST_N    (OTG_RST_N),    //            .RST_N
		.cy7c67200_INT      (OTG_INT[0]),      //            .INT
		.mouse_click_export (mouse_click), // mouse_click.export
		.mouse_x_export     (mouse_x),     //     mouse_x.export
		.mouse_y_export     (mouse_y),     //     mouse_y.export

		.reset_reset_n          (1'b1),          //           reset.reset_n
		.sdram_clk_clk          (DRAM_CLK),          //       sdram_clk.clk
		.sdram_wire_addr        (DRAM_ADDR),        //      sdram_wire.addr
		.sdram_wire_ba          (DRAM_BA),          //                .ba
		.sdram_wire_cas_n       (DRAM_CAS_N),       //                .cas_n
		.sdram_wire_cke         (DRAM_CKE),         //                .cke
		.sdram_wire_cs_n        (DRAM_CS_N),        //                .cs_n
		.sdram_wire_dq          (DRAM_DQ),          //                .dq
		.sdram_wire_dqm         (DRAM_DQM),         //                .dqm
		.sdram_wire_ras_n       (DRAM_RAS_N),       //                .ras_n
		.sdram_wire_we_n        (DRAM_WE_N),        //                .we_n

	);
	
	

    
    // Use PLL to generate the 25MHZ VGA_CLK.
    // You will have to generate it on your own in simulation.
    vga_clk vga_clk_instance(.inclk0(Clk), .c0(VGA_CLK));
    
    // TODO: Fill in the connections for the rest of the modules 
    VGA_controller vga_controller_instance(.*,.Reset(Reset_h));
    
    // Which signal should be frame_clk?
 //   ball ball_instance(.*,.Reset(Reset_h),.frame_clk(VGA_VS));
    
    color_mapper color_instance(.*);
	 
	 logic [9:0] corner_x,corner_y;
	 logic is_steve,left_en,right_en,top_en,down_en;
	 logic [3:0] x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,y1,y2,y3,y4,y5,y6,y7,y8,y9,y10,y11,y12,x11,x12;
	 logic [6:0] steve_relx,steve_rely;
	 logic [9:0] x,y;
	 logic [19:0] hearts; //heart
	 Steve steve (.*,.Reset(Reset_h),.frame_clk(VGA_VS));
    logic [9:0] pixelyd,pixelxr;

    // Display keycode on hex display
	 
	 logic [4:0] hand;
    HexDriver hex_inst_0 (keycode[3:0], HEX0);
    HexDriver hex_inst_1 (keycode[7:4], HEX1);
	 HexDriver hex_inst_2 (x[3:0], HEX2);
	 HexDriver hex_inst_3 ({1'b0,x[6:4]}, HEX3);
	 HexDriver hex_inst_4 (y[3:0], HEX4);
	 HexDriver hex_inst_5 ({1'b0,y[6:4]}, HEX5);
	 assign LEDR=mouse_click;
	 
	 
	 //timer and backrgb
	 
	 
	 logic [31:0] time_in_sec;
	 
	 logic [23:0] back_rgb;
	 
	 time_generator t0 (.*);
	 
//	 parameter backr=8'hd2;
//	 parameter backg=8'he6;
//	 parameter backb=8'hff;
	 
	 logic [8:0] backrnow,backgnow,backbnow;
	 
	 always_comb
	 begin
		if(time_in_sec<600)
		begin
			backrnow=210-7*(time_in_sec/60);
			backgnow=230-6*(time_in_sec/60);
			backbnow=250;
		end
		else
		begin
			backrnow=230-9*(time_in_sec/60);
			backgnow=280-11*(time_in_sec/60);
			backbnow=400-15*(time_in_sec/60);
		
		end
	end
	 

	 
	 
	 assign back_rgb={backrnow[7:0],backgnow[7:0],backbnow[7:0]};
	 
	 

	 //main FSM
	 
	 logic [3:0] push_id;
	 logic [1:0] operation;
	 logic [9:0] changex,changey;
	 logic [3:0] mouse_relx,mouse_rely;
	 rxycalc rmouse(.DrawX(MouseX),.DrawY(MouseY),.x(mouse_relx),.y(mouse_rely),.relx(),.rely());
	 
	 assign changex=corner_x+mouse_relx;
	 assign changey=corner_y+mouse_rely;
	 
	 
	 
	 
	 logic [3:0] state;
	 
	 
	 
	 parameter start_menu=4'd0;
	 parameter main_game=4'd1;
	 parameter backpack=4'd2;
	 parameter craft=4'd3;
	 parameter furnace=4'd4;
	 parameter pause=4'd5;
	 always_ff @(posedge Clk)
	 begin
	 if(Reset_h)
		state<=start_menu;
	 case(state)
	 start_menu:
	 begin
		if((mouse_click==8'b1)&&(MouseX>119)&&(MouseX<519)&&(MouseY>211)&&(MouseY<251))
			state<=main_game;
	 
	 end
	 main_game:
	 begin
		operation=mouse_click[1:0]; //1 left click, 2 right ,0 none
		if(keycode==8'h24)
		begin
			state<=backpack;
		end
		
		//decide push id
		if(keycode==8'h45)
			push_id<=4'd2;
		if(keycode==8'h16)
			push_id<=4'd3;
		if(keycode==8'h1e)
			push_id<=4'd4;
		if(keycode==8'h26)
			push_id<=4'd6;
		if(keycode==8'h25)
			push_id<=4'd7;
		if(keycode==8'h2e)
			push_id<=4'd9;
		if(keycode==8'h36)
			push_id<=4'd12;
		if(keycode==8'h3d)
			push_id<=4'd13;
		if(keycode==8'h3e)
			push_id<=4'd14;
		if(keycode==8'h46)
			push_id<=4'd15;
		
		
	 end
	 backpack:
	 begin
		if(keycode==8'h76)
		begin
			state<=main_game;
		end
	 end
	 default:
		operation=2'b00;
	 endcase
	 end
	 


	 
    
    /**************************************************************************************
        ATTENTION! Please answer the following quesiton in your lab report! Points will be allocated for the answers!
        Hidden Question #1/2:
        What are the advantages and/or disadvantages of using a USB interface over PS/2 interface to
             connect to the keyboard? List any two.  Give an answer in your Post-Lab.
    **************************************************************************************/
endmodule
