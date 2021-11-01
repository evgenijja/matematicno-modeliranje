function rate = konvergenca(b,r)

    % set set1
    t = linspace(0,1,10000);
    set1 = zeros(2,length(t));
    for i = 1:length(t)
        set1(:,i) = deCasteljau(b,t(i));
    end    
    distVec = hausdorffRazdalja(set1,b);
   
    % sets set2 and distances
    for i=1:r
        [b1, b2] = sub_demo(b,1/2,0);
        b = [b1; b2];
        distVec = [distVec, hausdorffRazdalja(set1,reshape(b,2,[]))];
    end
   
    rate = log(distVec(2:end)./distVec(1:end-1))/log(1/2);

end

% function vektor_razdalj = konvergenca(b,r, t)
% % b poligon
% % r koraki subdivizije
% % t subdivizijski parameter
% 
% X = linspace(0, 1, 10000);
% tocke_na_krivulji = CasteljauSez(b, X);
% 
% razdalja1 = hausdorffRazdalja(tocke_na_krivulji, b);
% vektor_razdalj = [razdalja1]; % nièelni korak subdivizije
% 
% nov_poligon = b;
% for i=1:r
%     [k1, k2] = sub_demo(nov_poligon, t, 0);
%     nov_poligon = [k1(:,1:end-1), k2];
%     razd = hausdorffRazdalja(tocke_na_krivulji, nov_poligon);
%     vektor_razdalj = [vektor_razdalj, razd];
% end
% end