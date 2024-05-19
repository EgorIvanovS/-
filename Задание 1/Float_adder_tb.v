module testbench_Addition_Subtraction;

    reg [31:0] a_operand, b_operand;
    reg AddBar_Sub;
    wire Exception;
    wire [31:0] result;
    
    // Подключаем тестируемый модуль Addition_Subtraction
    Addition_Subtraction DUT(
        .a_operand(a_operand),
        .b_operand(b_operand),
        .AddBar_Sub(AddBar_Sub),
        .Exception(Exception),
        .result(result)
    );

    // Генерация входных сигналов
    initial begin
        // Пример входных данных
        a_operand = 32'b01000000010000000000000000000000; // 2.0 в float32
        b_operand = 32'b00111111011000000000000000000000; // 0.75 в float32
        AddBar_Sub = 1; // Выполняем сложение

        // Ожидаемый результат суммы чисел 2.0 + 0.75
        // 2.0 + 0.75 = 2.75 или 32'b01000000011000000000000000000000 в float32
        // Exception = 0 (нет исключения)
        #1;

        // Проверяем результат
        if (Exception == 0 && result == 32'b01000000011000000000000000000000)
            $display("Test passed successfully: 2.0 + 0.75 = 2.75");
        else
            $display("Test failed");

        // Для проверки работы с вычитанием измените AddBar_Sub на 0 и установите другие данные для проверки

        $stop;
    end

endmodule