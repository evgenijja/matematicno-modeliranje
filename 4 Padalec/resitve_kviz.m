% vhodni podatki
H = 40000;
m = 94;
c = 1.1;
S = 1.2;
parametri = [m,c,S];
zac = [H;0];

n = 10000;
r = 6371000;

podatki = [0:2000:10000, 15000, 20000, 25000, 30000, 40000; 1.225 1.007 0.8194 0.6601 0.5258 0.4135 0.1948 0.08891 0.04008 0.01841 0.003996]';


% aproksimacija s polinomom po metodi najmanjših kvadratov (da dobimo a-je)
% rešujemo Ax = b
% b = podatki(2,:)';
% visine = podatki(1,:);
% A = [1, 1, 1];
% for i=2:length(visine)
%     A = [A; 1, ((visine(i)-40000)/40000)^2, ((visine(i)-40000)/40000)^4]; 
% end
% x = A\b;

koef = mnk();
ro = @(y)  koef(1) + koef(2)*((y-40000)/40000).^(2) + koef(3)*((y-40000)/40000).^(4);

%g0 = 9.81; %m/s
%r = 6371000; %metrov
%g = @(h) g*(r/(r+h))^2;

% tk = 300;
% m = 105;
% S = 1.2;
% parametri = [m,c,S];

% 1. vprašanje
%padalec(parametri,zac,tk,n,3);
tk = 250;
[y,v,~] = padalec(parametri,zac,tk,n,3);
odg1 = H - y(end);

% 2. vprašanje
% na kateri višini je zrak redkejši od 0.5
f = @(h) ro(h) - 0.5;
odg2 = fzero(f, 10000);

% 3. vprašanje
tk2 = 300; % ko odpre padalo
S2 = S + 12;
c2 = c*4;
tk22 = 400; % gostota zraka ob tem èasu
% zraèunam višino na kateri se nahaja, potem bom lahko tudi gostoto
parametri2 = [m, c2, S2];
pot1 = 40000 - padalec_ykon(parametri,zac,tk2,n,3); % to pot prepotuje v 300 s preden odpre padalo

% potem še 100 s pada z odprtim padalom pri drugih zaèetnih pogojih
v_nov = padalec_vkon(parametri,zac,tk2,n,3);
zac_nov = [40000 - pot1; v_nov];
pot2 = 40000 - pot1 - padalec_ykon(parametri2, zac_nov, 100,n,3);
odg3 = ro(40000 - pot1 - pot2);

% 4. vprašanje
F = 200;
tk3 = 50;
m3 = m + 100;
parametri3 = [m3, c, S];
% sila vpliva na pospešek F = ma
a_x = F/m3;

g0 = 9.81; %m/s
g = @(h) g0*(r/(r+h))^2 + a_x; % popravljeno v datoteki diferencialnisistem

% datoteke imam malo pomešane - padalec_vkon se nahaja v mapi 1. kviz -
% padalec
odg4 = padalec_vkon(parametri3,zac,tk3,n,4);

% 5. vprašanje
mk = 30;
Sk = 6;
ck = 6;
Hk = 5000;
parametrik = [mk, ck, Sk];
zack = [Hk; 0];
% kje je Feliks po 100s ?
Feliks100y = padalec_ykon(parametri,zac,100,n,3);
Feliks100v = padalec_vkon(parametri, zac, 100, n, 3);
zac_feliks = [Feliks100y; Feliks100v];

pot_feliks = @(t) padalec_ykon(parametri,zac_feliks,t,n,3);
pot_kamera = @(t) padalec_ykon(parametrik,zack,t,n,3);
% zanima nas t ko bosta enaki
enacba = @(t) pot_feliks(t) - pot_kamera(t);
odg5 = fzero(enacba, 200) + 100;
