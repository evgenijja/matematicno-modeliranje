function T_min = najnizja_tocka(a,A,b,B,l)
    
    z = isci_z([a A],[b B],l,1,1e-10);

    v = atanh((B-A)/l) + z;
    u = atanh((B-A)/l) - z;

    D = (a*v-b*u)/(v-u);
    T_min = D;

end