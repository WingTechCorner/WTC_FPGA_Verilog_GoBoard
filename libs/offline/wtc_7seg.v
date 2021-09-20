// Wing Tech Corner - 7 segment control library
module wtc_7seg
  (
   input  i_Clk,
   input  [2:0]  i_mode       = 3'b000,
   input  [4:0]  i_value      = 5'b00000,
   output [6:0]  o_7segment   = 7'b0000000,
   );

  // For determining 
  reg [31:0]  period  = 1200;
  reg [31:0]  counter = 0;
  reg [3:0]   mode    = 0;

  // Modes:
  // 000 => set the display mode using i_value
  // 001 => RESET
  // 110 => set the brightness period divisor
  // 111 => set the brightness period divisor

  always @(posedge i_Clk)
  begin
    case (i_mode)

      3'b000 : begin
        // Default case, set the mode of display.
        // Uses the first 4 bits to set the mode.
        mode <= i_value[3:0];
      end

      3'b001 : begin
        // Reset
        period    <= 1200;
        count     <= 0;
        mode      <= 0;
      end

      3'b010      : begin
        // Default case, set the digit
        case      ( i_value )
          4'b000  : begin
          end
          default : begin
          end
        endcase
      end

      3'b001      : begin
        // Default case, set the digit
        case      ( i_value )
          4'b000  : begin
          end
          default : begin
          end
        endcase
      end

      3'b011      : begin
        // Default case, set the digit
        case      ( i_value )
          4'b000  : begin
          end
          default : begin
          end
        endcase
      end

      3'b101      : begin
        // Default case, set the digit
        case ( i_value )
          4'b000 : begin
          end
          default : begin
          end
        endcase
      end

      3'b110 : begin
        // Default case, set the digit
        case ( i_value )
          4'b000 : begin
          end
          default : begin
          end
        endcase
      end

      3'b101 : begin
        // Default case, set the digit
        case ( i_value )
          4'b000 : begin
          end
          default : begin
          end
        endcase
      end

      3'b111 : begin
        // Set the period value with the input value as the divisor
        period <= CLOCKSPEED >>> i_value;
      end
    endcase
  end


endmodule // Binary_To_7Segment
