x = (0: 0.1 : 8);

x1 = (0: 0.1 : 8);
x2 = (0: 0.1 : 8);
[X, Y] = meshgrid(x1, x2);

Z = max(0.5 * trapmf(x, [1 2 4 6]), 0.5 * trimf(x, [2 3 4]))

x3 = defuzz(x, Z, 'centroid');
h3.Color = gray;
t3.Color = gray;
h = line([x3 x3], [0.2 0.6], 'Color', 'k');
t = text(x3, 0.2, 'centroid', 'FontWeight','bold');
fprintf("Результат дефаззификации: ");
disp(x3);