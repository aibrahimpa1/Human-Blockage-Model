clear, close all

% dimensions of surface
W = 200;
L = 200;

% Number of pedestrians
N_pedestrians = [10,20,50];

% Number of time steps
N_steps = 200;

% parameters of antennas
Xa = [0, W-1, W-1, 0  ];
Ya = [0, 0  , L-1, L-1];
Ha = 3;


% create antenna objects
for i=1:4
    antenna(i)= Antenna(Xa(i), Ya(i), Ha);
end

ProbabilitiesXY = {};
ProbabilitiesR = {};
Histories = {};

for i=1:3 % i is the index for the case: low, average, high (crowded)
    [ProbabilitiesXY{i}{1}, Histories{i}] = Motion_simulation(W,L,N_pedestrians(i), N_steps, antenna(1));

    % Plot movement of pedestrians
    %PlotHistory(Histories{i}, W, L, N_steps, N_pedestrians(i));

    % Compute blockage probability for other antennas
    for j=2:length(antenna)
        if (Xa(j) ~= Xa(1)) & (Ya(j) ~= Ya(1))
            ProbabilitiesXY{i}{j} = flip(flip(ProbabilitiesXY{i}{1}, 1), 2);
        else if (Xa(j) ~= Xa(1)) 
            ProbabilitiesXY{i}{j} = flip(ProbabilitiesXY{i}{1}, 1);
        else (Ya(j) ~= Ya(1))
            ProbabilitiesXY{i}{j} = flip(ProbabilitiesXY{i}{1}, 2);
            end 
     end
    end
    % Transform the probablity distribution
    for k=1:length(antenna)
        [distances, ProbabilitiesR{k}] = ProbXY2R(antenna(1), ProbabilitiesXY{i}{k}, W, L);
    end
    
    % Calculate attenuation
    Attenuation = 1.0;
    Attenuation = Attenuation .* ProbabilitiesR{1};
       
    Attenuation = abs(1 - Attenuation);

    % Log of attentuation for estimating alpha
    LogAtt = log(Attenuation);

    % Estimating alpha
    alpha(i) = (distances.')\(LogAtt.');

end

% Plot the probablity distribution
figure, clf
subplot(2,2,1)
[X, Y] = meshgrid(1:W,1:L);
h = surf(X, Y, ProbabilitiesXY{1}{1} .* ProbabilitiesXY{1}{2} .* ProbabilitiesXY{1}{3} .* ProbabilitiesXY{1}{4});
set(h,'LineStyle','none')
subplot(2,2,2)
h = surf(X, Y, ProbabilitiesXY{2}{1} .* ProbabilitiesXY{2}{2} .* ProbabilitiesXY{2}{3} .* ProbabilitiesXY{2}{4});
set(h,'LineStyle','none')
subplot(2,2,3)
h = surf(X, Y, ProbabilitiesXY{3}{1} .* ProbabilitiesXY{3}{2} .* ProbabilitiesXY{3}{3} .* ProbabilitiesXY{3}{4});
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