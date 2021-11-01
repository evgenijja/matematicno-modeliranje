function pritisnjena_kroznica(b, z, bezier)
% PRITISNJENA_KROZNICA izri�e pritisnjeno kro�nico na krivuljo, podano z matriko katere stolpci so kontrolne to�ke krivulje, pri izbranjem
% parametru. Ima mo�nost 'vklopa' in 'izklopa' prikaza krivulje, kar je smiselno, �e 
% funkcijo uporabljamo samo, ni pa prakti�no, ko jo uporabljamo znotraj
% drugih funkcij.
% Vhodni podatki
% b ....... kontrolni poligon krivulje
% korak ... �tevilo korakov simulacije
% bezier...... pove, ali �elimo, da nari�e tudi krivuljo ali le kro�nico

if bezier
    plotBezier(b)
    hold on
end

% to�ka v kateri ri�emo kro�nico
tocka = deCasteljau(b, z); 

% polmer je obratna vrednost velikosti ukrivljenosti
polmer = 1/abs(ukrivljenost(b, z));

% sredi��e je v smeri normale
vekt = normalni_vektor(b, z);
sredisce = tocka + polmer*vekt;

% �elimo narisati tudi daljico od to�ke na krivulji do sredi��a kro�nice
tangentni_vektor = bezier_der(b, z, 0);
tx = tangentni_vektor(1); ty = tangentni_vektor(2);
k_normale = -tx/ty;
normala = @(x) k_normale*x + tocka(2) - k_normale*tocka(1);
x = linspace(tocka(1), sredisce(1), 50);
ptn = plot(x, normala(x));

% nari�emo kro�nico
kot = linspace(0, 2*pi, 100);
x = polmer*cos(kot) + sredisce(1);
y = polmer*sin(kot) + sredisce(2);

pt = plot(x, y, 'b-', 'LineWidth', 1);
axis([min(b(1,:))-1, max(b(1,:))+1, min(b(2,:))-1, max(b(2,:))+1])
pause(.1)
delete(ptn) % na koncu jo izbri�emo, �e �elimo uporabljati funkcijo samo, moramo ta del zakomentirati
delete(pt)
end

