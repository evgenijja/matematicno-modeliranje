function pl = ploscina_trikotnika(A, B, C)
% zraèuna plošèino trikotnika med temi tremi toèkami

stranica1 = norm(A-B);

% premica skozi A in B
koef = (A(2)-B(2))/(A(1)-B(1)); 
n = A(2) - koef*A(1);
premica = @(x) koef*x + n;
disp(premica)

razdalja = @(x) norm([x, premica(x)]-C);
% visina bo minimalna razdalja
x_koord = fminsearch(razdalja, 1);
visina = razdalja(x_koord);
disp(visina)

pl = stranica1*visina/2;
end