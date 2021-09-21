// wing tech corner - 7 segment control library
module wtc_7seg
  (
   input       i_clk,
   input [2:0] i_mode = 0,
   input [3:0] i_binary_num = 4'b0000,
   output      o_segment_a,
   output      o_segment_b,
   output      o_segment_c,
   output      o_segment_d,
   output      o_segment_e,
   output      o_segment_f,
   output      o_segment_g
   );

  reg [31:0]   r_segment_a_period = 1;
  reg [31:0]   r_segment_b_period = 1;
  reg [31:0]   r_segment_c_period = 1;
  reg [31:0]   r_segment_d_period = 1;
  reg [31:0]   r_segment_e_period = 1;
  reg [31:0]   r_segment_f_period = 1;
  reg [31:0]   r_segment_g_period = 1;

  reg [31:0]   r_segment_a_counter = 0;
  reg [31:0]   r_segment_b_counter = 0;
  reg [31:0]   r_segment_c_counter = 0;
  reg [31:0]   r_segment_d_counter = 0;
  reg [31:0]   r_segment_e_counter = 0;
  reg [31:0]   r_segment_f_counter = 0;
  reg [31:0]   r_segment_g_counter = 0;

  reg [6:0]    r_hex_encoding = 7'h00;
  reg [6:0]    r_hex_encoding_state = 7'h00;

  always @(posedge i_clk)
  begin

    // ***************************************************

    // handle segment a 
    if ( r_segment_a_counter > r_segment_a_peripd )
    begin
      r_hex_encoding_state[6] <= ~r_hex_encoding_state[6];
      r_segment_a_counter <= 0;
    end
    else
    begin
      r_segment_a_counter <= r_segment_a_counter + 1;
    end

    // handle segment b 
    if ( r_segment_b_counter > r_segment_b_peripd )
    begin
      r_hex_encoding_state[5] <= ~r_hex_encoding_state[5];
      r_segment_b_counter <= 0;
    end
    else
    begin
      r_segment_b_counter <= r_segment_b_counter + 1;
    end

    // handle segment c 
    if ( r_segment_c_counter > r_segment_c_peripd )
    begin
      r_hex_encoding_state[4] <= ~r_hex_encoding_state[4];
      r_segment_c_counter <= 0;
    end
    else
    begin
      r_segment_c_counter <= r_segment_c_counter + 1;
    end

    // handle segment d 
    if ( r_segment_d_counter > r_segment_d_peripd )
    begin
      r_hex_encoding_state[3] <= ~r_hex_encoding_state[3];
      r_segment_d_counter <= 0;
    end
    else
    begin
      r_segment_d_counter <= r_segment_d_counter + 1;
    end

    // handle segment e 
    if ( r_segment_e_counter > r_segment_e_peripd )
    begin
      r_hex_encoding_state[2] <= ~r_hex_encoding_state[2];
      r_segment_e_counter <= 0;
    end
    else
    begin
      r_segment_e_counter <= r_segment_e_counter + 1;
    end

    // handle segment f 
    if ( r_segment_f_counter > r_segment_f_peripd )
    begin
      r_hex_encoding_state[1] <= ~r_hex_encoding_state[1];
      r_segment_f_counter <= 0;
    end
    else
    begin
      r_segment_f_counter <= r_segment_f_counter + 1;
    end

    // handle segment g 
    if ( r_segment_g_counter > r_segment_g_peripd )
    begin
      r_hex_encoding_state[0] <= ~r_hex_encoding_state[0];
      r_segment_g_counter <= 0;
    end
    else
    begin
      r_segment_g_counter <= r_segment_g_counter + 1;
    end

    // ***************************************************

    r_segment_a <= r_hex_encoding_state[6];
    r_segment_b <= r_hex_encoding_state[5];
    r_segment_c <= r_hex_encoding_state[4];
    r_segment_d <= r_hex_encoding_state[3];
    r_segment_e <= r_hex_encoding_state[2];
    r_segment_f <= r_hex_encoding_state[1];
    r_segment_g <= r_hex_encoding_state[0];
  end


endmodule // binary_to_7segment
