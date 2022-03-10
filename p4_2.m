%%
% part a
% plot the magnitude and phase, and calculate pass band for L = 41
p4sub(41);
%%
% part b
% plot the magnitude and phase, and calculate pass band for L = 21
p4sub(21);
% plot the magnitude and phase, and calculate pass band for L = 81
p4sub(81);
% the width of the passband is approximately cut in half when L is doubled

%%
% part c
% The magnitude is the product of abs(h) at the given frequency
% the phase is the sum of angle(h) at the given frequency
fprintf("x[n] = %f + %fcos(0.1pi*n + %f) + %fcos(0.25pi*n + %f)\n", ...
    2 * 0.007350, 2 * 0.007290, pi/3-3.078761, 1.001234, -pi/3 - 3.078761);

% the magnitude of the first two terms is almost zero because they are in
% the stop band
% the magnitude of the last term is almost one because it is in the pass
% band

%%
% part d
% The magnitude response of the filter is approximately 1 at 0.25pi
% This means that the magnitude of the response will be scaled by
% approximately 1 at the frequency
% on the other hand, the magnitude is approximately 0 away from 0.25 pi
% This means that the magnitude of the response will be approximately 0 for
% frequencies away from 0.25pi

function p4sub(L)
% calculate and plot the magnitude and phase of the hamming window
% print out the magnitude and phase at specific center frequencies
% calculate h
h = gen_hamming(0.25*pi, L);
% x axis in our plots
ww = -pi:(pi/1000):pi;

% calculate magnitude and phase response of h
HH = freqz(h, 1, ww);

% plot magnitude
figure
subplot(2,1,1);
plot(ww, abs(HH));
title(sprintf("magnitude plot for L = %d", L))

% plot phase
subplot(2,1,2);
plot(ww, angle(HH));
title(sprintf("phase plot for L = %d", L))

% calculate the magnitdue and phase response at
% 0, 0.1pi, 0.25pi, 0.4pi, 500pi, 750pi
array = [0, 100, 250, 400, 500, 750];

for i = array
    % print the response
    fprintf("mag = %f and phase = %f at w = 0.%dpi\n", abs(HH(1000+i)), ...
        angle(HH(1000+i)), i);
end

% the pass band in the number of elements above 0.5 times the spacing
% (pi/1000)
pass = nnz(abs(HH) > 0.5) / 2;
% print the result
fprintf("pass band is %f radians for L = %d\n", pass * pi/1000, L);
end
