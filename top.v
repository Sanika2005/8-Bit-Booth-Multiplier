module top(
input clk
);
wire start;
wire [7:0] multiplicand;
wire [7:0] multiplier;
wire [15:0] product;
wire done;
Booth_Multiplier i1 (
.clk(clk),
.start(start),
.multiplicand(multiplicand),
.multiplier(multiplier),
.product(product),
.done(done)
);
ila_0 i2 (
	.clk(clk), // input wire clk


	.probe0(multiplicand), // input wire [7:0]  probe0  
	.probe1(multiplier), // input wire [7:0]  probe1 
	.probe2(product), // input wire [15:0]  probe2 
	.probe3(done), // input wire [0:0]  probe3 
	.probe4(start) // input wire [0:0]  probe4
);
vio_0 i3 (
  .clk(clk),                // input wire clk
  .probe_out0(multiplicand),  // output wire [7 : 0] probe_out0
  .probe_out1(multiplier),  // output wire [7 : 0] probe_out1
  .probe_out2(start)  // output wire [0 : 0] probe_out2
);
endmodule
