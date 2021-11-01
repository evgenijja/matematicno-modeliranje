function tocke = razdeli_veriznico(T1, T2, l, n)
% razdeli zvezno verižnico na n delov in vrne delilne toèke vkljuèno s prvo
% in zadnjo
%n = 5;
z0 = 1;
tol = 1e-10;
z = isci_z(T1,T2,l,z0,tol);
a = T1(1); A = T1(2);
b = T2(1); B = T2(2);
v = atanh((B-A)/l) + z;
u = atanh((B-A)/l) - z;
C = (b-a)/(v-u);
D = (a*v-b*u)/(v-u);
lambda = A-C*cosh((a-D)/C);
w = @(x) lambda + C*cosh((x-D)/C);

del_l = l/n;
abcisa = T1(1);
abcise = []; ordinate = [];
% premaknemo se za l/5 po verižnici ampak ne vemo koliko je to po abcisi
for i = 1:n-1
    %abcisa = D + C*(asinh((del_l + C*sinh((abcisa-D)/C)*C)/C)); %tle je
    %neki narobe
    abcisa = D + C*(asinh(del_l/C + sinh((abcisa-D)/C)));
    abcise = [abcise, abcisa];
    ordinate = [ordinate, w(abcisa)];
end
%odg4 = sum(ordinate);

abcise = [a, abcise, b];
ordinate = [A, ordinate, B];
tocke = [abcise; ordinate];
end