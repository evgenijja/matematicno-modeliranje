function b = C1CubicSpline(u,p,v)
% C1CUBICSPLINE izracuna kontrolne tocke C^1 kubicnega zlepka,
% ki interpolira dane tocke in pripadajoce tangentne vektorje.
% u je vektor delilnih tock (vozlov),
% p je matrika interpolacijskih tock (tocke podane v stolpcih),
% v je matrika tangentnih vektorjev v sticnih tockah

% N je stevilo odsekov
N = length(u) - 1;
    
%dimenzija prostora:
d = size(p,1);

% kontrolne tocke
b = zeros(d,3*N + 1);

% i tece po odsekih
for i=1:N
    
    b(:,3*i-2:3*i+1)=[p(:,i), p(:,i)+1/3*(u(i+1)-u(i))*v(:,i), p(:,i+1)-1/3*(u(i+1)-u(i))*v(:,i+1), p(:,i+1)];
    
    % narisemo Bezierovo krivuljo na posameznem odseku:
    plotBezier(b(:,3*i-2:3*i+1));
    hold on;
    
end


end