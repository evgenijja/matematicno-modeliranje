% letošnji izpit

c = 45;
T1 = [-2, 1]; T2 = [2, 4+c/100]; l = 11; g = 9.81;

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
w_odvod = @(x) sinh((x-D)/C);

tol = 1e-10;
options = optimoptions('fsolve','Display','none');

fun = @(x) norm([x, w(x)], 2);
fminsearch(fun, 1);

%risi_ver(T1, T2, l, tol)
% fun = @(x) sqrt((1+w_odvod(x).^2)./(-2.*g.*w(x)));
% cas = integral(fun, 0, 2, 'ArrayValued', true);
% cas_ver = 1/2*cas;
cas = cas_ver(T1, T2, l);

% cas z dodano zacetno hitrostjo zracunam tako da v datoteki cas_ver
% popravim funkcijo pod integralom - v imenovalcu je nova velikost hitrost
% sqrt(-2.*9.81.*w(x)+10^2)
% to dobim namreè iz enaèbe energij 
% zaèetek: mgh + 1/2mv0^2 = zac
% v poljubni tocki : mgw(x) + 1/2 v^2
% izrazim v = sqrt(2zac - 2gw(x))

%cas2 = cas_ver(T1, T2, l);


T1 = [-2, 1-4-c/100]; T2 = [2, 0]; l = 11; g = 9.81;

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
w_odvod = @(x) sinh((x-D)/C);

zac_e = g*w(-2) + 10^2/2;

fun1 = @(x) sqrt((1+w_odvod(x).^2)./(-2.*9.81.*w(x)));
cas1 = integral(fun1, -2, 2, 'ArrayValued', true);

fun2 = @(x) sqrt((1+w_odvod(x).^2)./((2*zac_e - 2*g*w(x))));
cas2 = integral(fun2, -2, 2, 'ArrayValued', true);

t = cas2*1/2;
cas22 = @(x) integral(fun2, -2, x, 'ArrayValued', true);
enacba = @(x) cas22(x) - t;
x_koord = fsolve(enacba, 0.5);
cas22(x_koord);

t2 = cas2*2;

nov_z = @(l) isci_z(T1,T2,l,z0,tol);
v2 = @(l) atanh((B-A)./l) + nov_z(l);
u2 = @(l) atanh((B-A)./l) - nov_z(l);

DD = @(l) (a.*v2(l) - b.*u2(l))./(v2(l)-u2(l));
CC = @(l) (b-a)./(v2(l)-u2(l));

lambda_nov = @(l) A - CC(l).*cosh((a-DD(l))./CC(l));
w_nov = @(l, x) lambda_nov(l) + CC(l).*cosh((x-DD(l))./CC(l));
w_odvod_nov = @(l, x) sinh((x-DD(l))/CC(l));

fun = @(l, x) sqrt((1+w_odvod_nov(l, x).^2)./(2*zac_e - 2*g*w_nov(l, x)));
cas = @(l) integral(@(x) fun(l, x), -2, 2, 'ArrayValued', true);

enacba = @(l) cas(l) - t2;
fsolve(enacba, 20)