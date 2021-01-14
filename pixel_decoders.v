module fullgrid_pixel_decode(
    input  [1:0]  addr_pixel,
    output [12-1:0] pixel
);

parameter [12-1:0] list [0:2] = {
    12'hFFE,
    12'hBA9,
    12'hCCB 
};
assign pixel = list[addr_pixel];

endmodule
module one_pixel_decode(
    input  [1:0]  addr_pixel,
    output [12-1:0] pixel
);

parameter [12-1:0] list [0:1] = {
    12'hEED,
    12'h000 
};
assign pixel = list[addr_pixel];

endmodule

module two_pixel_decode(
    input  [1:0]  addr_pixel,
    output [12-1:0] pixel
);

parameter [12-1:0] list [0:1] = {
    12'hEDC,
    12'h000 
};
assign pixel = list[addr_pixel];

endmodule

module three_pixel_decode(
    input  [1:0]  addr_pixel,
    output [12-1:0] pixel
);

parameter [12-1:0] list [0:1] = {
    12'hFB7,
    12'hFFF 
};
assign pixel = list[addr_pixel];

endmodule

module four_pixel_decode(
    input  [1:0]  addr_pixel,
    output [12-1:0] pixel
);

parameter [12-1:0] list [0:1] = {
    12'hF96,
    12'hFFF 
};
assign pixel = list[addr_pixel];

endmodule

module five_pixel_decode(
    input  [1:0]  addr_pixel,
    output [12-1:0] pixel
);

parameter [12-1:0] list [0:1] = {
    12'hF75,
    12'hFFF 
};
assign pixel = list[addr_pixel];

endmodule

module six_pixel_decode(
    input  [1:0]  addr_pixel,
    output [12-1:0] pixel
);

parameter [12-1:0] list [0:1] = {
    12'hF53,
    12'hFFF 
};
assign pixel = list[addr_pixel];

endmodule

module seven_pixel_decode(
    input  [1:0]  addr_pixel,
    output [12-1:0] pixel
);

parameter [12-1:0] list [0:1] = {
    12'hEC7,
    12'hFFF 
};
assign pixel = list[addr_pixel];

endmodule

module eight_pixel_decode(
    input  [1:0]  addr_pixel,
    output [12-1:0] pixel
);

parameter [12-1:0] list [0:1] = {
    12'hEC6,
    12'hFFF 
};
assign pixel = list[addr_pixel];

endmodule

module nine_pixel_decode(
    input  [1:0]  addr_pixel,
    output [12-1:0] pixel
);

parameter [12-1:0] list [0:1] = {
    12'hEC5,
    12'hFFF 
};
assign pixel = list[addr_pixel];

endmodule

module ten_pixel_decode(
    input  [1:0]  addr_pixel,
    output [12-1:0] pixel
);

parameter [12-1:0] list [0:1] = {
    12'hEC3,
    12'hFFF 
};
assign pixel = list[addr_pixel];

endmodule

module eleven_pixel_decode(
    input  [1:0]  addr_pixel,
    output [12-1:0] pixel
);

parameter [12-1:0] list [0:1] = {
    12'hEC2,
    12'hFFF 
};
assign pixel = list[addr_pixel];

endmodule