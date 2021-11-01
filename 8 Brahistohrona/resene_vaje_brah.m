% % rešene vaje
% T1 = [1 1];
% T2 = [3 0]; 
% % naredimo premik tock, da bo veljalo T1(0,0);
% b = T2(1) - T1(1);
% B = T2(2) - T1(2);
% [k,theta0]=isci_theta(b,B);
% 
% % èas potovanja po brahistohorni med T1 in T2
% cas_brah = k/sqrt(2*9.81)*theta0;
% % potovanje po premici 
% cas_premica = sqrt(2*(b^2+B^2)/(-9.81*B));
% % èe pointegriram premico y = (B/b)x dobim isto
% enacba = @(x) sqrt((b.^2 + B.^2)./(-2.*9.81.*B.*b.*x));
% cas = integral(enacba, 0, b);
% 
% % najnižja toèka brahistohrone
% % najnizja tocka je pri theta = pi, ce je theta0 > pi, sicer desno krajisce
% % gledaš enaèbo y(phi) = -1/2k^2(1-cos(phi)) - to bo max ko bo cos(phi)=-1
% if theta0 > pi
%     x_min = 1/2*k^2*(pi-sin(pi)) + T1(1);
%     y_min = -1/2*k^2*(1-cos(pi)) + T1(2);
% else
%     x_min = T2(1);
%     y_min = T2(2);
% end
% 
% % dolžina brahistohrone
% dx = @(phi) 1/2.*k.^2.*(1-cos(phi));
% dy = @(phi) 1/2.*k.^2.*sin(phi);
% fun = @(phi) sqrt(dx(phi).^2+dy(phi).^2);
% dolzina = integral(fun, 0, theta0);
% % od kje pa še ta enaèba
% l = 2*k^2*(1-cos(theta0/2));

%--------------------------------------------------------------------------
% domaèa naloga
a = 22;
T1 = [0, 5]; T2 = [10, 1+a/100];
a = 24; T1 = [0, 5]; T2 = [8, 2+a/100];
g = 9.81;

% naredimo premik tock, da bo veljalo T1(0,0);
b = T2(1) - T1(1);
B = T2(2) - T1(2);

[k,theta0]=isci_theta(b,B); % dobimo theta_zvezdica ki doloca interval za 2t

% theta0 doloca interval risanje, k obliko krivulje
%%theta = linspace(0,theta0,100);

% cas potovanja po brahistohroni in premici med tockama T1 in T2
cas_brah = k/sqrt(2*9.8)*theta0;

% Premaknemo brahistrono v originalni koordinatni sistem
x = @(theta) 1/2*k^2*(theta-sin(theta)) + T1(1);
y = @(theta) -1/2*k^2*(1-cos(theta)) + T1(2);

x_odvod = @(theta) 1/2*k^2*(1 - cos(theta));
y_odvod = @(theta) -1/2*k^2*sin(theta);
smer = @(theta) y_odvod(theta) / x_odvod(theta);

% abcisa pri smer=-1
f = @(theta) smer(theta) + 1; 
moj_theta = fzero(f, 1); %fsolve?
odg2 = x(moj_theta);

% ploscina trikotnika ki ga omejuje tangenta v P (iz prejšne nal) in
% ordintani osi
P = [x(moj_theta), y(moj_theta)];
% enaèba tangente y = kx + n
koef = smer(moj_theta);
n = P(2) - koef*P(1);
stranica1 = n; stranica2 = -n/koef; % preseèišèi premice s koordinatnima osema
pl = stranica1*stranica2/2;

% še en naèin
(x(moj_theta) + y(moj_theta))^2*1/2;

% najnizja tocka brahistohrone
M = risi_brah(T1, T2);
x_min = M(1); y_min = M(2);

% vse tri toèke premaknemo tako, da gre parabola èez izhodišèe
T1 = [0, 0]; T2 = [T2(1), T2(2)-5]; M = [M(1), M(2)-5];

matrika = [1, T1(1), T1(1)^2; 1, T2(1), T2(1)^2; 1, M(1), M(1)^2];
res = [T1(2); T2(2); M(2)];
parabola = matrika\res;
y = @(x) parabola(1) + parabola(2).*x + parabola(3).*x.^2;
dy = @(x) parabola(2) + parabola(3).*2.*x;
enacba = @(x) sqrt((1+dy(x).^2)./(-2.*9.8.*y(x)));
integral(enacba, 0, b);
% 
%--------------------------------------------------------------------------
% kviz 2021

% 1. naloga
b = 82;
T1 = 0; T2 = [5, -1-b/100];
g = 9.81;
t = 1.3;

% 1. naloga - koliko je A?
% naredimo premik tock, da bo veljalo T1(0,0);
b = T2(1) - T1;
B = @(A) T2(2) - A;

theta = @(A) isci_theta1(b,B(A));
k = @(A) isci_k(b, B(A));

cas_brah = @(A) k(A) ./sqrt(2*g).*theta(A);
cas = @(A) cas_brah(A) - 1.3;
odg1 = fsolve(cas, 2);
A = odg1;
T1 = [0, A];

% 2. naloga - pri kateri koordinati x porabi ravno polovico èasa
b = T2(1) - T1(1);
B = T2(2) - T1(2);

k = isci_k(b,B);
t0 = 1.3;
cas_brah = @(t) k ./sqrt(2*g).*t;
fun = @(t) cas_brah(t) - 1/2*t0;
phi = fsolve(fun, 1);
x = @(theta) 1/2*k^2*(theta-sin(theta)) + T1(1);
y = @(theta) -1/2*k^2*(1-cos(theta)) + T1(2);
odg2 = x(phi);

% 3. naloga - T toèka s podano x koordinato, koliko je y?
T = @(y) [1/3*T2(1), y];
x_koord = 1/3*T2(1);
% poišèem phi pri katerem je v tej koordinati
fun3 = @(phi) x(phi) - x_koord;
phi3 = fzero(fun3, 1);
odg3 = y(phi3);
T = T(odg3);

% 4. naloga
% absolutna hitrost kroglice, ko se nahaja na x osi
%sprememba potencialne energije je m*g*A (ker se za toliko spusti)
% to se pretvori v kinteièno, izrazimo v
v = sqrt(2*g*A);

%%% 5. naloga - ne uspe nikakor
T11 = @(x) [T2(1), x]; T22 = [0, T2(2)];
% 
b2 = T22(1) - T2(1);
B2 = @(x) T22(2) - x;
% 
theta2 = @(x) isci_theta1(b2,B2(x));
k2 = @(x) isci_k(b2, B2(x));
% 
x2 = @(t, theta) 1/2.*k2(t).^2.*(theta-sin(theta)) + T2(1);
y2 = @(t, theta) -1/2.*k2(t).^2.*(1-cos(theta)) + t;
% 
eq1 = @(t, theta) x2(t, theta) - T(1);
eq2 = @(t, theta) y2(t, theta) - T(2);
eq3 = @(t, theta) norm([x2(t, theta), y2(t, theta)] - T);
%fminsearch(eq3, [5, 5]);
eq12 = @(v) [eq1(v(1), v(2)); eq2(v(1), v(2))];
%odg = fsolve(eq12, [10; 5]);
%fminsearch(eq1, [5, 5], [])


% x,y parametrizirata prvo, x2, y2 pa drugo
% hoèemo, da se sekata v T

% eq1 = @(theta, t) x(theta) + x2(t) - 2.*T(1);
% eq2 = @(theta, t) y(theta) - y2(t) - 2.*T(2);
% 
% eq12 = @(v) [eq1(v(1), v(2)); eq2(v(1), v(2))];
% presek = fsolve(eq12, [1; 1])
% t1 = presek(1);
% eq12 = @(v) [eq1(v(1), v(2)); eq2(v(1), v(2))];
% solution = fsolve(eq12, [7; 1])

% eq1 = @(a, b) vekt(a, b, 0) - v(:,1);
% eq2 = @(a, b) vekt(a, b, 1) - v(:,2);
% eq12 = @(x) [eq1(x(1), x(2)); eq2(x(1), x(2))];
% 
% solution = fsolve(eq12, [0;0]);
% a1 = solution(1); b1 = solution(2);

%--------------------------------------------------------------------------
% 2. kviz 2020

a = 53; T1 = [0, 5]; T2 = [8, 2+a/100];
b = T2(1) - T1(1);
B = T2(2) - T1(2);
[k,theta0]=isci_theta(b,B);

% 1. naloga - P toèka kjer je smerni koef -3/4
% % Premaknemo brahistrono v originalni koordinatni sistem
x = @(theta) 1/2*k^2*(theta-sin(theta)) + T1(1);
y = @(theta) -1/2*k^2*(1-cos(theta)) + T1(2);

x_odvod = @(theta) 1/2*k^2*(1 - cos(theta));
y_odvod = @(theta) -1/2*k^2*sin(theta);
smer = @(theta) y_odvod(theta) / x_odvod(theta);
% % abcisa pri smer=-3/4
f = @(theta) smer(theta) + 3/4; 
moj_theta = fzero(f, 1); %fsolve?
odg2 = y(moj_theta); 

% doloèi toèko na brah da bosta dolžini v razmerju 2:1

% % dolžina brahistohrone
dx = @(phi) 1/2.*k.^2.*(1-cos(phi));
dy = @(phi) 1/2.*k.^2.*sin(phi);
fun = @(phi) sqrt(dx(phi).^2+dy(phi).^2);
dolzina_cela = integral(fun, 0, theta0); % cela dolžina
dolzina1 = @(phi) integral(fun, 0, phi);
dolzina2 = @(phi) integral(fun, phi, theta0);
enacba = @(phi) 3*dolzina2(phi) - dolzina_cela;
phi2 = fsolve(enacba, 5);
x(phi2);


% najveèja navpièna razdalja med premico, ki povezuje zaèetni toèki in
% brahistohrono
% toèke na premici y = kx +n
k = (T2(2)-T1(2))/(T2(1)-T1(1));
n = T1(2) - k*T1(1);
premica = @(x) k*x + n;

razdalja = @(phi) -norm([x(phi), y(phi)]-[x(phi), premica(x(phi))], 2); 
% paè gledam negativne razdalje pa poišèem min
phi = fminsearch(razdalja, 3);
odg = abs(razdalja(phi)); 


%--------------------------------------------------------------------------

% kolaž izpitov

function f = eq(v)
t = eq(1);
theta = eq(2);
f = norm([x2(t, theta), y2(t, theta)] - T);
end
