	vga_driver_with_framebuffer_soc u0 (
		.clk_clk            (<connected-to-clk_clk>),            //   clk.clk
		.epcs_dclk          (<connected-to-epcs_dclk>),          //  epcs.dclk
		.epcs_sce           (<connected-to-epcs_sce>),           //      .sce
		.epcs_sdo           (<connected-to-epcs_sdo>),           //      .sdo
		.epcs_data0         (<connected-to-epcs_data0>),         //      .data0
		.reset_reset_n      (<connected-to-reset_reset_n>),      // reset.reset_n
		.sdram_addr         (<connected-to-sdram_addr>),         // sdram.addr
		.sdram_ba           (<connected-to-sdram_ba>),           //      .ba
		.sdram_cas_n        (<connected-to-sdram_cas_n>),        //      .cas_n
		.sdram_cke          (<connected-to-sdram_cke>),          //      .cke
		.sdram_cs_n         (<connected-to-sdram_cs_n>),         //      .cs_n
		.sdram_dq           (<connected-to-sdram_dq>),           //      .dq
		.sdram_dqm          (<connected-to-sdram_dqm>),          //      .dqm
		.sdram_ras_n        (<connected-to-sdram_ras_n>),        //      .ras_n
		.sdram_we_n         (<connected-to-sdram_we_n>),         //      .we_n
		.vga_export_vga_clk (<connected-to-vga_export_vga_clk>), //   vga.export_vga_clk
		.vga_export_vga_hs  (<connected-to-vga_export_vga_hs>),  //      .export_vga_hs
		.vga_export_vga_vs  (<connected-to-vga_export_vga_vs>),  //      .export_vga_vs
		.vga_export_vga_de  (<connected-to-vga_export_vga_de>),  //      .export_vga_de
		.vga_export_vga_r   (<connected-to-vga_export_vga_r>),   //      .export_vga_r
		.vga_export_vga_g   (<connected-to-vga_export_vga_g>),   //      .export_vga_g
		.vga_export_vga_b   (<connected-to-vga_export_vga_b>)    //      .export_vga_b
	);

