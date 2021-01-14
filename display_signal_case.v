module signal_case(
    input [4:0] curpos,
    input [10:0] h_cnt,
    input [10:0] v_cnt,
    input clk,
    input [3:0] curdata,
    output reg [11:0] signal  
);  
    parameter zero = 4'b0000;
    parameter one = 4'b0001;
    parameter two = 4'b0010;
    parameter three = 4'b0011;
    parameter four = 4'b0100;
    parameter five = 4'b0101;
    parameter six = 4'b0110;
    parameter seven = 4'b0111;
    parameter eight = 4'b1000;
    parameter nine = 4'b1001;
    parameter ten = 4'b1010;
    parameter eleven = 4'b1011;
    
    reg [18:0] pixel_addr;
    wire [2:0] undecode_background;
    wire [11:0] background_pixel;
    wire [11:0] signal0, signal1, signal2, signal3, signal4, signal5, signal6, signal7, signal8, signal9, signal10, signal11;

    
    always @* begin
        case(curpos)
            5'b00001 : begin
                if(!curdata) 
                    pixel_addr = (h_cnt)+640*(v_cnt);
                else 
                    pixel_addr = (h_cnt-136)+(v_cnt-66)*80;
            end
            5'b00010 : begin
                if(!curdata) 
                    pixel_addr = (h_cnt)+640*(v_cnt);
                else 
                    pixel_addr = (h_cnt-232)+(v_cnt-66)*80;
            end
            5'b00011 : begin
                if(!curdata) 
                    pixel_addr = (h_cnt)+640*(v_cnt);
                else 
                    pixel_addr = (h_cnt-328)+(v_cnt-66)*80;
            end
            5'b00100 : begin
                if(!curdata) 
                    pixel_addr = (h_cnt)+640*(v_cnt);
                else 
                    pixel_addr = (h_cnt-424)+(v_cnt-66)*80;
            end
            5'b00101 : begin
                if(!curdata) 
                    pixel_addr = (h_cnt)+640*(v_cnt);
                else 
                    pixel_addr = (h_cnt-136)+(v_cnt-162)*80;
            end
            5'b00110 : begin
                if(!curdata) 
                    pixel_addr = (h_cnt)+640*(v_cnt);
                else 
                    pixel_addr = (h_cnt-232)+(v_cnt-162)*80;
            end
            5'b00111 : begin
                if(!curdata) 
                    pixel_addr = (h_cnt)+640*(v_cnt);
                else 
                    pixel_addr = (h_cnt-328)+(v_cnt-162)*80;
            end
            5'b01000 : begin
                if(!curdata) 
                    pixel_addr = (h_cnt)+640*(v_cnt);
                else 
                    pixel_addr = (h_cnt-424)+(v_cnt-162)*80;
            end
            5'b01001 : begin
                if(!curdata) 
                    pixel_addr = (h_cnt)+640*(v_cnt);
                else 
                    pixel_addr = (h_cnt-136)+(v_cnt-258)*80;
            end
            5'b01010 : begin
                if(!curdata) 
                    pixel_addr = (h_cnt)+640*(v_cnt);
                else 
                    pixel_addr = (h_cnt-232)+(v_cnt-258)*80;
            end
            5'b01011 : begin
                if(!curdata) 
                    pixel_addr = (h_cnt)+640*(v_cnt);
                else 
                    pixel_addr = (h_cnt-328)+(v_cnt-258)*80;
            end
            5'b01100 : begin
                if(!curdata) 
                    pixel_addr = (h_cnt)+640*(v_cnt);
                else 
                    pixel_addr = (h_cnt-424)+(v_cnt-258)*80;
            end
            5'b01101 : begin
                if(!curdata) 
                    pixel_addr = (h_cnt)+640*(v_cnt);
                else 
                    pixel_addr = (h_cnt-136)+(v_cnt-354)*80;
            end
            5'b01110 : begin
                if(!curdata) 
                    pixel_addr = (h_cnt)+640*(v_cnt);
                else 
                    pixel_addr = (h_cnt-232)+(v_cnt-354)*80;
            end
            5'b01111 : begin
                if(!curdata) 
                    pixel_addr = (h_cnt)+640*(v_cnt);
                else 
                    pixel_addr = (h_cnt-328)+(v_cnt-354)*80;
            end
            5'b10000 : begin
                if(!curdata) 
                    pixel_addr = (h_cnt)+640*(v_cnt);
                else 
                    pixel_addr = (h_cnt-424)+(v_cnt-354)*80;
            end
            default : begin
                pixel_addr = (h_cnt)+640*(v_cnt);
            end
        endcase
    end
    
    pic_mem OGC(
    .pixel_addr(pixel_addr +1),
    .clk(clk),
    .signal0(signal0),
    .signal1(signal1),
    .signal2(signal2),
    .signal3(signal3),
    .signal4(signal4),
    .signal5(signal5),
    .signal6(signal6),
    .signal7(signal7),
    .signal8(signal8),
    .signal9(signal9),
    .signal10(signal10),
    .signal11(signal11)
    );   
    always @* begin
        case(curdata)
                zero : begin
                    signal = signal0;
                end
                one : begin
                    signal = signal1;
                end
                two : begin
                    signal = signal2;
                end
                three : begin
                    signal = signal3;
                end
                four : begin
                    signal = signal4;
                end
                five : begin
                    signal = signal5;
                end
                six : begin
                    signal = signal6;
                end
                seven : begin
                    signal = signal7;
                end
                eight : begin
                    signal = signal8;
                end
                nine : begin
                    signal = signal9;
                end
                ten : begin
                    signal = signal10;
                end
                eleven : begin
                    signal = signal11;
                end
                default : begin
                    signal = signal0;
                end
            endcase
        end
    
endmodule


/*
case(curdata)
    zero : begin
        
    end
    one : begin
        
    end
    two : begin
        
    end
    three : begin
        
    end
    four : begin
        
    end
    five : begin
        
    end
    six : begin
        
    end
    seven : begin
        
    end
    eight : begin
        
    end
    nine : begin
        
    end
    ten : begin

    end
    eleven : begin
        
    end
    default : begin 
endcase
*/