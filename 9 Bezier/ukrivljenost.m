function kapa = ukrivljenost(b, t)

n = size(b, 2);

% kontrolne tocke odvoda 
db = b(:, 2:end) - b(:, 1:(end-1));
ddb = db(:, 2:end) - db(:, 1:end-1);

%dolz = 8.860785348048653;
v = (n-1) * deCasteljau(db, t);
vv = (n-1)*(n-2) * deCasteljau(ddb, t);

vektorski = cross([v; 0], [vv; 0]);
produkt = vektorski(3);
kapa = produkt / norm(v)^3;

end
