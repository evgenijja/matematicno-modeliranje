function tocke = CasteljauSez(b,t)
% DE_CASTELJAU izracuna tocko na Bezierovi krivulji pri parametru t
% s pomocjo de Casteljauovega algoritma.
% Stolpci matrike b so kontrolne tocke Bezierove krivulje.
% za seznam parametrov, vrne seznam tock

m = size(t,2);
n = size(b,2);

tocke = zeros(2, m);

for j = 1:m
    for i = 1:(n-1)
        b(:, 1:n-i) = b(:, 1:end-i) .* (1-t(j)) + b(:, 2:end+1-i) .* t(j);
    end 
    tocke(:, j) = b(:, 1);
end

end
