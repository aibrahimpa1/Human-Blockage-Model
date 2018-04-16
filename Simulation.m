clear, close all

% dimensions of surface
W = 200;
L = 200;

% Number of pedestrians
N_pedestrians = [10,20,50];

% Number of time steps
N_steps = 10;

% parameters of antennas
Xa = [0, W-1, W-1, 0  ];
Ya = [0, 0  , L-1, L-1];
Ha = 3;


% create antenna objects
for i=1:4
    antenna(i)= Antenna(Xa(i), Ya(i), Ha);
end
Probabilities = {};
Histories = {};

for i=1:3
    [Probabilities{i}, Histories{i}] = Motion_simulation(W,L,N_pedestrians(i), N_steps, antenna);

    % Plot movement of pedestrians
    PlotHistory(Histories{i}, W, L, N_steps, N_pedestrians(i));

    for j=1:length(Probabilities{i})
        % Transform the probablity distribution
        [distances, distprob] = ProbXY2R(antenna(j), Probabilities{i}{j}, W, L);

        % Calculate attenuation
        Attenuation = abs(1 - distprob);

        % Log of attentuation for estimating alpha
        LogAtt = log(Attenuation);

        % Estimating alpha
        %alpha = polyfit(distances, LogAtt, 1);
        alpha(i, j) = (distances.')\(LogAtt.');
    end
end

% Plot the probablity distribution
figure, clf
subplot(2,2,1)
[X, Y] = meshgrid(1:W,1:L);
h = surf(X, Y, Probabilities{1}{1} + Probabilities{1}{2} + Probabilities{1}{3} + Probabilities{1}{4});
set(h,'LineStyle','none')
subplot(2,2,2)
h = surf(X, Y, Probabilities{2}{1} + Probabilities{2}{2} + Probabilities{2}{3} + Probabilities{2}{4});
set(h,'LineStyle','none')
subplot(2,2,3)
h = surf(X, Y, Probabilities{3}{1} + Probabilities{3}{2} + Probabilities{3}{3} + Probabilities{3}{4});
set(h,'LineStyle','none')

% Estimating Attenuation using the estimated alpha value
figure, clf
subplot(2,2,1)
AttEstimate = exp(sum(alpha(1))*distances);
plot(distances, AttEstimate)
grid on
xlabel('Distance to Antenna')
ylabel('Attenuation')
title('Silent Case')
subplot(2,2,2)
AttEstimate = exp(sum(alpha(2))*distances);
plot(distances, AttEstimate)
grid on
xlabel('Distance to Antenna')
ylabel('Attenuation')
title('Busy Case')
subplot(2,2,3)
AttEstimate = exp(sum(alpha(3))*distances);
plot(distances, AttEstimate)
grid on
xlabel('Distance to Antenna')
ylabel('Attenuation')
title('Crowded Case')