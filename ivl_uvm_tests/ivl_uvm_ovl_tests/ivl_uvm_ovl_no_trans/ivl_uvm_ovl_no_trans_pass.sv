`timescale 1ns/1ns

module test;

   wire clk;
   reg rst_n;
   
reg count, start_s, next_s, sig_1;

	
	 logic [7:0] arb_gnt_vec;

	 initial begin
		 $dumpfile("dump.vcd");
		 $dumpvars(0,test);
	 end
  
   ovl_no_transition no_trans ( .clock (clk),.reset(rst_n),.enable (1'b1),.test_expr (count),.start_state(start_s),.next_state(next_s));
   ovl_no_transition sign ( .clock (clk),.reset(rst_n),.enable (1'b1),.test_expr (sig_1),.start_state(start_s),.next_state(next_s));

   // use function
  ovl_no_transition u_ovl_a_fn ( 
			     .clock     (clk),
			     .reset     (rst_n), 
			     .enable    (1'b1),
			     .test_expr ( ($countones (arb_gnt_vec) <= 1)),
			     .start_state(start_s),
			     .next_state(next_s)
			     );

   initial begin
      // Dump waves
      //$dumpfile("dump.vcd");
      //$dumpvars(1, test);

  //Initialized value
  		rst_n=0;
		arb_gnt_vec=0;
		start_s=1;
		next_s=0;
		sig_1=0;
		count=0;
		$display("Initialization");
		sig_1=1;
		wait_clks(5);
		rst_n=1;
		wait_clks(5);
		sig_1=1;
		$display("Out of reset");
		count=1;
		wait_clks(5);
		$display("signal value is high");
		//count=next_s;
		wait_clks(10);
		$finish;
	end

   task wait_clks (input int num_clks = 1);
      repeat (num_clks) @(posedge clk);
   endtask : wait_clks

  ivl_uvm_ovl_clk_gen #(.FREQ_IN_MHZ(100)) u_clk_100 (clk);

endmodule



