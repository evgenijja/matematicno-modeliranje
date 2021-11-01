function risi_kroznici(T)
% RISI_KROZNICI narise trikotnik ter vcrtano in ocrtano kroznico
% skupaj s srediscema. Trikotnik je podan z matriko T velikosti 2x3,
% kjer prva vrstica doloca abscise, druga pa ordinate ogljisc trikotnika.

%% OCRTANA KROZNICA

% izracun dveh simetral stranic trikotnika
[T1,s1]=simetrala_daljice(T(:,1),T(:,2));
[T2,s2]=simetrala_daljice(T(:,1),T(:,3));

% sredisce in polmer ocrtane kroznice
S_ocrtana = presek_premic(T1,T2,s1,s2);
R = norm(T(:,1)-S_ocrtana);

%% VCRTANA KROZNICA

% izracun dveh simetral kotov trikotnika
[T1,s1]=simetrala_kota(T(:,1),T(:,2),T(:,3));
[T2,s2]=simetrala_kota(T(:,3),T(:,1),T(:,2));

% sredisce vcrtane kroznice
S_vcrtana = presek_premic(T1,T2,s1,s2);

% polmer vcrtane kroznice: r = ploscina trikotnika / polovicni obseg
% ploscino trikotnika izracunamo s pomocjo Heronovega obrazca
a = norm(T(:,2)-T(:,1));
b = norm(T(:,3)-T(:,2));
c = norm(T(:,1)-T(:,3));

s = (a + b + c)/2;
pl = sqrt(s*(s-a)*(s-b)*(s-c));

r = pl/s;


%% RISANJE
t = linspace(0,2*pi,100);

% parametrizacija ocrtane kroznice
x_o = S_ocrtana(1) + R * cos(t);
y_o = S_ocrtana(2) + R * sin(t);

% parametrizacija vcrtane kroznice
x_v = S_vcrtana(1) + r * cos(t);
y_v = S_vcrtana(2) + r * sin(t);

hold on
plot(x_o,y_o, 'color', 'b')
plot(x_v,y_v, 'color', 'r'); 
axis equal

% risanje trikotnika
x = T(1,:);
y = T(2,:);
x(4) = x(1);
y(4) = y(1);
line(x,y,'color','k');

% risanje oglisc trikotnika in sredisc kroznic
plot(T(1,:), T(2,:), 'o', 'color','k')
plot(S_vcrtana(1),S_vcrtana(2), 'x', 'color','r')
plot(S_ocrtana(1),S_ocrtana(2), 'x', 'color','b')

hold off

end