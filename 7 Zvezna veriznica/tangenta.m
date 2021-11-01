function tangenta = tangenta(w, w_odvod, x_koord)
% w je funkcija veriznice
% tocka je tam kjer iscemo tangenta - x komponenta

k = w_odvod(x_koord);
n = w(x_koord) - k*x_koord;

tangenta = @(x) k*x + n;
end