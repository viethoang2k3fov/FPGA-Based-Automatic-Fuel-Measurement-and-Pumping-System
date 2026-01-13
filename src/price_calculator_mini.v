module price_calculator_mini (
    input  wire        clk,   // clock 1 MHz
	 input  wire        relay_auto ,
    input  wire        sw0,
    output reg [16:0]  price_mini
);

    
  
    
    reg  [20:0] cnt_750ms;          
    wire tick_750ms;
    assign tick_750ms = (cnt_750ms == 21'd1704544);

	


	 
	// tinh toan thoi gian 
    always @(posedge clk) begin
        if (!relay_auto)
            cnt_750ms <= 21'd0;
        else if (tick_750ms)
            cnt_750ms <= 21'd0;
        else
            cnt_750ms <= cnt_750ms + 1'b1;
    end



	 
	 

	 
	 
	// Price logic (TĂNG DẦN)
    always @(posedge clk) begin
        if (sw0)
            price_mini <= 17'd0;
        else if (relay_auto && tick_750ms)
            price_mini <= price_mini + 17'd1000;
    end
	 
	 
	 
    endmodule


