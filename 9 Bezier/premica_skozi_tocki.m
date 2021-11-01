function [k, n] = premica_skozi_tocki(prva, druga)

k = (druga(2) - prva(2))/(druga(1) - prva(1));
n = prva(2) - k*prva(1);

end