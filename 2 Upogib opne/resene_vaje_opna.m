% resene naloge opna

% 1. DN 2020

% funkcija na desni
g = @(x) 0.8.*(exp(x.*exp(-x)) + ((1-2.*x)./50 - 900 .* cos(30.*x) + 60.*sin(30.*x)));

% osnovno
n = 5000;
a = -50; b = 50; h = (b-a)/n;

% R je celoten interval
% r je vektor ki celoten interval razdeli
R = 100; % polmer krožne zanke
r = linspace(-50,50,n+1); % n+1 delilnih toèk AMPAK PAZI - prvo in zadnjo že poznamo
% 
%h = R/n;


% matrika iz treh diagonal bo velikost n+1 - 2 (ker poznamo oba robna
% pogoja - torej n-1*n-1

% vekt je konstantni vektor ki pride v poštev samo pri pod/naddiag zato ga naštimam na njuno velikost
% tle smo mel enaèbo èist neodvisno od r-jev
vekt = 9/10*ones(n-2, 1);

% poddiagonala - koeficient pri y(i-1) 
a = 1 - 1/2.*h*vekt(1:end); % ne vzamemo prvega in zadnjega, ker jih poznamo
%a = 1 - h/2 * 1./r(2:n);

%ones(n-1,1)-h./(2*r(2:n));

% diagonala
b = -2 * ones(n-1,1);
%b = [1 b 1];

% naddiagonala
c = 1 + h/2*vekt(1:end);
%c = 1 + h/2 * 1./r(2:n-1);
%c = [2 c];

% nastavimo tridiagonalni sistem
rhs = [h^2 * g(r(2)) - 1 + 0.5 * 0.9 * h, h^2 .* g(r(3:n-1)), h^2 * g(r(n)) - 2 - 0.9 * h]; % zadnjega ne vzamemo, saj je na robu opna pripeta
%za reševanje sistema n-1 enaèb vzamemo rhs brez prvega in zadnjega
norm(rhs, 2);

% A = diag(a,-1) + diag(b) + diag(c,1);
% y = A\rhs'; 


rhs = [1, rhs, 2];
norm(rhs, 2); % cel rhs je vkljuèno s prvim in zadnjim
norm(A, 'fro');

% hoèemo uporabit funkcijo resi3 ki požene Thomasov algoritem
rhs2 = rhs(2:end-1);

% sled modificirane matrike po Thomasu
matrika = resi3_b(a,b,c,rhs2); % to funkcijo naštimaš da ti vrne kar rabiš
sled = sum(matrika);
u = resi3(a,b,c,rhs2);

n = length(rhs2);

% eliminacije
for i = 1:(n-1)
    faktor = a(i)/b(i);
    b(i+1) = b(i+1) - faktor*c(i);
    
    %c ni potrebno popravljati, ker je nad njim 0!
    
    % desno stran popravljamo sproti
    rhs2(i+1) = rhs2(i+1) - faktor*rhs2(i);
end

% obratna substitucija
x = zeros(n,1);
x(n) = rhs2(n)/b(n);

for i = (n-1):-1:1
    x(i) = 1/b(i)*(rhs2(i)-c(i)*x(i+1));
end

for i=1:length(r)
    if r(i) == 0
        x(i);
        x(i-1); % tale je tapravi
        x(i+1);
end
end



%--------------------------------------------------------------------------

% prvi kviz

g = @(x) 1.1.*(exp(cos(x./10)) + 1000 .* cos(100.*x));

% osnovno
%n = 500000; 
n = 20;
a = -32; b = 32; h = (b-a)/n;

r = linspace(a,b,n+1); % n+1 delilnih toèk AMPAK PAZI - prvo in zadnjo že poznamo

% vekt je konstantni vektor ki pride v poštev samo pri pod/naddiag zato ga naštimam na njuno velikost
% to se grem ker v enaèbi nimam r jev, èe so moram gledat poves_opne
vekt = 9/10*ones(n-2, 1);

% poddiagonala - koeficient pri y(i-1) 
a = 1 - 1/2.*h*vekt(1:end); % ne vzamemo prvega in zadnjega, ker jih poznamo

% diagonala
b = -2 * ones(n-1,1);

% naddiagonala
c = 1 + h/2*vekt(1:end);

% nastavimo tridiagonalni sistem
rhs = [h^2 * g(r(2)) + 10 - 5 * 0.9 * h, h^2 .* g(r(3:n-1)), h^2 * g(r(n)) - 10 - 0.9 *5* h];

%za reševanje sistema n-1 enaèb vzamemo rhs brez prvega in zadnjega, sicer
%pride:
%rhs2 = [-10*h^2, rhs, 10*h^2];

%rhs = resi3_matrika(a,b,c, rhs);
sum(rhs)/length(rhs); % delujeeee

% sestavim matriko A
%A = diag(a,-1) + diag(b) + diag(c,1);
%norm(A, 1);

% izvedemo Thomasov algoritem, raèunamo determinanto
m = length(rhs);
% eliminacije
b2 = b;
for i = 1:(m-1)
    faktor = a(i)/b2(i);
    b2(i+1) = b2(i+1) - faktor*c(i);
end

% modificirana matrika je zgornje trikotna (brez poddiagonale)
A2 = diag(b2) + diag(c,1);
det(A2);

% koliko se razlikuje modificiran rhs
rhs2 = resi3(a,b,c,rhs);
D = [];
% for i=1:length(rhs)
%     d = abs(rhs(i) - rhs2(i));
%     D = [D, d];
% end
% max(D);

% vrednost funkcije pri x = 1
for i=1:length(r)
    if r(i) == 1
        rhs2(i-1);
    end
end

% èe na levi strani glavne enaèbe dodamo še +0.1y(x)
% pogledam enaèbo (ki je šla v matriko) in vidim, da se spremeni samo b
b3 = (-2+0.1*h^2) * ones(n-1,1); % 
A3 = diag(a,-1) + diag(b3) + diag(c,1);
norm(A3, 1);

% glej list s sprintanimi nalogami
abs(1+0.9*h*0.5) + abs(-1-0.9*h*0.5);