clear, close all

% dimensions of surface
W = 200;
L = 200;

% Number of pedestrians
N_pedestrians = [10,20,50];

% Number of time steps
N_steps = 20;

% parameters of antenna
Xa = floor((W+1)/2);
Ya = floor((L+1)/2);
Ha = 3;

% create antenna object
antenna = Antenna(Xa, Ya, Ha);

Probablities = {};
Histories = {};

for i=1:3
    [Probablities{i}, Histories{i}] = Motion_simulation(W,L,N_pedestrians(i), N_steps, antenna);

    % Plot movement of pedestrians
    PlotHistory(Histories{i}, W, L, N_steps, N_pedestrians(i));

    % Transform the probablity distribution
    [distances, distprob] = ProbXY2R(antenna, Probablities{i}, W, L);

    % Calculate attenuation
    Attenuation = abs(1 - distprob);

    % Log of attentuation for estimating alpha
    LogAtt = log(Attenuation);

    % Estimating alpha
    %alpha = polyfit(distances, LogAtt, 1);
    alpha(i) = (distances.')\(LogAtt.');
end

% Plot the probablity distribution
figure, clf
subplot(2,2,1)
[X, Y] = meshgrid(1:W,1:L);
h = surf(X, Y, Probablities{1});
set(h,'LineStyle','none')
subplot(2,2,2)
h = surf(X, Y, Probablities{2});
set(h,'LineStyle','none')
subplot(2,2,3)
h = surf(X, Y, Probablities{3});
set(h,'LineStyle','none')

% Estimating Attenuation using the estimated alpha value
figure, clf
subplot(2,2,1)
AttEstimate = exp(alpha(1)*distances);
plot(distances, AttEstimate)
grid on
xlabel('Distance to Antenna')
ylabel('Attenuation')
title('Silent Case')
subplot(2,2,2)
AttEstimate = exp(alpha(2)*distances);
plot(distances, AttEstimate)
grid on
xlabel('Distance to Antenna')
ylabel('Attenuation')
title('Busy Case')
subplot(2,2,3)
AttEstimate = exp(alpha(3)*distances);
plot(distances, AttEstimate)
grid on
xlabel('Distance to Antenna')
ylabel('Attenuation')
title('Crowded Case')