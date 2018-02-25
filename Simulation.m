clear, close all

% dimensions of surface
W = 100;
L = 100;

% Number of pedestrians
N_pedestrians = [10,20,50];

% Number of time steps
N_steps = 10;

% parameters of antenna
Xa = floor((W+1)/2);
Ya = floor((L+1)/2);
Ha = 3;

% create antenna object
antenna = Antenna(Xa, Ya, Ha);

[prob, history] = Motion_simulation(W,L,N_pedestrians(1), N_steps, antenna);


% Plot movement of pedestrians
PlotHistory(history, W, L, N_steps, N_pedestrians);

% Plot the probablity distribution
figure, clf
[X, Y] = meshgrid(1:W,1:L);
h = surf(X, Y, prob);
set(h,'LineStyle','none')

% Transform the probablity distribution
[distances, distprob] = ProbXY2R(antenna, prob, W, L);

% Calculate attenuation
Attenuation = 1 - distprob;

% Log of attentuation for estimating alpha
LogAtt = log(Attenuation);

% Estimating alpha
%alpha = polyfit(distances, LogAtt, 1);
alpha = (distances.')\(LogAtt.');

% Estimating Attenuation using the estimated alpha value
AttEstimate = exp(alpha*distances);

figure, clf
plot(distances, AttEstimate)
grid on
xlabel('Distance to Antenna')
ylabel('Attenuation')
