module distanceraw_to_ml (
    input  wire [20:0] distance_raw,   // số chu kỳ ECHO (50MHz)
    output reg  [15:0] volume_ml         // thể tích ml
);

    reg [15:0] distance_cm_x10;          // cm * 10 (vd 10.2cm -> 102)

    // ===== RAW -> cm x10 =====
    always @(*) begin
        // cm_x10 = distance_raw * 0.003448
        distance_cm_x10 = (distance_raw * 16'd3460) / 32'd1_000_000;
    end

    // ===== LUT: cm -> ml =====
    always @(*) begin
    if      (distance_cm_x10 >= 183) volume_ml = 0;
    else if (distance_cm_x10 >= 174) volume_ml = 100;
    else if (distance_cm_x10 >= 165) volume_ml = 200;
    else if (distance_cm_x10 >= 156) volume_ml = 300;
    else if (distance_cm_x10 >= 147) volume_ml = 400;
    else if (distance_cm_x10 >= 138) volume_ml = 500;
    else if (distance_cm_x10 >= 129) volume_ml = 600;
    else if (distance_cm_x10 >= 120) volume_ml = 700;
    else if (distance_cm_x10 >= 111) volume_ml = 800;
    else if (distance_cm_x10 >= 102) volume_ml = 900;
    else if (distance_cm_x10 >=  93) volume_ml = 1000;
    else if (distance_cm_x10 >=  84) volume_ml = 1100;
    else if (distance_cm_x10 >=  75) volume_ml = 1200;
    else if (distance_cm_x10 >=  66) volume_ml = 1300;
    else if (distance_cm_x10 >=  57) volume_ml = 1400;
    else if (distance_cm_x10 >=  48) volume_ml = 1500;
    else if (distance_cm_x10 >=  39) volume_ml = 1600;
    else if (distance_cm_x10 >=  30) volume_ml = 1700;
    else if (distance_cm_x10 >=  21) volume_ml = 1800;
    else if (distance_cm_x10 >=  12) volume_ml = 1900;
    else                              volume_ml = 2000;
end


endmodule
