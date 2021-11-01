function y = horner(a,x)
% HORNER izracuna vrednost polinoma, podanega z vektorjem koeficientov a,
% v dani tocki x po Hornerjevem algoritmu.

n = length(a) - 1;
y = a(1);

for i = 2:(n+1)
    y = y*x + a(i);
end

end

