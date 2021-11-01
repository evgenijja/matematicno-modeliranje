function b_rot = rotiraj_bezier(b,phi)
% ROTIRAJ_BEZIER rotira Bezierovo krivuljo, podano s kontrolnimi
% tockami b, za kot phi okrog prve kontrolne tocke. Izrise tudi
% zacetno in rotirano krivuljo ter oba kontrolna poligona. 

% rotiramo kontrolne tocke za kot phi
b_rot = zeros(2,size(b,2));
Q = [cos(phi) -sin(phi); sin(phi) cos(phi)];

% najprej premaknemo prvo kontrolno tocko v izhodisce, nato rotiramo in na
% koncu transliramo nazaj
for i = 1:size(b,2)
   b_rot(:,i) = b(:,i) - b(:,1);
   b_rot(:,i) = Q*b_rot(:,i);  
   b_rot(:,i) = b_rot(:,i) + b(:,1);
end


hold on

axis equal
plotBezier(b);
plotBezier(b_rot);

hold off
end

