module LCD1602(
    input           clk,
    input           rst_n,
	 input wire echo,
	 output wire trig,
    output          scl,
    inout           sda
);

    wire            clk_1MHz;
    wire            done_write;
    wire [7:0]      data;
    wire            cmd_data;
    wire            ena_write;
    wire [127:0]    row1;
    wire [127:0]    row2;
	 wire [31:0] volume_ml;
    wire [20:0] distance_raw ;
	 wire  [79:0]  ascii ;

    assign row1 =      {"00000",ascii} ;
    assign row2 =   "..Le Viet Hoang.";

    clk_divider clk_1MHz_gen(
        .clk        (clk),
        .clk_1MHz   (clk_1MHz)
    );

    lcd_display lcd_display_inst(
        .clk_1MHz   (clk_1MHz),
        .rst_n      (rst_n),
        .ena        (1'b1),
        .done_write (done_write),
        .row1       (row1),
        .row2       (row2),
        .data       (data),
        .cmd_data   (cmd_data),
        .ena_write  (ena_write)
    );

    lcd_write_cmd_data lcd_write_cmd_data_inst(
        .clk_1MHz   (clk_1MHz),
        .rst_n      (rst_n),
        .data       (data),
        .cmd_data   (cmd_data),
        .ena        (ena_write),
        .i2c_addr   (7'h27),
        .sda        (sda),
        .scl        (scl),
        .done       (done_write)
    );
	 
	 
	 ultrasonic sensor(
        .clk(clk),
        .trigger(trig),
        .echo(echo),
        .distance_raw(distance_raw)
        
    );

    distance_raw_to_ml distance_to_ml(
       
        .distance_raw(distance_raw),
        .volume_ml(volume_ml)
    );
	 
	 num_to_ascii asci1i(
	 .num(volume_ml),
	 .ascii_str(ascii)
);
endmodule