function kappa = ukrivljenost(x, y, dx, dy, dxx, dyy, tocka)

kappa_fun = @(x) abs(dx(x)*dyy(x) + dy(x)*dxx(x))/(dx(x)^2+dy(x)^2)^(3/2);

kappa = kappa_fun(tocka);
end