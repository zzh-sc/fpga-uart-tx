# fpga-uart-tx
使用fpga发送16位的数据，基于正点原子的历程。
将历程中的  assign uart_tx_busy = tx_flag; 
修改为      assign uart_tx_busy =  en_flag|tx_flag|uart_en;
去除了tx_busy上升沿与发送使能脉冲上升沿之间的延迟。
