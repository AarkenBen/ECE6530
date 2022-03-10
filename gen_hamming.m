function h = gen_hamming(wc,L)
%gen_h generate filter coefficients
h = zeros(1,L);
for n = 0:L-1
    h(n+1) = (0.54 - 0.46 * cos(2*pi*n/(L-1)))*cos(wc *(n - (L - 1)/2));
end
end

