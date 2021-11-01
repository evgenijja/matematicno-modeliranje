function seka = seka_pravokotnik(l,P)
% SEKA_PRAVOKOTNIK doloci, ali premica l seka pravokotnik P ali ne.
% Premica l je podana v obliki l = [tocka, smerni].
% Pravokotnik P je dolocen s tabelo 2x4 oglisc po stolpcih

normala = [0 -1;1 0]*l(:,2);
normala = normala/norm(normala);


tocka = l(:,1);

% Preverimo, na kateri strani polaravnine
% (dolocene  z normalo premice) lezijo oglisca.
% Ce so vse na eni strani, presecisca ni.
    
% vektor 1 in -1, katerega komponente dolocajo na kateri polravnini lezi
% tocka
stran_polravnine = zeros(1,4);

for i = 1:4
   stran_polravnine(i) = sign(dot(normala,P(:,i)-tocka));
end


% ce so vsi predznaki enaki, premica ne seka pravokotnika
if abs(sum(stran_polravnine)) == 4
    seka = 0;
else
    seka = 1;
end
    

end
