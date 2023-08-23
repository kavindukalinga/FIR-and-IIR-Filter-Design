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

