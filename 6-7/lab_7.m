cam = {'Canon', 'Sony', 'Hikvision', 'Dahua', 'Samsung', 'Logitech'};
n = length(ranks);

% Разрешение
matrix_permission = [1,   1/2,  2,   1/3, 1/4, 3;  
                     2,   1,    3,   1/2, 1/3, 4; 
                     1/2, 1/3,  1,   1/4, 1/5, 2;  
                     3,   2,    4,   1,   1/2, 5; 
                     4,   3,    5,   2,   1,   6; 
                     1/3, 1/4,  1/2, 1/5, 1/6, 1];

% Чувствительность к свету
matrix_sensitivity = [1,   1/2, 1/3, 1,   2, 3;
                      2,   1,   1/2, 2,   3, 4; 
                      3,   2,   1,   3,   4, 5;  
                      1,   1/2, 1/3, 1,   2, 3; 
                      1/2, 1/3, 1/4, 1/2, 1, 2; 
                      1/3, 1/4, 1/5, 1/3, 1/2, 1];

% Скорость записи
matrix_rec_speed = [1,   2, 1/2, 1,   1/3, 1;
              1/2, 1, 1/3, 1/2, 1/4, 1/2; 
              2,   3, 1,   2,   1/2, 2;  
              1,   2, 1/2, 1,   1/3, 1; 
              3,   4, 2,   3,   1,   3; 
              1,   2, 1/2, 1,   1/3, 1];

% Колличество шума 
matrix_noise = [1,   2,   1/2, 3,   4,   5;
                1/2, 1,   1/3, 2,   3,   4; 
                2,   3,   1,   4,   5,   6;  
                1/3, 1/2, 1/4, 1,   2,   3; 
                1/4, 1/3, 1/5, 1/2, 1,   2; 
                1/5, 1/4, 1/6, 1/3, 1/2, 1];

% Частота кадров
matrix_fps = [1, 1, 1/2, 1, 1/2, 1;
              1, 1, 1/2, 1, 1/2, 1; 
              2, 2, 1,   2, 1,   2;  
              1, 1, 1/2, 1, 1/2, 1; 
              2, 2, 1,   2, 1,   2; 
              1, 1, 1/2, 1, 1/2, 1];

% Размер матрицы
matrix_m_size = [1,   1,   2, 1/2, 1/2, 1;
                 1,   1,   2, 1/2, 1/2, 1; 
                 1/2, 1/2, 1, 1/3, 1/3, 1/2;  
                 2,   2,   3, 1,   1,   2; 
                 2,   2,   3, 1,   1,   2; 
                 1,   1,   2, 1/2, 1/2, 1];

% Вычисление весов для каждой альтернативы
matrix_size = size(matrix_permission, 1);

row_prod = prod(matrix_permission', 2);
prod_sqrt = nthroot(row_prod, matrix_size);
sum_sqrt = sum(prod_sqrt);
weights_permission = prod_sqrt / sum_sqrt;

row_prod = prod(matrix_sensitivity', 2);
prod_sqrt = nthroot(row_prod, matrix_size);
sum_sqrt = sum(prod_sqrt);
weights_sensitivity = prod_sqrt / sum_sqrt;

row_prod = prod(matrix_rec_speed', 2);
prod_sqrt = nthroot(row_prod, matrix_size);
sum_sqrt = sum(prod_sqrt);
weights_rec_speed = prod_sqrt / sum_sqrt;

row_prod = prod(matrix_noise', 2);
prod_sqrt = nthroot(row_prod, matrix_size);
sum_sqrt = sum(prod_sqrt);
weights_noise = prod_sqrt / sum_sqrt;

row_prod = prod(matrix_fps', 2);
prod_sqrt = nthroot(row_prod, matrix_size);
sum_sqrt = sum(prod_sqrt);
weights_fps = prod_sqrt / sum_sqrt;

row_prod = prod(matrix_m_size', 2);
prod_sqrt = nthroot(row_prod, matrix_size);
sum_sqrt = sum(prod_sqrt);
weights_m_size = prod_sqrt / sum_sqrt;

disp('Разрешение:'); disp(weights_permission);
disp('Чувствительность к свету:'); disp(weights_sensitivity);
disp('Скорость записи:'); disp(weights_rec_speed);
disp('Количество шумов:'); disp(weights_noise);
disp('Частота кадров:'); disp(weights_fps);
disp('Размер матрицы:'); disp(weights_m_size);

final_scores = zeros(n, 1);
for i = 1 : n
    final_scores(i) = weights_permission(i) + weights_sensitivity(i) + weights_rec_speed(i) + ...
    + weights_noise(i) + weights_fps(i) + weights_m_size(i);
end

disp("Оценка каждой видеокамеры:"); disp(final_scores);

[max_score, best] = max(final_scores);
fprintf("Оптимальный вариант: "); disp(cam(best)); disp(" с весом: "); disp(max_score);

figure;
bar(final_scores);
xlabel('Варианты видеокамеры');
ylabel('Итоговый вес');
title('Итоговые веса вариантов видеокамер');
xticklabels(cam);
grid on;