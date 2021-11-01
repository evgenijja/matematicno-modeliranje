function v_kon = padalec_vkon(parametri,zac,tk,n,caseNo)

[y,v,t] = padalec(parametri,zac,tk,n,caseNo);
v_kon = v(end);

end