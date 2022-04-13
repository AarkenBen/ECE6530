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
% low end frequencies in Hertz
lowHertz = lowRad / 2 / pi;
% high end frequencies in Hertz
highHertz = highRad / 2 / pi;
% the center point of the octave 
centerRad  = (lowRad + highRad) ./ 2;
% the center in Hertz
centerHertz = centerRad / 2 / pi;