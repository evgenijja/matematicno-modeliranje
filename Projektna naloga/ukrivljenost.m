function ukrivljenosti = ukrivljenost(b, t)
% UKRIVLJENOST izraèuna predznaèeno ukrivljenost krivulje pri parametrih podanih v seznamu t. 
% Stolpci matrike b so kontrolne tocke Bezierove krivulje.

n = size(b, 2);
m = length(t);
% kontrolne tocke odvoda 
db = b(:, 2:end) - b(:, 1:(end-1));
ddb = db(:, 2:end) - db(:, 1:end-1);

ukrivljenosti = zeros(1, m);
for i = 1:length(t)
    v = (n-1) * deCasteljau(db, t(i));
    vv = (n-1)*(n-2) * deCasteljau(ddb, t(i));

    vektorski = cross([v; 0], [vv; 0]);
    produkt = vektorski(3); % prva in druga komponenta bosta nièelni
    kappa = produkt / norm(v)^3;
    
    ukrivljenosti(i) = kappa;
end

end
