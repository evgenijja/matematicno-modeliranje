% test MEHURCEK

n = 32;
a = 1;
tol = 1e-3;

% a)
f_levo = @(x) zeros(size(x));
f_desno = @(x) 1-x.^2;
f_zgoraj = @(x) 1-x.^2;
f_spodaj = @(x) x.^2-1;

colormap(jet)
U = milnica(a, n, f_spodaj, f_zgoraj, f_levo, f_desno, tol, 'Jacobi');

% b)
f = @(x) 1-x.^2;

figure
colormap(jet)
milnica(a, n, f, f, f, f, tol, 'Jacobi');

