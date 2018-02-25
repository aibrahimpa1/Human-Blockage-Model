function [ prob, history ] = Motion_simulation( W,L,N_pedestrians, N_steps, antenna )

% height of device
Hd = 1.5;

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

% Normalize the probablity
prob = prob/N_steps;

end

