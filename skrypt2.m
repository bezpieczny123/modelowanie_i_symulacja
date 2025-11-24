clear;
close all;

TzewN=-20;
TkzN=30;
Tw1N=20;
Tw2N=15;


PkN=10000;

Pwm=50; % powierchnia mieszkania

b=.5; % proporcja pokoi

Vw1=2.5*b*Pwm;
Vw2=2.5*b*Pwm;

cp=1000; % powietrze J/kg*K
pp=1.2; %

a=0.6;

fpN=PkN/(cp*pp*(TkzN-Tw1N))
Ks1=a*PkN/(Tw1N-TzewN);
K0=(1-a)*PkN/(Tw1N-Tw2N);

Ks2=(K0*(Tw1N-Tw2N))/(Tw2N-TzewN);

%x=cp*pp*fpN*(TkzN-Tw1N)-Ks1*(Tw1N-TzewN)-K0*(Tw1N-Tw2N);
%x2=K0(Tw1N-Tw2N)-Ks2*(Tw2N-TzewN)
%x==x2

A=cp*pp*fpN;
%Tw1_r = ((cp*pp*fpN*TkzN+Ks1*TzewN)*(K0+Ks2)-Ks2*TzewN*K0) / (cp*pp*fpN*(K0+Ks2)+Ks1*(K0+Ks2)+K0*Ks2)
%Tw1_r = (A * TkzN + Ks1 * TzewN + K0 * Tw) / (A + K_s1 + K_0)
%Tw2_r = (K0*Tw1_r + Ks2*TzewN) / (K0+Ks2)


Tw1c = ((A*TkzN + Ks1*TzewN)*(K0 + Ks2) + K0*Ks2*TzewN) / ((A + Ks1 + K0)*(K0 + Ks2) - K0^2);
Tw2c = ((A + Ks1 + K0)*Ks2*TzewN + K0*(A*TkzN + Ks1*TzewN)) / ((A + Ks1 + K0)*(K0 + Ks2) - K0^2);

czas = 2000;
step_time = 400;

Cv1 = cp*pp*Vw1;
Cv2 = cp*pp*Vw2;

przy_zew = 2;
przy_kz = 0;
przyFp0 = 0; %0.7 * fpN;


tab_Tzew = [-20, -20+10, -20, -20];
tab_tk = [30, 30, 20, 30];
tab_Fp0 = [fpN, fpN, fpN, fpN*0.7];

fig3 = figure; hold on; grid on;
fig4 = figure; hold on; grid on;
figdelta3 = figure; hold on; grid on;
figdelta4 = figure; hold on; grid on;

legend_entries = cell(1, length(tab_Tzew));

for i = 1:length(tab_Tzew)
    Tzew0 = tab_Tzew(i);
    Tkz0 = tab_tk(i);
    Fp0  = tab_Fp0(i);

    legend_entries{i} = sprintf('Tzew=%g, Tkz=%g, Fp=%g', Tzew0, Tkz0, Fp0);

    A = cp*pp*Fp0;

    Tw1c = ((A*Tkz0 + Ks1*Tzew0)*(K0 + Ks2) + K0*Ks2*Tzew0) / ((A + Ks1 + K0)*(K0 + Ks2) - K0^2)
    Tw2c = ((A + Ks1 + K0)*Ks2*Tzew0 + K0*(A*Tkz0 + Ks1*Tzew0)) / ((A + Ks1 + K0)*(K0 + Ks2) - K0^2)

    out = sim('symulacja_sadowski.slx', czas);

    fprintf('Tzew=%g, Tkz=%g, Fp=%g -> Tw1* = %.4f, Tw2* = %.4f\n', ...
        Tzew0, Tkz0, Fp0, Tw1c, Tw2c);

    figure(fig3);
    plot(out.tout, out.tw1);

    figure(figdelta3);
    plot(out.tout, out.tw1 - out.tw1(1));

    figure(fig4);
    plot(out.tout, out.tw2);

    figure(figdelta4);
    plot(out.tout, out.tw2 - out.tw2(1));
end


pos = [100, 100, 1200, 900];

figure(fig3);
legend(legend_entries, 'Location', 'best'); title('Twew1'); xlabel('Czas'); ylabel('Temperatura');
set(fig3, 'Color', 'w', 'Position', pos); drawnow;
imwrite(getframe(fig3).cdata, 'bez_Twew1.png');

figure(figdelta3);
legend(legend_entries, 'Location', 'best'); title('\Delta Twew1'); xlabel('Czas'); ylabel('Temperatura');
set(figdelta3, 'Color', 'w', 'Position', pos); drawnow;
imwrite(getframe(figdelta3).cdata, 'bez_Delta_Twew1.png');

figure(fig4);
legend(legend_entries, 'Location', 'best'); title('Twew2'); xlabel('Czas'); ylabel('Temperatura');
set(fig4, 'Color', 'w', 'Position', pos); drawnow;
imwrite(getframe(fig4).cdata, 'bez_Twew2.png');

figure(figdelta4);
legend(legend_entries, 'Location', 'best'); title('\Delta Twew2'); xlabel('Czas'); ylabel('Temperatura');
set(figdelta4, 'Color', 'w', 'Position', pos); drawnow;
imwrite(getframe(figdelta4).cdata, 'bez_Delta_Twew2.png');
