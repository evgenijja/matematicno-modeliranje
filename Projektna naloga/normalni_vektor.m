function vekt = normalni_vektor(b, T)
% NORMALNI_VEKTOR izraèuna normirane normalne vektorje na krivuljo pri parametrih v seznamu T.

n = size(b, 2);

db = b(:, 2:end) - b(:, 1:(end-1));
ddb = db(:, 2:end) - db(:, 1:end-1);

v = @(t) (n-1) * deCasteljau(db, t);
vv = @(t) (n-1)*(n-2) * deCasteljau(ddb, t);

m = length(T); vekt = zeros(2, m);
for i=1:m
    tt = T(i);
    vektorski1 = cross([vv(tt); 0], [v(tt); 0]);
    nov_vektor = [0; 0; vektorski1(3)];
    vektorski2 = cross([v(tt); 0], nov_vektor);
    vektorski = vektorski2(1:2);
    vekt(:,i) = vektorski/norm(vektorski);
end

end

