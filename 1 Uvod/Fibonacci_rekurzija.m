function F = Fibonacci_rekurzija(n)
% Vrne n-ti clen Fibonaccijevega zaporedja
% 1, 1, 2, 3, 5, 8, 13, ...

if n <= 2
    F = 1;
else
    F = Fibonacci_rekurzija(n-1) + Fibonacci_rekurzija(n-2);
end

end

