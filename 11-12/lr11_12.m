% % Получение Input и Target значений
n = 5; 
x1 = -2 : 1 : 2; 
x2 = -2 : 1 : 2; 
y = zeros(n, n); 
s = 0;
Input = zeros(2, 25); 
Target = zeros(1, 25); 
for j = 1 : n
    for i = 1 : n
    y(j, i) = (x1(j)^2) + (x2(i)^2) + (11 * x1(j) * x2(i)); 
    s = s + 1;
    Input(1, s) = x1(j); 
    Input(2, s) = x2(i);
    Target(1, s) = (x1(j)^2) + (x2(i)^2) + (11 * x1(j) * x2(i));
end
end 
Input
Target
surf(x1,x2,y)
xlabel('x1')
xlabel('x2')
zlabel('y')
title('Target')

Target = [52 27 4 -17 -36 27 13 1 -9 -17 4 1 0 1 4 -17 -9 1 13 27 -36 -17 4 27 52]
Output = [51.9975 27.2332 4.0012 -17.1568 -35.9984 27.0055 12.9975 0.95677 -8.9973 -17.0026 3.9974 0.98719 0.0042075 1.0272 4.0058 -17.1104 -8.9905 1.0549 12.9944 27.0031 -35.9925 -16.9999 4.0633 27.0092 51.9993]

s1 = 0;
s2 = 0;
for (i = 1 : 25)
   s1 = s1 + ((Target(i) - Output(i))^2);
   s2 = s2 + (Target(i)^2);
end
s1 = s1^(1 / 2);
d = s1 / (s2^(1 / 2));
ans = d


