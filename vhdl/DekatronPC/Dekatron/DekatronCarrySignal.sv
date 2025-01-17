module DekatronCarrySignal(
    input wire Rst_n,
    input wire [9:0] In,
    output wire CarryLow,
    output wire CarryHigh,
	output wire Busy
); 
/*This module generates carry signal for full 10-position width dekatron*/

// synopsys translate_off
wire carryLowSet = In[0];
wire noCarrySet = |In[8:1];
wire carryHighSet = In[9];

assign Busy = ~(carryLowSet | noCarrySet | carryHighSet);

wire carryLowRst = carryHighSet | noCarrySet;
wire carryHighRst = carryLowSet | noCarrySet;

RsLatch carryLowLatch(
	.Rst_n(Rst_n),
	.S(carryLowSet),
	.R(carryLowRst),
	.Q(CarryLow)
);
 
RsLatch carryHighLatch(
	.Rst_n(Rst_n),
	.S(carryHighSet),
	.R(carryHighRst),
	.Q(CarryHigh)
);
// synopsys translate_on

endmodule
