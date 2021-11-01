function dp = odvod(p)
% ODVOD vrne vektor koeficientov odvoda polinoma,
% podanega z vektorjem koeficientov p

n = length(p) - 1;

if n == 0
    dp = 0;
    return
end

%% varianta z uporabo zanke for

% % dodelimo prostor
% dp = zeros(1,n);
% 
% for i = 1:n
%     dp(i) = (n-i+1)*p(i);
% end

%% vektorizacija
dp = (n:-1:1).*p(1:(end-1));

end

