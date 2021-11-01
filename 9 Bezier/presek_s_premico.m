function Tp = presek_s_premico(b,l,tol)
% PRESEK_S_PREMICO poisce presek ravninske Bezierove krivulje 
% s premico l podano s tocko P in smernim vektorjem s
% 
% Tp je tabela tock presecisc (ce ni presecisca, vrne prazno matriko)
% b je tabela 2x(n+1) kontrolnih tock po stolpcih
% l = [P,s]
% tol je natancnost, do katere isce presecisce. 
% ponavadi 1e-6

Tp = [];

% IDEJA:
% - izracunamo pravokotnik P, ki vsebuje vse kontrolne tocke
% - ce premica ne seka pravokotnika, potem tudi ne seka Bezierove krivulje,
%   saj je ta vsebovana v svoji konveksni ogrinjaci, ta pa je vsebovana v P.
% - ce premica seka pravokotnik, naredimo korak subdivizije in postopek
%   ponovimo


P = pravokotnik(b);

if ~seka_pravokotnik(l,P)
    return
else
    
    % ce je dolzina stranic pravokotnika dovolj majhna, vrnemo sredisce
    % pravokotnika kot presecisce
    if (norm(P(:,2)-P(:,1)) < tol && norm(P(:,4)-P(:,1)) < tol) 
        Tp = [Tp 1/4*sum(P,2)];
    else
        [kontrolne1,kontrolne2] = sub_demo(b,0.5,0);
        Tp1 = presek_s_premico(kontrolne1,l,tol);
        Tp2 = presek_s_premico(kontrolne2,l,tol);
        Tp = [Tp Tp1 Tp2];
    end
end


end