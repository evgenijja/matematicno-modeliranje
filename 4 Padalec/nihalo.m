% matematicno nihalo
format long

l = 10;         % dolzina vrvice
g = 9.8;
tol = 1e-15;    % toleranca za tangentno metodo

% zacetni odmik (merjen v radianih) in hitrost
zac = [pi/4 0];

% risanje
%Funkcija f na desni strani sistema NDE: y' = f(t,y)
f = @(t,y) [y(2); - g/l*sin(y(1))];

% koncni cas opazovanja
tk = 7;
t = linspace(0,tk,200);

[t,Y] = ode45(f,t,zac);

% odmiki in hitrosti
theta = Y(:,1);
v = Y(:,2);
plot(t,theta);

% a) nihajni cas 
%zacetni priblizek razberemo iz slike
disp('Nihajni cas je enak:');
disp(nihajni_cas(l,g,zac,2,tol));

% 2. moznost: preko numericnega integriranje elipticnega integrala
integrand = @(x) 1./sqrt(cos(x)-cos(zac(1)));
disp('Nihajni cas izracunan preko elipticnega integrala:');
disp(4*sqrt(l/(2*g))*integral(integrand,0,zac(1),'RelTol',1e-13,'AbsTol',1e-13));


% b) kaksen naj bo zacetni odmik, da je nihajni cas enak 9 s
% uporabimo fzero  na funkciji

F = @(theta) nihajni_cas(l,g,[theta 0],2,tol)-9;

% priblizek za zacetni domik dobimo iz grafov odmikov pri razlicnih zac.
% odmikih
theta0 = fzero(F,2.2);

disp('Zacetni odmik, ki da nihajni cas 9 s:');
disp(theta0);





function T = nihajni_cas(l,g,zac,t0,tol)
% NIHAJNI_CAS izracuna nihajni cas matematicnega nihala, podanega
% s parametri
%
% l...dolzina nihala
% g...graviracijski pospesek 9.8
% zac = [theta_0 v_0]...zacetni pogoji
% t0...zacetni priblizek za tangentno metodo

% IDEJA: T = 4 x cas, ko je theta enak 0
F = @(t) Y_val(t,l,g,zac);

% zacetni priblizek odcitamo iz grafa
T = tangentna(F,t0,tol);

T = 4*T;

end

function Y = Y_val(T,l,g,zac)
% Y_VAL vrne odmik in hitrost ob casu T.

% Funkcija f na desni strani sistema NDE: y' = f(t,y)
f = @(t,y) [y(2); - g/l*sin(y(1))];

opts = odeset('RelTol',1e-13,'AbsTol',1e-13);
[~,Y] = ode45(f,[0 T],zac,opts);

% potrebujemo odmik in hitrost ob casu T
Y=Y(end,:);
end

function nicla = tangentna(F,x0,tol)
% TANGENTNA izvaja tangentno metodo. Funkcija f in df sta podani
% z vektorsko funkcijo F. x0 je zacetni priblizek in tol toleranca.

% vrednosti funkcije in odvoda
y = F(x0);

while abs(y(1)) > tol
    
    x0 = x0 - y(1)/y(2);
    y = F(x0);
    
end

nicla = x0;
end



