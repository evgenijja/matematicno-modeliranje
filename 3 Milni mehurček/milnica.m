function U = milnica(a,n,f_spodaj,f_zgoraj,f_levo,f_desno,tol,metoda)
% MILNICA izracuna obliko milnice na kvadratu [-a,a]^2, kjer so 
% podane robne vrednosti s funkcijami f_i. Pri tem je:
% n+2 je stevilo delilnih tock na eni koordinatni osi
% f_i so stiri funkcije, ki dolocajo vrednosti na robu
% tol je toleranca pri iterativni metodi
% metoda je stikalo, ki doloca iterativno metodo:
%'Jacobi' = Jacobijevo iteracijo
%'Gauss-Seidel' = Gauss-Seidelovo iteracijo

U = zeros(n+2);
x = linspace(-a,a,n+2);

% Izracunamo vrednosti na robu:

% U je na koncu matrika z n+2 stolpci in n+2 vrsticami

% spodnji rob - spodnja vrstica matrike
U(end,:) = f_spodaj(x);

% zgornji rob - zgornja vrstica matrike
U(1,:) = f_zgoraj(x);

% levi rob - prvi stolpec brez prve in zadnje vrstice
U(2:end-1,1) = f_levo(flip((x(2:end-1))'));

% desni rob - zadnji stolpec brez prve in zadnje vrstice
U(2:end-1,end) = f_desno(flip((x(2:end-1))'));

% Izberemo iterativno metodo
switch metoda
    case 'Jacobi'
        U = jacobi(U,tol,a);
    case 'Gauss-Seidel'
        U = gauss_seidl(U,tol,a);
end

% Risanje
[X,Y] = meshgrid(x,x);

U = flipud(U);

surf(X,Y,U);


end