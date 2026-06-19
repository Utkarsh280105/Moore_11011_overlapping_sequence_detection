`timescale 1ns / 1ps
module seq_moore_over(din,clk,rst,state,out);
input din,clk,rst;
output reg [2:0] state;
output reg out;

parameter S0=3'b000, 
          S1=3'b001, 
          S2=3'b010, 
          S3=3'b011, 
          S4=3'b100, 
          S5=3'b101;

reg [26:0] counter;
reg clk2hz;
 always @(posedge clk or posedge rst) begin
        if (rst) begin
            counter <= 0;
            clk2hz <= 0;
        end else begin
            if (counter == 27'd99_999_999) begin
                counter <= 0;
                clk2hz <= ~clk2hz;  // toggle every 1 sec -> 0.5 Hz clock (period = 2 sec)
            end else begin
                counter <= counter + 1;
            end
        end
    end

always@(posedge clk2hz or posedge rst)
begin
if (rst)
state<=S0;
else begin
case (state)
S0:  state<=(din==1)?S1:S0;          //11011 moore overlapping sequence detection
S1:  state<=(din==1)?S2:S0;
S2:  state<=(din==0)?S3:S1;
S3:  state<=(din==1)?S4:S0;
S4:  state<=(din==1)?S5:S0;
S5:  state<=(din==1)?S2:S3;
default: state<=S0;
endcase
end
end

always@(*)
begin
case (state)
S5: out=1'b1;
default: out=1'b0;
endcase
end
endmodule
