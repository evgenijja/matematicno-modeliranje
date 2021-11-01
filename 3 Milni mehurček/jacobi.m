function U = jacobi(U,tol,a)
% JACOBI izvaja Jacobijevo metodo na mrezi U, ki predstavlja
% diskretizacijo kvadrata [-a,a] x [-a,a]. Na vsakem koraku iteracije
% je vsak element izracunan kot povprecje njegovih stirih sosedov.
% Pri tem je U matrika z niclami v notranjosti in vrednostmi na robu,
% dolocenimi z robnimi pogoji.
% tol je toleranca, ki doloca natancnost izracunane resitve.

n = size(U,1) - 2;
x = linspace(-a,a,n+2);
[X,Y] = meshgrid(x,x);

napaka = Inf;
korakov = 0;

% pomozna mreza
U_k = U;

while napaka > tol
    % 'rob' matrike smo že doloèil pri milnica funkciji
    for j = 2 : n+1
        for i = 2 : n+1
            U_k(i,j) = 1/4*(U(i-1,j) + U(i+1,j) + U(i,j-1) + U(i,j+1));
        end
    end
    
    napaka = max(max(abs(U-U_k)));
    U = U_k;
    korakov = korakov + 1;
    
    % animacija
    graf = surf(X, Y, flipud(U));
    
    pause(0.01);
    
    delete(graf)
    
end
   
% izpis stevila korakov
fprintf('Jacobijeva metoda potrebuje %d korakov.\n', korakov);

end

