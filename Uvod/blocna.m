function A = blocna(n)

%%%% 1. moznost %%%%

% prvi obdiagonali
obdiagonala = ones(1,n^2-1);
obdiagonala(n:n:n^2-1) = 0;

% diagonala + prvi obdiagonali + n-ti obdiagonali
A = -4*eye(n^2) + diag(obdiagonala,1) + diag(obdiagonala,-1) + diag(ones(1,n^2-n),n) + diag(ones(1,n^2-n),-n);


%%%% 2. moznost %%%%
I = eye(n);
T = -4*diag(ones(n,1)) + diag(ones(n-1,1),1) + diag(ones(n-1,1),-1);
tmp1 = diag(ones(n,1));
tmp2 = diag(ones(n-1,1),1) + diag(ones(n-1,1),-1);
A = kron(tmp1,T) + kron(tmp2,I);


end

