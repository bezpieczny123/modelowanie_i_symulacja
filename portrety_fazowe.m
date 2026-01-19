clear;
close all;

% Ustawienia początkowe
ksi = 1.1;
omega = 2;
x10 = 0;
x20 = 0;
skok = 1;
czas_skoku = 10;
czas = 20;

% --- Wykres 1: Przebieg czasowy ---
out = sim('faza.slx', czas);
fig1 = figure; hold on; grid on;
plot(out.tout, out.simout, 'LineWidth', 1.5);
xlabel("Czas [s]")
ylabel("Sygnał wyjściowy")
title(["Odpowiedź skokowa", "ksi = " + string(ksi)])

% Ustawienia dla portretów fazowych
skok = 0;
tabx10 = [-2, -3, -4, -5, 6, 7, 8 ,9];
tabx20 = [9, 8, -7, -5, -4, -3, 2 ,1];
% Zakres widoczności dla portretów (dostosowany do warunków początkowych)
view_limit = 12; 

% --- Wykres 2: Stabilny (a) ---
czas = 10;
fig2 = figure; hold on; grid on;
title("a) Portret fazowy (ksi = " + string(ksi) + ")")
xlabel("x_1"); ylabel("x_2");

for i = 1:length(tabx10)
    x10 = tabx10(i);
    x20 = tabx20(i);
    out = sim('faza.slx', czas);
    plot(out.simout, out.simout1);
end

% --- Wykres 3: Stabilny (b) ---
fig3 = figure; hold on; grid on;
ksi = .5;
title("b) Portret fazowy (ksi = " + string(ksi) + ")")
xlabel("x_1"); ylabel("x_2");

for i = 1:length(tabx10)
    x10 = tabx10(i);
    x20 = tabx20(i);
    out = sim('faza.slx', czas);
    plot(out.simout, out.simout1);
end

% --- Wykres 4: Granica stabilności (c) ---
fig4 = figure; hold on; grid on;
ksi = 0;
title("c) Portret fazowy (ksi = " + string(ksi) + ")")
xlabel("x_1"); ylabel("x_2");

for i = 1:length(tabx10)
    x10 = tabx10(i);
    x20 = tabx20(i);
    out = sim('faza.slx', czas);
    plot(out.simout, out.simout1);
end

% --- Wykres 5: Niestabilny (d) ---
czas = 1.5;
fig5 = figure; hold on; grid on;
ksi = -.5;
title("d) Portret fazowy (ksi = " + string(ksi) + ")")
xlabel("x_1"); ylabel("x_2");

for i = 1:length(tabx10)
    x10 = tabx10(i);
    x20 = tabx20(i);
    out = sim('faza.slx', czas);
    plot(out.simout, out.simout1);
end

xlim([-view_limit view_limit]);
ylim([-view_limit view_limit]);


% --- Wykres 6: Bardzo niestabilny (e) ---
czas = 1; 
fig6 = figure; hold on; grid on;
ksi = -5;
title("e) Portret fazowy (ksi = " + string(ksi) + ")")
xlabel("x_1"); ylabel("x_2");

for i = 1:length(tabx10)
    x10 = tabx10(i);
    x20 = tabx20(i);
    out = sim('faza.slx', czas);
    plot(out.simout, out.simout1);
end

xlim([-view_limit view_limit]);
ylim([-view_limit view_limit]);