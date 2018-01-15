function [ r ] = RandomIn(a,b)
% generates a single random number in the interval (a,b)
r = a + (b-a).*rand();
end

