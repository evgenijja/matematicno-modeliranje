function A = naloga5(m,n)
% Vrne matriko A dimenzije m x n z elementi
%
% A(i,j) = (j-4)^2 * (i+1)^(-3) + i*j

[cols, rows] = meshgrid(1:n,1:m);

A = (cols - 4).^2  .* (rows + 1).^(-3) + rows.*cols;

end

