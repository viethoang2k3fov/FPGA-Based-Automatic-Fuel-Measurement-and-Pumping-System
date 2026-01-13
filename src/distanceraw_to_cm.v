module distanceraw_to_cm (
    input  wire [20:0] distance_raw_mini,   // số chu kỳ ECHO (50MHz)
    output reg  [15:0] distance_cm         
);

   
    always @(*) begin
        
        distance_cm = (distance_raw_mini * 16'd346) / 32'd1_000_000;
    end

    endmodule
	 