module CircularQueue (
    input clk,
    input reset,
    input wr_en,
    input re_en,
    input reg [3:0] datain,
    output reg [3:0] dataout
);
    reg [3:0] temp [7:0];
    reg [2:0] wr_ptr;
    reg [2:0] re_ptr;
    integer i;
    always@(posedge clk)begin
        if (reset)
        begin
            for(i=0;i<8;i=i+1)
            begin
                temp[i]<=4'b0000;
            end
        dataout<=4'b0000;
        wr_ptr<=3'b000;
        re_ptr<=3'b000;
        end
        else 
        begin
            if (wr_en) 
            begin
            if (wr_ptr==3'b111) begin
                wr_ptr<=3'b000;
            
            end
            else begin
                wr_ptr<=wr_ptr+1;

            end 
            temp[wr_ptr]<=datain;   
            end


            if (re_en) 
            begin
            if (re_ptr==3'b111) begin
                re_ptr<=3'b000;
            
            end
            else begin
                re_ptr<=re_ptr+1;

            end 
            dataout<=temp[re_ptr];   
            end
        end
    end
    
endmodule