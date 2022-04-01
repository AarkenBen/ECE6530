function [h] = BPF(L,W)

n = 0:L-1; % Number of the sample 

h = (2/L).*cos(W.*n); % Transfer function equation

end