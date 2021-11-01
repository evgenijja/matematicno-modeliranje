function X = ver_uv(W0,zac,L,M)
% VER_UV resi problem veriznice iz sistema za u in v.
% Rezultat X je 2x(n+2) tabela koordinat vozlisc, kjer
% prva vrstica doloca abscise, druga ordinate iskanih tock.
%
% Vhodni parametri:
% W0 = [u0;v0] zaceten priblizek pri resevanju sistema
% nelinearnih enacb.
% zac = [x_0 x_n+1;y_0 y_n+1], kjer sta (x_0,y_0) in
% (x_n+1, y_n+1) obesisci. 
% L je vrstica, ki doloca dolzine palic.
% M je vrstica, ki doloca mase palic.

mi = (1/2)*(M(1:end-1)+M(2:end)); % formula (23)
vsote_mi = [0,cumsum(mi)]; % formula (33)

% izracun u in v
sistem = @(W) sistem_uv(W, zac, L, vsote_mi);

% 1. moznost: Ce imamo nalozen optimization toolbox,
% resimo sistem z vgrajeno funkcijo fsolve

% options = optimoptions('fsolve','Display','none');
% W = fsolve(sistem, W0, options);
% 
% u=W(1);
% v=W(2);

% 2. moznost: Uporaba Newtonove metode
% Jacobijeva matrika
JF = @(W) jacobian_uv(W,L,vsote_mi);

% Newtonova metoda
W = newton(sistem,JF,W0,1e-10);
u=W(1);
v=W(2);

% izracun xi in eta po formulah (27) in (25)
xi = L./sqrt(1+(v-u*vsote_mi).^2);
eta = xi.*(v-u*vsote_mi);

% izracun koordinat krajisc
X=[zac(1,1)+cumsum(xi);zac(2,1)+cumsum(eta)];
X=[zac(:,1) X];




