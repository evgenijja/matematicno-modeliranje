function [T,info] = delec_brownian(a, b, poz, delta, N, risi)

% proba
% delec_brownian(1, 1, [0; 0], 1e-10, 5, 1)

% Simulacija: Zacni v dani poziciji poz v pravokotniku [-a,a]x[-b,b]
% in poisci najvecji krog, ki ga lahko vrises v ta pravokotnik.
% Pojdi v nakljucno tocko na tem krogu in ce je razdalja do roba
% manjsa kot delta, stej da si presel stranico.
% T je tabela delezev prehodov delca skozi eno od stranic pravokotnika.
% N je stevilo simulacij

info={'Desno','Levo','Gor','Dol'};
T=zeros(4,1);

% shranimo originalno pozicijo
poz0 = poz;

r = 0;

% izris zacetnega stanja:
if risi
    axis([-a,a,-b,b]);
    grid on;
    hold on;
    plot(poz(1),poz(2),'ro');
end

for i=1:N
    
    % dokler se ne priblizamo dovolj stranici pravokotnika, se premikam
    % "naprej"
    poz1=poz0;
    zunaj=false;
    
    while ~zunaj
        
        % nakljucen kot
        phi = 2*pi*rand();
        poz = poz1 + r*[cos(phi);sin(phi)];
        
        
        if risi
            plot([poz(1),poz1(1)],[poz(2),poz1(2)],'r-o');
            pause(0.2);
            
        end
        
        poz1  = poz;
        
        
        % izracunamo polmer kroznici in stranico, kateri smo najblizje
        [r,stranica] = razdalja(poz,a,b);
        
        zunaj= (r<delta);
        
    end
    
    if risi
        clf;
        axis([-a,a,-b,b]);
        grid on;
        hold on;
        plot(0,0,'ro');
    end
    
    T(stranica) = T(stranica)+1;
end


if risi
    hold off
    close
end


end


function [r,stranica]=razdalja(poz,a,b)
[r,stranica]=min(abs([a-poz(1),a+poz(1),b-poz(2),b+poz(2)]));
end
