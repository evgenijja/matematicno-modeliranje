function l = dolzina(T1,T2,l,z0,X, Y,tol)
% dolžina nas zanima od A do B
z = isci_z(T1,T2,l,1,1e-10);

a = T1(1);
A = T1(2);
b = T2(1);
B = T2(2);

v = atanh((B-A)/l) + z;
u = atanh((B-A)/l) - z;

C = (b-a)/(v-u);
D = (a*v-b*u)/(v-u);

a1 = X(1); a2 = X(2);
b1 = Y(1); b2 = Y(2);


l = C*(sinh((b1-D)/C)-sinh((a1-D)/C));
%lambda = A-C*cosh((a-D)/C);

%w = @(x) lambda + C*cosh((x-D)/C);
end