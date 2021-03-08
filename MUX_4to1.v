// Author: 0717035 王偉軒

module MUX_4to1(data0,data1,data2,data3,switch,mux_4_out);

parameter size = 0;

//I/O ports
input   [size-1:0] data0;
input   [size-1:0] data1;
input   [size-1:0] data2;
input   [size-1:0] data3;
input   [2:1]      switch;
output  [size-1:0] mux_4_out;

//Internal Signals
reg     [size-1:0] mux_4_out;

always @(*) 
begin
	case(switch)
	2'b00	:	mux_4_out=data0;		
	2'b01	:	mux_4_out=data1;	
	2'b10	:	mux_4_out=data2;
	2'b11	:	mux_4_out=data3;	
	endcase
end

endmodule
