module SPI(input cs,input sclk,input mosi,output reg miso=0);
    parameter S0 = 4'd0;
    parameter S1 = 4'd1;
    parameter S2 = 4'd2;
    parameter S3 = 4'd3;
    parameter S4 = 4'd4;
    parameter S5 = 4'd5;
    parameter S6 = 4'd6;
    parameter S7 = 4'd7;
    reg [7:0] buffer_s = 8'd0;
    reg s7 = 0;
    always @(posedge sclk) 
    begin
        if(!cs)
        begin
            s7 <= buffer_s[7];
            buffer_s <= buffer_s << 1'b1;
            buffer_s[0] <= mosi;
            miso <= s7;
            
        end
    
    end
endmodule
