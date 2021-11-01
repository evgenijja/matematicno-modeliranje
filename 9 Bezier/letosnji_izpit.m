% letošnji izpit

bC = [-2.00     -1.00     0.00     1.04     0.00     3.00;     5.00     3.00     0.00     2.00     4.10     6.00];

plotBezier(bC);

b1 = bC;


b1 = premakni_bezier(b1, [2; -5]);
b1 = zrcali_bezier(b1);
b1 = premakni_bezier(b1, [-2; 5]);
abcise = b1(1,:);
sum(abcise)/length(abcise);
% abcise = b1(1,:);
% abcise = -1*abcise;
% b11=[abcise; b1(2,:)];
% %
% plotBezier(b11);
%b1 = rotiraj_bezier(b1, pi);


funkc = @(t) deCasteljau(bC, t);  
fun_x = @(t) norm(bezier_der(bC, t, 0), 2);
dolzina = integral(fun_x, 0, 1, 'ArrayValued', true);
%s = @(t) t*dolzina/dolzina;

[x, y] = parametricno(bC);
ds = @(t) sqrt(x(t)^2 + y(t)^2);
fun = @(b, x) ukrivljenost(b, x);
fun2 = @(x) fun(bC, x);
fun3 = @(t) abs(fun2(ds(t)))^2*ds(t);
odg3 = integral(fun3, 0, dolzina, 'ArrayValued', true)


