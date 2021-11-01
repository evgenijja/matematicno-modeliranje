% vaje o diskretni verižnici

b = 73; A = [0,0]; B = [2, 0];
M = [1+b/100, 0.6, 0.6, 1+b/100];
L = [1, 1, 1, 1];
g = 9.8;

%zac = [A', B'];
zac = [0 2;0 0]; % navpièno
W0 = [-0.5;-1.2];
X = ver_uv(W0,zac,L,M); %vrne vozlišèa

% a) Koliksna je vsota razdalj krajisc vseh palic do tezisca diskretne verižnice?
tezisca_posameznih = (X(:,1:(end-1))+X(:,2:end))/2;
mase = [M;M];

% tezisce
tezisce = sum(mase.*tezisca_posameznih,2)/sum(M); %sum(___, 2) sešteje po vrsticah

razdalja = 0;
for i = 1:size(X,2)
    razdalja = razdalja + norm(X(:,i)-tezisce);
end
razdalja;

% b) Zapišite enaèbo parabole, ki gre skozi obesišèi diskretne verižnice in
% sta v teh toèkah prva in zadnja palica tangencialni na parabolo. 
% Kolikšna je ordinata najnižje toèke parabole?

naklon = (X(2,2)-X(2,1)) / (X(1,2)-X(1,1)); % delta y / delta x za prvo palico

% sistem za koeficiente a,b,c parabole
A = [X(1,1)*X(1,1) X(1,1) 1; X(1,end)*X(1,end) X(1,end) 1; 2*X(1,1) 1 0];
% prva in druga enaèba povesta, da gre parabola èez krajišèi
% tretja pa da je odvod v krajišèu enak naklonu
rhs = [X(2,1); X(2,end); naklon];
koef = A\rhs;

% ordinata najnizje tocke na paraboli q = -D/4a
disk = koef(2)*koef(2) - 4*koef(1)*koef(3); % diskriminanta
resitev2 = -disk/(4*koef(1));

% c) Vsak èlenek veriznice razpolovimo (predpostavimo, da so clenki homogeni). 
% Koliksna je absolutna razlika potencialnih energij stare in nove veriznice?
W_old = potencialna(X,M,g);

% vsak clenek veriznice razpolovimo. 
% podatki kar na roke
L_new = 0.5*ones(1,8);
M_new = 0.5*[1+b/100 1+b/100 0.6 0.6 0.6 0.6 1+b/100 1+b/100];

% izracun veriznice
W0 = [-0.5;-1.2];
X_new = ver_uv(W0,zac,L_new,M_new);

W_new = potencialna(X_new,M_new,g);

resitev3 = abs(W_old - W_new);

% d) Dana je premica l z enaèbo y =  0.5*( m1 + m2 ), kjer sta
% m1 in m2 najmanjša in najveèja vrednost ordinat krajisc.
% Oznacimo s P1 in P2 presecisci premice l z dano veriznico. 
% Koliksna je ploscina trapeza AP1P2B?
k = 0.5*( max(X(2,:)) + min(X(2,:)) );

% stranice trapeza
a = norm(zac(:,1)-zac(:,2)); % zgornja stranica od A do B
visina = abs(k); % to gre ker sta A in B na isti višini, k pa je konst

% b dobimo kot presescisce premice y = k s premico skozi tocki
    % X(:,1) in X(:,2) in nato izracunamo razdaljo med P1 in P2
% na obeh straneh je veriznica simetricna - glej sliko
% risi_veriznica(zac, L, M)
if (k >= X(2,2))
    smerni = ( X(2,2)-X(2,1) ) / ( X(1,2)-X(1,1) );   
    x = X(1,1) + (k-X(2,1))/smerni;
    
else % k < X(2,2)
    smerni = ( X(2,2)-X(2,3) ) / ( X(1,2)-X(1,3) );
    x = X(1,2) + (k-X(2,2))/smerni;  
end

P1_x = X(1,1)+x;
P2_x = X(1,end)-x;
b = abs(P1_x - P2_x);

resitev4 = (a+b)/2 * visina;

%--------------------------------------------------------------------------

% lanska prva domaèa naloga

b = 37; A = [0, 0]; B = [3, 0];
M = [2+b/100,3.4,0.8,1+b/100,0.6,3.1];
L=[1,1,1,1,1,1]; % 6 palic

%zac = [A', B'];
zac = [0 3;0 0]; % navpièno
W0 = [-0.5;-1.2];
X = ver_uv(W0,zac,L,M); %vrne vozlišèa vkljuèno s prvim in zadnjim

% Vsota koordinat najnižje toèke na verižnici
% risi_veriznica(zac, L, M); % iz slike se vidi da je to eno od vozlišè
ordinate = X(2,:);
min(ordinate);
for i=1:length(ordinate)
    if ordinate(i) == min(ordinate)
        sum(X(:,i));
    end
end

% Vsota koordinat preseèišè daljic AK5 in K1B
%risi_veriznica(zac, L, M); % pomagam si s sliko
K1 = X(:,2)'; K5 = X(:,6)';
y1 = enacba_premice(A, K5);
y2 = enacba_premice(K1, B);
% presek premic
enacba = @(x) y1(x) - y2(x);
x_koord = fsolve(enacba, 1);
% vsota koordinat preseèišèa
x_koord + y1(x_koord);

% Kolikšna naj bo dolžina zadnjega èlenka (masa ista) da bo tretji èlenek
% vzporeden z abcisno osjo
L2 = @(x) [1,1,1,1,1,x];
X2 = @(x) ver_uv(W0,zac,L2(x),M);
vstavi_x = @(x) X2(x);
vrni_ordinato = @(seznam, x, y) seznam(x,y);
% tretji èlenek je med tretjim in èetrtim oglišèem
vrni1 = @(x) vrni_ordinato(X2(x), 2, 3);
vrni2 = @(x) vrni_ordinato(X2(x), 2, 4);
enacba = @(x) vrni1(x)-vrni2(x);
fzero(enacba, 1);

% Pri kateri abscisi moramo navpicno prerezati veckotnik, ki ga dobite, 
%ce povezete obesisci A in B veriznice, da imata dobljena lika enaki ploscini?
enacba = @(x) ploscina(X) - 2*ploscina_ver(X, x);
fsolve(enacba, 1);
