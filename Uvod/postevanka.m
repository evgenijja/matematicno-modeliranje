function A = postevanka()
% POSTEVANKA2 vprasa uporabnika za stevili a in b
% ter tabelira postevanko, tako da izpise matriko
% velikosti a x b.

a = input('Vnesite stevilo a: ');
b = input('Vnesite stevilo b: ');

% varianta z uporabo zanke for
% dodelimo prostor za matriko

A = zeros(a,b);

% najprej polnimo stolpce
for j = 1:b
    for i = 1:a
        A(i,j) = i*j;
    end
end


% vektorizacija 
A = (1:a)'*(1:b);

end

