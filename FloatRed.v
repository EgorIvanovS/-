module series_reducer #(
    parameter N = 32, // Количество входных чисел
    parameter WIDTH = 32 // Ширина каждого входного числа
)
(
    input wire clk, // Входной тактовый сигнал
    input wire reset, // Сигнал сброса
    input wire [N-1:0][WIDTH-1:0] numbers, // Массив входных чисел
    output reg [WIDTH-1:0] sum // Выходной сигнал суммы
);

reg [WIDTH-1:0] temp_sum [N/2-1:0]; // Временные суммы
reg [WIDTH-1:0] final_sum; // Итоговая сумма

always @(posedge clk or posedge reset) begin
    if (reset) begin
        final_sum <= 0;
        for (int i = 0; i < N/2; i = i + 1) begin 
            temp_sum[i] <= numbers[i*2] + numbers[i*2 + 1]; // Суммируем пары чисел параллельно
        end
    end else begin
        for (int i = 0; i < N/2-1; i = i + 1) begin
            temp_sum[i] <= temp_sum[i] + temp_sum[i+1]; // Суммируем результаты параллельного суммирования
        end
        final_sum <= temp_sum[0]; // Получаем итоговую сумму ряда
        sum <= final_sum;
    end
end

endmodule