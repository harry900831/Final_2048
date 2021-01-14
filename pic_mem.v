module pic_mem(
    input [18:0] pixel_addr,
    input clk,
    output [11:0] signal0,
    output [11:0] signal1,
    output [11:0] signal2,
    output [11:0] signal3,
    output [11:0] signal4,
    output [11:0] signal5,
    output [11:0] signal6,
    output [11:0] signal7,
    output [11:0] signal8,
    output [11:0] signal9,
    output [11:0] signal10,
    output [11:0] signal11
);
    wire [11:0] data;
    wire [1:0] undecode_background;
    wire one, two, three, four, five, six, seven, eight, nine, ten, eleven;
    
    blk_mem_gen_0 blk_mem_gen_0_inst(
      .clka(clk),
      .wea(0),
      .addra(pixel_addr),
      .dina(data[1:0]),
      .douta(undecode_background)
    ); 
    fullgrid_pixel_decode decode_fullgrid(
        .addr_pixel(undecode_background),
        .pixel(signal0)
    );

    blk_mem_gen_2 blk_mem_gen_2_inst(
        .clka(clk),
        .wea(0),
        .addra(pixel_addr),
        .dina(data[11:0]),
        .douta(one)
    );
    one_pixel_decode decode_2(
        .addr_pixel(one),
        .pixel(signal1)
    );
    
    blk_mem_gen_4 blk_mem_gen_4_inst(
        .clka(clk),
        .wea(0),
        .addra(pixel_addr),
        .dina(data[11:0]),
        .douta(two)
    );
    two_pixel_decode decode_4(
        .addr_pixel(two),
        .pixel(signal2)
    );
    
    blk_mem_gen_8 blk_mem_gen_8_inst(
        .clka(clk),
        .wea(0),
        .addra(pixel_addr),
        .dina(data[11:0]),
        .douta(three)
    );
    three_pixel_decode decode_8(
        .addr_pixel(three),
        .pixel(signal3)
    );
    
    blk_mem_gen_16 blk_mem_gen_16_inst(
        .clka(clk),
        .wea(0),
        .addra(pixel_addr),
        .dina(data[11:0]),
        .douta(four)
    );
    four_pixel_decode decode_16(
        .addr_pixel(four),
        .pixel(signal4)
    );
    
    blk_mem_gen_32 blk_mem_gen_32_inst(
        .clka(clk),
        .wea(0),
        .addra(pixel_addr),
        .dina(data[11:0]),
        .douta(five)
    );
    five_pixel_decode decode_32(
        .addr_pixel(five),
        .pixel(signal5)
    );
    
    blk_mem_gen_64 blk_mem_gen_64_inst(
        .clka(clk),
        .wea(0),
        .addra(pixel_addr),
        .dina(data[11:0]),
        .douta(six)
    );
    six_pixel_decode decode_64(
        .addr_pixel(six),
        .pixel(signal6)
    );
    
    blk_mem_gen_128 blk_mem_gen_128_inst(
        .clka(clk),
        .wea(0),
        .addra(pixel_addr),
        .dina(data[11:0]),
        .douta(seven)
    );
    seven_pixel_decode decode_128(
        .addr_pixel(seven),
        .pixel(signal7)
    );

    blk_mem_gen_256 blk_mem_gen_256_inst(
        .clka(clk),
        .wea(0),
        .addra(pixel_addr),
        .dina(data[11:0]),
        .douta(eight)
    );
    eight_pixel_decode decode_256(
        .addr_pixel(eight),
        .pixel(signal8)
    );
    
    blk_mem_gen_512 blk_mem_gen_512_inst(
      .clka(clk),
      .wea(0),
      .addra(pixel_addr),
      .dina(data[11:0]),
      .douta(nine)
    );
    nine_pixel_decode decode_512(
        .addr_pixel(nine),
        .pixel(signal9)
    );
    
    blk_mem_gen_1024 blk_mem_gen_1024_inst(
      .clka(clk),
      .wea(0),
      .addra(pixel_addr),
      .dina(data[11:0]),
      .douta(ten)
    );
    ten_pixel_decode decode_1024(
        .addr_pixel(ten),
        .pixel(signal10)
    );
    
    blk_mem_gen_2048 blk_mem_gen_2048_inst(
      .clka(clk),
      .wea(0),
      .addra(pixel_addr),
      .dina(data[11:0]),
      .douta(eleven)
    );
    eleven_pixel_decode decode_2048(
        .addr_pixel(eleven),
        .pixel(signal11)
    );

endmodule
