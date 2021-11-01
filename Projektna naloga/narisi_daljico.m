function narisi_daljico(T1, T2)
% NARISI_DALJICO nariše daljico med podanima toèkama.

x1 = T1(1); y1 = T1(2);
x2 = T2(1); y2 = T2(2);

k = (y2-y1)/(x2-x1);

y = @(x) k*x + y2 - k*x2;

x = linspace(min(x1, x2), max(x1, x2), 100);
plot(x, y(x), 'r', 'LineWidth', 1);
end