
`timescale 1ns/1ps
// Clock 50 MHz → chu kỳ 20 ns

module tb_ultrasonic;

    // =====================
    // TÍN HIỆU TEST
    // =====================
    reg clk;
    reg echo;

    wire trigger;
    wire new_measure;
    wire timeout;
    wire [20:0] distance_raw;

    // =====================
    // DUT
    // =====================
    ultrasonic dut (
        .clk(clk),
        .echo(echo),
        .trigger(trigger),
        .distance_raw(distance_raw),
        .new_measure(new_measure),
        .timeout(timeout)
    );

    // =====================
    // CLOCK 50 MHz
    // =====================
    always #10 clk = ~clk;   // 20 ns period

    // =====================
    // TASK MÔ PHỎNG ECHO
    // =====================
    // echo_delay_us : thời gian chờ sau trigger (us)
    // echo_width_us : độ rộng xung echo (us)
    task send_echo;
        input integer echo_delay_us;
        input integer echo_width_us;
        begin
            #(echo_delay_us * 1000);  // đổi us → ns
            echo = 1;
            #(echo_width_us * 1000);
            echo = 0;
        end
    endtask

    // =====================
    // SEQUENCE TEST
    // =====================
    initial begin
        // Init
        clk  = 0;
        echo = 0;

        // =====================
        // TEST CASE 1: ĐO BÌNH THƯỜNG
        // =====================
        // Echo lên sau 750us, kéo dài 300us
        // distance_raw ≈ 50MHz × 300us = ~15000
        @(posedge trigger);
        send_echo(750, 300);

        // đợi kết quả
        wait(new_measure);
        #100_000;

        // =====================
        // TEST CASE 2: ĐO XA HƠN
        // =====================
        // Echo dài hơn
        @(posedge trigger);
        send_echo(750, 600);

        wait(new_measure);
        #100_000;

        // =====================
        // TEST CASE 3: TIMEOUT (KHÔNG CÓ ECHO)
        // =====================
        @(posedge trigger);
        // không phát echo → timeout

        wait(new_measure);
        #100_000;

        $stop;
    end

endmodule
