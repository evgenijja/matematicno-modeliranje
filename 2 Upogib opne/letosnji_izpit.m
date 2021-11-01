% letošnji izpit

c = 83; n = 21+2*mod(c, 21);
a=-1; b=1; h = 2/(n+1);
r = linspace(-1, 1, n+2); % prvo in zadnjo poznamo
f1 = @(x) x+1+c/100; % krat 12 h^2
f2 = @(x) -x+1+c/100;

% matrika bo velikosti nxn ker prvega in zadnjega poznamo

% prvi dve in zadnji dve drstici bom posebej premislila

% naredim matriko n-2 x n-2
d = -30 * ones(n-4,1);

pd = 16*ones(n-5, 1);
ppd = -1*ones(n-6, 1);

nd = pd; nnd = ppd;

A = diag(ppd,-2) + diag(pd,-1) + diag(d) + diag(nd, 1) + diag(nnd, 2);

% A dodam dva stolpca nièel na levi in desni
stolpec = zeros(n-4, 1); 
stolpec1 = stolpec; stolpec1(1,1) = -1;
stolpec2 = stolpec; stolpec2(1,1) = 16; stolpec1(2,1) = -1;
stolpec3 = stolpec; stolpec3(end,1) = 16; stolpec3(end-1,1) = -1;
stolpec4 = stolpec; stolpec4(end,1) = -1;
A = [stolpec1, stolpec2, A, stolpec3, stolpec4];

fill = zeros(1, n-4);
prvi = [-20 6 4 -4 fill];
drugi = [16 -30 16 -1 fill];

zadnji = [ fill -1 4 6 -20];
predzadnji = [fill -1 16 -30 16];

A =[prvi; drugi; A; predzadnji; zadnji];
norm(A, 'fro');

for i=1:length(r)
    if r(i) == 0
        disp(i);
    end
end

rhs = 12.*h^2.*[f1(r(2:32)), f2(r(33:end-1))];
b = A\rhs';
b(33)
b(32)
b(31)
% b(30)
    
