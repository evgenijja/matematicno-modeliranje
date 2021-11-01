n = 1000;

% f = 1
f = @(r) ones(size(r));
R = 1;
[r,u]=poves_opne(f,R,n);

plot(r, u) % nariše funkcijo
title('$$f(r) = 1$$','interpreter','latex','fontsize',15)
risi_opno(R,u); % izriše opno v 3d

% f = 1 - r^2
f = @(r) 1-r.^2;
R = 1;
[r,u]=poves_opne(f,R,n);

figure 
plot(r, u)
title('$$f(r) = 1-r^2$$','interpreter','latex','fontsize',15)
risi_opno(R,u);

% f = sin(2*pi*r)
f = @(r) sin(2*pi*r);
R = 2;
[r,u]=poves_opne(f,R,n);

figure 
plot(r, u)
title('$$f(r) = \sin(2\pi r)$$','interpreter','latex','fontsize',15)
risi_opno(R,u);
