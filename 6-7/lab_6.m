ranks = [1, 2, 3, 4, 5, 6];
n = length(ranks);

matrix_power = [1,   1/3,  2,   1/2, 1/4, 3;  
                3,   1,    4,   2,   1/2, 5; 
                1/2, 1/4,  1,   1/3, 1/5, 2;  
                2,   1/2,  3,   1,   1/3, 4; 
                4,   2,    5,   3,   1,   6; 
                1/3, 1/5,  1/2, 1/4, 1/6, 1];

matrix_torque = [1,   1/3, 2, 1/2, 1/4, 1/2;
                 3,   1,   4, 2,   1/2, 2; 
                 1/2, 1/4, 1, 1/3, 1/5, 1/3;  
                 2,   1/2, 3, 1,   1/3, 1; 
                 4,   2,   5, 3,   1,   3; 
                 2,   1/2, 3, 1,   1/3, 1];

matrix_mass = [1,   2,   5, 3,   1,   4;
               1/2, 1,   4, 2,   1/2, 3; 
               1/5, 1/4, 1, 1/3, 1/5, 1/2;  
               1/3, 1/2, 3, 1,   1/3, 2; 
               1,   2,   5, 3,   1,   4; 
               1/4, 1/3, 2, 1/2, 1/4, 1];

% Вычисление весов для каждой альтернативы
matrix_size = size(matrix_power, 1);

row_prod = prod(matrix_power, 2);
prod_sqrt = nthroot(row_prod, matrix_size);
sum_sqrt = sum(prod_sqrt);
weights_power = prod_sqrt / sum_sqrt;

row_prod = prod(matrix_torque, 2);
prod_sqrt = nthroot(row_prod, matrix_size);
sum_sqrt = sum(prod_sqrt);
weights_torque = prod_sqrt / sum_sqrt;

row_prod = prod(matrix_mass, 2);
prod_sqrt = nthroot(row_prod, matrix_size);
sum_sqrt = sum(prod_sqrt);
weights_mass = prod_sqrt / sum_sqrt;


disp('Мощность:'); disp(weights_power);
disp('Крутящий момент:'); disp(weights_torque);
disp('Масса:'); disp(weights_mass);

final_scores = zeros(n, 1);
for i = 1 : n
    final_scores(i) = weights_power(i) + weights_torque(i) + weights_mass(i);
end

disp("Оценка каждого двигателя:"); disp(final_scores);

[max_score, best] = max(final_scores);
fprintf("Оптимальный вариант: Двигатель "); disp(best); disp(" с весом: "); disp(max_score);
