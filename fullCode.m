%   Parameters
% Maximum passband ripple = 0.1 dB
% Minimum stopband attenuation = 58 dB
% Lower passband edge = 1100 rad/s
% Upper passband edge = 1600 rad/s
% Lower stopband edge = 800 rad/s
% Upper stopband edge = 1800 rad/s
% Sampling frequency = 4400 rad/s




% FIR Filter

fsamp = 4400/(2*pi);
fcuts = [800/(2*pi) 1100/(2*pi) 1600/(2*pi) 1800/(2*pi)];
mags = [0 1 0];
devs = [10^(-58/20) 10^(0.1/20) 10^(-58/20)];
[n,Wn,beta,ftype] = kaiserord(fcuts,mags,devs,fsamp);
n = n + rem(n,2)
hh = fir1(n,Wn,ftype,kaiser(n+1,beta),'noscale');
%impz(hh,1)
[H,w] = freqz(hh,1);
Hdb=20*log10(abs(H));
figure;
plot([flip(-w); w], [flip(Hdb); Hdb])
xlabel('frequency (rad/sample)')
ylabel('Magnitude (dB)')
title('Magnitude response')
ax = gca;
ax.YLim = [-200 20];
ax.XLim = [-pi pi];
grid on;
grid minor;
figure;
plot(w, Hdb);
xlabel('frequency (rad/sample)')
ylabel('Magnitude (dB)')
title('Magnitude response in passband')
ax = gca;
ax.YLim = [-0.2 0.2];
ax.XLim = [1100*T 1600*T];
grid on;
grid minor;



% IIR Filter

T=2*pi/4400;
Wp=2*tan([1100 1600]*T/2)/T;
Ws=2*tan([800 1800]*T/2)/T;
[N,W] = ellipord(Wp, Ws , 0.1, 58,"s")
[num,den] = ellip(N,0.1,58,W,"bandpass","s");
[zd,pd]=bilinear(num,den,1/T);
%freqz([zd,zp])
[H,w]=freqz(zd,pd);
Hdb=20*log10(abs(H));
figure;
plot([flip(-w); w], [flip(Hdb); Hdb])
xlabel('frequency (rad/sample)')
ylabel('Magnitude (dB)')
title('Magnitude response')
ax = gca;
ax.YLim = [-200 20];
ax.XLim = [-pi pi];
grid on;
grid minor;
figure;
plot(w, Hdb);
xlabel('frequency (rad/sample)')
ylabel('Magnitude (dB)')
title('Magnitude response in passband')
ax = gca;
ax.YLim = [-0.2 0.2];
ax.XLim = [1100*T 1600*T];
grid on;
grid minor;
