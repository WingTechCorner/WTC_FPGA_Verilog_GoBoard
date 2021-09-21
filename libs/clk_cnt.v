module clk_cnt (input in_sys_clk, input in_ext_clk, input in_reset, input in_period ,output out_output);

  wire sys_clk;
  wire ext_clk;
  wire reset;
  wire [31:0] period;

  reg [63:0] ext_ticks, sys_ticks, out_counter;

  // tick out_counters for both internal and external clock
  always @(posedge sys_clk)
  begin
    sys_ticks = sys_ticks + 1;
  end

  always @(posedge ext_clk)
  begin
    ext_ticks = ext_ticks + 1;
  end

  // when sys_ticks is above the provided period,
  //
  always @(posedge sys_clk)
  begin
    if ( reset == high)
    begin
      out_counter = 0;
      ext_ticks = 0;
      sys_ticks = 0;
    end

    else

    begin

      if ( sys_ticks == period )
      begin
        out_counter = ext_ticks;
      end

      if ( sys_ticks > period )
      begin
        ext_ticks = 0;
        sys_ticks = 0;
      end
    end
  end

endmodule
