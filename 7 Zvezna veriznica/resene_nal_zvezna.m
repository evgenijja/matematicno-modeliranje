% % rešene nal iz zvezne verižnice

% OSNOVNO

% z = isci_z(T1,T2,l,z0,tol);
% a = T1(1); A = T1(2);
% b = T2(1); B = T2(2);
% z0 = 1;
% tol = 1e-10;
% 
% v = atanh((B-A)/l) + z;
% u = atanh((B-A)/l) - z;
% 
% C = (b-a)/(v-u);
% D = (a*v-b*u)/(v-u);
% lambda = A-C*cosh((a-D)/C);
% 
% w = @(x) lambda + C*cosh((x-D)/C);
% w_odvod = @(x) sinh((x-D)/C);
% 
% tol = 1e-10;
% options = optimoptions('fsolve','Display','none');

%--------------------------------------------------------------------------
% % kviz zvezna veriznica 2021
% l = 14;
% T1 = [0 5]; T2 = [5 3];
% a = T1(1); A = T1(2);
% b = T2(1); B = T2(2);
% 
% z = isci_z([a A],[b B],l,1,1e-10);
% 
% v = atanh((B-A)/l) + z;
% u = atanh((B-A)/l) - z;
% 
% C = (b-a)/(v-u);
% D = (a*v-b*u)/(v-u);
% lambda = A-C*cosh((a-D)/C);
% 
% w = @(x) lambda + C*cosh((x-D)/C);
% w_odvod = @(x) sinh((x-D)/C);
% 
% % y pri abcisi 2
% odg1 = w(2); % torej y = w(x)
% 
% % najnižja toèka je pri
% fminsearch(w, 1);
% 
% % presek s premico y = x
% enacba = @(x) w(x) - x;
% x_koord = fsolve(enacba, 3);
% y_koord = x_koord; % ker leži na y = x
% 
% % prerežemo jo s premico y = 4, koliko je dolg daljši del vrvi?
% %risi_ver(T1, T2, l, tol);
% % presek s premico y = 4 je samo eden
% enacba = @(x) w(x) - 4;
% x_koord = fsolve(enacba, 2);
% T = [x_koord w(x_koord)];
% % dolžina od T do zadnje toèke
% ds = @(x) sqrt(1 + w_odvod(x).^2);
% dolzina = integral(ds, T(1), T2(1));
% 
% % koliko bi morala biti ordinata toèke T1, da bi bila najnižja toèka pri x
% % = 2.5
% l = 14;
% T1 = [0 5]; T2 = @(x) [5 x];
% a = T1(1); A = T1(2);
% b = 5; B = @(x) x;
% 
% z = @(x) isci_z(T1, T2(x),l,1,1e-10);
% 
% v = @(x) atanh((B(x)-A)/l) + z(x);
% u = @(x) atanh((B(x)-A)/l) - z(x);
% 
% %C = @(x)(b-a)/(v(x)-u(x));
% D = @(x)(a.*v(x)-b.*u(x))./(v(x)-u(x));
% %lambda = @(x) A(x)-C(x)*cosh((a-D(x))/C(x));
% 
% %w = @(x,y) lambda + C*cosh((x-D(y))/C(y));
% %w_odvod = @(x, y) sinh((x-D(y))/C(y));
% 
% % nièlo odvoda hoèemo pri x = 2,5
% % odvod bo nièeln za x-D(y) = 0 torej ko D(y) = 2,5
% enacba = @(x) D(x) - 2.5;
% fsolve(enacba, 2);
% 
% % ali drugaèe
% % izracun ordinate tocke T1, da bo najnizja tocka imela absciso 2.5
% F = @(x) najnizja_tocka(a,A,b,x,l)-2.5;
% ordinata = fsolve(F,3,options);

%--------------------------------------------------------------------------
% domaèa naloga 2021

% osnovno o verižnici
% K = 73;
% l = 16;
% T1 = [1 2]; T2 = [5 + K/100, 2];
% z0 = 1;
% tol = 1e-10;
% 
% z = isci_z(T1,T2,l,z0,tol);
% a = T1(1); A = T1(2);
% b = T2(1); B = T2(2);
% 
% v = atanh((B-A)/l) + z;
% u = atanh((B-A)/l) - z;
% 
% C = (b-a)/(v-u);
% D = (a*v-b*u)/(v-u);
% lambda = A-C*cosh((a-D)/C);
% 
% w = @(x) lambda + C*cosh((x-D)/C);

%-------------------------------------------------------------------------

% 1. vprašanje - doloèi abciso toèke tako, da bosta loka v razmerju 2:1
% P =@(x) [x, w(x)];
% l1 = @(x) dolzina(T1,T2,l,z0, T1, P(x),tol);
% l2 = @(x) dolzina(T1,T2,l,z0, [x, w(x)], T2, tol);
% enacba = @(x) l - 1.5*l1(x);
% odg1 = fsolve(enacba, 2);

% 2. vprašanje - razdalja med najnižjo toèko in težišèem
% težišèe
% f = @(x) x .* sqrt(1 + (sinh((x-D)./C)).^2); % tale sinh je w'(x), enacba je sqrt(1+w'^2)
% t_x =  (1/l) * integral(f, a, b);
% f2 = @(x) w(x) .* cosh((x-D)./C);
% t_y =  (1/l) * integral(f2, a, b);
% t = [t_x, t_y];
% 
% najnizja = [D, w(D)]; % v D je nièla odvoda
% d = t - najnizja;
% odg2 = norm(d);
% 
% % 3. vprašanje - najnižja toèka hoèemo da je na abcisi
% % hoèemo D = [x, w(x)=0]
% % l = koren(1 + w'^2)
% 
% nov_z = @(l) isci_z(T1,T2,l,z0,tol);
% v2 = @(l) atanh((B-A)./l) + nov_z(l);
% u2 = @(l) atanh((B-A)./l) - nov_z(l);
% 
% DD = @(l) (a.*v2(l) - b.*u2(l))./(v2(l)-u2(l));
% CC = @(l) (b-a)./(v2(l)-u2(l));
% 
% lambda_nov = @(l) A - CC(l).*cosh((a-DD(l))./CC(l));
% w_nov = @(l, x) lambda_nov(l) + CC(l).*cosh((x-DD(l))./CC(l));
% 
% enacba3 = @(l) w_nov(l, DD(l)); % najnižja je pri x = D
% odg3 = fzero(enacba3, 5); % èe dam zaèetni približek npr 1 ne dela
% 
% % 4. vprašanje - razdelimo na 5 delov
% n = 5;
% del_l = l/n;
% abcisa = a;
% abcise = []; ordinate = [];
% % premaknemo se za l/5 po verižnici ampak ne vemo koliko je to po abcisi
% for i = 1:n-1
%     %abcisa = D + C*(asinh((del_l + C*sinh((abcisa-D)/C)*C)/C)); %tle je
%     %neki narobe
%     abcisa = D + C*(asinh(del_l/C + sinh((abcisa-D)/C))); % izražen b iz enaèbe za l
%     abcise = [abcise, abcisa];
%     ordinate = [ordinate, w(abcisa)];
% end
% odg4 = sum(ordinate);
% 
% % dodam še T1 in T2
% abcise = [a, abcise, b];
% ordinate = [A, ordinate, B];
% 
% % 5. vprašanje - diskretna
% delilne_tocke = [abcise; ordinate];
% pl_diskretne = ploscina(delilne_tocke); % to je od diskretne
% pl_zvezne = abs(integral(w, a, b));
% odg5 = abs(pl_diskretne - pl_zvezne);
% 
% % 6. naloga - na koliko delov, da bo ploscina manjsa od 0.5
% delilne_tocke2 = @(n) razdeli_veriznico(T1, T2, l, n); % vrne delilne toèke
% enacba2 = @(n) abs(ploscina(delilne_tocke2(n)) - pl_zvezne) - 0.01;
% khm = fzero(enacba2, 1); % = 79.253931834254942 torej n = 80, ker 79 še ni ok, torej 80
% odg6 = ceil(khm); % zaokr navzgor
% 
% %--------------------------------------------------------------------------
% 
% % letošnji kviz
% 
% % b = 2; l = 16; T1 = [1, 0]; T2 = [5, 4+b/100];
% % z0 = 1;
% tol = 1e-10;
% 
% z = isci_z(T1,T2,l,z0,tol);
% a = T1(1); A = T1(2);
% b = T2(1); B = T2(2);
% 
% v = atanh((B-A)/l) + z;
% u = atanh((B-A)/l) - z;
% 
% C = (b-a)/(v-u);
% D = (a*v-b*u)/(v-u);
% lambda = A-C*cosh((a-D)/C);
% 
% w = @(x) lambda + C*cosh((x-D)/C);
% 
% % dolzina loka od najnižje toèke do konca
% Px = najnizja_tocka(a,A,b,B,l);
% P = [Px, w(Px)];
% dolz = dolzina(T1,T2,l,z0,P, T2,tol);
% 
% % 2. vprašanje - vstoa koordinat težišèa
% f = @(x) x .* sqrt(1 + (sinh((x-D)./C)).^2); % tale sinh je w'(x)
% t_x =  (1/l) * integral(f, a, b);
% f2 = @(x) w(x) .* cosh((x-D)./C);
% t_y =  (1/l) * integral(f2, a, b);
% tezisce = [t_x, t_y];
% odg1 = sum(tezisce);
% 
% % 3. vprašanje - imamo še eno verižnico vpeto v istih toèkah, raèunamo
% % plošèino lika med verižnicama
% pl_zvezne1 = abs(integral(w, a, b));
% 
% % druga verižnica odvisna od l
% z = @(l) isci_z(T1,T2,l,z0,tol);
% %a = T1(1); A = T1(2);
% %b = T2(1); B = T2(2);
% 
% v = @(l) atanh((B-A)/l) + z(l);
% u = @(l) atanh((B-A)/l) - z(l);
% 
% C = @(l) (b-a)/(v(l)-u(l));
% D = @(l)(a*v(l)-b*u(l))/(v(l)-u(l));
% lambda = @(l) A-C(l)*cosh((a-D(l))/C(l));
% 
% w2 = @(x, l) lambda(l) + C(l)*cosh((x-D(l))/C(l));
% 
% pl_zvezne2 = @(l) abs(integral(@(x)w2(x, l), a, b));
% 
% razlika = @(l)abs(pl_zvezne1 - pl_zvezne2(l)) - 10;
% odg3 = fzero(razlika, 16);
% 
% % 4. vprašanje
% % kako zraèunat kot med tremi toèkami
% velikost_kota = @(x) kot(T1, [x, w(x)], T2);
% fminbnd(velikost_kota, a, b);
% 
% % 5. vprašanje
% z = @(l) isci_z(T1,T2,l,z0,tol);
% %a = T1(1); A = T1(2);
% %b = T2(1); B = T2(2);
% 
% v = @(l) atanh((B-A)/l) + z(l);
% u = @(l) atanh((B-A)/l) - z(l);
% 
% C = @(l) (b-a)/(v(l)-u(l));
% D = @(l)(a*v(l)-b*u(l))/(v(l)-u(l));
% lambda = @(l) A-C(l)*cosh((a-D(l))/C(l));
% 
% w3 = @(x, l) lambda(l) + C(l)*cosh((x-D(l))/C(l));
% % w(3, l) = -3
% cez_tocko = @(l) w3(3, l) + 3;
% odg5 = fzero(cez_tocko, 10);

%--------------------------------------------------------------------------

% kolaž starih izpitov

% K = 61; l = 16; T1 = [1, 5]; T2 = [4, 3+K/100];
% 
% z = isci_z(T1,T2,l,z0,tol);
% a = T1(1); A = T1(2);
% b = T2(1); B = T2(2);
% 
% v = atanh((B-A)/l) + z;
% u = atanh((B-A)/l) - z;
% 
% C = (b-a)/(v-u);
% D = (a*v-b*u)/(v-u);
% lambda = A-C*cosh((a-D)/C);
% 
% w = @(x) lambda + C*cosh((x-D)/C);
% w_odvod = @(x) sinh((x-D)/C);
% 
% % doloèimo še eno verižnico, ki ima malo drugaèna obesišèa
% T3 = [1, 4]; T4 = [4, 3+K/100+2];
% 
% z2 = isci_z(T3,T4,l,z0,tol);
% a2 = T3(1); A2 = T3(2);
% b2 = T4(1); B2 = T4(2);
% 
% v2 = atanh((B2-A2)/l) + z2;
% u2 = atanh((B2-A2)/l) - z2;
% 
% C2 = (b2-a2)/(v2-u2);
% D2 = (a2*v2-b2*u2)/(v2-u2);
% lambda2 = A2-C2*cosh((a2-D2)/C2);
% 
% w2 = @(x) lambda2 + C2*cosh((x-D2)/C2);
% w_odvod2 = @(x) sinh((x-D2)/C2);
% 
% 
% % razlika med najnižjima toèkama obeh verižnic
% norm([D, w(D)]-[D2, w2(D2)], 2);
% 
% % preseèišèe, presek obeh verižnic
% enacba = @(x) w(x) - w2(x);
% x_koord = fsolve(enacba, 4);
% odg2 = w(x_koord);
% P = [x_koord, w(x_koord)];
% % raèunamo plošèino krivoèrtnih trikotnikov
% 
% % hold on
% % risi_ver(T1,T2,l,tol)
% % risi_ver(T3,T4,l,tol)
% % hold off
% % prvotna je višje na prvem delu do preseèišèa, druga pa na drugem
% pl1 = integral(w2, 1, P(1)) - integral(w, 1, P(1));
% pl2 = integral(w, P(1), 4) - integral(w2, P(1), 4);
% pl = abs(pl1) + (pl2);
% 
% % dolzina krivulje max od obeh
% d1 = dolzina(T1,T2,l,z0,T1, P,tol);
% d2 = dolzina(T3,T4,l,z0,P, T4,tol);
% d = d1 + d2;
% 
% %--------------------------------------------------------------------------
% 
% % lanski kviz
% 
% K = 49; l = 6; T1 = [0, 0]; T2 = [4, -3+K/100]; g = 9.8;
% 
% z = isci_z(T1,T2,l,z0,tol);
% a = T1(1); A = T1(2);
% b = T2(1); B = T2(2);
% z0 = 1;
% tol = 1e-10;
% 
% v = atanh((B-A)/l) + z;
% u = atanh((B-A)/l) - z;
% 
% C = (b-a)/(v-u);
% D = (a*v-b*u)/(v-u);
% lambda = A-C*cosh((a-D)/C);
% 
% w = @(x) lambda + C*cosh((x-D)/C);
% w_odvod = @(x) sinh((x-D)/C);
% w_drugi_odvod = @(x) 1/C*cosh((x-D)/C);
% 
% options = optimoptions('fsolve','Display','none');
% 
% % ukrivljenost krivulje
% kappa = @(x) abs(w_drugi_odvod(x))./((1 + w_odvod(x)^2).^(3/2));
% kappa(2);
% % x_fun = @(x) x;
% % x_odv = @(x) 1;
% % x_odv_odv = @(x) 0;
% % ukrivljenost(x_fun, w, x_odv, w_odvod, x_odv_odv, w_drugi_odvod, 2)
% 
% % èas potovanja po verižnici - glej brahistohrono
% fun = @(x) sqrt((1+w_odvod(x).^2)./(-2.*g.*w(x)));
% cas = integral(fun, 0, 4);
% 
% % tangenti v obesišèih, raèunamo trikotnik med obesišèema in preseèišèem
% % tangent
% % prva tangenta
% tang1 = @(x) w_odvod(0)*x;
% n2 = T2(2) - w_odvod(4)*4;
% tang2 =@(x) w_odvod(4)*x + n2;
% pres = @(x) tang1(x) - tang2(x);
% presecisce_x = fsolve(pres, 2);
% P = [presecisce_x, tang1(presecisce_x)];
% 
% % plošèina trikotnika med temi toèkami
% pl1 = ploscina_trikotnika(T1, T2, P);
% % prištela bom plošèino trikotnika, ki ga rabimo 'do abcise'
% % [4, 0] je toèka na abcisi pod drugim obesišèem
% pl2 = ploscina_trikotnika(T1, T2, [4, 0]);
% % in še plošèina verižnice
% pl3 = integral(w, 0, 4);
% pl = pl1 + pl2 - abs(pl3);
% 
% %--------------------------------------------------------------------------
% 
% % star izpit
% 
% b = 24; l = 16; T1=[1, 0]; T2 = [5, 4+b/100];
% 
% z = isci_z(T1,T2,l,z0,tol);
% a = T1(1); A = T1(2);
% b = T2(1); B = T2(2);
% z0 = 1;
% tol = 1e-10;
% 
% v = atanh((B-A)/l) + z;
% u = atanh((B-A)/l) - z;
% 
% C = (b-a)/(v-u);
% D = (a*v-b*u)/(v-u);
% lambda = A-C*cosh((a-D)/C);
% 
% w = @(x) lambda + C*cosh((x-D)/C);
% w_odvod = @(x) sinh((x-D)/C);
% 
% tol = 1e-10;
% options = optimoptions('fsolve','Display','none');
% 
% % najnižja toèka je pri D, dolzina loka P t2
% P = [D, w(D)];
% dolzina_krivulje = @(x) sqrt(1 + w_odvod(x).^2);
% dolzina1 = integral(dolzina_krivulje, P(1), T2(1));
% 
% w2 = @(x) -w(x);
% % X = linspace(1, 5, 1000);
% % hold on
% % risi_ver(T1, T2, l, tol)
% % plot(X, w2(X))
% % hold off
% 
% % iz skice vidim, da moram najprej poiskat preseèiše
% enacba = @(x) w(x) - w2(x);
% px = fsolve(enacba, 4);
% P = [px, w(px)];
% pl1 = integral(w, 1, px);
% pl2 = integral(w2, px, 5);
% pl = 2*(abs(pl1) + abs(pl2));
% 
% % poišèi toèko S, da je kot med T1S in ST2 najmanjši
% kot1 = @(x) kot(T1, [x, w(x)], T2);
% fminsearch(kot1, 1);
% 
% % dane so toèke
% P1= T1; P2 = T2; P3 = [3, w(3)]; 
% 
% % v teh toèkah imamo tangente
% tangenta1 = tangenta(w, w_odvod, P1(1));
% tangenta2 = tangenta(w, w_odvod, P2(1));
% tangenta3 = tangenta(w, w_odvod, P3(1));
% 
% % g definiramo na naslednji naèin
% g = @(x) max([tangenta1(x), tangenta2(x), tangenta3(x)]);
% min_g = fminsearch(g, 1);
% min_w = fminsearch(w, 1);
% 
% % zanima nas razlika minimumov
% razlika = abs(w(min_w) - g(min_g));

%--------------------------------------------------------------------------

% lanski izpit

T1 = [7, 16]; T2 = [12, 18]; T3 = [20, 20];

%min prve je 11, min druge 15
z0 = 1;
tol = 1e-10;

z = @(l) isci_z(T2,T3,l,z0,tol);
a = T2(1); A = T2(2);
b = T3(1); B = T3(2);

v = @(l)atanh((B-A)/l) + z(l);
u = @(l)atanh((B-A)/l) - z(l);

C = @(l)(b-a)/(v(l)-u(l));
D = @(l)(a*v(l)-b*u(l))/(v(l)-u(l));
lambda = @(l)A-C(l)*cosh((a-D(l))/C(l));

w = @(x, l) lambda(l) + C(l)*cosh((x-D(l))/C(l));
% w_odvod = @(x) sinh((x-D)/C);

z1 = @(l) isci_z(T1,T2,l,z0,tol);
a1 = T1(1); A1 = T1(2);
b1 = T2(1); B1 = T2(2);

v1 = @(l)atanh((B1-A1)/l) + z1(l);
u1 = @(l)atanh((B1-A1)/l) - z1(l);

C1 = @(l)(b1-a1)/(v1(l)-u1(l));
D1 = @(l)(a1*v1(l)-b1*u1(l))/(v1(l)-u1(l));
lambda1 = @(l)A1-C1(l)*cosh((a1-D1(l))/C1(l));

w1 = @(x, l) lambda1(l) + C1(l)*cosh((x-D1(l))/C1(l));
w1_odvod = @(x, l) sinh((x-D1(l))/C1(l));
tol = 1e-10;
options = optimoptions('fsolve','Display','none');


% najnižja je na višini 11
% najnižja je oblike [D, w(D)]

% 1. vprašanje 
eq = @(l) w1(D1(l), l) - 11;
l1 = fsolve(eq, 10);
% odg1 = D(l);
T = [D1(l1), 11];

% 2. vprašanje
eq = @(l) w(D(l), l) - 15;
l2 = fsolve(eq, 10);

L = l1 + l2;

najnizja1 = @(l)w1(D1(l), l);
najnizja2 = @(l)w(D(l), l);

fun = @(l) -najnizja1(l1-l) + najnizja2(l2+l);
poteg = fsolve(fun, 5);

ds = @(x) sqrt(1 + w1_odvod(x, l1).^2);
dolzina_pri_t = integral(ds, T1(1), T(1));

l11 = l1-1;
% nova ver
ds = @(x) sqrt(1 + w1_odvod(x, l11).^2);
dolzina2 = @(x) integral(ds, T1(1), x);
fun = @(x) dolzina2(x) - dolzina_pri_t;
abs(T(1) - fsolve(fun, 5));










