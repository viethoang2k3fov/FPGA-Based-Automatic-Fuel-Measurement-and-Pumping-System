module price_calculator (
    input  wire        clk,   // clock 1 MHz
	 input  wire        relay_manual ,
    input  wire        sw0,
    output reg [16:0]  price
);

    
  
    
    reg  [20:0] cnt_750ms;          
    wire tick_750ms;
    assign tick_750ms = (cnt_750ms == 21'd1704544);

	


	 
	// tinh toan thoi gian 
    always @(posedge clk) begin
        if (!relay_manual)
            cnt_750ms <= 21'd0;
        else if (tick_750ms)
            cnt_750ms <= 21'd0;
        else
            cnt_750ms <= cnt_750ms + 1'b1;
    end



	 
	 

	 
	 
	// Price logic (TĂNG DẦN)
    always @(posedge clk) begin
        if (sw0)
            price <= 17'd0;
        else if (relay_manual && tick_750ms)
            price <= price + 17'd1000;
    end
	 
	 
	 
    endmodule


