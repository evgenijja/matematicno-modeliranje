function premica = enacba_premice(T1, T2)

a = T1(1); A = T1(2);
b = T2(1); B = T2(2);

% smerni koeficient - delta y z delta x
k = (B-A)/(b-a);

% y = kx +n
n = T1(2) - T1(1)*k;

premica = @(x) k*x + n;
end

