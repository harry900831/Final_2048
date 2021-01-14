module button(
    input raw,
    input clk_100mhz,
    input clk, 
    output handled    
);
    wire debounced;
    debounce de(
    .pb(raw),
    .clock(clk_100mhz),
    .pb_debounced(debounced)
    );
    
    onepulse one(
    .PB_debounced(debounced),
    .clock(clk),
    .PB_one_pulse(handled)
    ); 
   
endmodule 


module debounce (pb, clock, pb_debounced); 
	output pb_debounced;
	input pb, clock;
	reg [3:0] DFF;
	always @(posedge clock) begin
		DFF[3:1] <= DFF[2:0];
		DFF[0] <= pb;
	end
	
	assign pb_debounced = ((DFF == 4'b1111) ? 1'b1 : 1'b0); 

endmodule


module onepulse (PB_debounced, clock, PB_one_pulse);
	input PB_debounced;
	input clock;
	output reg PB_one_pulse;
	reg PB_debounced_delay;

	always @(posedge clock) begin
		PB_one_pulse <= PB_debounced & (! PB_debounced_delay);
		PB_debounced_delay <= PB_debounced;
	end

endmodule