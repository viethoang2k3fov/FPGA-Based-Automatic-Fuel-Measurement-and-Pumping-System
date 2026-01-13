module thetichdabom_calculator (
    input  wire        clk,   // clock 1 MHz
	 input  wire        relay_manual ,
    input  wire        sw0,
    output reg [15:0]  thetichdabom
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
            thetichdabom <= 16'd0;
        else if (relay_manual && tick_750ms)
            thetichdabom <= thetichdabom + 16'd50;
    end
	 
	 
	 
    endmodule


