% test

% interpolacijske tocke in tangentni vektorji
p=[1,2,3,4,2;1,-2,4,6,-5];

figure;
v=[1,1,1,1,-1;1,-1,-3,-1,1];


% enakomerna parametrizacija (alpha = 0)
u = [0,1,2,3,4];
b =C1CubicSpline(u,p,v);
disp(b);
title('Enakomerna parametrizacija','FontSize',16,'interpreter','latex');


% centripetalna parametrizacija (alpha = 1/2)
u = zeros(1,5);
for i = 2:5
    u(i) = u(i-1) + sqrt(norm(p(:,i)-p(:,i-1)));
end
figure
C1CubicSpline(u,p,v);
title('Centripetalna parametrizacija','FontSize',16,'interpreter','latex');

% tetivna parametrizacija (alpha = 1)
u=zeros(1,5);
for i=2:5
    u(i)=u(i-1)+norm(p(:,i)-p(:,i-1));
end
figure
C1CubicSpline(u,p,v);
title('Tetivna parametrizacija','FontSize',16,'interpreter','latex');
