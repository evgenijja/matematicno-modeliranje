function presek = presecisce_krivulj(b1, b2)

[x1, y1] = parametricno(b1);
[x2, y2] = parametricno(b2);

eq1 = @(t1, t2) x1(t1) - x2(t2);
eq2 = @(t1, t2) y1(t1) - y2(t2);

eq12 = @(v) [eq1(v(1), v(2)); eq2(v(1), v(2))];
presek = fsolve(eq12, [0.5; 0.5]);
    
% % eq1 = @(t) x(t) - T(1);
% % eq2 = @(theta, t) y(t) - T(2);
% % %fsolve(eq1, 2)
% % eq12 = @(v) [eq1(v(1), v(2)); eq2(v(1), v(2))];
% % solution = fsolve(eq12, [7; 1])
end
