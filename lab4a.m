clc 
clear
close all


L = [20 40 80];             % Window length setup
W = 0.4*pi;                 % Center frequency definition

h_20 = BPF(L(1),W);         % Band Pass filter with the length of 20
h_40 = BPF(L(2),W);         % Band Pass filter with the length of 40
h_80 = BPF(L(3),W);         % Band Pass filter with the length of 80

WW = -pi:(pi/1000):pi;      % frequency range 

HH_40 = freqz(h_40,1,WW);
HH_20 = freqz(h_20,1,WW);
HH_80 = freqz(h_80,1,WW);

PB_40 = zeros(size(HH_40));


% finding the -3dB frequency of the Band pass filter based on Magnitude
% value of the Band pass filter output for 


% L =20
for i=1:length(HH_20)
    if abs(HH_20(i)) >= 0.5
        PB_20(i) = abs(HH_20(i));
    else
        PB_20(i) = 0;
    end
end

% L = 40
for i=1:length(HH_40)
    if abs(HH_40(i)) >= 0.5
        PB_40(i) = abs(HH_40(i));
    else
        PB_40(i) = 0;
    end
end

% L = 80
for i=1:length(HH_80)
    if abs(HH_80(i)) >= 0.5
        PB_80(i) = abs(HH_80(i));
    else
        PB_80(i) = 0;
    end
end

NUmnz_20 = nnz(PB_20)/2;    % non zero element of PB vector for L = 20
NUmnz_40 = nnz(PB_40)/2;    % non zero element of PB vector for L = 40
NUmnz_80 = nnz(PB_80)/2;    % non zero element of PB vector for L = 80

figure;
plot(WW,abs(HH_40),'k')
hold on
plot(WW,PB_40,'g-*')
plot(WW,PB_80,'r-o')
plot(WW,PB_20,'b-^')
title('Magnitude response of the Band Pass Filter')
xlabel('\omega')
ylabel('Phase value')
legend('Output response pf filter','40','80','20')

figure;
plot(WW,angle(HH_20),'b-^')
hold on
plot(WW,angle(HH_40),'g-*')
plot(WW,angle(HH_80),'r-o')
title('Phase response of the Band Pass Filter')
xlabel('\omega')
ylabel('Phase value')
legend('40','20','80')



