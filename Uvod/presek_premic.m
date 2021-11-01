function p = presek_premic(T1,T2,s1,s2)
% PRESEK_PREMIC vrne koordinati presecisca premic p =[x; y].
%
% Vhodni podatki:
% T1 in s1 sta tocka in smerni vektor, ki podajata prvo premico.
% T2 in s2 sta tocka in smerni vektor, ki podajata drugo premico.
%
% Vektorji in koordinate točk so podani kot stolpci.

% matrika sistema
A = [s1 -s2];

% desna stran
b = T2-T1;

lambda = A\b;

% presecisce
p = T1 + lambda(1)*s1;

end