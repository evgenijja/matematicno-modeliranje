% rešene naloge iz bezierjevih krivulj

%--------------------------------------------------------------------------
% % mini kviz o bezierjevih krivuljah
% c = [0, 1, 2, 4; 0, -1, -1, 2];
% 
% % easy
% deCasteljau(c, 0.5);
% norm(bezier_der(c, 0.5, 0), 2);
% norm(deCasteljau(c, 0.5));
% 
% % ukrivljenost v toèki
% ukrivljenost(c, 0.5);
% 
% % subdivizija
% [u1, u2] = sub_demo(c, 0.4, 0);
% sum(u1(2,:));
% 
% % presek s premico
% l = [1, 1; 0, -1];
% l = [1, -1; 0, 1];
% presek_s_premico(c, l, 1e-6);
% 
% % zvišaj stopnjo
% b = zvisaj_stopnjo(c);
% sum(b(1,:));
% 
% % pri kateri vrednosti parametra t je tangentni vektor vzporeden z abciso
% % (to je tam kjer bo y tangentnega vektorja 0
% nicla = @(t) bezier_der(c, t, 0);
% vzemi_drugo_komponento = @(seznam) seznam(2);
% druga_komponenta = @(t) vzemi_drugo_komponento(nicla(t));
% fsolve(druga_komponenta, 0);
% 
% % kakšna je razdalje toèke do krivulje
% A = [2; 0.5];
% razdalja = @(t) norm(-deCasteljau(c, t) + A, 2);
% options = optimset('TolFun', 1e-16);
% t0 = fminsearch(razdalja, 1, options);
% razdalja(t0);

%--------------------------------------------------------------------------

% % domaèa naloga 2021
% bC = [0 1 2 3 4 2 1.5 1; 0 2 -1 1 3 2 1 0];
% %plotBezier(bC);
% 
% % 1. naloga
% % zavrtimo in premaknemo tako da zaèetek na koncu in konec na zaèetku
% %b1 = rotiraj_bezier(bC, pi);
% vektor = [1, 0]';
% %b = premakni_bezier(b1, vektor);
% %norm(deCasteljau(b, 1/3), 2);
% 
% % 2. naloga
% % razdelimo na tri dele pri samopreseèišèu, doloèi vse tri krivulje
% [t1, t2] = poisci_samopresecisce(bC);
% [kontrolne1, ostalo] = sub_demo(bC, t1, 0);
% 
% % lokalni parameter
% t22 = (t2 - t1) / (1 - t1); % "delež," ki ga predstavlja vmesni del na ostalem intervalu [0,1]
% % t22 je toèka NA KONCU drugega dela
% [kontrolne2, kontrolne3] = sub_demo(ostalo, t22, 0);
% odg2 = norm(deCasteljau(kontrolne2, 1/3), 2); % 2.8390515564035
% 
% % 3. naloga
% % težišèe bezierjeve krivulje
% funkc = @(t) deCasteljau(bC, t);  
% fun_x = @(t) norm(bezier_der(bC, t, 0), 2);
% dolzina = integral(fun_x, 0, 1, 'ArrayValued', true); % dolžina krivulje
% [x1, y1] = parametricno(bC);
% x = @(t) x1(t);
% fun_xx = @(t) fun_x(t) * x(t);
% kriv = (1/dolzina) * integral(fun_xx, 0, 1, 'ArrayValued', true);
% 
% % vmesna naloga - dolzina krivulje
% fun_x = @(t) norm(bezier_der(bC, t, 0), 2);
% dolzina = integral(fun_x, 0, 1, 'ArrayValued', true); % dolžina krivulje
% 
% %4. naloga
% % ordinato èetrte toèke doloèite tako, da bo dolžina krivulje èim manjša
% b = @(x)[0 1 2 3 4 2 1.5 1; 0 2 -1 x 3 2 1 0];
% fun = @(t, x) norm(bezier_der(b(x), t, 0), 2); % ds
% %fun2 = @(x) fun(t, x);
% dolzina_min = @(x) integral(@(t) fun(t, x), 0, 1, 'ArrayValued', true);
% x_koord = fminsearch(dolzina_min, 1);
% dolzina_min(x_koord);
% 
% % 5. naloga
% % hausdorffova razdalja in konvergenca
% r = 4;
% t = 0.5;
% %razdalje = konvergenca(bC, r, t);
% % razdalje2 = konvergenca(bC, r+1, t);
% % %razdalje2 = konvergenca(b(x_koord), r+2, t);
% % K = [];
% % for i = 1:r+1
% %     k = log(razdalje2(i+1)/razdalje2(i))/log(0.5);
% %     K = [K, k];
% % end
% % povp = sum(K)/length(K) % ne dela prov :(

%--------------------------------------------------------------------------

% kviz 2021
%bC = [?     2.2     0   -13.8     0     2.2     ?; ?     ?     9.0     0    -9.0     ?     ?]
x = @(phi) 2.*(1-cos(phi)).*cos(phi);
y = @(phi) 2.*(1-cos(phi)).*sin(phi);

p = [x(0), x(2*pi); y(0), y(2*pi)];

x_odvod = @(phi) 2*(sin(phi) + 2.*sin(phi).*cos(phi));
y_odvod = @(phi) 2*(sin(phi).^2 + cos(phi) + cos(phi)^2);

v = [x_odvod(0), x_odvod(2*pi); y_odvod(0), y_odvod(2*pi)];

b = @(a, b) [x(0)     2.2     0   -13.8     0     2.2     x(2*pi); y(0)     a     9.0     0    -9.0     b     y(2*pi)];

% 
n = 6;
dP = @(a, b) [2.2-x(0), 0-2.2, -13.8-0, 0+13.8, 2.2-0, x(2*pi)-2.2; a-y(0), 9-a, 0-9, -9-0, b+9, y(2*pi)-b];
% Najprej izracunamo preme diference konrtolnih tock dP_i = b_{i+1} - b_i
%dP = b(:,2:end)-b(:,1:(end-1));
% for r=1:n
%     b(:,1:end-r) = (1-t)*b(:,1:end-r) + t*b(:,2:end-r+1);
% end
% tocka = b(:,1);
% tangentni vektor in tocka
vekt = @(a, b, t) n*deCasteljau(dP(a, b),t);
%tocka = deCasteljau(b,t);

eq1 = @(a, b) vekt(a, b, 0) - v(:,1);
eq2 = @(a, b) vekt(a, b, 1) - v(:,2);
eq12 = @(x) [eq1(x(1), x(2)); eq2(x(1), x(2))];

solution = fsolve(eq12, [0;0]);
a1 = solution(1); b1 = solution(2);

norm(deCasteljau(b(a1,b1), 1/3), 2); %3.394163648980155
%3.2804961357668 dobim z ugibanjem
norm(deCasteljau(b(0,0), 1/3), 2);

x = @(phi) 2.*(1-cos(phi)).*cos(phi);
y = @(phi) 2.*(1-cos(phi)).*sin(phi);

t = linspace(0, 2*pi, 1000);
% plot(x(t), y(t));

x_odvod = @(phi) -2.*sin(phi).*(1-2.*cos(phi));
y_odvod = @(phi) 2*(sin(phi).^2 + cos(phi) - cos(phi)^2);


smer2 = @(phi) y_odvod(phi)/x_odvod(phi);
smer = @(phi) [x_odvod(phi); y_odvod(phi)];

% %b = zeros(2, 7);
% b = @(u, v) [x(0)     2.2     0   -13.8     0     2.2     x(2*pi); y(0)     u     9.0     0    -9.0     v     y(2*pi)]; 
% %b(:,1) = [x(0); y(0)]; b(:,end) = [x(2*pi); y(2*pi)];
% 
% eq1 = @(u, v) bezier_derSez(b(u, v), 0, 0) - smer(0);
% eq2 = @(u, v) bezier_derSez(b(u, v), 2*pi, 0) - smer(2*pi);
% eq12 = @(u) [eq1(u(1), u(2)); eq2(u(1), u(2))];
% eq12 = @(u) [eq1(u, u); eq2(u, u)];
% sol = fsolve(eq12, 1);
% 
% % b2 = b(sol(1), sol(2));
% % norm(deCasteljau(b2, 1/3), 2)
% % b3 = b(0, 0);
% % norm(deCasteljau(b3, 1/3), 2);
% 
% 
% p = [x(0), x(2*pi); y(0), y(2*pi)];
% v = [x_odvod(0), x_odvod(2*pi); y_odvod(0), y_odvod(2*pi)];
% u = [x(0), 2.2, -13.8, 0, 2.2, x(2*pi)];
% u = [x(0), x(2*pi)];
% bb =C1CubicSpline(u,p,v);
% bb;
% 
% B = b(0,0);
% norm(deCasteljau(B, 1/3), 2);
% 
% % razmerje dolzin krivulj
% % dolzina bezierja
% fun = @(t) norm(bezier_derSez(B, t, 0), 2); % derSez ker mi sicer javlja, da rabim .*
% dolz = integral(fun, 0, 1, 'ArrayValued', true);
% % dolzina navadne krivulje, ki sem jo trikrat narobe odvajala preden sem
% % prav zraèunala
% fun_c = @(t) norm([x_odvod(t), y_odvod(t)], 2);
% dolz_c = integral(fun_c, 0, 2*pi, 'ArrayValued', true);
% dolz/dolz_c;
% 
% %hausdorffova razdalja
% X = linspace(0, 2*pi, 100);
% tocke_c = [];
% for i=1:100
%     tocke_c = [tocke_c, [x(t); y(t)]];
% end
% 
% Y = linspace(0, 1, 100);
% tocke_b = CasteljauSez(B, Y);
% hausdorffRazdalja_dvosmerna(tocke_c, tocke_b);
% 
% % preseèišèe s krožnico - zgornji del
% kroznica1 = @(x) sqrt(9-x^2);
% kroznica2 = @(x) -sqrt(9-x^2);
% 
% % presek krožnice in krivulje zraèunamo kot presek dveh parametriènih
% % krivulj
% [x1, y1] = parametricno(B);
% x2 = @(x) x;
% y2 = @(x) kroznica1(x);
% 
% eq1 = @(t1, t2) x1(t1) - x2(t2);
% eq2 = @(t1, t2) y1(t1) - y2(t2);
% 
% eq12 = @(v) [eq1(v(1), v(2)); eq2(v(1), v(2))];
% presek = fsolve(eq12, [0.5; 0.5]);
% t1 = presek(1);
% 
% B1 = sub_demo(B, t1, 0);
% abcise = B1(1,:);
% sum(abcise)/length(abcise);
% 
% 
% 
% 
% %--------------------------------------------------------------------------
% % 
% % % kolaž starh izpitov
% % c = 2;
% % b = [0, 1, 3 + c/100, 4; 1, 2, 2, -1];
% % 
% % % normala na krivuljo - pravokotna na tangento
% % odvod = @(t) bezier_der(b, t, 0);
% % 
% % vzemi_prvo_komponento = @(seznam) seznam(1);
% % vzemi_drugo_komponento = @(seznam) seznam(2);
% % 
% % prva = @(t) vzemi_prvo_komponento(odvod(t));
% % druga = @(t) vzemi_drugo_komponento(odvod(t));
% % 
% % enacba = @(t) prva(t)/druga(t) + 1;
% % fsolve(enacba, 0.5);
% % 
% % % kot pod katerim se sekata tangenta na b in premica
% % tangenta = bezier_der(b, 0.6, 0);
% % %tocka = deCasteljau(b, 0.6);
% % vektor = [1; 3/2];
% % %kosinus = (tangenta(1)*vektor(1) + tangenta(2)*vektor(2))/(norm(tangenta)*norm(vektor));
% % kosinus = tangenta'*vektor/(norm(tangenta)*norm(vektor));
% % kot = acos(kosinus);
% % 
% % % dolzina krivulje
% % fun = @(t) norm(bezier_derSez(b, t, 0), 2); % derSez ker mi sicer javlja, da rabim .*
% % dolz = integral(fun, 0, 1, 'ArrayValued', true);
% % 
% % % doloèi b(t) da bo plošèina trikotnika med prvo, drugo in b(t) najmanjša
% % 
% % % premica
% % K = b(:,2) - b(:,3);
% % k1 = K(1); k2 = K(2);
% % k = k2/k1;
% % tocka = b(:,2);
% % a1 = tocka(1); a2 = tocka(2);
% % n = a2 - k*a1;
% % premica = [-k, 1, -n];
% % 
% % dist = @(t) tocka_do_premice(deCasteljau(b, t), premica);
% % t0 = fminsearch(dist, 0.8);
% % norm(K) * dist(t0) * 1/2;
% 
% 
% %--------------------------------------------------------------------------
% 
% % kviz 2020
% b1C = [0.0000 208.6800 399.5000 399.5000 399.5000 208.6800 0.0000 ; 122.2000 122.2000 280.1200 474.7000 669.2800 827.2000 827.2000 ];
% 
% % razlika med dolžino bezierja in polovico krožnega loka
% r = norm(b1C(:,1) - b1C(:,end))/2;
% lok = pi*r;
% funkc = @(t) deCasteljau(b1C, t);  
% fun_x = @(t) norm(bezier_der(b1C, t, 0), 2);
% dolzina = integral(fun_x, 0, 1, 'ArrayValued', true);
% razlika = abs(lok-dolzina);
% 
% % % % skaliranje ipd
% % b2 = premakni_bezier(b1C, -b1C(:, end)); % premaknem v izhodišèe
% % % skaliram tako, da vektorje kontrolnih toèk množim z 4/3
% % b2 = 4/3*b2;
% % %plotBezier(b2)
% % b2 = premakni_bezier(b2, b1C(:, end));
% % % najnižjo ordinato pa vidimo kar iz slike heh
% % b22 = b2;
% % 
% % % okej torej
% % norma = norm(b2(:,1));
% % b2 = premakni_bezier(b2, -b2(:,1));
% % b2 = rotiraj_bezier(b2, -pi/3);
% % b2 = zrcali_bezier(b2);
% % b2 = rotiraj_bezier(b2, -pi/3);
% % vekt = [-cos(pi/6); sin(pi/6)]*norma;
% % b2 = premakni_bezier(b2, vekt);
% % abcise = b2(1,:);
% % sum(abcise)/length(abcise); % DELA!!!!!!!!!!!!!!
% % 
% % plotBezier(b2)
% % plotBezier(b22)
% 
% % %%%preseèišèe obeh krivulj
% % bz = b2;
% % T = presecisce_krivulj(b22, bz);
% % t1 = T(1); t2 = T(2);
% 
% % plotBezier(b22)
% % plotBezier(bz)
% % [b2p1, b2p2] = sub_demo(b22, t1, 1);
% % t22 = 1 / (1 - t1);
% % deCasteljau(b2p2, 1/2); % v tem primeru se sploh ne rabiš zafrkavat z lokalnim parametrom?
% 
% % tle sta še dve nalogi
% 
% %--------------------------------------------------------------------------
% 
% % stari izpiti
% 
% c = 24; b = [2, 3+c/100, 9/2, 5; 0, 3/2, 1, -1];
% 
% % predznaèena ukrivljenost
% ukrivljenost(b, 0.5);
% 
% %Pri katerem parametru t je tangenta na krivuljo b vzporedna premici skozi toèki b0 in  b3
% % torej kdaj imata isti smerni koeficient
% 
% % premica skozi prvo in zadnjo toèko
% [k, n] = premica_skozi_tocki(b(:,1), b(:,end));
% premica = @(x) k*x + n;
% 
% % tangenta na krivuljo
% %tangenta_v_t = @(t) bezier_derSez(b, t);
% % bezier_derSez vrne tangentni vektor v, jaz rabim smer
% tangenta_v_t = @(t) bezier_derSez_smer(b, t, false);
% iscem_t = @(t) tangenta_v_t(t) - k;
% %parameter = fsolve(iscem_t, 0);
% 
% % Krivuljo b zarotirajte okrog toèke b0 za 90 stopinj v nasprotni smeri 
% %urinega kazalca. Naj bo P toèka na dobljeni Bezierovi krivulji pri 
% %parametru 0.5 in S razpolovišèe daljice b0b3. Kolikšna je vsota koordinat 
% %preseèišèa daljice PS in krivulje  b
% b2 = b;
% b2 = premakni_bezier(b2, [-2; 0]); % èe jo enkrat premakneš jo moraš tudi nazaj
% b2 = rotiraj_bezier(b2, pi/2);
% b2 = premakni_bezier(b2, [2; 0]);
% P = deCasteljau(b2, 0.5);
% S = 1/2*(b(:,1) + b(:,end));
% 
% preseki = presek_s_premico(b, [P, S-P], tol);
% sum(preseki);
% 
% % nova krivulja
% c = [5, 5, 6; -1, 1, 2];
% c = premakni_bezier(c, [-1; -3]);
% 
% % Kolikšna je norma vektorja v, za katerega moramo premakniti toèko c1, 
% %da bo dobljen zlepek krivulj b in c C1?
% cx = @(x) [5, 5 + x(1), 6; -1, 1+x(2), 2];
% % pogoj za C1 je, da se ujemata odvoda v zadnji tocki b in prvi za c
% enacba = @(x) bezier_derSez(b, 1, 0) - bezier_derSez(cx(x), 0, 0);
% % vektor = fsolve(enacba, [1; 1]);
% % norm(vektor);
% % mora veljat, da je bn = c0
% 

%--------------------------------------------------------------------------

% lanski izpit

% bC = [0.0 1.0 1.9 2.8 4.0 2.0 1.5 1.0; 0.0 2.0 -1.0 1.0 2.8 1.9 1.0 0.0];
% 
% [t1, t2] = poisci_samopresecisce(bC);
% [kontrolne1, ostalo] = sub_demo(bC, t1, 0);
% t22 = (t2 - t1) / (1 - t1); % "delež," ki ga predstavlja vmesni del na ostalem intervalu [0,1]
% % % t22 je toèka NA KONCU drugega dela
% [kontrolne2, kontrolne3] = sub_demo(ostalo, t22, 0);
% bezier_derSez(kontrolne2, 0, 0);
% 
% [x2, y2] = parametricno(kontrolne2);
% razdalja = @(t) -norm(kontrolne2(:,1) - [x2(t), y2(t)]');
% t1 = fminsearch(razdalja, 0.5);
% razdalja(t1);
% 
% plotBezier(kontrolne2);
% r = @(t) sqrt(x2(t)^2 + y2(t)^2);
% 
% x = deCasteljau(kontrolne2, 1/4);
% k = bezier_derSez(kontrolne2, 1/4, 0);
% k1 = k(1); k2 = k(2);
% k = k2/k1;
% n = x(2) - k*x(1);
% premica = @(t) k*t + n;
% 
% % T = linspace(1, 3, 100);
% % hold on
% % plot(T, premica(T))
% % plotBezier(kontrolne2)
% % hold off
% 
% d = @(t) -abs(-k*x2(t) + y2(t) -n)/sqrt(k^2 + 1);
% t5 = fminsearch(d, 0.5);
% d(t5);
% 
% 
% 
