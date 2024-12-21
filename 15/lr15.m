% Входные данные
x = [-3 1; 2 -1; 2 2; 3 -1]; 
target = [1; 1; 0; 0]; 
w = [1 -0.8]; 
b = [1]; 

max_error = 0.01; 
learning_rate = 0.5; 
epoch = 10; 

linear_activation = @(z) z;

for e = 1 : epoch
    for i = 1 : size(x, 1)
        new_input = w * x(i, :)' + b;
        disp(new_input);
        output = linear_activation(new_input);

        error = target(i) - output;

        if abs(error) < max_error
            continue;
        end

        w = w + learning_rate * error * x(i, :);
        b = b + learning_rate * error;
    end
end

% Итоговые веса и смещение
disp('Итоговые веса: ');
disp(w);
disp('Итоговое смещение: ');
disp(b);