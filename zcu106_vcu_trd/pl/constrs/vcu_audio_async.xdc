#set_clock_groups -name clk_pl_async -asynchronous -group [get_clocks clk_out1_vcu_audio_clk_wiz_1_0] -group [get_clocks clk_pl_0]
set_clock_groups -asynchronous -group [get_clocks clk_pl_2] -group [get_clocks clk_pl_0]
set_clock_groups -asynchronous -group [get_clocks clk_out1_vcu_audio_clk_wiz_0_1] -group [get_clocks clk_pl_0]
