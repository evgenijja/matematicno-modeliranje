function [param_x, param_y] = parametricno(b)
% parametricni zapis Bezierjeve krivulje
n = size(b, 2);

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

end