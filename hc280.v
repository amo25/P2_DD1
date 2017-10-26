// Filename:    hc280.v
// Author:      Alex Orlov
// Date:        20 Oct 2017
// Version:     1
/* Description: 9 bit parity checker, returns a parity even bit and a parity odd bit
                */
`timescale 1ns/100ps             
module hc280(data_in, pe, po);
    input [8:0] data_in;
    output pe, po;
    
    //add up each bit of data_in, then return the last bit to check for even vs odd
    
    //largest possible value of 9 bits added = 9, thus 4 bits required
    wire [3:0] sum;
    assign sum = data_in[0] + data_in[1] + data_in[2] + data_in[3] + data_in[4] + data_in[5] + data_in[6] + data_in[7] + data_in[8];
    
    assign po = sum[0];
    assign pe = ~sum[0];
    
    //17ns prop delay for pe, 20 ns for po
    specify
        (data_in *> pe) = (17); //17 time units. Timescale directive must specify 1ns to be one time unit (e.g. `timescale 1ns/100ps)
        (data_in *> po) = (20); //20ns typical propagation delay @ 25C and Vcc = 5V
    endspecify
endmodule