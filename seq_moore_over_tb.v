`timescale 1ns / 1ps
module seq_moore_over_tb();
reg din,clk,rst;
wire [2:0] state;
wire out;
 seq_moore_over dut(din,clk,rst,state,out);
 initial
 clk=1;
 always #5 clk=~clk;
 initial
 begin
 $monitor($time,"din=%b, clk=%b, rst=%b, state=%d, out=%b",din,clk,rst,state,out);
 rst=1; din=0;
 #10 rst=0;
 #10 din=1;
 #20 din=0;
 #10 din=1;
 #20 din=0;
 #20 din=1;
 #20 din=0;
 #10 din=1;
 #10 din=1;
 #20 din=0;
 #10 din=1;
 #10 din=1;
 #10 din=0;
     #10 din=0;
     #10 $finish;
     end
 
endmodule
