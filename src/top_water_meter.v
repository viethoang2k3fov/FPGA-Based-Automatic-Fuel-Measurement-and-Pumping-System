module top_water_meter(
    
	 input wire CLOCK_50,        // Clock 50 MHz từ FPGA
    input wire echo_mini,
	 output wire trig_mini,
	 input wire echo,            // Tín hiệu echo từ HC-SR04
	 output wire trig,   	 // Tín hiệu trigger ra HC-SR04
	 output reg relay_out ,
	 output wire [6:0] seg0,     // LED 7 đoạn đơn vị
    output wire [6:0] seg1,     // chục
    output wire [6:0] seg2,     // trăm
    output wire [6:0] seg3,     // nghìn
    output wire [6:0] seg4,     // 10 nghìn
    output wire [6:0] seg5,      // 100 nghìn
    output wire led ,
	
	 
	 
	 input  wire  sw0 ,
	 input  wire  sw1 ,
	 input  wire  sw2 ,
	 input  wire  sw3 ,
	 input  wire btn_200ml ,
	 input  wire btn_500ml ,
	 input  wire btn_1000ml ,
	 
	 
    input           rst_n,
    output          scl,
    inout           sda
	 

);

    
    wire [1:0] mode;
    wire [20:0] distance_raw ;
	 wire [20:0] distance_raw_mini ;
    wire [15:0] volume_ml ;
	 wire [15:0] distance_cm ;
	 wire  [16:0] price_vnd ;
	 wire  [15:0] thetichdabom ;
	 wire  [16:0] price_vnd_mini ;
	 wire  [15:0] thetichdabom_mini ;
	 wire relay_auto ;
	 wire relay_manual ;
	 wire            clk_1MHz;
    wire            done_write;
    wire [7:0]      data;
    wire            cmd_data;
    wire            ena_write;
    wire [127:0]    row1;
    wire [127:0]    row2;
	 wire  [47:0]  ascii ;
	 wire  [47:0]  ascii_mini ;
	 wire  [47:0]  ascii_ver2 ;
	 wire  [47:0]  ascii_mini_ver2 ;
	 wire [3:0] bcd_HEX0, bcd_HEX1, bcd_HEX2, bcd_HEX3, bcd_HEX4, bcd_HEX5;
	 
	 assign mode = {sw3, sw2};
//	 assign row1 =    "....Gia tien....";
	 assign row1 = (mode == 2'b00)? 
              {"DaBom:",ascii_ver2,"(ml)"}:
              (mode == 2'b01) ?
              {"DaBom:",ascii_mini_ver2,"(ml)"}:
              {"..","UNKNOWN MODE",".."};
	 
    assign row2 = (mode == 2'b00)? 
              {"Tien:",ascii,"(VND)"}:
              (mode == 2'b01) ?
              {"Tien:",ascii_mini,"(VND)"}:
              {"..","UNKNOWN MODE",".."};

				  
				  
  always @(*) begin
    case (mode)
        2'b00: relay_out = relay_manual; // manual
        2'b01: relay_out = relay_auto;   // automatic
        default: relay_out = 1'b0;       // an toàn
    endcase
	 end
	 
	 
	 
	ultrasonic_mini sensor_mini(
        .clk(CLOCK_50),
        .trigger_mini(trig_mini),
        .echo_mini(echo_mini),
        .distance_raw_mini(distance_raw_mini) 
	 );
   
	distanceraw_to_cm distanceraw_to_cm(
      .distance_raw_mini(distance_raw_mini) ,
		.distance_cm(distance_cm)
    );
	 
	 relay_automatic relay_automatic(
	   .clk(clk_1MHz),
	   .distance_cm(distance_cm) ,
		.relay_auto(relay_auto) ,
		.btn0(btn_200ml),
		.btn1(btn_500ml),
		.btn2(btn_1000ml),
	   .mode(mode)
		
		
	);
	
	 price_calculator_mini price_calculator_mini(
	     .clk(clk_1MHz),
		  .sw0(sw0),
		  .relay_auto(relay_auto),
	     .price_mini(price_vnd_mini)
	 
	 );
	
	
	 num_to_ascii_mini asci1i_mini(
	 .num_mini(price_vnd_mini),
	 .ascii_str_mini(ascii_mini)
);


    thetichdabom_calculator_mini thetichdabom_calculator_mini(
	     .clk(clk_1MHz),
		  .sw0(sw0),
		  .relay_auto(relay_auto),
	     .thetichdabom_mini(thetichdabom_mini)
	 
	 );
	 
	 
	 num_to_ascii_mini_ver2 asci1i_mini_ver2(
	 .num_mini(thetichdabom_mini),
	 .ascii_str_mini(ascii_mini_ver2)
);
	 
	 
	 
	
	ultrasonic sensor(
        .clk(CLOCK_50),
        .trigger(trig),
        .echo(echo),
        .distance_raw(distance_raw)
        
    );

  distanceraw_to_ml distanceraw_to_ml(
     
       .distance_raw(distance_raw),
       .volume_ml(volume_ml)
    ); 
	 
	 
	 led_control(
	 
	    .clk(clk_1MHz),
		 .volume_ml(volume_ml),
	    .led(led),
		 
		 
	 );
  
   
    binary_to_bcd bcd(
        
        .volume_ml(volume_ml),
        .bcd_HEX0(bcd_HEX0),
        .bcd_HEX1(bcd_HEX1),
        .bcd_HEX2(bcd_HEX2),
        .bcd_HEX3(bcd_HEX3),
        .bcd_HEX4(bcd_HEX4),
        .bcd_HEX5(bcd_HEX5)
    );

 
    bcd_to_7seg u7seg(
        .bcd_HEX0(bcd_HEX0),
        .bcd_HEX1(bcd_HEX1),
        .bcd_HEX2(bcd_HEX2),
        .bcd_HEX3(bcd_HEX3),
        .bcd_HEX4(bcd_HEX4),
        .bcd_HEX5(bcd_HEX5),
        .seg0(seg0),
        .seg1(seg1),
        .seg2(seg2),
        .seg3(seg3),
        .seg4(seg4),
        .seg5(seg5)
    );
		  
		  	  
		
		clk_divider clk_1MHz_gen(
        .clk_50MHz  (CLOCK_50),
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
	 
	  relay_volume_control relay_control(
	     .clk(clk_1MHz),
	     .btn0(btn_200ml),
		  .btn1(btn_500ml),
		  .btn2(btn_1000ml),
		  .sw1(sw1),
		  .relay_manual(relay_manual),
		  .mode(mode)
		
		);
	 
	 price_calculator price_calculator(
	     .clk(clk_1MHz),
		  .sw0(sw0),
		  .relay_manual(relay_manual),
	     .price(price_vnd)
	 
	 );
	 
	 
	
	 num_to_ascii asci1i(
	     .num(price_vnd),
	     .ascii_str(ascii)
);


   thetichdabom_calculator thetichdabom_calculator(
	     .clk(clk_1MHz),
		  .sw0(sw0),
		  .relay_manual(relay_manual),
	     .thetichdabom(thetichdabom)
);

    num_to_ascii_ver2 asci1i_ver2(
	     .num(thetichdabom),
	     .ascii_str(ascii_ver2)
);
   
	

  


	 
endmodule
