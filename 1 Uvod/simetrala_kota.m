function [T,s] = simetrala_kota(A,B,C)
% SIMETRALA vrne simetralo kota ABC.
% T=[x;y] je tocka na simetrali, s=[s1;s2] je smerni vektor.
% 
% Vhodni podatki:
% A=[x1;y1],B=[x2;y2], C =[x3;y3]

T = B;

% enotska smerna vektorja na krakih kota
u = (A-B)/norm(A-B);
v = (C-B)/norm(C-B);

s = u + v;



end

