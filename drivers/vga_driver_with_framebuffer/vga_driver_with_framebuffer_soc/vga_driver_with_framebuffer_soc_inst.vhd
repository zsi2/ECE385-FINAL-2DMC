	component vga_driver_with_framebuffer_soc is
		port (
			clk_clk            : in    std_logic                     := 'X';             -- clk
			epcs_dclk          : out   std_logic;                                        -- dclk
			epcs_sce           : out   std_logic;                                        -- sce
			epcs_sdo           : out   std_logic;                                        -- sdo
			epcs_data0         : in    std_logic                     := 'X';             -- data0
			reset_reset_n      : in    std_logic                     := 'X';             -- reset_n
			sdram_addr         : out   std_logic_vector(12 downto 0);                    -- addr
			sdram_ba           : out   std_logic_vector(1 downto 0);                     -- ba
			sdram_cas_n        : out   std_logic;                                        -- cas_n
			sdram_cke          : out   std_logic;                                        -- cke
			sdram_cs_n         : out   std_logic;                                        -- cs_n
			sdram_dq           : inout std_logic_vector(31 downto 0) := (others => 'X'); -- dq
			sdram_dqm          : out   std_logic_vector(3 downto 0);                     -- dqm
			sdram_ras_n        : out   std_logic;                                        -- ras_n
			sdram_we_n         : out   std_logic;                                        -- we_n
			vga_export_vga_clk : out   std_logic;                                        -- export_vga_clk
			vga_export_vga_hs  : out   std_logic;                                        -- export_vga_hs
			vga_export_vga_vs  : out   std_logic;                                        -- export_vga_vs
			vga_export_vga_de  : out   std_logic;                                        -- export_vga_de
			vga_export_vga_r   : out   std_logic_vector(7 downto 0);                     -- export_vga_r
			vga_export_vga_g   : out   std_logic_vector(7 downto 0);                     -- export_vga_g
			vga_export_vga_b   : out   std_logic_vector(7 downto 0)                      -- export_vga_b
		);
	end component vga_driver_with_framebuffer_soc;

	u0 : component vga_driver_with_framebuffer_soc
		port map (
			clk_clk            => CONNECTED_TO_clk_clk,            --   clk.clk
			epcs_dclk          => CONNECTED_TO_epcs_dclk,          --  epcs.dclk
			epcs_sce           => CONNECTED_TO_epcs_sce,           --      .sce
			epcs_sdo           => CONNECTED_TO_epcs_sdo,           --      .sdo
			epcs_data0         => CONNECTED_TO_epcs_data0,         --      .data0
			reset_reset_n      => CONNECTED_TO_reset_reset_n,      -- reset.reset_n
			sdram_addr         => CONNECTED_TO_sdram_addr,         -- sdram.addr
			sdram_ba           => CONNECTED_TO_sdram_ba,           --      .ba
			sdram_cas_n        => CONNECTED_TO_sdram_cas_n,        --      .cas_n
			sdram_cke          => CONNECTED_TO_sdram_cke,          --      .cke
			sdram_cs_n         => CONNECTED_TO_sdram_cs_n,         --      .cs_n
			sdram_dq           => CONNECTED_TO_sdram_dq,           --      .dq
			sdram_dqm          => CONNECTED_TO_sdram_dqm,          --      .dqm
			sdram_ras_n        => CONNECTED_TO_sdram_ras_n,        --      .ras_n
			sdram_we_n         => CONNECTED_TO_sdram_we_n,         --      .we_n
			vga_export_vga_clk => CONNECTED_TO_vga_export_vga_clk, --   vga.export_vga_clk
			vga_export_vga_hs  => CONNECTED_TO_vga_export_vga_hs,  --      .export_vga_hs
			vga_export_vga_vs  => CONNECTED_TO_vga_export_vga_vs,  --      .export_vga_vs
			vga_export_vga_de  => CONNECTED_TO_vga_export_vga_de,  --      .export_vga_de
			vga_export_vga_r   => CONNECTED_TO_vga_export_vga_r,   --      .export_vga_r
			vga_export_vga_g   => CONNECTED_TO_vga_export_vga_g,   --      .export_vga_g
			vga_export_vga_b   => CONNECTED_TO_vga_export_vga_b    --      .export_vga_b
		);

