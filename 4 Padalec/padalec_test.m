% PAZI AL MA� ODE45 ALI ODE23S V DATOTEKI PADALEC


%vhodni podatki
m = 105;
c = 1;
S = 1.2;
parametri = [m,c,S];
zac = [40000;0];
tk = 300;
n = 10000;

% vpr1 - konstantna gostota ro in gravitacijski posp
[y,v,t] = padalec(parametri,zac,tk,n,1); 
pov_v = mean(v);
%fprintf('\nnaloga 1: %f\n', pov_v);

subplot(1,2,1)
plot(t,y,'bo-')
hold on
title('Pozicija v odvisnosti od casa')

subplot(1,2,2)
plot(t,v,'bo-')
hold on
title('Hitrost v odvisnosti od casa')


% vpr2 - maksimalna (kon�na) hitrost padalca
terminal_vel = -sqrt(m*9.81/(1.225*c*S/2));
%fprintf('naloga 2: %f\n', terminal_vel);

% vpr3 - sedaj pospe�ek odvisen tudi od vi�ine
[y,v,t] = padalec(parametri,zac,tk,n,2);
kon_y = y(end);
%fprintf('naloga 3: %f\n', kon_y);

% vpr4 - sedaj odvisen �e od gostote zraka
[y,v,t] = padalec(parametri,zac,tk,n,3);
kon2_y = y(end);
%fprintf('naloga 4: %f\n', kon2_y);

% vpr5 - dodatno se odrine ko sko�i
[~,v1,~] = padalec(parametri,[40000;0],30,n,3);
[~,v2,~] = padalec(parametri,[40000;-3],30,n,3);
razl = v2(end)-v1(end);
%fprintf('naloga 5: %f\n', razl);

% vpr6 - koliko �asa prete�e, ko prvi� dose�e hitrost 300 m/s brez odriva
%zadnji = @(x) x(end);
%f = @(h) zadnji(returnOneArg(2, @padalec, parametri,zac,h,n,3));

f = @(h) koncna_hitrost(parametri,zac,h,n,3);


%options = optimoptions('fsolve','Display','iter', 'FunctionTolerance', 1e-16);
options = optimoptions('fsolve','Display','none', 'FunctionTolerance', 1e-16);

% zacetni priblizek preberimo iz grafa
% figure
% subplot(1,2,1)
% plot(t,y,'bo-')
% hold on
% title('Pozicija v odvisnosti od casa')
% 
% subplot(1,2,2)
% plot(t,v,'bo-')
% hold on
% title('Hitrost v odvisnosti od casa')

h = fsolve(@(h) f(h) + 300,30,options);
%fprintf('naloga 6: %f\n', h);


%--------------------------------------------------------------------------

% doma�a naloga

H = 40000;
m = 94;
c = 1.1;
S = 1.2;
parametri = [m,c,S];
zac = [H;0];

n = 10000;
r = 6371000;

% 1. vpra�anje
%padalec(parametri,zac,tk,n,3);
tk = 250;
[y,v,~] = padalec(parametri,zac,25,n,3);
odg1 = H - y(end);

% 2. vpra�anje
tk2 = 60;
[y,v,t] = padalec(parametri,zac,tk2,n,3);
prva_hitrost = abs(v(end));
m2 = m + 100;
S2 = S + 0.1;
c2 = c + 0.1;
parametri2 = [m2, c2, S2];
[y2,v2,t2] = padalec(parametri2,zac,tk2,n,3);
druga_hitrost = abs(v2(end));
odg2 = abs(prva_hitrost - druga_hitrost);

% 3. vpra�anje
% X = fminbnd(FUN,x1,x2) attempts to find  a local minimizer X of the function 
   % FUN in the interval x1 < X < x2.  FUN is a function handle. 
% v bistvu i��rmo minimum
f = @(h) koncna_hitrost(parametri,zac,h,n,3);
t3 = fminbnd(f, 0, 60); % ob tem �asu je min
odg3 = f(t3); % tuk pa je vrednost 

% 4. vpra�anje
% i��emo topt, da bo po 400 sekundah od padca pristal na zemljo
t_cel = 400;
%[y,v,t] = padalec(parametri,zac,tk,n,3);

% skok bo iz dveh delov, prvi normalen, drugi pa ve�ja povr�ina
% prvi del bo trajal od 0 do topt
% drugi del pa od topt do 400 torej od 0 do 400-topt
% poleg tega bodo zacetni pogoji za drugi del drgac in sicer tako polozaj
% kot hitrost
S3 = S + 10;
c3 = 5*c;
parametri3 = [m, c3, S3];

% vsota poti, ki jih prepotuje v obeh delih mora bit H
pot1 = @(t) 40000 - padalec_ykon(parametri,zac,t,n,3); % prepotovana pot v prvem delu
% prepotovana pot v drugem delu je odvisna od hitrosti s katero zaklju�i
% prvi del

v_nov = @(t) padalec_vkon(parametri3,zac,t,n,3);
zac_nov = @(t) [40000 - pot1(t); v_nov(t)];
pot2 = @(t) 40000 - pot1(400 - t) - padalec_ykon(parametri3, zac_nov(400 - t), t,n,3);


enacba = @(t) pot1(t) + pot2(400-t) - 40000;
%fzero(enacba, 200);

%optimalen_t = @(t) padalec(parametri,zac,tk,n,3) + padalec(parametri3,zac,tk,n,3)

%--------------------------------------------------------------------------








