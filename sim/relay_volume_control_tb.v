`timescale 1us/1ns   // 1 us = 1 MHz

module tb_relay_volume_control;

    reg clk;
    reg rst_n;
    reg btn0;
    reg btn1;
    reg btn2;
    wire relay_out;

    // DUT
    relay_volume_control dut (
        .clk(clk),
        .rst_n(rst_n),
        .btn0(btn0),
        .btn1(btn1),
        .btn2(btn2),
        .relay_out(relay_out)
    );

    // Clock 1 MHz
    always #0.5 clk = ~clk;

    // Task nhấn nút
    task press_btn0;
    begin
        btn0 = 1;
        #5;
        btn0 = 0;
    end
    endtask

    task press_btn1;
    begin
        btn1 = 1;
        #5;
        btn1 = 0;
    end
    endtask

    task press_btn2;
    begin
        btn2 = 1;
        #5;
        btn2 = 0;
    end
    endtask

    initial begin
        // Init
        clk  = 0;
        btn0 = 0;
        btn1 = 0;
        btn2 = 0;
        rst_n = 0;

        // Reset
        #5;
        rst_n = 1;

        // ===== TEST BTN0 =====
        #10;
        press_btn0();
        #3_500_000;

        // ===== TEST BTN1 =====
        press_btn1();
        #8_000_000;

        // ===== TEST BTN2 =====
        press_btn2();
        #16_000_000;

        $stop;
    end

endmodule
