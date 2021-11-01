function [u,v,w] = sinFun_normalVecFun(x,y,dx_Fun,dy_Fun)
%
% function [u,v,w] = sinFun_normalVecFun(x,y,dx_Fun,dy_Fun)
%
% VHOD
% x:        x koordinate
% y:        y koordinate
% dx_Fun:   odvod funckije v x
% dy_Fun:   odvod funckije v y
%
% IZHOD
% u,v,w:    koordinate normal
%
% Funkcija izracune normalo 2D preslikave v izbranih tockah (potrebuje prva
% parcialna odvoda).
%

% odvodi izracunani v tockah
dx_f = dx_Fun(x,y);
dy_f = dy_Fun(x,y);

% vektorji oblike [1 0 dx_f]'
dx_fVec = dx_f(:);
ss = size(dx_fVec);
dx_fVec = [ones(ss) zeros(ss) dx_fVec];


% vektorji oblike [0 1 dy_f]'
dy_fVec = dy_f(:);
dy_fVec = [zeros(ss) ones(ss) dy_fVec];

% normale
normalVec = cross(dx_fVec, dy_fVec);
normalVec = normalVec./(sum(normalVec.^2,2)); %vsota po vrsticah

% komponente normal
u = normalVec(:,1);
v = normalVec(:,2);
w = normalVec(:,3);

u = reshape(u,size(x));
v = reshape(v,size(x));
w = reshape(w,size(x));