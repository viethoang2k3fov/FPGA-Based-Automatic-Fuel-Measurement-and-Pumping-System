module ultrasonic(clk, trigger, echo, distance_raw, new_measure, timeout);
   
	input clk, echo;
	output trigger, new_measure, timeout;
	output reg [20:0] distance_raw;

	parameter 	CLK_MHZ = 50,			
			TRIGGER_PULSE_US = 12,  	
			TIMEOUT_MS = 25;		
	
	localparam	COUNT_TRIGGER_PULSE = CLK_MHZ * TRIGGER_PULSE_US;
	localparam  	COUNT_TIMEOUT = CLK_MHZ * TIMEOUT_MS * 1000;
   localparam COUNT_INTERVAL = CLK_MHZ * 1500 * 1000; // Khoảng thời gian giữa các phép đo, 1500ms = 1.5s
	
	reg [20:0] counter;
	reg [31:0] wait_counter;
	reg[2:0]  state, state_next;
	
	localparam 	IDLE 		= 0,
			TRIG 		= 1,
			WAIT_ECHO_UP 	= 2,
			MEASUREMENT 	= 3,
			MEASURE_OK 	= 4,
	      WAIT_NEXT     = 5;
			
	always @(posedge clk) state <= state_next;
	
	wire measurement;
	assign measurement = (state == MEASUREMENT);
	
	assign new_measure = (state == MEASURE_OK);
	
	wire counter_timeout;
	assign counter_timeout = (counter >= COUNT_TIMEOUT);
	
	assign timeout = new_measure && counter_timeout;
	assign trigger = (state == TRIG);
	
	wire enable_counter;
	assign enable_counter = trigger || echo;	
	
	always @(posedge clk) begin
		if (enable_counter)
			counter <=  counter + 21'b1;
		else
			counter <= 21'b0;  
	end	
	
	always @(posedge clk) begin
		if (enable_counter && measurement)
			distance_raw <= counter;
	end
	
	 always @(posedge clk) begin
        if (state == WAIT_NEXT) begin
            if (wait_counter < COUNT_INTERVAL) 
                wait_counter <= wait_counter + 1;
            else
                wait_counter <= 0;  // Reset sau khi chờ đủ thời gian
        end
    end
	
	
	always @(*) begin
		state_next <= state; 

		case (state)
			IDLE: begin 
	      state_next <= TRIG;
			end
			
			TRIG: begin 
				if (counter >= COUNT_TRIGGER_PULSE) state_next <= WAIT_ECHO_UP;
			end
			
			WAIT_ECHO_UP: begin
				
				if (echo) state_next <= MEASUREMENT;
			end
			
			MEASUREMENT: begin 
				if (counter_timeout || (~echo)) state_next <= MEASURE_OK;
			end
			
			MEASURE_OK: begin
				state_next <= WAIT_NEXT;			
			end
			
			 WAIT_NEXT: begin
                // Chờ đủ thời gian giữa các phép đo
                if (wait_counter >= COUNT_INTERVAL)
                    state_next <= TRIG;  // Sau khi chờ đủ thời gian, quay lại IDLE để bắt đầu phép đo mới
            end

			default: begin
				state_next <= TRIG;
			end	
		endcase
		
	end
					
	
endmodule