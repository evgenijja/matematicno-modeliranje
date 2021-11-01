function dist = tocka_do_premice(tocka, premica)
% premica je podana kot [a, b, c] kjer ax + by + c
% racunamo pravokotno razdaljo
a = premica(1); b = premica(2); c = premica(3);
x = tocka(1); y = tocka(2);
stevec = abs(a*x + b*y + c);
imen = sqrt(a^2+b^2);

dist = stevec/imen;

end