%Išmokti savarankiškai suprogramuoti paprasto netiesinio aproksimatoriaus, grįsto Spindulio tipo bazinių funkcijų tinklu, mokymo (parametrų skaičiavimo) algoritmą.
clear all
clc
%duota
x = 0.1:1/22:1;
y_d = ((1 + 0.6*sin(2*pi*x/0.7)) + 0.3*sin(2*pi*x))/2;
%  F = exp(-(x-c)^2/(2*r^2))); gauso aktyvavimo funkcija

% Sugeneruojami svoriai
w0 = randn(1);
w1 = randn(1);
w2 = randn(1);

c1 = 0.20; %parinkta apytiksliai pagal maksimalias funkcijos reikšmes žiūrint į grafiką x ašyje
c2 = 0.90; %parinkta apytiksliai pagal maksimalias funkcijos reikšmes žiūrint į grafiką x ašyje
r1 = 0.16;
r2 = 0.16;

eta = 0.15; % Mokymosi žingsnis

% Mokomas neuroninis tinklas 100 kartų
for k = 1:100
    % mokomas kiekvienas taškas
    for n = 1:20
        % Neuronu gauso aktyvavimo funkcijos
        F1 = exp(-((x(n) - c1)^2) / (2 * (r1^2)));
        F2 = exp(-((x(n) - c2)^2) / (2 * (r2^2)));
        % Išvestis
        y(n) = F1 * w1 + F2 * w2 + 1 * w0;  % (m(gauso aktyvavimo funkcijos)+1)=3; pagal formule is vadovelio
        % Apskaičiuojama klaida
        e = y_d(n) - y(n) 
        % Atnaujinami svoriai
        w1 = w1 + eta * e * F1; % isvesties funkcijos svoriai. 
        w2 = w2 + eta * e * F2;
        w0 = w0 + eta * e; % pirmame LD buvo bias, bet uzduotyje nurodyta naudoti W0
    end
end
 
%sukuriamos naujos x vertes testavimui
x_n = 0.1:1/22:1;
for i = 1:length(x_n)
    F1_n = exp(-((x_n(i) - c1)^2) / (2 * (r1^2)));
    F2_n = exp(-((x_n(i) - c2)^2) / (2 * (r2^2)));
    y_n(i) = F1_n * w1 + F2_n * w2 + w0;
end

% apmokyto tinklo grafikas
figure(1);
plot(x, y_d, 'b', 'DisplayName', 'Desired Output');
hold on;
plot(x_n, y_n, 'r', 'DisplayName', 'Network Output');
hold off;
grid on;
legend;
xlabel('x');
ylabel('y');
title('Desired Output vs Network Output');