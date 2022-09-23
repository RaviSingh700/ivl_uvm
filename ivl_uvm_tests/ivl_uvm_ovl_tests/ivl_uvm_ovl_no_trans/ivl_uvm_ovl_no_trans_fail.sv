`timescale 1ns/1ns

module test;

   wire clk;
   reg rst_n;


reg start_s, next_s,sig_1;

	 logic [1:0] arb_gnt_vec;


   initial
   begin
      // Dump waves
      $dumpfile("dump_fail.vcd");
      $dumpvars(0, test);
      end

ovl_no_transition signal(.clock(clk),.reset(rst_n),.enable(1'b1),.test_expr(sig_1),.start_state(start_s),.next_state(next_s));
   initial begin
    

       rst_n=0;
       sig_1=0;
       start_s=1;
       next_s=0;

       $display("ovl no transition ");
       sig_1=1;
       wait_clks(5);
       rst_n=1;
       wait_clks(5);
	

       sig_1=start_s;
       wait_clks(2);

       sig_1=next_s;
       wait_clks(10);
       $finish;
   end

   task wait_clks (input int num_clks = 1);
      repeat (num_clks) @(posedge clk);
   endtask : wait_clks

  ivl_uvm_ovl_clk_gen #(.FREQ_IN_MHZ(100)) u_clk_100 (clk);

endmodule




