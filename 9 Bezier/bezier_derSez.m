function v = bezier_derSez(b, t, risanje)
% izracuna tangentni vektor na Bezierjevo krivuljo podano na
% kontrolnih tocka b pri parametru t

% odvod deCasteaujeve krivulje je ravno tako deCastejaueva krivulja
% izracunam jo kot: n * deCasteajev postopek na novih tockah (preme difer)
% kjer je n stevilo kontrolnih tock - 1

n = size(b, 2);

% izracunam preme diference oziroma kontrolne tocke odvoda 
% dt = b_{i+1} - b_i
dt = b(:, 2:end) - b(:, 1:(end-1));

% tangentni vektor in tocka
v = (n-1) .* CasteljauSez(dt, t);
tocka = CasteljauSez(b, t);

if risanje
    plotBezier(b);
    hold on
    
    % narisem tangentni vektor
    quiver(tocka(1,:), tocka(2,:), v(1,:), v(2,:), 'r', 'LineWidth', 2);
    
    hold off
end
end