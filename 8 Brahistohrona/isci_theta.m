function [k,theta] = isci_theta(b,B)
% ISCI_THETA doloci theta^*, resitev g(theta)=0
% Predpostavka: T1(0,0), T2(b,B)
% [k,theta]=ISCI_THETA_K(b,B);

g = @(x) 1-cos(x)+B/b*(x-sin(x));

theta = fzero(g,pi);  %g ima niclo na intervalu [0,2*pi]

k = sqrt(2*b/(theta-sin(theta)));
end