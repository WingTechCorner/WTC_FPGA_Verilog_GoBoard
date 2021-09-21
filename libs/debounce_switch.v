///////////////////////////////////////////////////////////////////////////////
// file downloaded from http://www.nandland.com
///////////////////////////////////////////////////////////////////////////////
// this module is used to debounce any switch or button coming into the fpga.
// does not allow the output of the switch to change unless the switch is
// steady for enough time (not toggling).
///////////////////////////////////////////////////////////////////////////////
module debounce_switch (input i_clk, input i_switch, output o_switch);
 
  parameter c_debounce_limit = 250000;  // 10 ms at 25 mhz
   
  reg [17:0] r_count = 0;
  reg r_state = 1'b0;
 
  always @(posedge i_clk)
  begin
    // switch input is different than internal switch value, so an input is
    // changing.  increase the counter until it is stable for enough time.  
    if (i_switch !== r_state && r_count < c_debounce_limit)
      r_count <= r_count + 1;
 
    // end of counter reached, switch is stable, register it, reset counter
    else if (r_count == c_debounce_limit)
    begin
      r_state <= i_switch;
      r_count <= 0;
    end 
 
    // switches are the same state, reset the counter
    else
      r_count <= 0;
  end
 
  // assign internal register to output (debounced!)
  assign o_switch = r_state;
 
endmodule
