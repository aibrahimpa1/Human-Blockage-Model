function [distances, distprob ] = Prob( antenna, prob, W, L)

distances = [];
distprob = [];
for i = 1:W
    for j = 1:L
        r = norm ([antenna.xa-i; antenna.ya-j]);
        if (ismember (r, distances))
            I = find (distances == r);
            distprob(I) = distprob(I) + prob(i,j)*r;
        else
            distances = [distances r];
            distprob = [distprob, prob(i,j)*r];
        end
    end
end
A = 1 - distprob;
plot (log(A), distances, 'o');
%x = 1:distances;
%y = 1:log(A);


end

