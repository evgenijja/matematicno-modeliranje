function [T,info] = delec(a,N,risi)
% DELEC izrise potovanje delca po kvadratu. 
% T je tabela delezev prehodov delca skozi eno od stranic
% kvadrata [-a,a]x[-a,a].
% N stevilo simulacij.
% Delec se na zacetku nahaja v (0,0), korak je 1
% kvadrat centriramo v (0,0)

if nargin == 2
    risi = false;
end

info = {'Desno','Levo','Gor','Dol'};

% T(i) je stevilo prehodov delca, skozi i-to stranico
T = zeros(1,4);

% izris zacetnega stanja:
if risi
    axis([-a,a,-a,a]);
    grid on;
    hold on;
    plot(0,0,'ro');
end

% smeri: desno, levo, gor, dol
P = [1,-1,0,0;0,0,1,-1];

% v for zanki izvedemo posamezne simulacije:
for i = 1:N
    
    % delec postavimo v izhodiscno lego:
    poz = [0;0];
    poz1 = poz; % prejsnja pozicija delca
    
    % dokler je delec v kvadratu, izvajam nakljucne premike:
    zunaj = false;
    
    while ~zunaj
        
        smer = randi(4,1);
        poz = poz + P(:,smer);
        
        if (max(abs(poz)) > a)
            zunaj = true;
            T(smer) = T(smer) + 1;
        end
        
        if risi
            plot([poz(1),poz1(1)],[poz(2),poz1(2)],'r-o');
            pause(0.2);
        
            poz1  = poz;
        end
        
    end
    
    if risi
        clf;
        axis([-a,a,-a,a]);
        grid on;
        hold on;
        plot(0,0,'ro');
    end
    
end

if risi
    hold off
    close
end


end
    
        
        
        
        