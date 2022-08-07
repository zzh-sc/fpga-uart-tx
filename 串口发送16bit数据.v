module uart_top(
    input sys_clk,
    input sys_rst_n,
    
    input send_en, //单脉冲
    input [16-1:0] data_16,
    
    output  uart_tx_busy,
    output  uart_txd
);
reg uart_en;
reg [7:0] data_in;

uart_send u_uart_send(
    .sys_clk(sys_clk),                  //系统时钟
    .sys_rst_n(sys_rst_n),                //系统复位，低电平有效
    
    .uart_en(uart_en),                  //发送使能信号
    .uart_din(data_in),                 //待发送数据
    .uart_tx_busy(uart_tx_busy),        //发送忙状态标志      
    .uart_txd(uart_txd)                 //UART发送端口
    );

reg [2:0] state;
always @(posedge sys_clk or negedge sys_rst_n) begin         
    if (!sys_rst_n)  begin
        state <= 0;
        uart_en <= 0;
        data_in <= 0;
    end
    else if( state == 0) begin
        if( send_en == 1) begin
            uart_en <= 1;
            data_in <= data_16[7:0];
            state <= 1;
        end
        else begin
            state <= 0;
            uart_en <= 0;
            data_in <= data_in;
        end
    end
    else if( state == 1) begin
            if( uart_tx_busy == 0) begin
                uart_en <= 1;
                data_in <= data_16[15:8];
                state <= 0;
            end
            else begin
                uart_en <= 0;
                data_in <= data_in;
                state <= 1;
            end
        end
end

endmodule



