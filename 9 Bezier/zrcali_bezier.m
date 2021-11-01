function b_zrc = zrcali_bezier(b)
% ZRCALI_BEZIER prezrcali Bezierovo krivuljo, podano s kontrolnimi
% tockami b, preko premice p, dolocene z zacetno in koncno kontrolno tocko.
% Izrise tudi zacetno in prezrcaljeno krivuljo ter oba kontrolna poligona. 

% smerni vektor premice p
s = b(:,end)-b(:,1);

% enotska normala premice
n = [0 -1;1 0]*s;
n = n/norm(n);

% prezrcalimo kontrolne tocke
% b_zrc = P*b, kjer je P = I-2nn' zrcaljenje.
b_zrc = zeros(2,size(b,2));

for i = 1:size(b,2)
   b_zrc(:,i) = b(:,i) - 2*dot(n,b(:,i))*n;  
end

hold on

axis equal
plotBezier(b);
plotBezier(b_zrc);

hold off
end

