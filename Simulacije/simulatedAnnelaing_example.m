%simulated annealing example


f = @(x) sin(10*x) + 1/3*cos(2*x) + 1/10*(x-5).^2;
a = 0;
b = 10;



coolingParameter = 1/100;

figure
xplot = linspace(a,b,1000);
plot(xplot, f(xplot));
hold on

x = 1;
fx = f(x);
for t=1:1000
    
    xNew = min([b max([a x+(rand()-1/2)])]);
    fxNew = f(xNew);
    swapProbability = exp(-coolingParameter * t * (fxNew-fx));
    
    if rand() < swapProbability
        x = xNew;
        fx = f(x);
    end
    pt = plot(x,fx,'ro');
    pause(.1);
    delete(pt)
    
end

plot(x,fx,'ro')
