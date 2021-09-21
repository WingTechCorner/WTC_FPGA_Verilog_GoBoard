/* Top level module for keypad + UART demo */
module top (
    // input hardware clock (12 MHz)
    hwclk, 
    // all LEDs
    led,
    // UART lines
    ftdi_tx, 
    );

    /* Clock input */
    input hwclk;

    /* LED outputs */
    output [1:0] led;

    /* FTDI I/O */
    output ftdi_tx;

    pll_48mhz fastCLK (.clock_in(hwclk), .clock_out(sysclk), .locked(locked)); 

    /* 9600 Hz clock generation (from 12 MHz) */
    reg clk_9600 = 0;
    reg [31:0] cntr_9600 = 32'b0;
    // parameter period_9600 = 625; // if 12mhz clock. 9600 x 625 = 6M... so
    // if the clock is 25Mhz... 
    parameter period_9600 = 1302;

    /* 250000 from 48Mhz PLL */
    reg clk_250          = 0;
    reg [31:0] cntr_250  = 32'b0;
    parameter period_250 = 625;

    /* 1 Hz clock generation (from 12 MHz) */
    reg clk_1 = 0;
    reg [31:0] cntr_1 = 32'b0;
    parameter period_1 = 12500000;

    // Note: could also use "0" or "9" below, but I wanted to
    // be clear about what the actual binary value is.
    parameter ASCII_0  = 8'd48;
    parameter ASCII_1  = 8'd49;
    parameter ASCII_2  = 8'd50;
    parameter ASCII_3  = 8'd51;
    parameter ASCII_4  = 8'd52;
    parameter ASCII_5  = 8'd53;
    parameter ASCII_6  = 8'd54;
    parameter ASCII_7  = 8'd55;
    parameter ASCII_8  = 8'd56;
    parameter ASCII_9  = 8'd57;
    parameter ASCII_LF = 8'd12;
    parameter ASCII_CR = 8'd13;

    /* UART registers */
    reg [7:0] uart_txbyte = ASCII_0;
    reg uart_send;
    wire uart_txed;
    reg reset = 1'b1;

    /* LED register */
    reg ledval = 0;

    /* UART transmitter module designed for
       8 bits, no parity, 1 stop bit. 
    */
    uart_tx_8n1 transmitter (
        // 9600 baud rate clock
        .clk (clk_9600),
        // byte to be transmitted
        .txbyte (uart_txbyte),
        // trigger a UART transmit on baud clock
        .senddata (uart_send),
        // input: tx is finished
        .txdone (uart_txed),
        // output UART tx pin
        .tx (ftdi_tx),
    );

    /* Wiring */
    assign led=ledval;
    
    /* Low speed clock generation */
    always @ (posedge hwclk) begin
        /* generate 9600 Hz clock */
        cntr_9600 <= cntr_9600 + 1;
        if (cntr_9600 == period_9600) begin
            clk_9600 <= ~clk_9600;
            cntr_9600 <= 32'b0;
        end


        /* generate 1 Hz clock */
        cntr_1 <= cntr_1 + 1;
        if (cntr_1 == period_1) begin
            clk_1 <= ~clk_1;
            cntr_1 <= 32'b0;
        end
    end

    always @ (posedge fastCLK ) begin
    /* 250K clock for UART */
        cntr_250 <= cntr_250 + 1;
        if (cntr_250 == period_250) begin
            clk_250 <= ~clk_250;
            cntr_250 <= 32'b0;
        end
    end


    always @ (posedge hwclk) begin
      if ( reset == 1 ) begin
        reset <= 0;
        uart_send <= 1'b1;
        uart_txbyte <= ASCII_0;
        uart_txed = 1'b0;
      end else begin
        case (uart_txed)
          1'b1 : begin
            uart_txed = 0;
            case (uart_txbyte)
              ASCII_9 : begin
                uart_txbyte <= ASCII_LF;
              end
              ASCII_LF : begin
                uart_txbyte <= ASCII_CR;
              end
              ASCII_CR : begin
                uart_txbyte <= ASCII_0;
              end
              ASCII_0 : begin
                uart_txbyte <= ASCII_1;
              end
              ASCII_1 : begin
                uart_txbyte <= ASCII_2;
              end
              ASCII_2 : begin
                uart_txbyte <= ASCII_3;
              end
              ASCII_3 : begin
                uart_txbyte <= ASCII_4;
              end
              ASCII_4 : begin
                uart_txbyte <= ASCII_5;
              end
              ASCII_5 : begin
                uart_txbyte <= ASCII_6;
              end
              ASCII_6 : begin
                uart_txbyte <= ASCII_7;
              end
              ASCII_7 : begin
                uart_txbyte <= ASCII_8;
              end
              ASCII_8 : begin
                uart_txbyte <= ASCII_9;
              end
            endcase
          end
      endcase
    end
    end
endmodule
