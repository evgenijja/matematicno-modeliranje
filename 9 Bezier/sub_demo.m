function [kontrolne1,kontrolne2] = sub_demo(b,c,risanje)
% SUB_DEMO demonstrira en korak subdivizije za ravninsko
% Bezierovo krivuljo. Pri tem je b tabela 2x(n+1) kontrolnih tock.
% c je subdivizijski parameter 0 <= c <= 1.

% Kontrolne tocke za subdivizijo dobimo preko de Casteljauovega algoritma.
% (zgornje trikotna shema)
%
% P0    P0_1    ...     P0_n    --> tocka na Bezierovi krivulji
% P1    P1_1
% P2    P2_1
% ...   ...
% Pn

n = size(b,2) - 1;      %stevilo tock je n+1
m = size(b,1);          %dimenzija prostora (aka število koordinat)

B = zeros(n+1,n+1,m);   %matrike, kjer bomo shranjevali korake
                        %de Casteljauovega algoritma po koordinatah

% nove kontrolne tocke
kontrolne1 = zeros(2,n+1);
kontrolne2 = zeros(2,n+1);

% v prvem stolpcu so kontrolne tocke                    
for i = 1:m
    B(:,1,i)=(b(i,:))';
end

for i = 1:m
    for j = 2:n+1
        
        B(1:(n+2-j),j,i) = (1-c)*B(1:(n+2-j),j-1,i) + c*B(2:(n+3-j),j-1,i);
        
    end
    
end

% iz tabele B preberemo nove kontrolne tocke
for i = 1:m
    for j = 1:(n+1)
        
    kontrolne1(i,j) = B(1,j,i);
    
    kontrolne2(i,j) = B(n+2-j,j,i); % v nasprotnem vrstnem redu
    
    end
end

kontrolne2 = fliplr(kontrolne2);
kontrolne1;
kontrolne2;

if risanje
    % risanje
    t = linspace(0,1,100);
    Bezier = zeros(2,length(t));

    for i = 1:length(t)
        Bezier(:,i) = deCasteljau(b,t(i));
    end

    hold on
    % krivulja
    plot(Bezier(1,:),Bezier(2,:),'r','LineWidth',3);

    % originalni kontrolni poligon
    plot(b(1,:),b(2,:),'k-o','MarkerFaceColor','k','LineWidth',1.5);


    % kontrolna poligona dobljen z subdivizijo
    plot(kontrolne1(1,:),kontrolne1(2,:),'b-o','MarkerFaceColor','b','LineWidth',1.5);
    plot(kontrolne2(1,:),kontrolne2(2,:),'b-o','MarkerFaceColor','b','LineWidth',1.5);

    hold off
end

end