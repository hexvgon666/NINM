x1 = (0: 0.1 : 8);
x2 = (0: 0.1 : 8);
[X, Y] = meshgrid(x1, x2);
Z = min(trimf(X, [3 5 7]), trimf(Y, [3 5 7]));
plot3(X, Y, Z)