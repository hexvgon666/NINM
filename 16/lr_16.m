
% Входные данные
n = 100;  % Увеличим количество точек для более плавной функции
x1 = linspace(pi/2, pi, n);          % Интервал от π/2 до π
x2 = linspace(3*pi/2, 2*pi, n);     % Интервал от 3π/2 до 2π

% Объединение входов
x_input = [x1 x2];  % Вектор x, объединяющий оба отрезка
summ = length(x1);    % Количество точек
disp(summ);

% Расчет целевой функции
%target = sin(x).^2 + cos(x).^3;  % Определение целевой функции
y_target = sin(x_input).^2 + cos(x_input).^3;            % Вычисление значений функции

% Объявление весов
w1 = [0.5 0.5;
      0.5 0.5;    
      0.5 0.5;
      0.5 0.5;];
w2 = [0.5 0.5 0.5 0.5;];  % Вектор весов выходного слоя

% Параметры обучения
ny = 0.2;  
learning_rate_decay = 0.95; 
error_value = 0.0001; 
previous_error = 0; 
total_error = 0;
    
for i = 1 : summ
    % Входные значения
    x = x_input(i);
        
    % Целевая функция
    target_value = y_target(i);
        
    % Выходы скрытого слоя
    S1 = w1(1, 1) * x1(i) + w1(1, 2) * x2(i); 
    S2 = w1(2, 1) * x1(i) + w1(2, 2) * x2(i);
    S3 = w1(3, 1) * x1(i) + w1(3, 2) * x2(i);
    S4 = w1(4, 1) * x1(i) + w1(4, 2) * x2(i);
        
    y1 = 1 ./ (1 + exp(-S1));
    y2 = 1 ./ (1 + exp(-S2));
    y3 = 1 ./ (1 + exp(-S3));
    y4 = 1 ./ (1 + exp(-S4));
        
    % Выходной слой
    s = w2(1, 1) * y1 + w2(1, 2) * y2 + w2(1, 3) * y3 + w2(1, 4) * y4;
    y = 1 ./ (1 + exp(s));

    % Ошибка
    error = (y - target_value)^2;
    total_error = total_error + error;  % Суммирование ошибки

    % Градиенты
    grad_output = (y - target_value) * y * (1 - y);
        
    % Градиенты для скрытого слоя
    grad_output_21 = y1 * (1 - y1) * grad_output * w2(1, 1);
    grad_output_22 = y2 * (1 - y2) * grad_output * w2(1, 2);
    grad_output_23 = y3 * (1 - y3) * grad_output * w2(1, 3);
    grad_output_24 = y4 * (1 - y4) * grad_output * w2(1, 4);

    % Обновление весов
    w1(1, 1) = w1(1, 1) - ny * x * grad_output_21;
    w1(1, 2) = w1(1, 2) - ny * target_value * grad_output_21; 
        
    w1(2, 1) = w1(2, 1) - ny * x * grad_output_22;
    w1(2, 2) = w1(2, 2) - ny * target_value * grad_output_22;

    w1(3, 1) = w1(3, 1) - ny * x * grad_output_23;
    w1(3, 2) = w1(3, 2) - ny * target_value * grad_output_23;

    w1(4, 1) = w1(4, 1) - ny * x * grad_output_24;
    w1(4, 2) = w1(4, 2) - ny * target_value * grad_output_24;

    w2(1, 1) = w2(1, 1) - ny * y1 * grad_output;
    w2(1, 2) = w2(1, 2) - ny * y2 * grad_output;
    w2(1, 3) = w2(1, 3) - ny * y3 * grad_output;
    w2(1, 4) = w2(1, 4) - ny * y4 * grad_output;
end

total_error = total_error / summ;
disp([' значение ошибки ' num2str(total_error) ]);

disp('Обновленные веса w1: ');
disp(w1);
disp('Обновленные веса w2: ');
disp(w2);