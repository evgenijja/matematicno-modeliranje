function plotBezier_deCasteljau(b)
% PLOTBEZIER izrise Bezierovo krivuljo in kontrolni poligon. Za izracun
% tocke na krivulji uporabimo deCasteljauov algoritem.
% Stolpci matrike b so kontrolne tocke Bezierove krivulje.

t = linspace(0,1,100);
B = zeros(2,length(t));

for i = 1:length(t)
    B(:,i) = deCasteljau(b,t(i));
end

hold on
% krivulja
plot(B(1,:),B(2,:),'r','LineWidth',3);

% kontrolni poligon
plot(b(1,:),b(2,:),'k-o','MarkerFaceColor','k','LineWidth',1.5);
hold off

end