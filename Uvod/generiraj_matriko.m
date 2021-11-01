function A = generiraj_matriko(n)
% GENERIRAJ_MATRIKO sestavi matriko dimenzije n × n, ki ima na diagonali
% stevila od 1 do n, v zgornjem trikotniku naj ima same stirice, prva
% poddiagonala naj bo sestavljena iz enic, druga poddiagonala pa iz −1.

A = diag(1:n) + 4*triu(ones(n),1) + diag(ones(n-1,1),-1) - diag(ones(n-2,1),-2);
end

