`timescale 1ns/100ps
module ninebit_ctr_tb();

	// Declare local wires and regs
	reg 	en_test;			// Locally-created "enable test" signal
   reg 	clr_test;		// Locally-created "clear test" signal
   reg 	clk_tb_enable;	// Locally-created clock-enable signal
	wire 	tb_clk;			// Clock produced by the "clk" module
	wire 	[8:0] cout1, cout2;	// Counter outputs for the two 9-bit counters

	// Intantiate two versions of the counter
	// The first one overrides the default values of the parameters with the "#(20, 30)"
	counter_9bit #(20, 30) M1 (en_test, clr_test, tb_clk, cout1);
	// The second one uses the default values 
	counter_9bit M2 (en_test, clr_test, tb_clk, cout2);

	// Instantiate the clock generator with a period of 100
	clk #(100) M3 (clk_tb_enable, tb_clk);

	// Sequence the ENABLE and CLR signals 
	initial begin
 /*        en_test = 1;
        clr_test = 0;
        clk_tb_enable = 1;
        #20; */
		en_test = 0;
		clr_test = 0;
		clk_tb_enable = 1;
		#10 clr_test = 1;
		#40 clr_test = 0;
		#50 en_test = 1;
		#400 en_test = 0;
		#200 en_test = 1;
		#300 clr_test = 1;
		#60 clr_test = 0;
	end


endmodule