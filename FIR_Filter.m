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
