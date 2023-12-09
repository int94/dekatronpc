module dekatron(
    input clk,           // Тактовый сигнал
    input reset,         // Сигнал сброса
    input P1,            // Сигнал P1 для управления перемещением вперед
    input P2,            // Сигнал P2 для управления перемещением назад
    inout [29:0] cathodes // Катоды декатрона, используемые для управления состоянием
);

// Внутренние сигналы для управления состоянием декатрона
reg [29:0] states;
reg [29:0] cathode_output;  // Регистр для управления выходными данными на cathodes
reg cathode_direction;     // Флаг для управления направлением данных (0 - чтение, 1 - запись)
integer i;

// Управление inout пинами
assign cathodes = cathode_direction ? cathode_output : 30'bz;  // 'z' обозначает high-impedance state

// Инициализация и управление состоянием декатрона
always @(posedge clk or posedge reset) begin
    if (reset) begin
        // Сброс всех защелок
        states <= 30'b000000000000000000000000000001;
        cathode_direction <= 1'b1;  // Установка на запись
        cathode_output <= 30'b000000000000000000000000000001;
    end else begin
        if (P1 && !P2) begin
            // Перемещение вперед
            states <= {states[28:0], states[29]};
        end else if (P2 && !P1) begin
            // Перемещение назад
            states <= {states[0], states[29:1]};
        end

        // Обновление выходных данных
        cathode_output <= states;
        cathode_direction <= 1'b1;  // Установка на запись

        // Проверка и управление катодами для чтения
        for (i = 0; i < 30; i = i + 1) begin
            if (!cathode_direction && cathodes[i]) begin
                // Сбросить все защелки, кроме активированного катода
                states <= (1 << i);
            end
        end
    end
end

endmodule
