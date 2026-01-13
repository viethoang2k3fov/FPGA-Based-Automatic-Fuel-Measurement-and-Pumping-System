module relay_automatic (
    input  wire        clk,           // 1 MHz
    input  wire [15:0] distance_cm,
    input  wire        btn0,
    input  wire        btn1,
    input  wire        btn2,
	 input  wire [1:0]  mode,
    output reg         relay_auto
);

    localparam [15:0] STOP_DISTANCE = 16'd12;
    localparam [31:0] STOP_DELAY    = 32'd100_000; // 100 ms @1MHz

    // Debounce
    reg b0_d, b0_d2;
    reg b1_d, b1_d2;
    reg b2_d, b2_d2;

    // Time counter
    reg [47:0] clk_count;
    reg [47:0] max_count;
    reg        busy;

    // Stop confirm counter
    reg [31:0] stop_cnt;

	 
    always @(posedge clk) begin
        // ---------------- Debounce ----------------
        b0_d  <= btn0;  b0_d2 <= b0_d;
        b1_d  <= btn1;  b1_d2 <= b1_d;
        b2_d  <= btn2;  b2_d2 <= b2_d;
    if(mode == 2'b01) begin
        // ---------------- STOP CONFIRM ----------------
        if (busy && distance_cm != 0 && distance_cm < STOP_DISTANCE)
            stop_cnt <= stop_cnt + 1'b1;
        else
            stop_cnt <= 32'd0;

        if (busy && stop_cnt >= STOP_DELAY) begin
            relay_auto <= 1'b0;
            busy       <= 1'b0;
            clk_count  <= 48'd0;
        end
        else begin
            // ---------------- IDLE ----------------
            if (!busy) begin
                relay_auto <= 1'b0;

                if (!b0_d2 && b0_d) begin
                    max_count   <= 6818181;
                    clk_count  <= 48'd0;
                    busy       <= 1'b1;
                    relay_auto <= 1'b1;
                end
                else if (!b1_d2 && b1_d) begin
                    max_count   <= 17045454;
                    clk_count  <= 48'd0;
                    busy       <= 1'b1;
                    relay_auto <= 1'b1;
                end
                else if (!b2_d2 && b2_d) begin
                    max_count   <= 34090909;
                    clk_count  <= 48'd0;
                    busy       <= 1'b1;
                    relay_auto <= 1'b1;
                end
            end

            // ---------------- RUN ----------------
            else begin
                clk_count <= clk_count + 1'b1;
                if (clk_count >= max_count) begin
                    relay_auto <= 1'b0;
                    busy       <= 1'b0;
                end
            end
        end
    end
end
endmodule
