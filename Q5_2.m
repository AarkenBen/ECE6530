% run script from part 5.1
Q5_1

% The BWL ratio is used to calculate L according to L = BWL / Bandwidth
BWL = 0.141372 * 81;
% x axis in our plots
ww = 0:(pi/1000):pi;
% calculate L for filters
L = BWL ./ (highRad - lowRad);
% hamming windows, each will be of different lengths
windows = cell(length(idx),1);
figure
hold on
for i = idx
    % calculate the window using wc and L
    windows{i} = gen_hamming(centerRad(i),round(L(i)));
    % calculate magnitude and phase response of h
    HH = freqz(windows{i}, 1, ww);
    % normalize the coefficients such that the max is 1
    windows{i} = windows{i} ./ max(HH);
    % recalculate HH using normalized coefficients
    HH = freqz(windows{i}, 1, ww);
    % plot magnitude, use ww / 2 / pi * 8000 for frequency on x axis
    plot(ww / 2 / pi * 8000, abs(HH));
end
plot(centerHertz * 8000, ones(i, 1), 'o');
hold off