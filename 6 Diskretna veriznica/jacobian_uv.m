function Z = jacobian_uv(W,L,vsote_mi)
% JACOBIAN_UV zgenerira Jacobijevo matriko v tocki W
% za sistem enacb (30) in (31) iz prilozenega clanka.
% 
% Vhodni parametri:
% W = [u;v], kjer sta u in v iskani neznanki.
% (x_n+1, y_n+1) obesisci. 
% L je vrstica, ki doloca dolzine palic.
% vsote_mi je vrstica kumulativnih vsot, definiranih v (33).

u = W(1);
v = W(2);

w = v-u*vsote_mi; % formula (32)
der = (1+w.^2).^(-3/2);

Z = [sum(L.*w.*vsote_mi.*der), sum(-L.*w.*der);
    sum(-L.*vsote_mi.*der), sum(L.*der)];

end

