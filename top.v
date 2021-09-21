module    top
(
    input i_clk,
    input io_pmod_1_clk,
    input i_switch_1,
    input i_switch_2,
    input i_switch_3,
    input i_switch_4,
   output o_led_1,
   output o_led_2,
   output o_led_3,
   output o_led_4,
   output o_segment1_a,
   output o_segment1_b,
   output o_segment1_c,
   output o_segment1_d,
   output o_segment1_e,
   output o_segment1_f,
   output o_segment1_g,
   output o_segment2_a,
   output o_segment2_b,
   output o_segment2_c,
   output o_segment2_d,
   output o_segment2_e,
   output o_segment2_f,
   output o_segment2_g
);


  // connections and registers
  wire w_clk;
  wire w_pmod_1_clk;
  wire w_extclk;

  wire w_led_1;
  wire w_led_2;
  wire w_led_3;
  wire w_led_4;

  wire w_switch_1;
  wire w_switch_2;
  wire w_switch_3;
  wire w_switch_4;

  wire r_switch_1;
  wire r_switch_2;
  wire r_switch_3;
  wire r_switch_4;

  wire w_segment1_a;
  wire w_segment1_b;
  wire w_segment1_c;
  wire w_segment1_d;
  wire w_segment1_e;
  wire w_segment1_f;
  wire w_segment1_g;
  
  wire w_segment2_a;
  wire w_segment2_b;
  wire w_segment2_c;
  wire w_segment2_d;
  wire w_segment2_e;
  wire w_segment2_f;
  wire w_segment2_g;

  reg [31:0] period = 0;
  reg [3:0] r_left_digit, r_right_digit;

  // module debounce_switch (input i_clk, input i_switch, output o_switch);
  debounce_switch sw1( .i_clk( i_clk ), .i_switch( w_switch1 ), .o_switch( r_switch_1 ));
  debounce_switch sw2( .i_clk( i_clk ), .i_switch( w_switch2 ), .o_switch( r_switch_2 ));
  debounce_switch sw3( .i_clk( i_clk ), .i_switch( w_switch3 ), .o_switch( r_switch_3 ));
  debounce_switch sw4( .i_clk( i_clk ), .i_switch( w_switch4 ), .o_switch( r_switch_4 ));

  always @(posedge w_clk)
  begin
    if ( period > 12000000 )
      begin
        r_left_digit = r_left_digit + 1;
      end
  end

  // processing 7 segment display updates
  binary_to_7segment m_left_digit(
    .i_clk( i_clk ),
    .i_mode( 0 ),
    .i_binary_num( r_left_digit ),
    .o_segment_a(w_segment1_a),
    .o_segment_b(w_segment1_b),
    .o_segment_c(w_segment1_c),
    .o_segment_d(w_segment1_d),
    .o_segment_e(w_segment1_e),
    .o_segment_f(w_segment1_f),
    .o_segment_g(w_segment1_g)
   );

  binary_to_7segment m_right_digit(
    .i_clk( i_clk ),
    .i_mode( 0 ),
    .i_binary_num( r_right_digit ),
    .o_segment_a(w_segment2_a),
    .o_segment_b(w_segment2_b),
    .o_segment_c(w_segment2_c),
    .o_segment_d(w_segment2_d),
    .o_segment_e(w_segment2_e),
    .o_segment_f(w_segment2_f),
    .o_segment_g(w_segment2_g)
   );



  // assigning connections
  assign w_clk        = i_clk;
  assign i_extclk     = io_pmod_1_clk;

	assign w_switch_1   = i_switch_1;
	assign w_switch_2   = i_switch_1;
	assign w_switch_3   = i_switch_1;
	assign w_switch_4   = i_switch_1;
	assign o_led_1      = w_led_1;
	assign o_led_2      = w_led_1;
	assign o_led_3      = w_led_1;
	assign o_led_4      = w_led_1;

  assign o_segment1_a = ~w_segment1_a;
  assign o_segment1_b = ~w_segment1_b;
  assign o_segment1_c = ~w_segment1_c;
  assign o_segment1_d = ~w_segment1_d;
  assign o_segment1_e = ~w_segment1_e;
  assign o_segment1_f = ~w_segment1_f;
  assign o_segment1_g = ~w_segment1_g;
  assign o_segment2_a = ~w_segment2_a;
  assign o_segment2_b = ~w_segment2_b;
  assign o_segment2_c = ~w_segment2_c;
  assign o_segment2_d = ~w_segment2_d;
  assign o_segment2_e = ~w_segment2_e;
  assign o_segment2_f = ~w_segment2_f;
  assign o_segment2_g = ~w_segment2_g;

endmodule
