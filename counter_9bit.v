// Filename:    hc280_tb.v
// Author:      Alex Orlov
// Date:        20 Oct 2017
// Version:     1
/* Description: Test bench for 9 bit parity checker
Uses a 9 bit counter, created by modifying a 4 bit counter made by T. Martin with the following description:

//  Description  : This module is a behavioral description of
// 		a simple four-bit counter with enable and
// 		asynchronous clear.
//
// 		This module has three inputs and one output:
//					clk:	input - system clock
//					clear:	input -	asynchronous clear (active high)
// 				enable:	input - count advances when asserted high
//					cout:	output - 4-bit counter output
//
// 		This module has two parameters:
//					CLRDEL	- delay from clear asserted to output valid
// 				CLKDEL	- delay from clk rising to output valid
//
//
//   		This module is not synthesizable.  It is intended
// 		for modeling only and should not be used as a
// 		template for synthesizable modules. 
//
//  Modification History:
//  Date      By    Version   Change Description
// ========================================================
//  09/07/04	TLM	1			Original
//  08/24/05	PMA	2			Restructured for Fall 2005
//  10/03/2013	TLM  3 			Revised for DD 1, fall 2013
*/

`timescale 1 ns/100 ps
module counter_9bit (enable, clear, clk, cout);
	parameter CLRDEL = 10;	// delay from clear asserted to output valid
  	parameter CLKDEL = 15;	// delay from clk rising to output valid

	input 	enable;			// count advances when asserted high
   input 	clear;			// asynchronous clear (active high)
  	input		clk;				// system clock
	output [8:0] cout;		// 9-bit counter output

	reg [8:0] cout;			// cout is a reg

	// Locally declared nets
	reg [8:0] count;			// local count holder register

	initial count = 0;

	// Build behavioral 9-bit up-counter with asynchronous clear
	always @(posedge clk or posedge clear)
	begin
		if (clear == 1) 
			begin
				count = 9'b0;
				cout = #CLRDEL count;
			end
		else if (clk == 1) 
			begin
				if (enable == 1) 
					begin
						if (count == 9'b111111111) 
							count = 0;
						else
							count = count + 9'd1;
					end	
				cout =  #CLKDEL count;
			end
	end
endmodule