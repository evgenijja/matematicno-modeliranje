function Z = sistem_uv(W,zac,L,vsote_mi)
% SISTEM_UV nastavi sistem dveh nelinearnih enacb za
% diskretno veriznico. To sta enacbi (30) in (31) iz
% prilozenega clanka.
% 
% Vhodni parametri:
% W = [u;v], kjer sta u in v iskani neznanki.
% zac = [x_0 x_n+1;y_0 y_n+1], kjer sta (x_0,y_0) in
% (x_n+1, y_n+1) obesisci. 
% L je vrstica, ki doloca dolzine palic.
% vsote_mi je vrstica kumulativnih vsot, definiranih v (33).

u = W(1);
v = W(2);

xi = L./sqrt(1+(v-u*vsote_mi).^2);
eta = xi.*(v-u*vsote_mi);

Z=[sum(xi)-(zac(1,2)-zac(1,1));sum(eta)-(zac(2,2)-zac(2,1))];