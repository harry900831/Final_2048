module display(
  input clk,
  input rst,
  input [63:0] board_state,
  output [3:0] vgaRed,
  output [3:0] vgaGreen,
  output [3:0] vgaBlue,
  output hsync,
  output vsync
  );


  wire valid;
  wire [10:0] h_cnt; //640
  wire [10:0] v_cnt;  //480
  wire [4:0] curpos;
  wire [3:0] curdata;
  wire [11:0] signal;

  poscheck pos(
    .h_cnt(h_cnt),
    .v_cnt(v_cnt),
    .data(board_state),
    .curpos(curpos),
    .curdata(curdata)
  );
 
  signal_case sig_case(
  .curpos(curpos),
  .h_cnt(h_cnt),
  .v_cnt(v_cnt),
  .clk(clk),
  .curdata(curdata),
  .signal(signal)
  );  
   
  vga_controller   vga_inst(
    .pclk(clk),
    .reset(rst),
    .hsync(hsync),
    .vsync(vsync),
    .valid(valid),
    .h_cnt(h_cnt),
    .v_cnt(v_cnt)
  );
  assign {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ?signal :12'h0;
endmodule


