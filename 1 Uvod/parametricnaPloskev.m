% mreza tock za r in th
r = linspace(1,2,50);
th = linspace(0,10*pi,250);
[r2d,th2d] = meshgrid(r,th);

% x in y v polarnih koordinatah
xFun = @(r,th) r.*cos(th);
yFun = @(r,th) r.*sin(th);

% x,y,z koordinate na mrezah
x2d = xFun(r2d,th2d);
y2d = yFun(r2d,th2d);
z2d = r2d.*th2d;

% narisemo funkcijo
figure
axis equal
surf(x2d,y2d,z2d)
shading interp % izbrisemo crte
