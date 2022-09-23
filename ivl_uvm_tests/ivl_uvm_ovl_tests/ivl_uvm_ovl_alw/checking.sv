
`timescale 1ns/1ns

module test;

   wire clk;
   reg rst_n;
   reg alw_high_sig;
logic width=3;
logic max=4, min=0;
  
	 //logic wr_val, wr_done;
	 logic [7:0] arb_gnt_vec;

   // Check max value is not equal to min value in next clock
   ovl_no_overflow _valid ( 
			     .clock     (clk),
			     .reset     (rst_n), 
			     .enable    (1'b1),
     			     .test_expr (!(max|=>min))
			     );

   // check max value is not greater then max value in next clock
   ovl_no_overflow u_ovl_always ( 
			     .clock     (clk),
			     .reset     (rst_n), 
			     .enable    (1'b1),
                             .test_expr (!(max|=> > max))
			     );

   // use function
   ovl_no_overflow u_ovl_a_fn ( 
			     .clock     (clk),
			     .reset     (rst_n), 
			     .enable    (1'b1),
			     .test_expr ( ($countones (arb_gnt_vec) <= 1))
			     );

   initial begin
      // Dump waves
      $dumpfile("dump.vcd");
      $dumpvars(1, test);

      // Initialize values.
      rst_n = 0;
      alw_high_sig = 0;
			arb_gnt_vec = 0;
			wr_val = 0;
			wr_done = 1;

      $display("ovl_always does not fire at rst_n");
      alw_high_sig = 1;
      wait_clks(5);

      rst_n = 1;
      wait_clks(5);
      $display("Out of reset");

      alw_high_sig = 1;
      $display({"ovl_always does not fire ",
                "when alw_high_sig is FALSE"});

      wait_clks(10);

      $finish;
   end

   task wait_clks (input int num_clks = 1);
      repeat (num_clks) @(posedge clk);
   endtask : wait_clks

  ivl_uvm_ovl_clk_gen #(.FREQ_IN_MHZ(100)) u_clk_100 (clk);

endmodule


