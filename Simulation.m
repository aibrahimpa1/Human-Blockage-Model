clear, close all

W = 100;
L = 100;

Xa = floor((W+1)/2);
Ya = floor((L+1)/2);

N_steps = 20;
N_pedestrians = 10;

for i=1:N_pedestrians
    pedestrian_array(i) = Pedestrian(W,L);
end

% matrix of position of pedestrians at all times steps
history=zeros(N_steps, N_pedestrians, 3);

prob=zeros(W,L);

%figure, clf,
%hold on, grid on
%axis([0,W, 0, L]);

for i=1:N_steps
    fprintf('\nStep %i', i);
    %pause(0.01)
    %clf,
    %hold on, grid on
    %axis([0,W, 0, L]);
    %plot(Xa, Ya, 'X')
    for j=1:N_pedestrians
        %plot(pedestrian_array(j).x, pedestrian_array(j).y, 'o')
        %viscircles([pedestrian_array(j).x, pedestrian_array(j).y], pedestrian_array(j).r)
        pedestrian_array(j).Walk();
        history(i,j,1) = pedestrian_array(j).x;
        history(i,j,2) = pedestrian_array(j).y;
        history(i,j,3) = pedestrian_array(j).r;
    end
    for k=1:W
        for h=1:L
            for index=1:N_pedestrians
                Xp = pedestrian_array(index).x;
                Yp = pedestrian_array(index).y;
                Xr = k;
                Yr = h;
                blocked = BlockCheck2D(Xa, Ya, Xp, Yp, Xr, Yr, pedestrian_array(index).r);
                if(blocked==true)
                    prob(k,h) = prob(k,h) + 1;
                    break;
                end
            end
        end
    end
end

PlotHistory(history, W, L, N_steps, N_pedestrians);

prob = prob/N_steps;

figure, clf
[X, Y] = meshgrid(1:W,1:L);
h = surf(X, Y, prob);
set(h,'LineStyle','none')