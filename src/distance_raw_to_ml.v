module distanceraw_to_cm (
    input  wire [20:0] distance_raw,    // Giá trị đếm số chu kỳ echo = 1
    output reg  [15:0] distance_cm      // Giá trị khoảng cách tính theo cm
);

    // Hệ số scale:
    // distance_cm = distance_raw * 0.0003448
    // Ta xấp xỉ: cm = (distance_raw * 346) / 1_000_000

    always @(*) begin
        distance_cm = (distance_raw * 16'd346) / 32'd1000000;
    end

endmodule
