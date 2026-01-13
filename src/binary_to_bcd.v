module binary_to_bcd(
    input wire [15:0] volume_ml,       // Giá trị ml cần hiển thị
    output reg [3:0] bcd_HEX0,         // đơn vị
    output reg [3:0] bcd_HEX1,         // chục
    output reg [3:0] bcd_HEX2,         // trăm
    output reg [3:0] bcd_HEX3,         // nghìn
    output reg [3:0] bcd_HEX4,         // 10 nghìn
    output reg [3:0] bcd_HEX5          // 100 nghìn
);

    integer i;
    reg [15:0] binary;
    reg [23:0] bcd_temp;  // 6 BCD x 4 bit = 24 bit

    always @(*) begin
        // Copy giá trị vào register tạm
        binary = volume_ml;
        bcd_temp = 0;

        // Double Dabble: shift bit từ binary vào BCD
        for (i = 15; i >= 0; i = i - 1) begin
            // Nếu bất kỳ nibble > 4, cộng 3
            if (bcd_temp[3:0] > 4) bcd_temp[3:0] = bcd_temp[3:0] + 3;
            if (bcd_temp[7:4] > 4) bcd_temp[7:4] = bcd_temp[7:4] + 3;
            if (bcd_temp[11:8] > 4) bcd_temp[11:8] = bcd_temp[11:8] + 3;
            if (bcd_temp[15:12] > 4) bcd_temp[15:12] = bcd_temp[15:12] + 3;
            if (bcd_temp[19:16] > 4) bcd_temp[19:16] = bcd_temp[19:16] + 3;
            if (bcd_temp[23:20] > 4) bcd_temp[23:20] = bcd_temp[23:20] + 3;

            // Shift left 1 bit
            bcd_temp = bcd_temp << 1;
            bcd_temp[0] = binary[i];  // nhét bit cao nhất vào
        end

        // Gán ra các BCD riêng lẻ
        bcd_HEX5 = bcd_temp[23:20];   // 100 nghìn
        bcd_HEX4 = bcd_temp[19:16];   // 10 nghìn
        bcd_HEX3 = bcd_temp[15:12];   // nghìn
        bcd_HEX2 = bcd_temp[11:8];    // trăm
        bcd_HEX1 = bcd_temp[7:4];     // chục
        bcd_HEX0 = bcd_temp[3:0];     // đơn vị
    end

endmodule
