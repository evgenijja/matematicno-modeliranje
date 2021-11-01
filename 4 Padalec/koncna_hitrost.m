function hitrost = koncna_hitrost(parametri,zac,tk,n,caseNo)

    [~,v] = padalec(parametri,zac,tk,n,caseNo);
    hitrost = v(end);

end