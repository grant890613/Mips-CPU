// Author: 0717035 王偉軒

module Cross(cross_data_01,cross_data_02,cross_answer);

//I/O ports
input  [32-1:0]  cross_data_01;
input  [32-1:0]	 cross_data_02;
output [32-1:0]  cross_answer;

//Internal Signals
wire   [64-1:0]	 sum_temp;
wire   [32-1:0]  sum_o;

/////////////////cross/////////////////////////
assign sum_temp = cross_data_01 * cross_data_02;
assign cross_answer = sum_temp[32-1:0];

endmodule
