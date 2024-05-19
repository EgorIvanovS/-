// Модуль тестирования 
module float32_adder_test;
    reg [31:0] a;
    reg [31:0] b;
    wire [31:0] result;

    float32_adder uut (
        .a(a),
        .b(b),
        .result(result)
    );

    initial begin
        // Тестовые данные
        a = 32'h40400000; // 2.5
        b = 32'h40800000; // 3.5
        #10;
        $display("a = %f, b = %f, result = %f", $realtobits(a), $realtobits(b), $realtobits(result)); 
        // Ожидаемый результат: 6.0
    end
endmodule