function a = resi3_a(a,b,c,rhs)
% RESI3 resuje tridiagonalni sistem Ax = rhs, kjer je
% matrika A predstavljena s tremi vektorji a,b,c.
% 
% NAŠTIMAJ DA TI VRNE KAR RABIŠ


% VHODNI PODATKI:
% a ... poddiagonala matrike A
% b ... diagonala matrike A
% c ... naddiagonala matrike A
% rhs ... desna stran sistema

n = length(rhs);

% eliminacije
for i = 1:(n-1)
    faktor = a(i)/b(i);
    b(i+1) = b(i+1) - faktor*c(i);
    
    %c ni potrebno popravljati, ker je nad njim 0!
    
    % desno stran popravljamo sproti
    rhs(i+1) = rhs(i+1) - faktor*rhs(i);
end
% diagonala = b
% poddiag = a
% naddiag = c
% res = rhs

% obratna substitucija
x = zeros(n,1);
x(n) = rhs(n)/b(n);

for i = (n-1):-1:1
    x(i) = 1/b(i)*(rhs(i)-c(i)*x(i+1));
end


end