function tocke = deCasteljau_sez(b,T)
% DE_CASTELJAU izracuna tocko na  Bezierovi krivulji pri parametru t
% s pomocjo de Casteljauovega algoritma.
% Stolpci matrike b so kontrolne tocke Bezierove krivulje.

%T je seznam parametrov pr katerih hoèmo zraèunat

%stevilo tock je n+1

n=size(b,2)-1; % število stolpcev minus 1
tocke = [];
m = size(T, 2);
for i=1:m
    t = T(i);
    for r=1:n
        b(:,1:end-r) = (1-t)*b(:,1:end-r) + t*b(:,2:end-r+1);
    end
    tocka = b(:,1);
    tocke = [tocke, tocka];
end
end
