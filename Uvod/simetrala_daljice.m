function [T,s]=simetrala_daljice(A,B)
% SIMETRALA vrne simetralo daljice AB.
% T=[x;y] je tocka na simetrali, s=[s1;s2] je smerni vektor.
% 
% Vhodni podatki:
% A=[x1;y1],B=[x2;y2]

% Tocka na simetrali je razpolovisce daljice AB
T = (A + B)/2;

% smerni vektor simetrale je pravokoten na smerni vektor daljice AB
smerni_AB = B - A;

% zasuk za 90 stopinj
s = [smerni_AB(2); -smerni_AB(1)];



end