module num_to_ascii(
    input  wire [16:0] num,
    output reg  [47:0] ascii_str  // 10 ký tự ASCII, mỗi ký tự 8 bit
);
    integer i;
    reg [16:0] temp;
    reg [3:0] digit;

    always @(*) begin
    temp = num;
    ascii_str = 80'b0;

    for (i = 0 ; i < 6; i = i + 1) begin
        digit = temp % 10;
        ascii_str[(8*i) +: 8] = 8'h30 + digit;   // không đảo chiều
        temp = temp / 10;
    end
end



endmodule
