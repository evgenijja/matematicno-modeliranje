% 1. naloga
A = [11 2 -3 0; 2 1 8 7; 0 22 21 -9; 4 -3 2 0; 5 1 10 -8];

% a) najvecji element matrike A
najvecji = max(max(A));

% b) A^TA
produkt = A'*A;

% c) Hadamardov produkt
hadamard_produkt = A .* A;

%%%% podmatrike %%%%

B = A(:,1:3);

C = A(1:end-1,[2 4]);

A(1:end-1,[2 4]) = ones(size(C));

