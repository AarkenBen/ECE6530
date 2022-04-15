% run previous sections
Q5_2

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
    subplot(length(idx),1,i);
    % plot the output
    plot(t, abs(output(:,i)));
    ylim([0,1])
end
sgtitle('Magnitude')

% matrix of outputs
output = zeros(length(xx), length(windows));
figure

for i = idx
    % calculate output using convolution
    yy = conv(windows{i}, xx);
    % cut off the first L elements of the convolution
    output(:, i) = yy(round(L(i)):end);
    subplot(length(idx),1,i);
    % plot the output
    plot(t, angle(output(:,i)));
    ylim([0,1])
end
sgtitle('Phase')