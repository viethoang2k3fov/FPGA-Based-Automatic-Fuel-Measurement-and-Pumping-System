module num_to_ascii_mini(
    input  wire [16:0] num_mini,
    output reg  [47:0] ascii_str_mini // 10 ký tự ASCII, mỗi ký tự 8 bit
);
    integer i;
    reg [16:0] temp;
    reg [3:0] digit;

    always @(*) begin
    temp = num_mini;
    ascii_str_mini = 80'b0;

    for (i = 0 ; i < 6; i = i + 1) begin
        digit = temp % 10;
        ascii_str_mini[(8*i) +: 8] = 8'h30 + digit;   // không đảo chiều
        temp = temp / 10;
    end
end



endmodule
