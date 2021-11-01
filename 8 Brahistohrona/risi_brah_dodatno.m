function [cas_brah, cas_premica] = risi_brah_dodatno(T1,T2)
% RISI_BRAH narise brahistohrono med tockama T1 in T2.
% Pri tem parameter theta lezi na intervalu [0,theta0],
% kjer je theta0 dobljena s funkcijo isci_theta.
% Funkcija vrne tudi cas potovanja po brahistohroni
% ter cas potovanja po premici med tockama T1 in T2.
  
% naredimo premik tock, da bo veljalo T1(0,0);
b = T2(1) - T1(1);
B = T2(2) - T1(2);

[k,theta0]=isci_theta(b,B);

% theta0 doloca interval risanje, k obliko krivulje
theta = linspace(0,theta0,100);

% Premaknemo brahistrono v originalni koordinatni sistem
x = 1/2*k^2*(theta-sin(theta)) + T1(1);
y = -1/2*k^2*(1-cos(theta)) + T1(2);

% risanje
hold on
plot(x,y,'b','LineWidth',3);

grid on
axis equal


% cas potovanja po brahistohroni in premici med tockama T1 in T2
% analiticna integracija
cas_premica = sqrt(2*(b^2+B^2)/(-9.81*B));

cas_brah = k/sqrt(2*9.81)*theta0;

disp('Casa potovanja po brahistohroni in po premici sta enaka:');
disp(cas_brah);
disp(cas_premica);

% najnizja tocka je pri theta = pi, ce je theta0 > pi, sicer desno krajisce

if theta0 > pi
    x_min = 1/2*k^2*(pi-sin(pi)) + T1(1);
    y_min = -1/2*k^2*(1-cos(pi)) + T1(2);
else
    x_min = T2(1);
    y_min = T2(2);
end

plot(x_min,y_min,'o','MarkerFaceColor','r','MarkerSize',10);

hold off

disp('Brahistohrona doseze najnizjo tocko pri x =');
disp(x_min);

% dolzina brahistohrone
% analiticna integracija
l = 2*k^2*(1-cos(theta0/2));

disp('Dolzina brahistohrone je:');
disp(l);


end