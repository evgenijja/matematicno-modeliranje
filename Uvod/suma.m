function [n, pari] = suma(a,s)
% Dan je urejen seznam a nepadajocih naravnih števil. 
% SUMA poisce vse pare števil, katerih vsota je dano število s.

% zacetni indeks
k = 1;

% koncni indeks
m = length(a);

% stevilo parov
n = 0;

% rezervacija spomina
pari = zeros(2,n*(n-1)/2);

while k < m
   
    if a(k) + a(m) == s
        
        if a(k) == a(k+1) && a(m-1) == a(m)
            % poiscimo stevilo ponovitev a(m) == a(m-1) == a(m-2) ...
            repeat = 1;
            for i = m-1:-1:k
               if a(i) == a(m)
                   repeat = repeat + 1;
               end
            end
            
            % povecamo n za repeat
            pari(:,n+1:n+repeat) = repmat([a(k);a(m)],1,repeat);
            n = n + repeat;
            k = k + 1;
            
        else
            n = n + 1;
            pari(:,n) = [a(k);a(m)];
            if a(k) == a(k+1)
                k = k + 1;

            elseif a(m-1) == a(m)
                m = m - 1;

            else 
                k = k + 1; 
            end
            
        end
        
    elseif a(k) + a(m) < s
        k = k + 1;
    else
        m = m - 1;
    end
    
end

pari = pari(:,1:n);

end

