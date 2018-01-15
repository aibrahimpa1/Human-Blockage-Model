function PlotHistory(history, W, L, N_steps, N_pedestrians)
figure, clf,
hold on, grid on
axis([1, W, 1, L]);
Xa = floor((W+1)/2);
Ya = floor((L+1)/2);
for i=1:N_steps
    pause(0.05)
    clf,
    hold on, grid on
    axis([1, W, 1, L]);
    % Plot antenna
    plot(Xa, Ya, 'X') 
    % Plot Pedestrians
    for j=1:N_pedestrians
        viscircles([history(i,j,1), history(i,j,2)], history(i,j,3));
    end
end
end

