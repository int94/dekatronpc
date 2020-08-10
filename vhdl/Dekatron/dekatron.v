module dekatron(
    /**/

    input wire PulseRight_n,
	input wire PulseLeft_n,
    input wire Rst_n,
    input wire Set,
    input wire [9:0] In,
    output wire[9:0] Out,
    output wire Ready
);


//Main wire state:
reg [29:0] Cathodes;

//Multiplexed state signals:

//Guide cathode right
wire GuideRightGlow = Cathodes[1] | Cathodes[4] | Cathodes[7] | Cathodes[10]
              | Cathodes[13] |  Cathodes[16] | Cathodes[19] | Cathodes[22]
              | Cathodes[25] | Cathodes[28];

//Guide Cathode Left
wire GuideLeftGlow = Cathodes[2] |  Cathodes[5] | Cathodes[8] | Cathodes[11]
              | Cathodes[14] |  Cathodes[17] | Cathodes[20] | Cathodes[23]
              | Cathodes[26] | Cathodes[29];

//Glow is on the one of the main cathodes:
wire CathodeGlow = Cathodes[0] |  Cathodes[3] | Cathodes[6] | Cathodes[9]
              | Cathodes[12] |  Cathodes[15] | Cathodes[18] | Cathodes[21]
              | Cathodes[24] | Cathodes[27];

//Connect cathodes to the output
assign Out[0] = Cathodes[0];
assign Out[1] = Cathodes[3];
assign Out[2] = Cathodes[6];
assign Out[3] = Cathodes[9];
assign Out[4] = Cathodes[12];
assign Out[5] = Cathodes[15];
assign Out[6] = Cathodes[18];
assign Out[7] = Cathodes[21];
assign Out[8] = Cathodes[24];
assign Out[9] = Cathodes[27];

assign Ready = CathodeGlow & PulseLeft_n & PulseRight_n;

//Internal extended InLong signal is used for Writing operation
wire [29:0] InLong = {{2'b00}, In[9], 2'b00, In[8], 
                    2'b00, In[7], 2'b00, In[6], 
                    2'b00, In[5], 2'b00, In[4], 
                    2'b00, In[3], 2'b00, In[2], 
                    2'b00, In[1], 2'b00, In[0]};

wire PulseLeft = ~PulseLeft_n;
wire PulseRight = ~ PulseRight_n;

wire Pulse = PulseLeft | PulseRight;

always @(negedge Rst_n, negedge Pulse, negedge PulseLeft_n, negedge PulseRight_n, posedge Set)
 begin
    if (~Rst_n) begin
        Cathodes <= 30'b000000000000000000000000000001;//Rst_n
     end
     else begin
        if (PulseRight) begin
            Cathodes <= Set ? InLong : 
                CathodeGlow ? {Cathodes[28:0], Cathodes[29]} :
                     GuideLeftGlow ? {Cathodes[0], Cathodes[29:1]} : Cathodes;
        end
        else if (PulseLeft) begin
            Cathodes <= Set ? InLong : 
                CathodeGlow ? {Cathodes[0], Cathodes[29:1]}:
                GuideRightGlow ? {Cathodes[28:0], Cathodes[29]} : Cathodes;
        end
        else begin
            Cathodes <= Set ? InLong : GuideRightGlow ? {Cathodes[0], Cathodes[29:1]}:
            GuideLeftGlow ? {Cathodes[28:0], Cathodes[29]} : Cathodes;
        end
     end//Rst_n
 end
endmodule
