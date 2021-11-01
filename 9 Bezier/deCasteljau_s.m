function tocka = deCasteljau_s(b,t, dolzina)
% DE_CASTELJAU izracuna tocko na  Bezierovi krivulji pri parametru t
% s pomocjo de Casteljauovega algoritma.
% Stolpci matrike b so kontrolne tocke Bezierove krivulje.

%stevilo tock je n+1

n=size(b,2)-1; % število stolpcev minus 1

for r=1:n
    b(:,1:end-r) = (dolzina-t).*b(:,1:end-r) + t.*b(:,2:end-r+1);
end
tocka = b(:,1);


end