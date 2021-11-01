function[t1, t2] = poisci_samopresecisce(b)
% vrne parametra t in s v obliki presecisce = [t s]
% pri katerima parametricna krivulja seka samo sebe

n = size(b, 2);

% parametricni zapis Bezierjeve krivulje
syms s;
px = 0;
py = 0;
for i=0:n-1
    px = px + nchoosek(n-1,i) .* b(1, i+1) .* s.^i .* (1-s).^(n-1-i);
    py = py + nchoosek(n-1,i) .* b(2, i+1) .* s.^i .* (1-s).^(n-1-i);
end
param_x = matlabFunction(px);
param_y = matlabFunction(py);
clear s

% funkcija, ki izenaci predpisa za bezierjevo krivuljo pri razlicnih param.
fun = @(T) (param_x(T(1)) - param_x(T(2))).^2 + (param_y(T(1)) - param_y(T(2))).^2;

% zacetni priblizek, ki ga preberem s slike
x0 = [0.3, 0.8];
fun(x0);

options = optimset('TolFun', 1e-16);
presecisce = fminsearch(fun, x0, options);
t1 = presecisce(1);
t2 = presecisce(2);

% to1 = [param_x(presecisce(1)), param_y(presecisce(1))]
% 
% to2 = [param_x(presecisce(2)), param_y(presecisce(2))]
% plotBezier(b);
% hold on
% plot([to1(1), to2(1)], [to1(2), to2(2)], 'o');
end
