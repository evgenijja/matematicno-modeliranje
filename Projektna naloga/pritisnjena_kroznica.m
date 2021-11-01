function pritisnjena_kroznica(b, z, bezier)
% PRITISNJENA_KROZNICA izriše pritisnjeno krožnico na krivuljo, podano z matriko katere stolpci so kontrolne toèke krivulje, pri izbranjem
% parametru. Ima možnost 'vklopa' in 'izklopa' prikaza krivulje, kar je smiselno, èe 
% funkcijo uporabljamo samo, ni pa praktièno, ko jo uporabljamo znotraj
% drugih funkcij.
% Vhodni podatki
% b ....... kontrolni poligon krivulje
% korak ... število korakov simulacije
% bezier...... pove, ali želimo, da nariše tudi krivuljo ali le krožnico

if bezier
    plotBezier(b)
    hold on
end

% toèka v kateri rišemo krožnico
tocka = deCasteljau(b, z); 

% polmer je obratna vrednost velikosti ukrivljenosti
polmer = 1/abs(ukrivljenost(b, z));

% središèe je v smeri normale
vekt = normalni_vektor(b, z);
sredisce = tocka + polmer*vekt;

% Želimo narisati tudi daljico od toèke na krivulji do središèa krožnice
tangentni_vektor = bezier_der(b, z, 0);
tx = tangentni_vektor(1); ty = tangentni_vektor(2);
k_normale = -tx/ty;
normala = @(x) k_normale*x + tocka(2) - k_normale*tocka(1);
x = linspace(tocka(1), sredisce(1), 50);
ptn = plot(x, normala(x));

% narišemo krožnico
kot = linspace(0, 2*pi, 100);
x = polmer*cos(kot) + sredisce(1);
y = polmer*sin(kot) + sredisce(2);

pt = plot(x, y, 'b-', 'LineWidth', 1);
axis([min(b(1,:))-1, max(b(1,:))+1, min(b(2,:))-1, max(b(2,:))+1])
pause(.1)
delete(ptn) % na koncu jo izbrišemo, èe želimo uporabljati funkcijo samo, moramo ta del zakomentirati
delete(pt)
end

