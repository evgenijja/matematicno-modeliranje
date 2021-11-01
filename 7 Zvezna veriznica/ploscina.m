function pl = ploscina(delilne_tocke)
% dela za diskretno
pl = 0;
for i=1:(length(delilne_tocke)-1)
    pl_sprotna = 0;
    tocka1 = delilne_tocke(:,i);
    tocka2 = delilne_tocke(:,i+1);
    x1 = tocka1(1); y1 = tocka1(2);
    x2 = tocka2(1); y2 = tocka2(2);
    pl_sprotna = abs(x1-x2) * min(y1, y2) + abs(y1-y2) * abs(x1-x2)*1/2;
    pl = pl + pl_sprotna;
end
pl = abs(pl);
end