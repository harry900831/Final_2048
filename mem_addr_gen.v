module mem_addr_gen(
   input [10:0] h_cnt,
   input [10:0] v_cnt,
   output [18:0] pixel_addr
   );
    
   reg [7:0] position;
   wire [11:0] data;
   assign pixel_addr = (h_cnt)+640*(v_cnt);  //640*480 --> 320*240 
endmodule
