function phi = kot(T1, S, T2)
% zraèuna kot med tremi toèkami z vrhom pri S
prva_daljica = S - T1;
druga_daljica = S - T2;

skalarni = prva_daljica(1)*druga_daljica(1) + prva_daljica(2)*druga_daljica(2);

cos_phi = skalarni/(norm(prva_daljica)*norm(druga_daljica));
phi = acos(cos_phi);
end