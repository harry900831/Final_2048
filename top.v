module top (
   input clk_100mhz,
   input raw_rst,
  input raw_up,
   input raw_down,
   input raw_left,
   input raw_right,
   input switch,
   output [3:0] vgaRed,
   output [3:0] vgaGreen,
   output [3:0] vgaBlue,
   output hsync,
   output vsync
    );
    wire [2:0] state;
    wire [63:0] board_state;
    //assign board_state = 64'h0000_0000_0000_0011;
    // to generate the 25mhz clk we need
    wire tmp_clk_25mhz, clk_25mhz;
    wire locked;
    clock_25mhz clk_div(tmp_clk_25mhz, 0, locked, clk_100mhz );
    assign clk_25mhz = tmp_clk_25mhz&locked;
    // end of clk generator
    
    //button debounce onpule 
    
    wire up, down, right ,left, tmp_rst, rst;
    reg [25:0] counter;
    always @(posedge clk_100mhz) begin
        counter <= counter + 1;
    end
    wire tmp_clk;
    assign tmp_clk = counter[21];
     
    button(raw_rst,clk_100mhz, clk_25mhz, rst);
    button(raw_up,clk_100mhz, clk_25mhz, up);
    button(raw_down,clk_100mhz, clk_25mhz, down);
    button(raw_right,clk_100mhz, clk_25mhz, right);
    button(raw_left,clk_100mhz, clk_25mhz, left);    
   /* button(raw_rst,tmp_clk, tmp_clk, rst);
    button(raw_up,tmp_clk, tmp_clk, up);
    button(raw_down,tmp_clk, tmp_clk, down);
    button(raw_right,tmp_clk, tmp_clk, right);
    button(raw_left,tmp_clk, tmp_clk, left); */
    // finish button handle
;
    // control the display
    display displayscreen(
       .clk(clk_25mhz),
       .rst(rst),
       .board_state(board_state),
       .vgaRed(vgaRed),
       .vgaGreen(vgaGreen),
       .vgaBlue(vgaBlue),
       .hsync(hsync),
       .vsync(vsync)
    );
    // end of display control
   calc cal(
        .clk(clk_25mhz), 
        .rst(rst),
        .up(up), 
        .down(down), 
        .left(left),
        .switch(switch),
        .right(right),
        .board(board_state),
        .state(state)
        );

endmodule