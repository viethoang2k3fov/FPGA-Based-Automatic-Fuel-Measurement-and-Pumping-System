module thetichdabom_calculator_mini (
    input  wire        clk,   // clock 1 MHz
	 input  wire        relay_auto ,
    input  wire        sw0,
    output reg [15:0]  thetichdabom_mini
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
            thetichdabom_mini <= 16'd0;
        else if (relay_auto && tick_750ms)
            thetichdabom_mini <= thetichdabom_mini + 16'd50;
    end
	 
	 
	 
    endmodule


