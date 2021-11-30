
module vga_driver_with_framebuffer_soc (
	clk_clk,
	epcs_dclk,
	epcs_sce,
	epcs_sdo,
	epcs_data0,
	reset_reset_n,
	sdram_addr,
	sdram_ba,
	sdram_cas_n,
	sdram_cke,
	sdram_cs_n,
	sdram_dq,
	sdram_dqm,
	sdram_ras_n,
	sdram_we_n,
	vga_export_vga_clk,
	vga_export_vga_hs,
	vga_export_vga_vs,
	vga_export_vga_de,
	vga_export_vga_r,
	vga_export_vga_g,
	vga_export_vga_b);	

	input		clk_clk;
	output		epcs_dclk;
	output		epcs_sce;
	output		epcs_sdo;
	input		epcs_data0;
	input		reset_reset_n;
	output	[12:0]	sdram_addr;
	output	[1:0]	sdram_ba;
	output		sdram_cas_n;
	output		sdram_cke;
	output		sdram_cs_n;
	inout	[31:0]	sdram_dq;
	output	[3:0]	sdram_dqm;
	output		sdram_ras_n;
	output		sdram_we_n;
	output		vga_export_vga_clk;
	output		vga_export_vga_hs;
	output		vga_export_vga_vs;
	output		vga_export_vga_de;
	output	[7:0]	vga_export_vga_r;
	output	[7:0]	vga_export_vga_g;
	output	[7:0]	vga_export_vga_b;
endmodule
