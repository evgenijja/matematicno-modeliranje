function W = potencialna(X,M,g)
% izracun potencialne
% X so krajišèa X = ver_uv
% M pa mase
% g pa gravitacija
tezisca_y = (X(2,1:(end-1))+X(2,2:end))/2;
W = g*sum(M.*tezisca_y);

end