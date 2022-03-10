%%
% part a

L = 41;
h = gen_hamming(0.25*pi, L);
ww = -pi:(pi/1000):pi;

HH = freqz(h, 1, ww);

figure
subplot(2,1,1);
plot(ww, abs(HH));
title(sprintf("magnitude plot for L = %d", L))

subplot(2,1,2);
plot(ww, angle(HH));
title(sprintf("phase plot for L = %d", L))

array = [0, 100, 250, 400, 500, 750];

for i = array
    fprintf("mag = %f and phase = %f at w = 0.%dpi\n", abs(HH(1000+i)), ...
        angle(HH(1000+i)), i);
end