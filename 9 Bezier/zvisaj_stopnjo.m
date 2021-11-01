function b1 = zvisaj_stopnjo(b)

n = size(b, 2);

b1 = zeros(2, n+1);
b1(:, 1) = b(:, 1);
b1(:, n+1) = b(:, n);
for i = 2:n
    b1(:, i) = (i-1)/n .* b(:, i-1) + (1 - (i-1)/n).* b(:, i);
end
