function pl = ploscina_ver(tocke, x)
% vrne plošèino diskretne verižnice pri nekem x
% tocke : delilne tocke iz funkcije ver_uv

%podatki za funkcijo ver_uv
n = length(tocke) - 1;

%tocke = ver_uv(W0, zac, L, M); % tock je n+1; A&B in n-1 tock umes
% tocke oblike tocke(1,:) so x koordinate
% prva tocka je A in zadnja je B

%n = length(L);
pl = 0;

% èe je x manjsi kot x pri A je P = 0
if x <= tocke(1,1)
    pl = 0;
end

if x >= tocke(1,n+1)
    x = tocke(1,n+1);
end
nova_pl = 0;
for i = 2:n % prvi interval bo od A do prve toèke, mel bomo n+1 intervalov
    % zaènemo pri 2 ker 1=A torej je prva od A razlièna toèka v tabeli i=2
    
    
    % poiscemo kje je x in pristejemo vse od prej
    if x >= tocke(1,i)
        
        nova_pl = pl + ploscina([tocke(:, i-1), (tocke(:, i))]);
        
        pl = nova_pl;   
    
    if x <= tocke(1, i+1)
        % dolocit moram koordinate tocke, x mam se y rabim
        delta_y = tocke(2, i+1) - tocke(2, i);
        delta_x = tocke(1, i+1) - tocke(1, i);
        k = delta_y / delta_x;
        y = tocke(2, i) + k * (x - tocke(1, i));
        se_bolj_nova_pl = nova_pl + ploscina([tocke(:, i), [x, y]']);
        pl = se_bolj_nova_pl;
        
        
    end
    end
end

P = pl;

% poženeš:
% pl_ver = @(x) ploscina_ver(x)
% g = @(x) ploscina_ver(B(1)) - 2 * pl_ver(x)
% fzero(g, 0)
% dobim 1.419096808501946

        
   
end