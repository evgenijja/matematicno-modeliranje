% testna skripta za prikaz subdivizije
b = [2 4 9/2 5;0 3/2 1 -1];
c = 0.5;

[kontrolne1,kontrolne2] = sub_demo(b,c,1);

P = pravokotnik(b);

l = [1.5 1; -1 1];
Tp = presek_s_premico(b,l,1e-6)