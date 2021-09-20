/*
 * SPI Communicatin Libraries
 * Author: Wing Tang Wong / Wing Tech Corner
 * Initial Date: 2021-08-21
 *
 *
 *
 *
 *
 */

module wtc_spi_ssd1306_oled
  (
   input   i_clk,    // System clock
   input   i_cmd,    // command
   input   i_dmode,  // data mode
   input   i_data,   // data to accompany command
   input   o_data,   // data returned to system
   inout   i_miso,   // Data In from Slave to Master
   output  o_sclk,   // Master Clock out to the slave
   output  o_mosi,   // Data out from Master to the Slave
   output  o_ss_ = 1 // Chip select is ACTIVE LOW, so should default to 1
   );

   // Various SPI Modes ( 0, 1, 2, 3 )
   // Clock Polarity
   // CPOL = 0  :: LOW idle, HIGH active
   // CPOL = 1  :: HIGH idle, LOW active
   // SS        :: HIGH idle, LOW active
   // Clock Edge
   // CPHA = 0  :: sample data in middle between transitions
   // CPHA = 1  :: sample data on clock edge 

   // Default to Mode 0, read data on rising edge, write data on falling edge
   reg  r_CPOL = 0;
   reg  r_CPHA = 0;

   reg  r_byte_in  = 8b'00000000;
   reg  r_byte_out = 8b'00000000;

   wire i_clk;
   wire i_cmd;
   wire i_data;
   wire i_miso;
   reg  o_data;
   reg  o_mosi;
   reg  o_sclk;
   reg  o_ss_;




