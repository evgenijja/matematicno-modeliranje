function risi_ver(T1,T2,l,tol)
% RISI_VER narise zvezno veriznico. Pri tem so:
% T1 in T2 sta krajisci veriznice oblike T1(a,A) in
% T2(b,B),
% l je dolzina veriznice,
% tol je toleranca, ki doloca natancnost priblizka
% pri navadni iteraciji.

a = T1(1);
A = T1(2);
b = T2(1);
B = T2(2);

z = isci_z(T1,T2,l,1,tol);

v = atanh((B-A)/l) + z;
u = atanh((B-A)/l) - z;

C = (b-a)/(v-u);
D = (a*v-b*u)/(v-u);
lambda = A-C*cosh((a-D)/C);

x = linspace(a,b,100);
w = lambda + C*cosh((x-D)/C);

plot(x,w,'LineWidth',3);

grid on
end