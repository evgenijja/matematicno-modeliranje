function y_kon = padalec_ykon(parametri,zac,tk,n,caseNo)

[y,v,t] = padalec(parametri,zac,tk,n,3);
y_kon = y(end);

end