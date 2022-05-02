close

%file = "sweep.wav";
%file = "chromatic.wav";
file = "compressed fourths.wav";
%file = "tritones.wav";
%file = "triads.wav";

window = 10;
gain = 10;
cutoff = 0.5;
yrange = 0.5;

afr = dsp.AudioFileReader(file,"SamplesPerFrame",4096);
adw = audioDeviceWriter('SampleRate', afr.SampleRate);
rate = afr.SampleRate;

octaves = 7;

lowFreq = arrayfun(@noteToHz, 24:12:108);
lowRad = 2 * pi * lowFreq /rate;

highFreq = arrayfun(@noteToHz, (36:12:120) - 0.5);
highRad = 2 * pi * highFreq /rate;

%centerFreq = arrayfun(@noteToHz, (30:12:114))
%centerRad = 2 * pi * centerFreq / rate;
%centerRad = (highRad - lowRad)/2 + lowRad;
centerRad = sqrt(lowRad .* highRad);

% The BWL ratio is used to calculate L according to L = BWL / Bandwidth
BWL = 0.141372 * 81;
L = BWL ./ (highRad - lowRad);

% hamming windows, each will be of different lengths
windows = cell(octaves,1);
for i=1:octaves
    % calculate the window using wc and L
    windows{i} = gen_hamming(centerRad(i),round(L(i)));
end
figure;
ylim([0,0.1]);

buff = dsp.AsyncBuffer;

while ~isDone(afr)
    d = afr();
    adw(d);
    buff.write(d);
    data = buff.peek();
    result = zeros(octaves,2);
    for i=1:octaves
       left = conv(data(:,1)*gain, windows{i});
       leftt = left(round(L(i)):end);
       result(i,1) = nnz(leftt > cutoff) / length(leftt);
       right = conv(data(:,2)*gain, windows{i});
       rightt = right(round(L(i)):end);
       result(i,2) = nnz(rightt > cutoff) / length(rightt);
    end
    bar(result);
    ylim([0 yrange]);
    drawnow;
    if (buff.NumUnreadSamples > window*afr.SamplesPerFrame)
        buff.read(afr.SamplesPerFrame);
    end
end

close;
release(afr);
release(adw);

function hz = noteToHz(n)
hz = 440*2^((n-49)/12);
end
