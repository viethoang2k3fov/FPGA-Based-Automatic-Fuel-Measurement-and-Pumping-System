module relay_volume_control(
    input wire clk,              // Clock 1 MHz
    input wire btn0,             // Nút chọn 200 ml
    input wire btn1,             // Nút chọn 500 ml
    input wire btn2,             // Nút chọn 1000 ml
	 input wire [1:0]  mode,
	 
    input wire sw1,              // CÔNG TẮC DỪNG BƠM KHẨN
    output reg relay_manual         // Tín hiệu điều khiển relay
);

    // Debounce
    reg b0_d, b0_d2;
    reg b1_d, b1_d2;
    reg b2_d, b2_d2;

    // Bộ đếm thời gian
    reg [47:0] clk_count;
    reg [47:0] max_count;
    reg busy;

    always @(posedge clk) begin
        // ======================
        // Debounce nút nhấn
        // ======================
        b0_d  <= btn0;   b0_d2 <= b0_d;
        b1_d  <= btn1;   b1_d2 <= b1_d;
        b2_d  <= btn2;   b2_d2 <= b2_d;
 if(mode == 2'b00) begin
        // ======================
        // DỪNG BƠM KHẨN
        // ======================
		  
        if (sw1) begin
            relay_manual <= 0;
            busy      <= 0;
            clk_count <= 0;
        end
        else begin
            // ===== KÍCH HOẠT BƠM =====
            if (!busy) begin
                relay_manual <= 0;

                if (b0_d2 && !b0_d) begin
                    max_count <= 6818181;   // 3 giây (200ml ) 
                    clk_count <= 0;
                    busy <= 1;
                    relay_manual <= 1;
                end
                else if (b1_d2 && !b1_d) begin
                    max_count <= 17045454;   // 7.5 giây ( 500 ml ) 
                    clk_count <= 0;
                    busy <= 1;
                    relay_manual <= 1;
                end
                else if (b2_d2 && !b2_d) begin
                    max_count <= 34090909;  // 15 giây ( 1000ml ) 
                    clk_count <= 0;
                    busy <= 1;
                    relay_manual <= 1;
                end
            end

            // ===== ĐANG BƠM =====
            else begin
                clk_count <= clk_count + 1;

                if (clk_count >= max_count) begin
                    relay_manual <= 0;
                    busy <= 0;
                end
            end
        end
    end
end
endmodule
