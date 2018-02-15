function [distances, distprob] = ProbXY2R( antenna, prob, W, L)
distances = [];
distprob = [];
for i = 1:W
    for j = 1:L
        r = norm([antenna.xa - i; antenna.ya - j]);
        if (ismember(r, distances))
            I = find(distances == r);
            distprob(I) = distprob(I) + prob(i,j);
        else
            distances = [distances, r];
            distprob = [distprob, prob(i,j)];
        end
    end
end
for i= 1:length(distances)-1
   min = i;
   for j = i+1:length(distances)
       if distances(min) > distances(j)
          min = j; 
       end
   end
   % Swap smaller element in distances
   temp = distances(i);
   distances(i) = distances(min);
   distances(min) = temp;
   % Swap elements in distprob using the same indices
   temp = distprob(i);
   distprob(i) = distprob(min);
   distprob(min) = temp;
end
end

