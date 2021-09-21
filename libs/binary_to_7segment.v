/*
based on file originally downloaded from http://www.nandland.com

modified to add additional display modes.  - wing tech corner

*/

module binary_to_7segment 
  (
   input       i_clk,
   input [1:0] i_mode = 0,
   input [3:0] i_binary_num,
   output      o_segment_a,
   output      o_segment_b,
   output      o_segment_c,
   output      o_segment_d,
   output      o_segment_e,
   output      o_segment_f,
   output      o_segment_g
   );
 
  reg [6:0]    r_hex_encoding = 7'h00;
   
  // purpose: creates a case statement for all possible input binary numbers.
  // drives r_hex_encoding appropriately for each input combination.
  always @(posedge i_clk)
    begin
      case (i_mode)
        2'b00 : begin
          case (i_binary_num)
            4'b0000 : r_hex_encoding <= 7'h7e; // 0
            4'b0001 : r_hex_encoding <= 7'h30; // 1
            4'b0010 : r_hex_encoding <= 7'h6d; // 2
            4'b0011 : r_hex_encoding <= 7'h79; // 3
            4'b0100 : r_hex_encoding <= 7'h33; // 4 
            4'b0101 : r_hex_encoding <= 7'h5b; // 5
            4'b0110 : r_hex_encoding <= 7'h5f; // 6
            4'b0111 : r_hex_encoding <= 7'h70; // 7
            4'b1000 : r_hex_encoding <= 7'h7f; // 8
            4'b1001 : r_hex_encoding <= 7'h7b; // 9
            4'b1010 : r_hex_encoding <= 7'h77; // a
            4'b1011 : r_hex_encoding <= 7'h1f; // b
            4'b1100 : r_hex_encoding <= 7'h4e; // c
            4'b1101 : r_hex_encoding <= 7'h3d; // d
            4'b1110 : r_hex_encoding <= 7'h4f; // e
            4'b1111 : r_hex_encoding <= 7'h47; // f
          endcase
        end
        2'b01 : begin
          case (i_binary_num)
            4'b0000 : r_hex_encoding <= 7'h7e; // 0
            4'b0001 : r_hex_encoding <= 7'h30; // 1
            4'b0010 : r_hex_encoding <= 7'h6d; // 2
            4'b0011 : r_hex_encoding <= 7'h79; // 3
            4'b0100 : r_hex_encoding <= 7'h33; // 4 
            4'b0101 : r_hex_encoding <= 7'h5b; // 5
            4'b0110 : r_hex_encoding <= 7'h5f; // 6
            4'b0111 : r_hex_encoding <= 7'h70; // 7
            4'b1000 : r_hex_encoding <= 7'h7f; // 8
            4'b1001 : r_hex_encoding <= 7'h7b; // 9
            default : r_hex_encoding <= 7'h00; // nothing
          endcase
        end
        2'b10 : begin
          case (i_binary_num)
            4'b0000 : r_hex_encoding <= 7'h7e; // 0
            4'b0010 : r_hex_encoding <= 7'h6d; // 2
            4'b0100 : r_hex_encoding <= 7'h33; // 4 
            4'b0110 : r_hex_encoding <= 7'h5f; // 6
            4'b1000 : r_hex_encoding <= 7'h7f; // 8
            default : r_hex_encoding <= i_binary_num; // nothing
          endcase
        end
        2'b11 : begin
          case (i_binary_num)
            4'b0000 : r_hex_encoding <= 7'b1000000; // 0
            4'b0001 : r_hex_encoding <= 7'b1100000; // 0
            4'b0010 : r_hex_encoding <= 7'b0100000; // 0
            4'b0011 : r_hex_encoding <= 7'b0110000; // 0
            4'b0100 : r_hex_encoding <= 7'b0010000; // 0
            4'b0101 : r_hex_encoding <= 7'b0011000; // 0
            4'b0110 : r_hex_encoding <= 7'b0001000; // 0
            4'b0111 : r_hex_encoding <= 7'b0001100; // 0
            4'b1000 : r_hex_encoding <= 7'b0000100; // 0
            4'b1001 : r_hex_encoding <= 7'b0000110; // 0
            4'b1010 : r_hex_encoding <= 7'b0000010; // 0
            4'b1011 : r_hex_encoding <= 7'b0000010; // 0
            4'b1100 : r_hex_encoding <= 7'b1000000; // 0
            4'b1101 : r_hex_encoding <= 7'b1000000; // 0
            4'b1110 : r_hex_encoding <= 7'b1100000; // 0
            4'b1111 : r_hex_encoding <= 7'b0100000; // 0
            default : r_hex_encoding <= 7'b0110000; // nothing
          endcase
        end
      endcase
    end // always @ (posedge i_clk)
 
  // r_hex_encoding[7] is unused
  assign o_segment_a = r_hex_encoding[6];
  assign o_segment_b = r_hex_encoding[5];
  assign o_segment_c = r_hex_encoding[4];
  assign o_segment_d = r_hex_encoding[3];
  assign o_segment_e = r_hex_encoding[2];
  assign o_segment_f = r_hex_encoding[1];
  assign o_segment_g = r_hex_encoding[0];
 
endmodule // binary_to_7segment
