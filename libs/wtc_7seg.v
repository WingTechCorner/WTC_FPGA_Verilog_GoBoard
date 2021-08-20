// Wing Tech Corner - 7 segment control library
module wtc_7seg
  (
   input       i_Clk,
   input [2:0] i_mode = 0,
   input [3:0] i_Binary_Num = 4'b0000,
   output      o_Segment_A,
   output      o_Segment_B,
   output      o_Segment_C,
   output      o_Segment_D,
   output      o_Segment_E,
   output      o_Segment_F,
   output      o_Segment_G
   );

  reg [31:0]   r_Segment_A_period = 1;
  reg [31:0]   r_Segment_B_period = 1;
  reg [31:0]   r_Segment_C_period = 1;
  reg [31:0]   r_Segment_D_period = 1;
  reg [31:0]   r_Segment_E_period = 1;
  reg [31:0]   r_Segment_F_period = 1;
  reg [31:0]   r_Segment_G_period = 1;

  reg [31:0]   r_Segment_A_counter = 0;
  reg [31:0]   r_Segment_B_counter = 0;
  reg [31:0]   r_Segment_C_counter = 0;
  reg [31:0]   r_Segment_D_counter = 0;
  reg [31:0]   r_Segment_E_counter = 0;
  reg [31:0]   r_Segment_F_counter = 0;
  reg [31:0]   r_Segment_G_counter = 0;

  reg [6:0]    r_Hex_Encoding = 7'h00;
  reg [6:0]    r_Hex_Encoding_state = 7'h00;

  always @(posedge i_Clk)
  begin

    // ***************************************************

    // Handle Segment A 
    if ( r_Segment_A_counter > r_Segment_A_peripd )
    begin
      r_Hex_Encoding_state[6] <= ~r_Hex_Encoding_state[6];
      r_Segment_A_counter <= 0;
    end
    else
    begin
      r_Segment_A_counter <= r_Segment_A_counter + 1;
    end

    // Handle Segment B 
    if ( r_Segment_B_counter > r_Segment_B_peripd )
    begin
      r_Hex_Encoding_state[5] <= ~r_Hex_Encoding_state[5];
      r_Segment_B_counter <= 0;
    end
    else
    begin
      r_Segment_B_counter <= r_Segment_B_counter + 1;
    end

    // Handle Segment C 
    if ( r_Segment_C_counter > r_Segment_C_peripd )
    begin
      r_Hex_Encoding_state[4] <= ~r_Hex_Encoding_state[4];
      r_Segment_C_counter <= 0;
    end
    else
    begin
      r_Segment_C_counter <= r_Segment_C_counter + 1;
    end

    // Handle Segment D 
    if ( r_Segment_D_counter > r_Segment_D_peripd )
    begin
      r_Hex_Encoding_state[3] <= ~r_Hex_Encoding_state[3];
      r_Segment_D_counter <= 0;
    end
    else
    begin
      r_Segment_D_counter <= r_Segment_D_counter + 1;
    end

    // Handle Segment E 
    if ( r_Segment_E_counter > r_Segment_E_peripd )
    begin
      r_Hex_Encoding_state[2] <= ~r_Hex_Encoding_state[2];
      r_Segment_E_counter <= 0;
    end
    else
    begin
      r_Segment_E_counter <= r_Segment_E_counter + 1;
    end

    // Handle Segment F 
    if ( r_Segment_F_counter > r_Segment_F_peripd )
    begin
      r_Hex_Encoding_state[1] <= ~r_Hex_Encoding_state[1];
      r_Segment_F_counter <= 0;
    end
    else
    begin
      r_Segment_F_counter <= r_Segment_F_counter + 1;
    end

    // Handle Segment G 
    if ( r_Segment_G_counter > r_Segment_G_peripd )
    begin
      r_Hex_Encoding_state[0] <= ~r_Hex_Encoding_state[0];
      r_Segment_G_counter <= 0;
    end
    else
    begin
      r_Segment_G_counter <= r_Segment_G_counter + 1;
    end

    // ***************************************************

    r_Segment_A <= r_Hex_Encoding_state[6];
    r_Segment_B <= r_Hex_Encoding_state[5];
    r_Segment_C <= r_Hex_Encoding_state[4];
    r_Segment_D <= r_Hex_Encoding_state[3];
    r_Segment_E <= r_Hex_Encoding_state[2];
    r_Segment_F <= r_Hex_Encoding_state[1];
    r_Segment_G <= r_Hex_Encoding_state[0];
  end


endmodule // Binary_To_7Segment
