	component lab8_soc is
		port (
			clk_clk            : in    std_logic                     := 'X';             -- clk
			cy7c67200_DATA     : inout std_logic_vector(15 downto 0) := (others => 'X'); -- DATA
			cy7c67200_ADDR     : out   std_logic_vector(1 downto 0);                     -- ADDR
			cy7c67200_RD_N     : out   std_logic;                                        -- RD_N
			cy7c67200_WR_N     : out   std_logic;                                        -- WR_N
			cy7c67200_CS_N     : out   std_logic;                                        -- CS_N
			cy7c67200_RST_N    : out   std_logic;                                        -- RST_N
			cy7c67200_INT      : in    std_logic                     := 'X';             -- INT
			mouse_click_export : out   std_logic_vector(7 downto 0);                     -- export
			mouse_x_export     : out   std_logic_vector(15 downto 0);                    -- export
			mouse_y_export     : out   std_logic_vector(15 downto 0);                    -- export
			reset_reset_n      : in    std_logic                     := 'X';             -- reset_n
			sdram_clk_clk      : out   std_logic;                                        -- clk
			sdram_wire_addr    : out   std_logic_vector(12 downto 0);                    -- addr
			sdram_wire_ba      : out   std_logic_vector(1 downto 0);                     -- ba
			sdram_wire_cas_n   : out   std_logic;                                        -- cas_n
			sdram_wire_cke     : out   std_logic;                                        -- cke
			sdram_wire_cs_n    : out   std_logic;                                        -- cs_n
			sdram_wire_dq      : inout std_logic_vector(31 downto 0) := (others => 'X'); -- dq
			sdram_wire_dqm     : out   std_logic_vector(3 downto 0);                     -- dqm
			sdram_wire_ras_n   : out   std_logic;                                        -- ras_n
			sdram_wire_we_n    : out   std_logic                                         -- we_n
		);
	end component lab8_soc;

	u0 : component lab8_soc
		port map (
			clk_clk            => CONNECTED_TO_clk_clk,            --         clk.clk
			cy7c67200_DATA     => CONNECTED_TO_cy7c67200_DATA,     --   cy7c67200.DATA
			cy7c67200_ADDR     => CONNECTED_TO_cy7c67200_ADDR,     --            .ADDR
			cy7c67200_RD_N     => CONNECTED_TO_cy7c67200_RD_N,     --            .RD_N
			cy7c67200_WR_N     => CONNECTED_TO_cy7c67200_WR_N,     --            .WR_N
			cy7c67200_CS_N     => CONNECTED_TO_cy7c67200_CS_N,     --            .CS_N
			cy7c67200_RST_N    => CONNECTED_TO_cy7c67200_RST_N,    --            .RST_N
			cy7c67200_INT      => CONNECTED_TO_cy7c67200_INT,      --            .INT
			mouse_click_export => CONNECTED_TO_mouse_click_export, -- mouse_click.export
			mouse_x_export     => CONNECTED_TO_mouse_x_export,     --     mouse_x.export
			mouse_y_export     => CONNECTED_TO_mouse_y_export,     --     mouse_y.export
			reset_reset_n      => CONNECTED_TO_reset_reset_n,      --       reset.reset_n
			sdram_clk_clk      => CONNECTED_TO_sdram_clk_clk,      --   sdram_clk.clk
			sdram_wire_addr    => CONNECTED_TO_sdram_wire_addr,    --  sdram_wire.addr
			sdram_wire_ba      => CONNECTED_TO_sdram_wire_ba,      --            .ba
			sdram_wire_cas_n   => CONNECTED_TO_sdram_wire_cas_n,   --            .cas_n
			sdram_wire_cke     => CONNECTED_TO_sdram_wire_cke,     --            .cke
			sdram_wire_cs_n    => CONNECTED_TO_sdram_wire_cs_n,    --            .cs_n
			sdram_wire_dq      => CONNECTED_TO_sdram_wire_dq,      --            .dq
			sdram_wire_dqm     => CONNECTED_TO_sdram_wire_dqm,     --            .dqm
			sdram_wire_ras_n   => CONNECTED_TO_sdram_wire_ras_n,   --            .ras_n
			sdram_wire_we_n    => CONNECTED_TO_sdram_wire_we_n     --            .we_n
		);

