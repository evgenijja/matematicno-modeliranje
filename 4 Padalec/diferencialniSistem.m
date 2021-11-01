function dY = diferencialniSistem(t,Y,parametri, caseNo)
% function dY = diferencialniSistem(t,Y,parametri)
% 
% Opisuje sistem dif. enacb za padalca pri navpicnem padu.
%
% Vhod:
% t je cas, Y = [y1;y2]
% Prva komponenta Y(1) predstavlja visino.
% Druga komponenta Y(2) predstavlja hitrost.
% parametri = [m,c,S]
% 
% Izhod:
% dY je sistem NDE, vrnemo desno stran sistema dY = F(t,Y)


% rhov = [1.225 1.112 1.007 0.9093 0.8194 0.7364 0.6601 0.5900 0.5258...
%    0.4671 0.4135 0.1948 0.08891 0.04008 0.01841 0.003996];
% v = [(0:10)*1000 15000 20000 25000 30000 40000];
% 
% rhov = [1.225 1.007  0.8194  0.6601  0.5258...
%        0.4135 0.1948 0.08891 0.04008 0.01841 0.003996];
% v = [(0:2:10)*1000 15000 20000 25000 30000 40000];
% 
% coeff = [ones(11,1) ((v-40000)/40000).^2' ((v-40000)/40000).^4'] \ rhov';


switch caseNo
    case 1
        ro = @(y) 1.225;
        g = @(y) 9.81;
    case 2
        ro = @(y) 1.225;
        g = @(y) 9.81*((6371*1000)/(6371*1000+y))^2;
    case 3
        koef = mnk();
        ro = @(y)  koef(1) + koef(2)*((y-40000)/40000).^(2) + koef(3)*((y-40000)/40000).^(4);
        g = @(y) 9.81*((6371*1000)/(6371*1000+y))^2;
    case 4
        koef = mnk(); %moraš pognat uno funkcijo / na roke
        a_x = 1.030927835051546;
        ro = @(y)  koef(1) + koef(2)*((y-40000)/40000).^(2) + koef(3)*((y-40000)/40000).^(4);
        g = @(y) 9.81*((6371*1000)/(6371*1000+y))^2 + a_x;
end


m = parametri(1);
c = parametri(2);
S = parametri(3);

% Opomba: Ce je hitrost pozitivna, je sila upora negativna in obratno.
%         Zato namesto y(2).^2 uporabimo -abs(y(2)).*y(2).
dY = [Y(2); -g(Y(1))-(1/2*ro(Y(1))*c*S)/m*abs(Y(2)).*Y(2)];
end