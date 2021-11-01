% Risanje grafov funkcij

% funkcija ene spremenljivke
% f(x)=sin(x)exp(sqrt(x))
f = @(x) sin(x).*exp(sqrt(x));

t = linspace(1,3,200);
plot(t,f(t));

% vektorska funkcija v R^2
% f(t)=(sin(t),cos(t))
g1 = @(t) cos(t);
g2 = @(t) sin(t);

t = linspace(0,2*pi,200);

figure
plot(g1(t),g2(t)); % graf funkcije f je izbrisan, 
                   % ce ne uporabimo ukaza figure
axis equal

% vektorska funkcija v R^3
% h(t)=(cos(t),sin(t),t)
t = linspace(0,10*pi,1000);
figure
plot3(g1(t),g2(t),t);

% funkcija dveh spremenljivk
% h(x,y)=(x^2+y^2)/(1+x+y)
h = @(x,y) (x.^2+y.^2)./(1+x+y);
x = linspace(0,1,20);
y = linspace(0,1,20);

[X,Y]=meshgrid(x,y);
Z = h(X,Y);

figure
surf(X,Y,Z); % oz. mesh(X,Y,Z)






