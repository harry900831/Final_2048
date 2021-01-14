module poscheck(
    input [10:0] h_cnt,
    input [10:0] v_cnt,
    input [63:0] data,
    output reg [4:0] curpos,
    output reg [3:0] curdata
);
    always @* begin
        curdata = 4'b0000;
        curpos = 5'b00000;
        if((h_cnt >= 136 && h_cnt < 215)&&(v_cnt >= 66 && v_cnt < 145)) begin
            curdata[3:0] = data[63:60];
            curpos = 5'b00001;
        end
        if((h_cnt >= 232 && h_cnt < 312)&&(v_cnt >= 66 && v_cnt < 146)) begin
            curdata[3:0] = data[59:56];
            curpos = 5'b00010;
        end
        if((h_cnt >= 328 && h_cnt < 408)&&(v_cnt >= 66 && v_cnt < 146)) begin
            curdata[3:0] = data[55:52];
            curpos = 5'b00011;
        end
        if((h_cnt >= 424 && h_cnt < 504)&&(v_cnt >= 66 && v_cnt < 146)) begin
            curdata[3:0] = data[51:48];
            curpos = 5'b00100;
        end

        if((h_cnt >= 136 && h_cnt < 216)&&(v_cnt >= 162 && v_cnt < 242)) begin
            curdata[3:0] = data[47:44];
            curpos = 5'b00101;
        end
        if((h_cnt >= 232 && h_cnt < 312)&&(v_cnt >= 162 && v_cnt < 242)) begin
            curdata[3:0] = data[43:40];
            curpos = 5'b00110;
        end
        if((h_cnt >= 328 && h_cnt < 408)&&(v_cnt >= 162 && v_cnt < 242)) begin
            curdata[3:0] = data[39:36];
            curpos = 5'b00111;
        end
        if((h_cnt >= 424 && h_cnt < 504)&&(v_cnt >= 162 && v_cnt < 242)) begin
            curdata[3:0] = data[35:32];
            curpos = 5'b01000;
        end

        if((h_cnt >= 136 && h_cnt < 216)&&(v_cnt >= 258 && v_cnt < 338)) begin
            curdata[3:0] = data[31:28];
            curpos = 5'b01001;
        end
        if((h_cnt >= 232 && h_cnt < 312)&&(v_cnt >= 258 && v_cnt < 338)) begin
            curdata[3:0] = data[27:24];
            curpos = 5'b01010;
        end
        if((h_cnt >= 328 && h_cnt < 408)&&(v_cnt >= 258 && v_cnt < 338)) begin
            curdata[3:0] = data[23:20];
            curpos = 5'b01011;
        end
        if((h_cnt >= 424 && h_cnt < 504)&&(v_cnt >= 258 && v_cnt < 338)) begin
            curdata[3:0] = data[19:16];
            curpos = 5'b01100;
        end

        if((h_cnt >= 136 && h_cnt < 216)&&(v_cnt >= 354 && v_cnt < 434)) begin
            curdata[3:0] = data[15:12];
            curpos = 5'b01101;
        end
        if((h_cnt >= 232 && h_cnt < 312)&&(v_cnt >= 354 && v_cnt < 434)) begin
            curdata[3:0] = data[11:8];
            curpos = 5'b01110;
        end
        if((h_cnt >= 328 && h_cnt < 408)&&(v_cnt >= 354 && v_cnt < 434)) begin
            curdata[3:0] = data[7:4];
            curpos = 5'b01111;
        end
        if((h_cnt >= 424 && h_cnt < 504)&&(v_cnt >= 354 && v_cnt < 434)) begin
            curdata[3:0] = data[3:0];
            curpos = 5'b10000;
        end
        

    end
endmodule