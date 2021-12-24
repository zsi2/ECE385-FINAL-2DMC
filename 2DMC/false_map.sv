module false_map

(

	input logic [9:0] corner_x,corner_y, // lefttop corner of buffer
	
	output logic [63:0] row_0,row_1,row_2,row_3,row_4,row_5,row_6,row_7,row_8,row_9,row_10,row_11,
	
	input logic [9:0] changex,changey,
	
	input logic [1:0]operation,
	
	input logic Clk,Reset_h,
	
	input logic [3:0] push_id
	

);

logic [3:0] wdata,wdata_in;
logic [3:0]we,we_in;
logic [10:0] waddr;

wire [511:0] chunkrows [11:0];


ram_chunk0 m00(.clock(Clk),.data(wdata),.wraddress(waddr),.wren(we[0]),.rdaddress(corner_y),.q(chunkrows[0][511:384]));
ram_chunk0 m01(.clock(Clk),.data(wdata),.wraddress(waddr),.wren(we[0]),.rdaddress(corner_y+1),.q(chunkrows[1][511:384]));
ram_chunk0 m02(.clock(Clk),.data(wdata),.wraddress(waddr),.wren(we[0]),.rdaddress(corner_y+2),.q(chunkrows[2][511:384]));
ram_chunk0 m03(.clock(Clk),.data(wdata),.wraddress(waddr),.wren(we[0]),.rdaddress(corner_y+3),.q(chunkrows[3][511:384]));
ram_chunk0 m04(.clock(Clk),.data(wdata),.wraddress(waddr),.wren(we[0]),.rdaddress(corner_y+4),.q(chunkrows[4][511:384]));
ram_chunk0 m05(.clock(Clk),.data(wdata),.wraddress(waddr),.wren(we[0]),.rdaddress(corner_y+5),.q(chunkrows[5][511:384]));
ram_chunk0 m06(.clock(Clk),.data(wdata),.wraddress(waddr),.wren(we[0]),.rdaddress(corner_y+6),.q(chunkrows[6][511:384]));
ram_chunk0 m07(.clock(Clk),.data(wdata),.wraddress(waddr),.wren(we[0]),.rdaddress(corner_y+7),.q(chunkrows[7][511:384]));
ram_chunk0 m08(.clock(Clk),.data(wdata),.wraddress(waddr),.wren(we[0]),.rdaddress(corner_y+8),.q(chunkrows[8][511:384]));
ram_chunk0 m09(.clock(Clk),.data(wdata),.wraddress(waddr),.wren(we[0]),.rdaddress(corner_y+9),.q(chunkrows[9][511:384]));
ram_chunk0 m010(.clock(Clk),.data(wdata),.wraddress(waddr),.wren(we[0]),.rdaddress(corner_y+10),.q(chunkrows[10][511:384]));
ram_chunk0 m011(.clock(Clk),.data(wdata),.wraddress(waddr),.wren(we[0]),.rdaddress(corner_y+11),.q(chunkrows[11][511:384]));

ram_chunk1 m10(.clock(Clk),.data(wdata),.wraddress(waddr),.wren(we[1]),.rdaddress(corner_y),.q(chunkrows[0][383:256]));
ram_chunk1 m11(.clock(Clk),.data(wdata),.wraddress(waddr),.wren(we[1]),.rdaddress(corner_y+1),.q(chunkrows[1][383:256]));
ram_chunk1 m12(.clock(Clk),.data(wdata),.wraddress(waddr),.wren(we[1]),.rdaddress(corner_y+2),.q(chunkrows[2][383:256]));
ram_chunk1 m13(.clock(Clk),.data(wdata),.wraddress(waddr),.wren(we[1]),.rdaddress(corner_y+3),.q(chunkrows[3][383:256]));
ram_chunk1 m14(.clock(Clk),.data(wdata),.wraddress(waddr),.wren(we[1]),.rdaddress(corner_y+4),.q(chunkrows[4][383:256]));
ram_chunk1 m15(.clock(Clk),.data(wdata),.wraddress(waddr),.wren(we[1]),.rdaddress(corner_y+5),.q(chunkrows[5][383:256]));
ram_chunk1 m16(.clock(Clk),.data(wdata),.wraddress(waddr),.wren(we[1]),.rdaddress(corner_y+6),.q(chunkrows[6][383:256]));
ram_chunk1 m17(.clock(Clk),.data(wdata),.wraddress(waddr),.wren(we[1]),.rdaddress(corner_y+7),.q(chunkrows[7][383:256]));
ram_chunk1 m18(.clock(Clk),.data(wdata),.wraddress(waddr),.wren(we[1]),.rdaddress(corner_y+8),.q(chunkrows[8][383:256]));
ram_chunk1 m19(.clock(Clk),.data(wdata),.wraddress(waddr),.wren(we[1]),.rdaddress(corner_y+9),.q(chunkrows[9][383:256]));
ram_chunk1 m110(.clock(Clk),.data(wdata),.wraddress(waddr),.wren(we[1]),.rdaddress(corner_y+10),.q(chunkrows[10][383:256]));
ram_chunk1 m111(.clock(Clk),.data(wdata),.wraddress(waddr),.wren(we[1]),.rdaddress(corner_y+11),.q(chunkrows[11][383:256]));

ram_chunk2 m20(.clock(Clk),.data(wdata),.wraddress(waddr),.wren(we[2]),.rdaddress(corner_y),.q(chunkrows[0][255:128]));
ram_chunk2 m21(.clock(Clk),.data(wdata),.wraddress(waddr),.wren(we[2]),.rdaddress(corner_y+1),.q(chunkrows[1][255:128]));
ram_chunk2 m22(.clock(Clk),.data(wdata),.wraddress(waddr),.wren(we[2]),.rdaddress(corner_y+2),.q(chunkrows[2][255:128]));
ram_chunk2 m23(.clock(Clk),.data(wdata),.wraddress(waddr),.wren(we[2]),.rdaddress(corner_y+3),.q(chunkrows[3][255:128]));
ram_chunk2 m24(.clock(Clk),.data(wdata),.wraddress(waddr),.wren(we[2]),.rdaddress(corner_y+4),.q(chunkrows[4][255:128]));
ram_chunk2 m25(.clock(Clk),.data(wdata),.wraddress(waddr),.wren(we[2]),.rdaddress(corner_y+5),.q(chunkrows[5][255:128]));
ram_chunk2 m26(.clock(Clk),.data(wdata),.wraddress(waddr),.wren(we[2]),.rdaddress(corner_y+6),.q(chunkrows[6][255:128]));
ram_chunk2 m27(.clock(Clk),.data(wdata),.wraddress(waddr),.wren(we[2]),.rdaddress(corner_y+7),.q(chunkrows[7][255:128]));
ram_chunk2 m28(.clock(Clk),.data(wdata),.wraddress(waddr),.wren(we[2]),.rdaddress(corner_y+8),.q(chunkrows[8][255:128]));
ram_chunk2 m29(.clock(Clk),.data(wdata),.wraddress(waddr),.wren(we[2]),.rdaddress(corner_y+9),.q(chunkrows[9][255:128]));
ram_chunk2 m210(.clock(Clk),.data(wdata),.wraddress(waddr),.wren(we[2]),.rdaddress(corner_y+10),.q(chunkrows[10][255:128]));
ram_chunk2 m211(.clock(Clk),.data(wdata),.wraddress(waddr),.wren(we[2]),.rdaddress(corner_y+11),.q(chunkrows[11][255:128]));

ram_chunk3 m30(.clock(Clk),.data(wdata),.wraddress(waddr),.wren(we[3]),.rdaddress(corner_y),.q(chunkrows[0][127:0]));
ram_chunk3 m31(.clock(Clk),.data(wdata),.wraddress(waddr),.wren(we[3]),.rdaddress(corner_y+1),.q(chunkrows[1][127:0]));
ram_chunk3 m32(.clock(Clk),.data(wdata),.wraddress(waddr),.wren(we[3]),.rdaddress(corner_y+2),.q(chunkrows[2][127:0]));
ram_chunk3 m33(.clock(Clk),.data(wdata),.wraddress(waddr),.wren(we[3]),.rdaddress(corner_y+3),.q(chunkrows[3][127:0]));
ram_chunk3 m34(.clock(Clk),.data(wdata),.wraddress(waddr),.wren(we[3]),.rdaddress(corner_y+4),.q(chunkrows[4][127:0]));
ram_chunk3 m35(.clock(Clk),.data(wdata),.wraddress(waddr),.wren(we[3]),.rdaddress(corner_y+5),.q(chunkrows[5][127:0]));
ram_chunk3 m36(.clock(Clk),.data(wdata),.wraddress(waddr),.wren(we[3]),.rdaddress(corner_y+6),.q(chunkrows[6][127:0]));
ram_chunk3 m37(.clock(Clk),.data(wdata),.wraddress(waddr),.wren(we[3]),.rdaddress(corner_y+7),.q(chunkrows[7][127:0]));
ram_chunk3 m38(.clock(Clk),.data(wdata),.wraddress(waddr),.wren(we[3]),.rdaddress(corner_y+8),.q(chunkrows[8][127:0]));
ram_chunk3 m39(.clock(Clk),.data(wdata),.wraddress(waddr),.wren(we[3]),.rdaddress(corner_y+9),.q(chunkrows[9][127:0]));
ram_chunk3 m310(.clock(Clk),.data(wdata),.wraddress(waddr),.wren(we[3]),.rdaddress(corner_y+10),.q(chunkrows[10][127:0]));
ram_chunk3 m311(.clock(Clk),.data(wdata),.wraddress(waddr),.wren(we[3]),.rdaddress(corner_y+11),.q(chunkrows[11][127:0]));

//display engine

logic [1:0] chunkcornerx,chunkchangex;
logic [9:0] chunkxcornerx, chunkxchangex;

assign chunkxcornerx=corner_x%32;
assign chunkcornerx=corner_x/32;
assign chunkchangex=changex/32;
assign chunkxchangex=changex%32;
// change waddr, wdata, we as a state machine triggered by operation

logic [3:0] change_state;

parameter hold=4'd0;
parameter set=4'd1;
parameter write=4'd2;

always_ff @(posedge Clk)
begin
	case(change_state)
	hold:
	begin
		we=4'b0;
		if(operation>0)
		change_state=set;
		else
		change_state=hold;
	end
	set:
	begin
		waddr=changey*32+(31-chunkxchangex);
		case(operation)
		2'd1: wdata=4'b0;
		2'd2: wdata=push_id;
		default: wdata=4'b0;
		endcase
		change_state=write;
	end
	write:
	begin
		case(chunkchangex)
		2'd0: we=4'b0001;
		2'd1: we=4'b0010;
		2'd2: we=4'b0100;
		2'd3: we=4'b1000;
		endcase
		change_state=hold;
	end
	default:
	begin
		change_state=hold;
	end
	endcase
end
		



always_comb
begin
row_0=chunkrows[0][(128-corner_x)*4-1-:64];
row_1=chunkrows[1][(128-corner_x)*4-1-:64];
row_2=chunkrows[2][(128-corner_x)*4-1-:64];
row_3=chunkrows[3][(128-corner_x)*4-1-:64];
row_4=chunkrows[4][(128-corner_x)*4-1-:64];
row_5=chunkrows[5][(128-corner_x)*4-1-:64];
row_6=chunkrows[6][(128-corner_x)*4-1-:64];
row_7=chunkrows[7][(128-corner_x)*4-1-:64];
row_8=chunkrows[8][(128-corner_x)*4-1-:64];
row_9=chunkrows[9][(128-corner_x)*4-1-:64];
row_10=chunkrows[10][(128-corner_x)*4-1-:64];
row_11=chunkrows[11][(128-corner_x)*4-1-:64];

end

// assign rows
endmodule

