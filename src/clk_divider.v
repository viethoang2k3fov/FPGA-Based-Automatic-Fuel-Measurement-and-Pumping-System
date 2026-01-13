module clk_divider(
    input wire clk_50MHz,    // Ngõ vào tần số 50 MHz
    output reg clk_1MHz      // Ngõ ra tần số 1 MHz
);

    // Định nghĩa số đếm cần thiết để chia tần số
    reg [5:0] counter;  // Bộ đếm 6 bit (0-49)

    always @(posedge clk_50MHz) begin
        if (counter == 24) begin
            counter <= 0;
            clk_1MHz <= ~clk_1MHz;  // Đảo ngược tín hiệu ngõ ra mỗi lần đếm đủ
        end else begin
            counter <= counter + 1;
        end
    end

endmodule
