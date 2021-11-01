function razd = hausdorffRazdalja_dvosmerna(mn1,mn2)

n1 = length(mn1); n2 = length(mn2);

seznam1 = [];
for j=1:n2
    sez = [];
    for i=1:n1
        razdalja = norm(mn1(:,i)-mn2(:,j), 2);
        sez = [sez, razdalja];
    end
    minimum = min(sez);
    seznam1 = [seznam1, minimum];  
end
razd1 = max(seznam1);

seznam2 = [];
for i=1:n1
    sez = [];
    for j=1:n2
        razdalja = norm(mn1(:,i)-mn2(:,j), 2);
        sez = [sez, razdalja];
    end
    minimum = min(sez);
    seznam2 = [seznam2, minimum];  
end
razd2 = max(seznam2);

razd = max([razd1, razd2]);
end