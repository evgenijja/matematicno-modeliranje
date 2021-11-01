function U = gauss_seidl(U,tol,a)
% GAUSS_SEIDL izvaja Gauss-Seidlovo metodo direktno na mrezi U,
% ki predstavlja diskretizacijo kvadrata [-a,a] x [-a,a]. V vsakem
% koraku iteracije je vsak element izracunan kot povprecje njegovih stirih
% sosedov. Pri tem je U matrika z niclami v notranjosti in
% vrednostmi na robu, dolocenimi z robnimi pogoji.
% tol je toleranca, ki doloca natancnost izracunane resitve.

n = size(U,1) - 2;
x = linspace(-a,a,n+2);
[X,Y] = meshgrid(x,x);

napaka = Inf;
korakov = 0;

while napaka > tol
    
    napaka = 0;
    
    for j = 2 : n+1
        for i = 2 : n+1
            U_new = 1/4*(U(i-1,j) + U(i+1,j) + U(i,j-1) + U(i,j+1));
            napaka = max(abs(U_new - U(i,j)), napaka);
            U(i,j) = U_new;
        end
    end
    
    korakov = korakov + 1;
    
    % animacija
    graf = surf(X, Y, flipud(U));
    
    pause(0.01);
    
    delete(graf)
    
end
    
fprintf('Gauss-Seidlova metoda potrebuje %d korakov.\n', korakov);

end

