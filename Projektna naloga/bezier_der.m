 function v = bezier_der(b,t,risanje)
% BEZIER_DER izracuna tangentni vektor na Bezierovo krivuljo pri
% parametru t.
% Stolpci matrike b so kontrolne tocke Bezierove krivulje.

n = size(b,2) - 1;

% Najprej izracunamo preme diference konrtolnih tock dP_i = b_{i+1} - b_i
dP = b(:,2:end)-b(:,1:(end-1));

% tangentni vektor in tocka
v = n*deCasteljau(dP,t);
tocka = deCasteljau(b,t);

if risanje
   
    plotBezier(b);
    hold on
    
    %tangentni vektor
    quiver(tocka(1),tocka(2),v(1),v(2),'r','LineWidth',2);
    
    hold off
    
end

end

