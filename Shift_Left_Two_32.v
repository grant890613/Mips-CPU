// Author: 0717035 王偉軒

module Shift_Left_Two_32(
    data_i,
    data_o
    );

//I/O ports
input [32-1:0] data_i;
output [32-1:0] data_o;

assign data_o = data_i << 2;


endmodule
