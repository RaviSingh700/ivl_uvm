`timescale 1ns/1ns
module test;

   	wire clk;
   	reg rst_n;
   
	reg  sig_1;

initial
begin
	$dumpfile("dump_fail.vcd");
	$dumpvars(0, test);
end


ovl_no_overflow  no_over(.clock(clk), .reset(rst_n), .enable(1'b1), .test_expr(sig_1));

initial begin


	rst_n=0;
	sig_1=0;
	$display(" Initilization");
	sig_1=1;
	wait_clks(5);
	rst_n=1;
	$display("out of reset");
	wait_clks(5);
	sig_1=0;


	wait_clks(10);
	$finish;
end



task wait_clks (input int num_clks = 1);
      repeat (num_clks) @(posedge clk);
   endtask : wait_clks

  ivl_uvm_ovl_clk_gen #(.FREQ_IN_MHZ(100)) u_clk_100 (clk);

endmodule
