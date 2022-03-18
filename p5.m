close all
clear
% 5 filters
idx = 1:5;
% the lower normalized radial frequency of the octave
lowRad = ones(length(idx), 1);
% the lowest octave starts at key 16   
% Key 49 is 440 Hz, so 440*2^((16-49)/12) is the frequency of key 16
lowRad(1) = 440*2^((16-49)/12) / 8000 * 2 * pi;
for k = 2:5
    % each octave is double the previous
    lowRad(k) = lowRad(k-1) * 2;
end
% the high end of the octave is double the low
highRad = 2.*lowRad;
% the center point of the octave 
centerRad  = (lowRad + highRad) ./ 2;
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

% number of points in xx
N = 0.85*8000;
% x(t)
xx = zeros(N,1);
% t
t = zeros(N,1);
for i = 1:N
    t(i) = i/8000;
end
% first segment goes to 0.25 seconds
for i = 1:round(0.25*8000)
    % formula for first segment
    xx(i) = cos(2*pi*220*i / 8000);
end
% zero in between
for i = round(0.25*8000) + 1:round(0.30*8000)
    xx(i) = 0;
end
% second segment goes from 0.30 to 0.55
for i = round(0.30*8000) + 1:round(0.55*8000)
    % formula for second segment
    xx(i) = cos(2*pi*880*i / 8000);
end
% zero in between
for i = round(0.55*8000) + 1:round(0.60*8000)
    xx(i) = 0;
end
% third segment goes from 0.60 to 0.85
for i = round(0.60*8000) + 1:round(0.85*8000)
    % formula for third segment
    xx(i) = cos(2*pi*440*i / 8000) + cos(2*pi*1760*i / 8000);
end
% matrix of outputs
output = zeros(length(xx), length(windows));
figure
for i = idx
    % calculate output using convolution
    yy = conv(windows{i}, xx);
    % cut off the first L elements of the convolution
    output(:, i) = yy(round(L(i)):end);
    subplot(7,1,i);
    % plot the output
    plot(t, abs(output(:,i)));
    ylim([0,1])
end