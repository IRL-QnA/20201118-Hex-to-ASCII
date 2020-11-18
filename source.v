function [7:0] ascii;
    input [4:0] hex;
    integer i;
    begin
        ascii = 0;
        if(hex <= 9)
            ascii = hex + 8'h30; // 10이하인 경우 + 0X30
        else
            ascii = hex + 8'd55; // 이상인 경우에는 + 0X37
    end
