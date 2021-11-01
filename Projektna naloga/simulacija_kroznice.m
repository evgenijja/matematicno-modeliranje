function simulacija_kroznice(b, korak, pot)
% SIMULACIJA_KROZNICE podobno kot SIMULACIJA_GIBANJA prikazuje gibanje
% delca po krivulji, zraven pa na vsakem koraku simulacije izriše
% pritisnjeno krožnico na krivuljo. Prav tako vzporedno izrisuje
% ukrivljenost krivulje, ki je geometrijsko povezana s polmerom pritisnjene
% krožnice.
% Vhodni podatki
% b ....... kontrolni poligon krivulje
% korak ... število korakov simulacije
% pot...... pove, ali želimo, da se sproti izrisuje pot delca

figure

subplot(1, 2, 1);
T = linspace(0,1,korak);
plotBezier(b);
hold on
axis([min(b(1,:))-1, max(b(1,:))+1, min(b(2,:))-1, max(b(2,:))+1])
title('Simulacija gibanja delca')

subplot(1, 2, 2);
R = linspace(0, 1, 100);
plot(R, ukrivljenost(b, R));
ukrivljenosti = ukrivljenost(b, R);
najmanjsa = min(ukrivljenosti); najvecja = max(ukrivljenosti);
hold on
axis([0 1 najmanjsa-0.5 najvecja+0.5]);
title('Ukrivljenost')

nova_tocka = deCasteljau(b, T(1));
for i=2:korak

    prejsnja_tocka = nova_tocka;
    nova_tocka = deCasteljau(b, T(i));
    
    subplot(1, 2, 1);
    if pot
        narisi_daljico(prejsnja_tocka, nova_tocka);
        hold on
    end
    pt1 = plot(nova_tocka(1), nova_tocka(2), 'ro');

    pritisnjena_kroznica(b, T(i), 0);

    subplot(1, 2, 2);
    kappa_nov = ukrivljenost(b, T(i));
    pt2 = plot(T(i), kappa_nov, 'ro');
    
    pause(.1);
    delete(pt1)
    delete(pt2)

end
subplot(1, 2, 1)
zadnja_tocka = deCasteljau(b, T(end));
plot(zadnja_tocka(1), zadnja_tocka(2), 'ro'); 

subplot(1, 2, 2)
plot(T(end), ukrivljenost(b, T(end)), 'ro');

hold off
end
