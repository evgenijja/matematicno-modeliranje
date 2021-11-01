function b_trans = premakni_bezier(b,s)
% PREMAKNI_BEZIER translira Bezierovo krivuljo, podano s kontrolnimi
% tockami b, za vektor s. Izrise tudi zacetno in translirano krivuljo
% ter oba kontrolna poligona. (v bistvu premakne samo kontrolni poligon)

% transliramo kontrolne tocke
b_trans = zeros(2,size(b,2));

for i = 1:size(b,2)
   b_trans(:,i) = b(:,i) + s;  
end

hold on

plotBezier(b);
plotBezier(b_trans);

hold off
end

