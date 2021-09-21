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

  reg MHZ = 1;
  reg KHZ = 2;
  reg HZ  = 3;
  reg [3:0] r_display_mode = HZ;
  reg [6:0] r_display_dummy = 1;
  reg [7:0] r_digits = 8'b00000000;
  reg [7:0] r_display_value =0;
  reg [63:0] r_mhz_counter ;
  reg [63:0] r_khz_counter ;
  reg [63:0] r_hz_counter  ;

  wire i_Clk;
  wire io_PMOD_1_clk;
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
  clk_cnt mhz_clock(.in_sys_clk( i_Clk ), .in_ext_clk(io_PMOD_1_clk), .in_reset(reset_clocks), .in_period(25),       .out_output(r_mhz_counter));
  clk_cnt khz_clock(.in_sys_clk( i_Clk ), .in_ext_clk(io_PMOD_1_clk), .in_reset(reset_clocks), .in_period(25000),    .out_output(r_khz_counter));
  clk_cnt hz_clock(.in_sys_clk( i_Clk ),  .in_ext_clk(i_Clk), .in_reset(reset_clocks), .in_period(25000000), .out_output(r_hz_counter));

  always @(posedge i_Clk)
  begin
    case (r_display_mode)
      MHZ : 
      begin
        if ( r_mhz_counter > 99 ) begin
          r_display_value = 0;
        end
        else
        begin
          r_display_value = r_mhz_counter;
        end
      end

      KHZ :
      begin
        if ( r_khz_counter > 99 ) begin
          r_display_value = 0;
        end
        else
        begin
          r_display_value = r_khz_counter;
        end
      end

      HZ  : 
      begin
        if ( r_hz_counter > 99 ) begin
          r_display_value = 0;
        end
        else
        begin
          r_display_value = r_hz_counter;
        end
      end

      default : 
      begin
        begin
          r_display_value = r_display_dummy;
        end
      end
    endcase
  end

//  Binary_To_7Segment Inst1
  Binary_To_7Segment Inst1
    (.i_Clk(i_Clk),
     .i_mode(2'b01),
     .i_Binary_Num(r_display_value[7:4]),
     .o_Segment_A(w_Segment1_A),
     .o_Segment_B(w_Segment1_B),
     .o_Segment_C(w_Segment1_C),
     .o_Segment_D(w_Segment1_D),
     .o_Segment_E(w_Segment1_E),
     .o_Segment_F(w_Segment1_F),
     .o_Segment_G(w_Segment1_G)
     );

//  Binary_To_7Segment Inst2
  Binary_To_7Segment Inst2
    (.i_Clk(i_Clk),
     .i_mode(2'b00),
     .i_Binary_Num(r_display_value[3:0]),
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
