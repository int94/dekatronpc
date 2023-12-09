`timescale 1ns / 1ps

module dekatron_tb;

// Параметры тестового модуля
reg clk;
reg reset;
reg P1;
reg P2;
wire [29:0] cathodes;

// Инстанцирование тестируемого модуля
dekatron uut (
    .clk(clk),
    .reset(reset),
    .P1(P1),
    .P2(P2),
    .cathodes(cathodes)
);

// Генерация тактового сигнала
always #10 clk = ~clk;

// Проверка состояния декатрона
task check_state;
    input [29:0] expected_state;
    begin
        if (cathodes !== expected_state) begin
            $display("Test failed at time %t. Expected state: %b, got: %b", $time, expected_state, cathodes);
            $stop;
        end
    end
endtask

// Инициализация и тестовые сценарии
initial begin
    // Настройка VCD файла
    $dumpfile("dekatron_tb.vcd");
    $dumpvars(0, dekatron_tb);

    // Инициализация сигналов
    clk = 0;
    reset = 1;
    P1 = 0;
    P2 = 0;

    // Сброс устройства
    #20;
    reset = 0;
    check_state(30'b000000000000000000000000000001);

    // Полный цикл инкрементов
    for (int i = 0; i < 29; i++) begin
        P1 = 1;
        #20;
        P1 = 0;
        check_state(30'b1 << i);
    end
    $display("Inc OK");
    // Полный цикл декрементов
    for (int i = 29; i >= 0; i--) begin
        #20;
        P2 = 1;
        #20;
        P2 = 0;
        check_state(30'b1 << i);
    end
    $display("Dec OK");

    // Повторный сброс и проверка
    #20;
    reset = 1;
    #20;
    reset = 0;
    check_state(30'b000000000000000000000000000001);

    // Завершение теста
    #40;
    $finish;
end

endmodule
