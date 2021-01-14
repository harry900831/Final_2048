module AI(clk, rst, state, board, best_dir);
    input clk, rst;
    input reg [63 ： 0] board;
	input [2 : 0] state;
    output [2 : 0] best_dir;

    reg [35 : 0] up_point, down_point, left_point, right_point;
    
    parameter INPUT = 3'b000;
	parameter MERGE = 3'b001;
	parameter GEN = 3'b010;
	parameter CHECK = 3'b011;
	parameter END = 3'b100;
	parameter SEARCH = 3'b101;
    
    parameter UP = 3'b001;
	parameter DOWN = 3'b010;
	parameter LEFT = 3'b011;
	parameter RIGHT = 3'b100;

	wire start1, start2, start3, start4;
    wire [63 : 0] up_b, down_b, right_b, left_b, init_up, init_down, init_right, init_left;
    MoveUp mu(board, up_b);
	MoveDown md(board, down_b);
	MoveRight mr(board, right_b);
	MoveLeft ml(board, left_b);
    GenPlace genb1(clk, rst, up_b, init_up);
    GenPlace genb1(clk, rst, down_b, init_down);
	GenPlace genb1(clk, rst, right_b, init_right);
	GenPlace genb1(clk, rst, left_b, init_left);

	assign start1 = (state == INPUT);
	assign start2 = (state == INPUT);
	assign start3 = (state == INPUT);
	assign start4 = (state == INPUT);
	
	MakeMove mk1(clk, rst, start1, init_up, up_point);
	MakeMove mk2(clk, rst, start2, init_down, down_point);
	MakeMove mk3(clk, rst, start3, init_right, left_point);
	MakeMove mk4(clk, rst, start4, init_left, right_point);


	reg [20 : 0] count, next_count;
    always@(posedge clk) begin
        if(state == INPUT) begin
			count <= 21'd100000;
		end else count <= next_count;
    end


	always@(*) begin
		if(state == search) next_count = (count == 0 ? 0 : count - 1);
		else if(state == CHECK) next_count = 21'd7122;
		else next_count = count;		
	end
	always@(*) begin
		if(count < 21'd5)	begin
			if(up_point >= down_point && up_point >= left_point && up_point >= right_point) best_dir = UP;
			else if(down_point >= up_point && down_point >= left_point && down_point >= right_point) best_dir = DOWN;
			else if(left_point >= down_point && left_point >= up_point && left_point >= right_point) best_dir = LEFT;
			else if(right_point >= up_point && right_point >= left_point && right_point >= down_point) best_dir = RIGHT;
			else best_dir = 0;
		end else best_dir = 0;
	end

   

endmodule


module MakeMove(clk, rst, start, in, out);
	input clk, rst, start;
	input [63 : 0] in;
	output [35 : 0] out;

    parameter INPUT = 3'b000;
	parameter MERGE = 3'b001;
	parameter GEN = 3'b010;
	parameter CHECK = 3'b011;
	parameter END = 3'b100;
	parameter SEARCH = 3'b101;
	parameter INIT = 3'b110;
    
    parameter UP = 3'b001;
	parameter DOWN = 3'b010;
	parameter LEFT = 3'b011;
	parameter RIGHT = 3'b100;

	reg [2 : 0] state, next_state, dir, next_dir;
	reg [3 : 0] get_rnd;
	reg [63 : 0] board;
	wire [25 : 0] sum;
	wire [3 : 0] arr [15 : 0];



	assign {arr[15], arr[14], arr[13], arr[12], arr[11], arr[10], arr[9], arr[8], arr[7], arr[6], arr[5], arr[4], arr[3], arr[2], arr[1], arr[0]} = board;

	assign sum = (((arr[15]+arr[14])+(arr[13]+arr[12]))+((arr[11]+arr[10])+(arr[9]+arr[8])))+(((arr[7]+arr[6])+(arr[5]+arr[4]))+((arr[3]+arr[2])+(arr[1]+arr[0])));



	MoveUp mu(board, up_board);
	MoveDown md(board, down_board);
	MoveRight mr(board, right_board);
	MoveLeft ml(board, left_board);
	GenPlace genb1(clk, rst, board, gen_board);
	RandGen4 rnd1(clk, rst, get_rnd);

	always@(posedge clk) begin
		if(start == 1) begin
			state <= INPUT;
			dir <= 3'b0;
			board <= in;
		end else begin
			state <= next_state;
			dir <= next_dir;
			board <= next_board;
		end
	end

	reg[10 : 0] count, next_count;
	always@(posedge clk) begin
		if(start == 1) begin
			count <= 11'd20;
		end else count <= next_count;
	end

	always@(posedge clk) begin
		if(start == 1) out <= 0;
		else out <= out + next_out;
	end

	always@(*) begin
		if(count == 0) next_count = 11'd20;
		else next_count = (state == CHECK ? count - 1 : count);
	end

	always@(*) begin
		if(state == INPUT) next_dir = 3'b001 + get_rnd % 4;
		end else if (state == CHECK) next_dir = 3'b0;
		end else if (state == INIT) next_dit = 3'b0;
		else next_dir = dir;
	end

	always@(*) begin
		next_out = 0;
		case(state)
			INIT: begin
				next_state = INPUT;
			end
			INPUT: begin
				if(next_dir != 3'b0) next_state = MERGE;
				else next_state = INPUT;
			end
			MERGE: begin
			     case(dir)
			         UP: next_state = (board == up_board ? SEARCH : GEN);
			         DOWN: next_state = (board == down_board ? SEARCH : GEN);
			         LEFT: next_state = (board == left_board ? SEARCH : GEN);
			         RIGHT: next_state = (board == right_board ? SEARCH : GEN);
			         default next_state = GEN;
			     endcase
			end
			SEARCH: next_state = CHECK;
			GEN: next_state = CHECK;
			CHECK: begin
				if(count == 0) begin
					next_state = INIT;
					next_out = sum;
				end
				else next_state = INPUT;
			end
			END: next_state = END;
			default: next_state = END;
		endcase
	end

	always@(*) begin
		if(state == INIT) board = in;
		if(state == MERGE) begin
			case(dir)
				UP: next_board =  up_board;
				DOWN: next_board =  down_board;
				LEFT: next_board =  left_board;
				RIGHT: next_board =  right_board;
				default: next_board =  board;
			endcase
		end else if(state == GEN) begin
		        next_board = gen_board;
		end else next_board = board;
	end

endmodule


module GenPlace(clk, rst, in, out);
	input clk, rst;
	input [64 - 1 : 0] in;
	output reg [64 - 1 : 0] out;
	wire [3 : 0] arr [15 : 0];
	wire [3 : 0] prefix [15 : 0];
    wire [3 : 0] get_gen, gen_place, new_num;



	parameter EMPTY = 4'b0000;

	RandGen4 gen1(clk, rst, get_gen);

	assign {arr[15], arr[14], arr[13], arr[12], arr[11], arr[10], arr[9], arr[8], arr[7], arr[6], arr[5], arr[4], arr[3], arr[2], arr[1], arr[0]} = in;

	assign gen_place = (get_gen % prefix[0]) + 1;
	assign new_num = (get_gen % 10) == 0 ? 4'b0010 : 4'b0001;

	assign prefix[15] = (arr[15] == EMPTY);
	assign prefix[14] = (arr[14] == EMPTY) + (arr[15] == EMPTY);
	assign prefix[13] = prefix[14] + (arr[13] == EMPTY);
	assign prefix[12] = prefix[14] + ((arr[13] == EMPTY) + (arr[12] == EMPTY));
	assign prefix[11] = prefix[12] + (arr[11] == EMPTY);
	assign prefix[10] = prefix[12] + ((arr[11] == EMPTY) + (arr[10] == EMPTY));
	assign prefix[9]  = prefix[10] + (arr[9] == EMPTY);
	assign prefix[8]  = prefix[10] + ((arr[9] == EMPTY) + (arr[8] == EMPTY));
	assign prefix[7]  = prefix[8] + (arr[7] == EMPTY);
	assign prefix[6]  = prefix[8] + ((arr[7] == EMPTY) + (arr[6] == EMPTY));
	assign prefix[5]  = prefix[6] + (arr[5] == EMPTY);
	assign prefix[4]  = prefix[6] + ((arr[5] == EMPTY) + (arr[4] == EMPTY));
	assign prefix[3]  = prefix[4] + (arr[3] == EMPTY);
	assign prefix[2]  = prefix[4] + ((arr[3] == EMPTY) + (arr[2] == EMPTY));
	assign prefix[1]  = prefix[2] + ((arr[1] == EMPTY));
	assign prefix[0]  = prefix[2] + ((arr[1] == EMPTY) + (arr[0] == EMPTY));

    always@(*) begin
        if(prefix[15] == gen_place && arr[15] == EMPTY) out = {new_num, in[59 : 0]};
        else if(prefix[14] == gen_place && arr[14] == EMPTY) out = {in[63 : 60], new_num, in[55 : 0]};
        else if(prefix[13] == gen_place && arr[13] == EMPTY) out = {in[63 : 56], new_num, in[51 : 0]};
        else if(prefix[12] == gen_place && arr[12] == EMPTY) out = {in[63 : 52], new_num, in[47 : 0]};
        else if(prefix[11] == gen_place && arr[11] == EMPTY) out = {in[63 : 48], new_num, in[43 : 0]};
        else if(prefix[10] == gen_place && arr[10] == EMPTY) out = {in[63 : 44], new_num, in[39 : 0]};
        else if(prefix[9] == gen_place && arr[9] == EMPTY) out = {in[63 : 40], new_num, in[35 : 0]};
        else if(prefix[8] == gen_place && arr[8] == EMPTY) out = {in[63 : 36], new_num, in[31 : 0]};
        else if(prefix[7] == gen_place && arr[7] == EMPTY) out = {in[63 : 32], new_num, in[27 : 0]};
        else if(prefix[6] == gen_place && arr[6] == EMPTY) out = {in[63 : 28], new_num, in[23 : 0]};
        else if(prefix[5] == gen_place && arr[5] == EMPTY) out = {in[63 : 24], new_num, in[19 : 0]};
        else if(prefix[4] == gen_place && arr[4] == EMPTY) out = {in[63 : 20], new_num, in[15 : 0]};
        else if(prefix[3] == gen_place && arr[3] == EMPTY) out = {in[63 : 16], new_num, in[11 : 0]};
        else if(prefix[2] == gen_place && arr[2] == EMPTY) out = {in[63 : 12], new_num, in[7 : 0]};
        else if(prefix[1] == gen_place && arr[1] == EMPTY) out = {in[63 : 8], new_num, in[3 : 0]};
        else if(prefix[0] == gen_place && arr[0] == EMPTY) out = {in[63 : 4], new_num};
        else out = in;
    end
    
endmodule

module RandGen4(clk, rst, out);
	input clk, rst;
	output [3 : 0] out;
	reg[7 : 0] DFF;
	always@(posedge clk) begin
		if(rst) DFF <= 8'b01110101;
		else begin
			DFF[0] <= DFF[1];
			DFF[1] <= DFF[2];
			DFF[2] <= DFF[3];
			DFF[3] <= DFF[4] ^ DFF[1];
			DFF[4] <= DFF[5];
			DFF[5] <= DFF[6];
			DFF[6] <= DFF[7];
			DFF[7] <= DFF[0] ^ DFF[1];
		end
	end
	assign out = DFF[3:0];
endmodule




module MoveUp(in, out);
	input [64 - 1 : 0] in;
	output [64 - 1 : 0] out;
	Merge mer1 ({in[15:12], in[31:28], in[47:44], in[63:60]}, {out[15:12], out[31:28], out[47:44], out[63:60]});
	Merge mer2 ({in[11:8], in[27:24], in[43:40], in[59:56]}, {out[11:8], out[27:24], out[43:40], out[59:56]});
	Merge mer3 ({in[7:4], in[23:20], in[39:36], in[55:52]}, {out[7:4], out[23:20], out[39:36], out[55:52]});
	Merge mer4 ({in[3:0], in[19:16], in[35:32], in[51:48]}, {out[3:0], out[19:16], out[35:32], out[51:48]});
endmodule

module MoveDown(in, out);
	input [64 - 1 : 0] in;
	output [64 - 1 : 0] out;
	Merge mer1 ({in[63:60], in[47:44], in[31:28], in[15:12]}, {out[63:60], out[47:44], out[31:28], out[15:12]});
	Merge mer2 ({in[59:56], in[43:40], in[27:24], in[11:8]}, {out[59:56], out[43:40], out[27:24], out[11:8]});
	Merge mer3 ({in[55:52], in[39:36], in[23:20], in[7:4]}, {out[55:52], out[39:36], out[23:20], out[7:4]});
	Merge mer4 ({in[51:48], in[35:32], in[19:16], in[3:0]}, {out[51:48], out[35:32], out[19:16], out[3:0]});
endmodule

module MoveLeft(in, out);
	input [64 - 1 : 0] in;
	output [64 - 1 : 0] out;
	Merge mer1 ({in[51:48], in[55:52], in[59:56], in[63:60]}, {out[51:48], out[55:52], out[59:56], out[63:60]});
	Merge mer2 ({in[35:32], in[39:36], in[43:40], in[47:44]}, {out[35:32], out[39:36], out[43:40], out[47:44]});
	Merge mer3 ({in[19:16], in[23:20], in[27:24], in[31:28]}, {out[19:16], out[23:20], out[27:24], out[31:28]});
	Merge mer4 ({in[3:0], in[7:4], in[11:8], in[15:12]}, {out[3:0], out[7:4], out[11:8], out[15:12]});
endmodule

module MoveRight(in, out);
	input [64- 1 : 0] in;
	output [64 - 1 : 0] out;
	Merge mer1 (in[63 : 48], out[63 : 48]);
	Merge mer2 (in[47 : 32], out[47 : 32]);
	Merge mer3 (in[31 : 16], out[31 : 16]);
	Merge mer4 (in[15 : 0], out[15 : 0]);
endmodule


module Merge(in, out);
	input [64 - 1:0] in;
	output reg [64 - 1 : 0] out;
	parameter zero = 4'b0;
	wire [4 - 1 : 0] arr[3 : 0];
	wire [3 : 0] type;

	assign {arr[3], arr[2], arr[1], arr[0]} = in;
	assign type = {arr[3] != zero, arr[2] != zero, arr[1] != zero, arr[0] != zero};

	always@(*) begin
		case (type)
			4'b0000: out = 0;
			4'b0001: out = in;
			4'b0010: out = {{3{zero}}, arr[1]};
			4'b0011:begin
				if(arr[0] == arr[1]) out = {{3{zero}}, arr[0] + 4'b1};
				else out = {{2{zero}}, arr[1], arr[0]};
			end
			4'b0100: out = {{3{zero}}, arr[2]};
			4'b0101:begin
				if(arr[0] == arr[2]) out = {{3{zero}}, arr[0] + 4'b1};
				else out = {{2{zero}}, arr[2], arr[0]};
			end
			4'b0110:begin
				if(arr[1] == arr[2]) out = {{3{zero}}, arr[1] + 4'b1};
				else out = {{2{zero}}, arr[2], arr[1]};
			end
			4'b0111:begin
				if(arr[0] == arr[1]) out = {{2{zero}}, arr[2], arr[0] + 4'b1};
				else if(arr[1] == arr[2]) out = {{2{zero}}, arr[1] + 4'b1, arr[0]};
				else out = in;
			end
			4'b1000: out = {{3{zero}}, arr[3]};
			4'b1001:begin
				if(arr[0] == arr[3]) out = {{3{zero}}, arr[0] + 4'b1};
				else out = {{2{zero}}, arr[3], arr[0]};
			end
			4'b1010:begin
				if(arr[1] == arr[3]) out = {{3{zero}}, arr[1] + 4'b1};
				else out = {{2{zero}}, arr[3], arr[1]};
			end
			4'b1011:begin
				if(arr[0] == arr[1]) out = {{2{zero}}, arr[3], arr[0] + 4'b1};
				else if(arr[1] == arr[3]) out = {{2{zero}}, arr[1] + 4'b1, arr[0]};
				else out = {zero, arr[3], arr[1], arr[0]};
			end
			4'b1100:begin
				if(arr[2] == arr[3]) out = {{3{zero}}, arr[2] + 4'b1};
				else out = {{2{zero}}, arr[3], arr[2]};
			end
			4'b1101:begin
				if(arr[0] == arr[1]) out = {{2{zero}}, arr[3], arr[0] + 4'b1};
				else if(arr[2] == arr[3]) out = {{2{zero}}, arr[2] + 4'b1, arr[0]};
				else out = {zero, arr[3], arr[2], arr[0]};
			end
			4'b1110:begin
				if(arr[1] == arr[2]) out = {{2{zero}}, arr[3], arr[1] + 4'b1};
				else if(arr[2] == arr[3]) out = {{2{zero}}, arr[2] + 4'b1, arr[1]};
				else out = {zero, arr[3], arr[2], arr[1]};
			end
			4'b1111:begin
				if(arr[0] == arr[1]) begin
					if(arr[1] == arr[2]) out = {{2{zero}}, arr[2] + 4'b1, arr[0] + 4'b1};
					else out = {zero, arr[3], arr[2], arr[1] + 4'b1};
				end	else if(arr[1] == arr[2]) out = {zero, arr[3], arr[1] + 4'b1, arr[0]};
				else if(arr[2] == arr[3])out = {zero, arr[2] + 4'b1, arr[1], arr[0]};
				else out = in;
			end
			default: out = in;
		endcase
	end
endmodule
