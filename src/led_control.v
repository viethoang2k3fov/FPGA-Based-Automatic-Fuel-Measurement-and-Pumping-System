module led_control (
    input         clk,          // clock 1 MHz
    input  [15:0] volume_ml,     // thể tích (ml)
    output reg    led            // đèn cảnh báo
);

    always @(posedge clk) begin
        if (volume_ml < 16'd400)
            led <= 1'b1;   // bật đèn cảnh báo
        else
            led <= 1'b0;   // tắt đèn
    end

endmodule
