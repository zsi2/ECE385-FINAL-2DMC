
module lab8_soc (
	clk_clk,
	cy7c67200_DATA,
	cy7c67200_ADDR,
	cy7c67200_RD_N,
	cy7c67200_WR_N,
	cy7c67200_CS_N,
	cy7c67200_RST_N,
	cy7c67200_INT,
	mouse_click_export,
	mouse_x_export,
	mouse_y_export,
	reset_reset_n,
	sdram_clk_clk,
	sdram_wire_addr,
	sdram_wire_ba,
	sdram_wire_cas_n,
	sdram_wire_cke,
	sdram_wire_cs_n,
	sdram_wire_dq,
	sdram_wire_dqm,
	sdram_wire_ras_n,
	sdram_wire_we_n);	

	input		clk_clk;
	inout	[15:0]	cy7c67200_DATA;
	output	[1:0]	cy7c67200_ADDR;
	output		cy7c67200_RD_N;
	output		cy7c67200_WR_N;
	output		cy7c67200_CS_N;
	output		cy7c67200_RST_N;
	input		cy7c67200_INT;
	output	[7:0]	mouse_click_export;
	output	[15:0]	mouse_x_export;
	output	[15:0]	mouse_y_export;
	input		reset_reset_n;
	output		sdram_clk_clk;
	output	[12:0]	sdram_wire_addr;
	output	[1:0]	sdram_wire_ba;
	output		sdram_wire_cas_n;
	output		sdram_wire_cke;
	output		sdram_wire_cs_n;
	inout	[31:0]	sdram_wire_dq;
	output	[3:0]	sdram_wire_dqm;
	output		sdram_wire_ras_n;
	output		sdram_wire_we_n;
endmodule
