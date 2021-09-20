/*
  * Verilog module to run some tests against the GoBoard to generate responses
  * from the two 7-segment LED Displays
  *
*/
module top
  (input i_Clk,
   input io_PMOD_1_clk,
   input i_Switch_1,  
   input i_Switch_2,
   input i_Switch_3,
   input i_Switch_4,
   output o_LED_1,
   output o_LED_2,
   output o_LED_3,
   output o_LED_4,
   output o_Segment1_A,
   output o_Segment1_B,
   output o_Segment1_C,
   output o_Segment1_D,
   output o_Segment1_E,
   output o_Segment1_F,
   output o_Segment1_G,
   output o_Segment2_A,
   output o_Segment2_B,
   output o_Segment2_C,
   output o_Segment2_D,
   output o_Segment2_E,
   output o_Segment2_F,
   output o_Segment2_G
 );
   
  reg r_LED_1 = 1'b0;
  reg r_Switch_1 = 1'b0;
  reg r_Switch_2 = 1'b0;
  reg [7:0] r_Count = 8'b00000000;
  reg [31:0] ticks  = 0;
  reg [31:0] period = 500000;

  reg [63:0] mhz_counter ;
  reg [63:0] khz_counter ;
  reg [63:0] hz_counter  ;

  wire w_Segment1_A;
  wire w_Segment1_B;
  wire w_Segment1_C;
  wire w_Segment1_D;
  wire w_Segment1_E;
  wire w_Segment1_F;
  wire w_Segment1_G;
  
  wire w_Segment2_A;
  wire w_Segment2_B;
  wire w_Segment2_C;
  wire w_Segment2_D;
  wire w_Segment2_E;
  wire w_Segment2_F;
  wire w_Segment2_G;


  // Setup clock counters ( timers? )
  clk_cnt mhz_clock(.in_sys_clk( i_Clk ), .in_ext_clk(io_PMOD_1_clk), .in_reset(reset_clocks), .in_period(25),       .out_output(mhz_counter));
  clk_cnt khz_clock(.in_sys_clk( i_Clk ), .in_ext_clk(io_PMOD_1_clk), .in_reset(reset_clocks), .in_period(25000),    .out_output(khz_counter));
  clk_cnt hz_clock(.in_sys_clk( i_Clk ),  .in_ext_clk(io_PMOD_1_clk), .in_reset(reset_clocks), .in_period(25000000), .out_output(hz_counter));

  // Debounce switch inputs
  Debounce_Switch Debounce_Inst_1 (.i_Clk(i_Clk), .i_Switch(i_Switch_1), .o_Switch(w_Switch_1));
  Debounce_Switch Debounce_Inst_2 (.i_Clk(i_Clk), .i_Switch(i_Switch_2), .o_Switch(w_Switch_2));

  always @(posedge i_Clk)
  begin
    r_Switch_1 <= i_Switch_1;
    r_Switch_2 <= i_Switch_2;

    if ( ticks > period ) begin
      r_Count <= r_Count + 1;
      ticks <= 0;
    end
    else begin
      ticks <= ticks + 1;
    end

    if ( i_Switch_1 == 1'b0 && r_Switch_1 == 1'b1 )
    begin
      r_LED_1 <= ~r_LED_1;
      if ( r_Count == 99 ) begin
        r_Count <= 0;
      end
      else begin
        r_Count <= r_Count + 1;
      end 
    end


    if ( i_Switch_2 == 1'b0 && r_Switch_2 == 1'b1 )
    begin
      r_LED_1 <= ~r_LED_1;
      if ( r_Count == 0 ) begin
        r_Count <= 99;
      end
      else begin
        r_Count <= r_Count - 1;
      end
    end
  end

assign o_LED_1 = r_LED_1;
assign o_LED_2 = i_Switch_2;
assign o_LED_3 = i_Switch_3;
assign o_LED_4 = i_Switch_4;

//  Binary_To_7Segment Inst1
  wtc_7seg Inst1
    (.i_Clk(i_Clk),
     .i_mode(2'b11),
     .i_Binary_Num(r_Count[7:4]),
     .o_Segment_A(w_Segment1_A),
     .o_Segment_B(w_Segment1_B),
     .o_Segment_C(w_Segment1_C),
     .o_Segment_D(w_Segment1_D),
     .o_Segment_E(w_Segment1_E),
     .o_Segment_F(w_Segment1_F),
     .o_Segment_G(w_Segment1_G)
     );

//  Binary_To_7Segment Inst2
  wtc_7seg Inst2
    (.i_Clk(i_Clk),
     .i_mode(2'b11),
     .i_Binary_Num(r_Count[3:0]),
     .o_Segment_A(w_Segment2_A),
     .o_Segment_B(w_Segment2_B),
     .o_Segment_C(w_Segment2_C),
     .o_Segment_D(w_Segment2_D),
     .o_Segment_E(w_Segment2_E),
     .o_Segment_F(w_Segment2_F),
     .o_Segment_G(w_Segment2_G)
     );

  assign o_Segment1_A = ~w_Segment1_A;
  assign o_Segment1_B = ~w_Segment1_B;
  assign o_Segment1_C = ~w_Segment1_C;
  assign o_Segment1_D = ~w_Segment1_D;
  assign o_Segment1_E = ~w_Segment1_E;
  assign o_Segment1_F = ~w_Segment1_F;
  assign o_Segment1_G = ~w_Segment1_G;

  assign o_Segment2_A = ~w_Segment2_A;
  assign o_Segment2_B = ~w_Segment2_B;
  assign o_Segment2_C = ~w_Segment2_C;
  assign o_Segment2_D = ~w_Segment2_D;
  assign o_Segment2_E = ~w_Segment2_E;
  assign o_Segment2_F = ~w_Segment2_F;
  assign o_Segment2_G = ~w_Segment2_G;

endmodule
