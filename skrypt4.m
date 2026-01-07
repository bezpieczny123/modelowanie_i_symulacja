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

czas = 1000;
step_time = 100;

Cv1 = cp*pp*Vw1;
Cv2 = cp*pp*Vw2;

przy_zew = 5;
przy_kz = 1;
przyFp0 = 0; %0.7 * fpN;

fig4 = figure; hold on; grid on;

Tzew0 = TzewN;
Tkz0 = TkzN
Fp0  = fpN

A = cp*pp*Fp0;

Tw1c = ((A*Tkz0 + Ks1*Tzew0)*(K0 + Ks2) + K0*Ks2*Tzew0) / ((A + Ks1 + K0)*(K0 + Ks2) - K0^2)
Tw2c = ((A + Ks1 + K0)*Ks2*Tzew0 + K0*(A*Tkz0 + Ks1*Tzew0)) / ((A + Ks1 + K0)*(K0 + Ks2) - K0^2)

out = sim('symulacja_sadowski.slx', czas);

fprintf('Tzew=%g, Tkz=%g, Fp=%g -> Tw1* = %.4f, Tw2* = %.4f\n', ...
    Tzew0, Tkz0, Fp0, Tw1c, Tw2c);

xtick = linspace(0,500,51);

t1=16
t2=150

tau = t1/t2


t_0 = 13
%T = czas - 250
T = 247

delta_x = max(out.tw2) - min(out.tw2)

delta_u = 1
%delta_y=1
k = delta_x / delta_u
%k=0.0241

kp = 0.9*T/(k*t_0)
ti = 3.33*t_0

sp0=15
przy_sp=5

out2 = sim('symulacja3.slx', czas);

figure(fig4);
plot(out2.tout, out2.tw2);
xlabel("Czas [s]")
ylabel("Temperatura [°C]")
title("Regulator PI dla obiektu")

fig6 = figure; hold on; grid on;
figure(fig6);
plot(out2.tout, out2.reg);
xlabel("Czas [s]")
ylabel("Sterowanie")
title("Sygnał sterowania regulatora PI")


fig5 = figure; hold on; grid on;

out3 = sim('symulacja4.slx', czas);

figure(fig5);
plot(out3.tout, out3.tw3);
xlabel("Czas [s]")
ylabel("Temperatura [°C]")
title("Regulator PI dla modelu")