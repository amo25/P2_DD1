// Filename:    hc280_tb.v
// Author:      Alex Orlov
// Date:        20 Oct 2017
// Version:     1
/* Description: Test bench for 9 bit parity checker
Uses a 9 bit counter, created by modifying a 4 bit counter made by T. Martin.


                */
                
`timescale 1ns/100ps               
module hc280_tb();
    
    reg tb_enable, tb_clear;
    wire tb_clk;
    wire [8:0] tb_cout;
    wire pe, po;
    //assign tb_enable = 1;
    //assign tb_clear = 0;
    
    // Instantiate the clock generator with a period of 100
	clk #(100) M3 (tb_enable, tb_clk);
    
    //feed the clock into the counter, have the counter always enabled, have the clear always off
    counter_9bit c9b(tb_enable, tb_clear, tb_clk, tb_cout);
    
    //feed the counter into the parity checker
    hc280 parityC(tb_cout, pe, po);
    
    initial begin
        tb_enable = 1;
        tb_clear = 0;
    end
    
    
endmodule