clear, close all

% dimensions of surface
W = 100;
L = 100;

% parameters of antenna
Xa = floor((W+1)/2);
Ya = floor((L+1)/2);
Ha = 3;

% height of device
Hd = 1.5;

% Number of time steps
N_steps = 50;

% Number of pedestrians
N_pedestrians = 10;

% create antenna object
antenna = Antenna(Xa, Ya, Ha);

% create device object and put it in lower left corner (1, 1) 
device = Device(1, 1, Hd);

% create pedestrian objects
for i=1:N_pedestrians
    pedestrian_array(i) = Pedestrian(W,L);
end

% matrix of position of pedestrians at all times steps
history=zeros(N_steps, N_pedestrians, 3);

prob=zeros(W,L);

for i=1:N_steps
    fprintf('\nStep %i', i);
    for j=1:N_pedestrians
        pedestrian_array(j).Walk();
        history(i,j,1) = pedestrian_array(j).x;
        history(i,j,2) = pedestrian_array(j).y;
        history(i,j,3) = pedestrian_array(j).r;
    end
    for k=1:W
        for h=1:L
            for index=1:N_pedestrians
                pedestrian = pedestrian_array(index);
                device.xd = k;
                device.yd = h;
                blocked = BlockCheck3D(antenna, pedestrian, device);
                if(blocked==true)
                    prob(k,h) = prob(k,h) + 1;
                    break;
                end
            end
        end
    end
end

% Plot movement of pedestrians
PlotHistory(history, W, L, N_steps, N_pedestrians);

% Normalize the probablity
prob = prob/N_steps;

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
alpha = polyfit(distances, LogAtt, 1);

% Estimating Attenuation using the estimated alpha value
AttEstimate = exp(alpha(2)*distances);
