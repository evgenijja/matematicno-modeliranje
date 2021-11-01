function min = risi_brah_dodatno(T1,T2)
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


% najnizja tocka je pri theta = pi, ce je theta0 > pi, sicer desno krajisce

if theta0 > pi
    x_min = 1/2*k^2*(pi-sin(pi)) + T1(1);
    y_min = -1/2*k^2*(1-cos(pi)) + T1(2);
else
    x_min = T2(1);
    y_min = T2(2);
end

min = [x_min; y_min];

plot(x_min,y_min,'o','MarkerFaceColor','r','MarkerSize',10);

hold off


end