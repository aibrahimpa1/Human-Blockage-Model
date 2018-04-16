function [ probability, history ] = Motion_simulation( W,L,N_pedestrians, N_steps, antenna )

% height of device
Hd = 1.5;

% create device object and put it in lower left corner (1, 1) 
device = Device(1, 1, Hd);

% create pedestrian objects
for i=1:N_pedestrians
    pedestrian_array(i) = Pedestrian(W,L);
end

% matrix of position of pedestrians at all times steps
history = zeros(N_steps, N_pedestrians, 3);

prob = zeros(W,L);

for k = 1:length(antenna)
    probability{k} = prob;
end

for i=1:N_steps
    fprintf('\nStep %i', i);
    for j=1:N_pedestrians
        %check for collision with previously moved pedestrians
        condition = true;
        while condition
            pedestrian_array(j).Walk();
            condition = false;
            for k=1:j-1    
                x1 = pedestrian_array(j).x;
                y1 = pedestrian_array(j).y;
                r1 = pedestrian_array(j).r;
                x2 = pedestrian_array(k).x;
                y2 = pedestrian_array(k).y;
                r2 = pedestrian_array(k).r;

               if norm([x1-x2, y1-y2]) < r1+r2
                    condition = true;
               end
            end
        end
        history(i,j,1) = pedestrian_array(j).x;
        history(i,j,2) = pedestrian_array(j).y;
        history(i,j,3) = pedestrian_array(j).r;
    end
    for k=1:W
        for h=1:L
            for index=1:N_pedestrians
                for ant=1:length(antenna)
                    pedestrian = pedestrian_array(index);
                    device.xd = k;
                    device.yd = h;
                    blocked = BlockCheck3D(antenna(ant), pedestrian, device);
                    if(blocked==true)
                        probability{ant}(k,h) = probability{ant}(k,h) + 1/N_steps;
                        break;
                    end
                end
            end
        end
    end
end
end

