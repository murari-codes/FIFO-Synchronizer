module FIFOsync (
    input clk,
    input reset,
    input [3:0] datain,
    input wr_en,
    input re_en,
    output [3:0] dataout,
    output full,
    output empty
);
reg [3:0] count;

assign full=(count==4'b1000)?1'b1:1'b0;
assign empty=(count==4'b0000)?1'b1:1'b0;
wire [3:0] queue_dataout;

wire queue_wr_en,queue_re_en;

assign queue_wr_en= wr_en && !full;
assign queue_re_en= re_en && !empty;
assign dataout = queue_dataout;
CircularQueue queue_inst (
    .clk (clk),
    .reset (reset),
    .wr_en (queue_wr_en),
    .re_en (queue_re_en),
    .datain (datain),
    .dataout (queue_dataout)
);

  always @ (posedge clk)
    begin
        if (reset)
        begin
            count <= 4'b000; 
        end
        else begin
        if (queue_wr_en && !queue_re_en)
        count<= count+1;
        else if (!queue_wr_en && queue_re_en)
        count <= count -1;
        end
    end 
endmodule