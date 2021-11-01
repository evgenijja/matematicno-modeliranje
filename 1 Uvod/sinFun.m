% naloga: 
%   1) narisimo sin(x^2-y^4)./(x^2-y^4) na [0,1]x[0,2]
%   2) popravimo nedolocene vrednosti
%   3) poiscemo najvecje in najmanjse vrednosti
%
%   4*) dolocimo normale tangent v dolocenih tockah

% mreza za risanje
x = 0:.01:1;
y = 0:.01:2;
[x2d,y2d] = ndgrid(x,y);

% def preslikave in njene vrednosti
zFun = @(x,y) sin(x.^2-y.^4)./(x.^2-y.^4);
z2d = zFun(x2d,y2d);
figure 
surf(x2d,y2d,z2d)
shading interp


% popravimo vrednosti
z2d(isnan(z2d))=1;

% narisemo graf preslikave
figure
surf(x2d,y2d,z2d)
shading interp
hold on

% poiscemo najvecje vrednosti
mm = max(max(z2d));
mmLoc = find(z2d==mm);
plot3(x2d(mmLoc),y2d(mmLoc),z2d(mmLoc),'o-')

% poisemo najmanjse vrednosti, do tolerance 10^-5
mm = min(min(z2d));
mmLoc = find(abs(z2d-mm)<10^-5);
plot3(x2d(mmLoc),y2d(mmLoc),z2d(mmLoc),'ro-')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% izracunamo paricalna odvoda funkcije (rabimo simbolic toolbox)
syms x y
dx_zFun = matlabFunction(diff(zFun(x,y),x));
dy_zFun = matlabFunction(diff(zFun(x,y),y));

% izberemo tocke za risanje normal
skip = 30;
xxCoarse = x2d(1:skip:end,1:skip:end);
yyCoarse = y2d(1:skip:end,1:skip:end);
zzCoarse = z2d(1:skip:end,1:skip:end);

% definiramo (zunanjo) funkcijo, ki izracuna normalo preko vektorskega produkta
[uu,vv,ww] = sinFun_normalVecFun(xxCoarse,yyCoarse,dx_zFun,dy_zFun);

% izrisemo normale
quiver3(xxCoarse,yyCoarse,zzCoarse,uu,vv,ww,0.25,'LineWidth',1, 'color', [.2 .5 .2])