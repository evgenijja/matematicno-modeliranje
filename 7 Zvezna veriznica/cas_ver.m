function cas = cas_ver(T1, T2, l)

a = T1(1); A = T1(2);
b = T2(1); B = T2(2);

T1 = [T1(1), T1(2)-max(T1(2), T2(2))];
T2 = [T2(1), T2(2)-max(T1(2), T2(2))];


a = T1(1); A = T1(2);
b = T2(1); B = T2(2);


z0 = 1;
tol = 1e-10;
z = isci_z(T1,T2,l,z0,tol);

v = atanh((B-A)/l) + z;
u = atanh((B-A)/l) - z;

C = (b-a)/(v-u);
D = (a*v-b*u)/(v-u);
lambda = A-C*cosh((a-D)/C);

w = @(x) lambda + C*cosh((x-D)/C);
w_odvod = @(x) sinh((x-D)/C);

fun = @(x) sqrt((1+w_odvod(x).^2)./(-2.*9.81.*w(x)+10^2));
cas = integral(fun, -2, 2, 'ArrayValued', true);

end
