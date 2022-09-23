`timescale 1ns/1ns
module test;

   	wire clk;
   	reg rst_n;
   
	reg count, max, min, sig_1;

	initial
	begin
		$dumpfile("dump.vcd");
		$dumpvars(0, test);
	end
	
ovl_no_overflow  no_over(.clock(clk), .reset(rst_n), .enable(1'b1), .test_expr(count));
ovl_no_overflow u_ovl_a_fn ( 
			     .clock     (clk),
			     .reset     (rst_n), 
			     .enable    (1'b1),
			     .test_expr ( ($countones (arb_gnt_vec) <= 1))
			     );
		     //end

initial begin
      

// Initialize values
	 rst_n=0;
	count=0;
	$display("ovl_always does not fire at rst_n");
wait_clks(5);
	rst_n=1;
	 $display("Out of reset");
	count=1;
	//wait_clks(1);
	//count=0;
wait_clks(10);

$finish;
end

	



task wait_clks (input int num_clks = 1);
      repeat (num_clks) @(posedge clk);
   endtask : wait_clks

  ivl_uvm_ovl_clk_gen #(.FREQ_IN_MHZ(100)) u_clk_100 (clk);

endmodule
