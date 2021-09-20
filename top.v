/*
  * Verilog module to run some tests against the GoBoard to generate responses
  * from the two 7-segment LED Displays
  *
*/
module top
  (
   input i_Clk,

   input i_Switch_1,  
   input i_Switch_2,
   input i_Switch_3,
   input i_Switch_4,

   output o_LED_1,
   output o_LED_2,
   output o_LED_3,
   output o_LED_4,

   output io_PMOD_1,  /* SPI_MISO */
   output io_PMOD_2,  /* SPI_CS */
   output io_PMOD_3,  /* SPI_MOSI */
   output io_PMOD_4,  /* SPI_CLK */

   output io_PMOD_7,
   output io_PMOD_8,
   output io_PMOD_9,
   output io_PMOD_10,
 );
  
 // Instantiate an SPI Master for the OLED Module
 // Using Nandland's SPI-Master
 SPI_Master oled ( 
   .i_Rst_L(    rst ),
   .i_Clk(      i_clk ),
   .i_TX_Byte(  spi_data_out ),
   .i_TX_DV(    spi_data_out_valid ),
   .o_TX_Ready( spi_tx_ready ),
   .o_RX_DV(    spi_data_in_valid ),
   .o_RX_Byte(  spi_data_in ),
   .o_SPI_Clk(  spi_clk ),
   .i_SPI_MISO( spi_miso ),
   .o_SPI_MOSI( spi_mosi ),
 );

  wire i_clk;
  wire rst = 0;
  reg  [7:0] spi_data_out = 7'b00000000;
  reg  spi_data_out_valid = 0;
  reg  spi_data_in_valid = 0;
  reg  spi_tx_ready = 0;
  reg  [7:0] spi_data_in;
  reg  spi_clk;
  reg  spi_miso;
  wire spi_mosi;

  reg o_LED_1=0;
  reg o_LED_2=0;
  reg o_LED_3=0;
  reg o_LED_4=0;

  assign spi_miso = io_PMOD_1;
  assign io_PMOD_2 = 1;
  assign io_PMOD_3 = spi_mosi;
  assign io_PMOD_4 = spi_clk;

  reg [7:0] state = 0;

  always @(posedge i_clk)
  begin
    case (state)
      // set command to be display turn on
      0 : begin
        spi_data_out <= 8'hA5; 
        state <= state + 1;
        o_LED_1 <= 1;
      end

      // Send the command
      5 : begin
        if ( spi_tx_ready == 1 ) begin
          spi_data_out_valid <= 1;
          state <= state + 1;
          o_LED_2 <= 1;
        end
        else
        begin
          o_LED_2 <= 0;
        end
      end
    
      // Display on
      50 : begin
        spi_data_out <= 8'hAF; 
        state <= state + 1;
        o_LED_1 <= 1;
        o_LED_2 <= 1;
        o_LED_3 <= 1;
      end

      // Send the command
      100 : begin
        if ( spi_tx_ready == 1 ) begin
          spi_data_out_valid <= 1;
          state <= state + 1;
          o_LED_2 <= 1;
        end
        else
        begin
          o_LED_2 <= 0;
        end
      end

      // hold
      7'b11111111 : begin
        state <= 7'b11111111;
      end

      default : begin
        state <= state + 1;
      end
    endcase
  end

  endmodule
