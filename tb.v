`timescale 1ns / 1ps

module uart_timer_tb();
reg sys_clk;
reg sys_rst_n;
reg send_en;
reg [15:0]data_16;
wire send_busy;
wire uart_txd;

uart_top u_uart_top(
     .sys_clk(sys_clk),
     .sys_rst_n(sys_rst_n),
    
     .send_en(send_en), //单脉冲
     .data_16(data_16),
    
     .uart_tx_busy(send_busy),
     .uart_txd(uart_txd)
);

initial sys_clk = 1;
always #10 sys_clk = !sys_clk;

initial begin
    sys_rst_n = 0;
    #201
    sys_rst_n = 1;
    data_16 = 16'h1234;
    send_en = 1;
    #20;
    send_en = 0;
    #1000000;
    data_16 = 16'h4321;
    send_en = 1;
    #20;
    send_en = 0;
    #100000;
    $stop;
end

endmodule
