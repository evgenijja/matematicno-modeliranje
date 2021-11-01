% Prikaz re�itve na razli�nih krivuljah

% enostavne oblike Bezierjevih krivulj
b1 = [0, 1, 2, 4; 0, -1, -1, 2];
b2 = [1, 2, 6, 8; 1, 8, 0, 7];
b3 = [1, 4, 8, 5, 3, 6; 2, 0, 3, 4, 3, 8];
% s samoprese�i��em
b4 = [0 1 2 3 4 2 1.5 1; 0 2 -1 1 3 2 1 0];
b5 = [1, 8, 2, 6; 1, 7, 8, 0];
% naklju�na
b6 = randi([-5 5],2,6);

% Glavna funkcija, ki simulira gibanje po krivulji in hkrati izrisuje
% ukrivljenost je 'simulacija_gibanja.' Sprejme kontrolni poligon in
% �tevilo korakov parametra, na tretjem mestu pa sprejme �tevili 0 ali 1,
% ki ozna�ujeta, ali sproti izrisuje tudi daljice med opravljenimi koraki.

% Delovanje si lahko ogledamo na nekaj primerih. Vsak primer se izri�e kot
% nova slika oziroma 'new figure.'

simulacija_gibanja(b1, 5, 1);
simulacija_gibanja(b2, 10, 1);
% simulacija_gibanja(b3, 25, 1);
simulacija_gibanja(b4, 50, 1);
% simulacija_gibanja(b5, 75, 1);
simulacija_gibanja(b6, 10, 1);

% Ker vemo, da obratna vrednost ukrivljenosti predstavlja polmer
% pritisnjene kro�nice, sem sestavila �e funkcijo 'simulacija_kroznice', ki
% na vsakem koraku izri�e tudi pritisnjeno kro�nico. Sprejme iste podatke kot
% zgornja funkcija. 

% simulacija_kroznice(b1, 5, 1);
% simulacija_kroznice(b2, 10, 1);
simulacija_kroznice(b3, 25, 0);
% simulacija_kroznice(b4, 50, 1);
simulacija_kroznice(b5, 75, 0);
simulacija_kroznice(b6, 10, 1);