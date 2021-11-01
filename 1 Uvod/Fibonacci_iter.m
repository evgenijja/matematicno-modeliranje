function F = Fibonacci_iter(n)
% Vrne n-ti clen Fibonaccijevega zaporedja
% 1, 1, 2, 3, 5, 8, 13, ...

if n <= 2
    F = 2;
else
    a = 1;
    b = 1;
    
    for i = 3:n
        
       F = a + b;
       a = b;
       b = F;
       
    end

end