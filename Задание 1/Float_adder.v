
module float32_adder (
    input  wire [31:0] a,
    input  wire [31:0] b,
    output wire [31:0] result
);

    // Выделение битов порядка и мантиссы
    wire [7:0]  a_exp;
    wire [23:0] a_man;
    wire [7:0]  b_exp;
    wire [23:0] b_man;

    assign a_exp = a[30:23];
    assign a_man = a[22:0];
    assign b_exp = b[30:23];
    assign b_man = b[22:0];

    // Присоединение неявной старшей единицы к мантиссе
    wire [24:0] a_man_ext = {1'b1, a_man};
    wire [24:0] b_man_ext = {1'b1, b_man};

    // Сравнение порядков
    wire a_exp_gt_b_exp = a_exp > b_exp;

    // Сдвиг числа с меньшим порядком
    wire [24:0] shifted_man;
    wire [7:0]  shifted_exp;
    
    assign shifted_man = (a_exp_gt_b_exp) ? a_man_ext : b_man_ext;
    assign shifted_exp = (a_exp_gt_b_exp) ? b_exp : a_exp;

    // Сложение мантисс
    wire [25:0] sum_man = (a_exp_gt_b_exp) ? a_man_ext + {shifted_man[23:0], 2'b00} : b_man_ext + {shifted_man[23:0], 2'b00};

    // Нормализация мантиссы и порядка
    wire [24:0] normalized_man;
    wire [7:0]  normalized_exp;

    fp_normalize #(25, 8) normalizer (
        .data_in(sum_man),
        .exp_in(shifted_exp),
        .data_out(normalized_man),
        .exp_out(normalized_exp)
    );

    // Округление результата
    wire [24:0] rounded_man;

    fp_round #(25) rounder (
        .data_in(normalized_man),
        .data_out(rounded_man)
    );

    // Сборка обратно порядка и мантиссы в итоговое число с плавающей точкой
    assign result = {normalized_exp, rounded_man[23:0]};

endmodule