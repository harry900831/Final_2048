`define RANGE 4

module main(clk, rst, up, down, left, right, board);
	input clk, rst, up, down, left, right;
	output reg [`RANGE * 16 - 1 : 0] board;
	reg [`RANGE * 16 - 1 : 0] next_board;
	wire [`RANGE * 16 - 1 : 0] up_board, down_board, right_board, left_board;
	reg [2 : 0] dir, next_dir, state, next_state;
	wire [`RANGE - 1 : 0] arr [15 : 0];
	wire win;
	wire [3 : 0] prefix [15 : 0];

	parameter INPUT = 3'b000;
	parameter MERGE = 3'b001;
	parameter GEN = 3'b010;
	parameter CHECK = 3'b011;
	parameter END = 3'b100;

	parameter UP = 3'b001;
	parameter DOWN = 3'b010;
	parameter LEFT = 3'b011;
	parameter RIGHT = 3'b100;

	parameter ZO4B = 4'b1011;
	parameter EMPTY = 4'b0000;


	assign {arr[15], arr[14], arr[13], arr[12], arr[11], arr[10], arr[9], arr[8], arr[7], arr[6], arr[5], arr[4], arr[3], arr[2], arr[1], arr[0]} = board;
	assign win = (((arr[15] == ZO4B || arr[14] == ZO4B) || (arr[13] == ZO4B || arr[12] == ZO4B)) || ((arr[11] == ZO4B || arr[10] == ZO4B) || (arr[9] == ZO4B || arr[8] == ZO4B))) || (((arr[7] == ZO4B || arr[6] == ZO4B) || (arr[5] == ZO4B || arr[4] == ZO4B)) || ((arr[3] == ZO4B || arr[2] == ZO4B) || (arr[1] == ZO4B || arr[0] == ZO4B)));

	prefix[15] = arr[15] == EMPTY;
	prefix[14] = arr[14] == EMPTY + arr[15] == EMPTY;
	prefix[13] = prefix[14] + arr[13] == EMPTY;
	prefix[12] = prefix[14] + (arr[13] == EMPTY + arr[12] == EMPTY);
	prefix[11] = prefix[12] + arr[11] == EMPTY;
	prefix[10] = prefix[12] + (arr[11] == EMPTY + arr[10] == EMPTY);
	prefix[9]  = prefix[10] + array[9] == EMPTY;
	prefix[8]  = prefix[10] + (array[9] == EMPTY + array[8] == EMPTY);
	prefix[7]  = prefix[8] + array[7] == EMPTY;
	prefix[6]  = prefix[8] + (array[7] == EMPTY + array[6] == EMPTY);
	prefix[5]  = prefix[6] + array[5] == EMPTY;
	prefix[4]  = prefix[6] + (array[5] == EMPTY + array[4] == EMPTY);
	prefix[3]  = prefix[4] + array[3] == EMPTY;
	prefix[2]  = prefix[4] + (array[3] == EMPTY + array[2] == EMPTY);
	prefix[1]  = prefix[2] + (array[1] == EMPTY);
	prefix[0]  = prefix[2] + (array[1] == EMPTY + array[0] == EMPTY);

	MoveUp mu(board, up_board);
	MoveDown md(board, down_board);
	MoveRight mr(board, right_board);
	MoveLeft ml(board, left_board);


	always@(posedge clk) begin
		if(rst == 1) begin
			state <= INPUT;
			dir <= 3'b0;
			board <= 64'b00010001;
		end else begin
			state <= next_state;
			dir <= next_dir;
			board <= next_board;
		end
	end

	always@(*) begin
		if(state == INPUT) begin
			if(up == 1) next_dir = UP;
			else if(down == 1) next_dir = DOWN;
			else if(left == 1) next_dir = LEFT;
			else if(right == 1) next_dir = RIGHT;
			else next_dir = 3'b0;
		end else if(state == GEN) next_dir = 3'b0;
		else next_dir = dir;
	end



	always@(*) begin
		case(state)
			INPUT: begin
				if(dir != 3'b0) next_state = MERGE;
				else next_state = INPUT;
			end
			MERGE: begin
				next_state = GEN;
			end
			GEN: begin
				next_state = CHECK;
			end
			CHECK: begin
				if(win == 1) next_state = END;
				else next_state = INPUT;
			end
			END: begin
				next_state = END;
			end
			default: next_state = END;
		endcase
	end


	always@(*) begin
		if(state == MERGE) begin
			case(dir)
				UP: next_board = up_board;
				DOWN: next_board = down_board;
				LEFT: next_board = left_board;
				RIGHT: next_board = right_board;
				default: next_board = board;
			endcase
		end else if(state == GEN) begin
		end else next_board = board;
	end


endmodule

module RAND_GEN3(clk, rst, out);
	input clk, rst;
	output [3 : 0] out;
	reg[7 : 0] DFF;
	always@(posedge clk) begin
		if(rst) DFF <= 6'b011101;
		else begin
			DFF[0] <= DFF[1];
			DFF[1] <= DFF[2];
			DFF[2] <= DFF[3];
			DFF[3] <= DFF[0] ^ DFF[1];
		end
	end
	out = DFF[3:0];
endmodule


module MoveUp(in, out);
	input [`RANGE * 16 - 1 : 0] in;
	output [`RANGE * 16 - 1 : 0] out;
	Merge mer1 ({in[15:12], in[31:28], in[47:44], in[63:60]}, {out[15:12], out[31:28], out[47:44], out[63:60]});
	Merge mer2 ({in[11:8], in[27:24], in[43:40], in[59:56]}, {out[11:8], out[27:24], out[43:40], out[59:56]});
	Merge mer3 ({in[7:4], in[23:20], in[39:36], in[55:52]}, {out[7:4], out[23:20], out[39:36], out[55:52]});
	Merge mer4 ({in[3:0], in[19:16], in[35:32], in[51:48]}, {out[3:0], out[19:16], out[35:32], out[51:48]});
endmodule

module MoveDown(in, out);
	input [`RANGE * 16 - 1 : 0] in;
	output [`RANGE * 16 - 1 : 0] out;
	Merge mer1 ({in[63:60], in[47:44], in[31:28], in[15:12]}, {out[63:60], out[47:44], out[31:28], out[15:12]});
	Merge mer2 ({in[59:56], in[43:40], in[27:24], in[11:8]}, {out[59:56], out[43:40], out[27:24], out[11:8]});
	Merge mer3 ({in[55:52], in[39:36], in[23:20], in[7:4]}, {out[55:52], out[39:36], out[23:20], out[7:4]});
	Merge mer4 ({in[51:48], in[35:32], in[19:16], in[3:0]}, {out[51:48], out[35:32], out[19:16], out[3:0]});
endmodule

module MoveLeft(in, out);
	input [`RANGE * 16 - 1 : 0] in;
	output [`RANGE * 16 - 1 : 0] out;
	Merge mer1 ({in[51:48], in[55:52], in[59:56], in[63:60]}, {out[51:48], out[55:52], out[59:56], out[63:60]});
	Merge mer2 ({in[35:32], in[39:36], in[43:40], in[47:44]}, {out[35:32], out[39:36], out[43:40], out[47:44]});
	Merge mer3 ({in[19:16], in[23:20], in[27:24], in[31:28]}, {out[19:16], out[23:20], out[27:24], out[31:28]});
	Merge mer4 ({in[3:0], in[7:4], in[11:8], in[15:12]}, {out[3:0], out[7:4], out[11:8], out[15:12]});
endmodule

module MoveRight(in, out);
	input [`RANGE * 16 - 1 : 0] in;
	output [`RANGE * 16 - 1 : 0] out;
	Merge mer1 (in[63 : 48], out[63 : 48]);
	Merge mer2 (in[47 : 32], out[47 : 32]);
	Merge mer3 (in[31 : 16], out[31 : 16]);
	Merge mer4 (in[15 : 0], out[15 : 0]);
endmodule


module Merge(in, out);
	input [`RANGE * 4 - 1:0] in;
	output reg [`RANGE * 4 - 1 : 0] out;
	parameter zero = `RANGE'b0;
	wire [`RANGE - 1 : 0] arr[3 : 0];
	wire [3 : 0] type;

	assign {arr[3], arr[2], arr[1], arr[0]} = in;
	assign type = {arr[3] == zero, arr[2] == zero, arr[1] == zero, arr[0] == zero};

	always@(*) begin
		case (type)
			4'b0000: out = 0;
			4'b0001: out = in;
			4'b0010: out = {{3{zero}}, arr[1]};
			4'b0011:begin
				if(arr[0] == arr[1]) out = {{3{zero}}, arr[0] + `RANGE'b1};
				else out = {{2{zero}}, arr[1], arr[0]};
			end
			4'b0100: out = {{3{zero}}, arr[2]};
			4'b0101:begin
				if(arr[0] == arr[2]) out = {{3{zero}}, arr[0] + `RANGE'b1};
				else out = {{2{zero}}, arr[2], arr[0]};
			end
			4'b0110:begin
				if(arr[1] == arr[2]) out = {{3{zero}}, arr[1] + `RANGE'b1};
				else out = {{2{zero}}, arr[2], arr[1]};
			end
			4'b0111:begin
				if(arr[0] == arr[1]) out = {{2{zero}}, arr[2], arr[0] + `RANGE'b1};
				else if(arr[1] == arr[2]) out = {{2{zero}}, arr[1] + `RANGE'b1, arr[0]};
				else out = in;
			end
			4'b1000: out = {{3{zero}}, arr[3]};
			4'b1001:begin
				if(arr[0] == arr[3]) out = {{3{zero}}, arr[0] + `RANGE'b1};
				else out = {{2{zero}}, arr[3], arr[0]};
			end
			4'b1010:begin
				if(arr[1] == arr[3]) out = {{3{zero}}, arr[1] + `RANGE'b1};
				else out = {{2{zero}}, arr[3], arr[1]};
			end
			4'b1011:begin
				if(arr[0] == arr[1]) out = {{2{zero}}, arr[3], arr[0] + `RANGE'b1};
				else if(arr[1] == arr[3]) out = {{2{zero}}, arr[1] + `RANGE'b1, arr[0]};
				else out = {zero, arr[3], arr[1], arr[0]};
			end
			4'b1100:begin
				if(arr[2] == arr[3]) out = {{3{zero}}, arr[2] + `RANGE'b1};
				else out = {{2{zero}}, arr[3], arr[2]};
			end
			4'b1101:begin
				if(arr[0] == arr[1]) out = {{2{zero}}, arr[3], arr[0] + `RANGE'b1};
				else if(arr[2] == arr[3]) out = {{2{zero}}, arr[2] + `RANGE'b1, arr[0]};
				else out = {zero, arr[3], arr[2], arr[0]};
			end
			4'b1110:begin
				if(arr[1] == arr[2]) out = {{2{zero}}, arr[3], arr[1] + `RANGE'b1};
				else if(arr[2] == arr[3]) out = {{2{zero}}, arr[2] + `RANGE'b1, arr[1]};
				else out = {zero, arr[3], arr[2], arr[1]};
			end
			4'b1111:begin
				if(arr[0] == arr[1]) begin
					if(arr[1] == arr[2]) out = {{2{zero}}, arr[2] + `RANGE'b1, arr[0] + `RANGE'b1};
					else out = {zero, arr[3], arr[2], arr[1] + `RANGE'b1};
				end	else if(arr[1] == arr[2]) out = {zero, arr[3], arr[1] + `RANGE'b1, arr[0]};
				else if(arr[2] == arr[3])out = {zero, arr[2] + `RANGE'b1, arr[1], arr[0]};
				else out = in;
			end
			default: out = in;
		endcase
	end
endmodule