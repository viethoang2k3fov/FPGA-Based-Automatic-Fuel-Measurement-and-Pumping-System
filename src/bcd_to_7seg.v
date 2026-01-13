module bcd_to_7seg (
    input wire [3:0] bcd_HEX0,   // Giá trị BCD đầu vào (0-9)
	 input wire [3:0] bcd_HEX1,
	 input wire [3:0] bcd_HEX2,
	 input wire [3:0] bcd_HEX3,
	 input wire [3:0] bcd_HEX4,
	 input wire [3:0] bcd_HEX5,
	 
    output reg [6:0] seg0 ,  
	 output reg [6:0] seg1 ,
	 output reg [6:0] seg2 ,
	 output reg [6:0] seg3 ,
	 output reg [6:0] seg4 ,
	 output reg [6:0] seg5 
	// Đầu ra điều khiển LED 7 đoạn (đã đảo bit)
);

always @(*) begin
    case (bcd_HEX0)
        4'd0:  seg0 = 7'b1000000; // Hiển thị số 0
        4'd1:  seg0 = 7'b1111001; // Hiển thị số 1
        4'd2:  seg0 = 7'b0100100; // Hiển thị số 2
        4'd3:  seg0 = 7'b0110000; // Hiển thị số 3
        4'd4:  seg0 = 7'b0011001; // Hiển thị số 4
        4'd5:  seg0 = 7'b0010010; // Hiển thị số 5
        4'd6:  seg0 = 7'b0000010; // Hiển thị số 6
        4'd7:  seg0 = 7'b1111000; // Hiển thị số 7
        4'd8:  seg0 = 7'b0000000; // Hiển thị số 8
        4'd9:  seg0 = 7'b0010000; // Hiển thị số 9
        default: seg0 = 7'b1111111; // Tắt LED nếu giá trị không hợp lệ
    endcase
	 end
	 
	 
always @(*) begin
    case (bcd_HEX1)
        4'd0:  seg1 = 7'b1000000; // Hiển thị số 0
        4'd1:  seg1 = 7'b1111001; // Hiển thị số 1
        4'd2:  seg1 = 7'b0100100; // Hiển thị số 2
        4'd3:  seg1 = 7'b0110000; // Hiển thị số 3
        4'd4:  seg1 = 7'b0011001; // Hiển thị số 4
        4'd5:  seg1 = 7'b0010010; // Hiển thị số 5
        4'd6:  seg1 = 7'b0000010; // Hiển thị số 6
        4'd7:  seg1 = 7'b1111000; // Hiển thị số 7
        4'd8:  seg1 = 7'b0000000; // Hiển thị số 8
        4'd9:  seg1 = 7'b0010000; // Hiển thị số 9
        default: seg1 = 7'b1111111; // Tắt LED nếu giá trị không hợp lệ
    endcase
	 end	 

	 
always @(*) begin
    case (bcd_HEX2)
        4'd0:  seg2 = 7'b1000000; // Hiển thị số 0
        4'd1:  seg2 = 7'b1111001; // Hiển thị số 1
        4'd2:  seg2 = 7'b0100100; // Hiển thị số 2
        4'd3:  seg2 = 7'b0110000; // Hiển thị số 3
        4'd4:  seg2 = 7'b0011001; // Hiển thị số 4
        4'd5:  seg2 = 7'b0010010; // Hiển thị số 5
        4'd6:  seg2 = 7'b0000010; // Hiển thị số 6
        4'd7:  seg2 = 7'b1111000; // Hiển thị số 7
        4'd8:  seg2 = 7'b0000000; // Hiển thị số 8
        4'd9:  seg2 = 7'b0010000; // Hiển thị số 9
        default: seg2 = 7'b1111111; // Tắt LED nếu giá trị không hợp lệ
    endcase
	 end	 
	 

always @(*) begin
    case (bcd_HEX3)
        4'd0:  seg3 = 7'b1000000; // Hiển thị số 0
        4'd1:  seg3 = 7'b1111001; // Hiển thị số 1
        4'd2:  seg3 = 7'b0100100; // Hiển thị số 2
        4'd3:  seg3 = 7'b0110000; // Hiển thị số 3
        4'd4:  seg3 = 7'b0011001; // Hiển thị số 4
        4'd5:  seg3 = 7'b0010010; // Hiển thị số 5
        4'd6:  seg3 = 7'b0000010; // Hiển thị số 6
        4'd7:  seg3 = 7'b1111000; // Hiển thị số 7
        4'd8:  seg3 = 7'b0000000; // Hiển thị số 8
        4'd9:  seg3 = 7'b0010000; // Hiển thị số 9
        default: seg3 = 7'b1111111; // Tắt LED nếu giá trị không hợp lệ
    endcase
	 end	 


always @(*) begin
    case (bcd_HEX4)
        4'd0:  seg4 = 7'b1000000; // Hiển thị số 0
        4'd1:  seg4 = 7'b1111001; // Hiển thị số 1
        4'd2:  seg4 = 7'b0100100; // Hiển thị số 2
        4'd3:  seg4 = 7'b0110000; // Hiển thị số 3
        4'd4:  seg4 = 7'b0011001; // Hiển thị số 4
        4'd5:  seg4 = 7'b0010010; // Hiển thị số 5
        4'd6:  seg4 = 7'b0000010; // Hiển thị số 6
        4'd7:  seg4 = 7'b1111000; // Hiển thị số 7
        4'd8:  seg4 = 7'b0000000; // Hiển thị số 8
        4'd9:  seg4 = 7'b0010000; // Hiển thị số 9
        default: seg4 = 7'b1111111; // Tắt LED nếu giá trị không hợp lệ
    endcase
	 end	 
	 
	 
always @(*) begin
    case (bcd_HEX5)
        4'd0:  seg5 = 7'b1000000; // Hiển thị số 0
        4'd1:  seg5 = 7'b1111001; // Hiển thị số 1
        4'd2:  seg5 = 7'b0100100; // Hiển thị số 2
        4'd3:  seg5 = 7'b0110000; // Hiển thị số 3
        4'd4:  seg5 = 7'b0011001; // Hiển thị số 4
        4'd5:  seg5 = 7'b0010010; // Hiển thị số 5
        4'd6:  seg5 = 7'b0000010; // Hiển thị số 6
        4'd7:  seg5 = 7'b1111000; // Hiển thị số 7
        4'd8:  seg5 = 7'b0000000; // Hiển thị số 8
        4'd9:  seg5 = 7'b0010000; // Hiển thị số 9
        default: seg5 = 7'b1111111; // Tắt LED nếu giá trị không hợp lệ
    endcase
	 end	 
		 
		 
	 
		 
		 
		 
endmodule