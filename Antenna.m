classdef Antenna < handle
    properties
      xa, ya, ha;
    end
    methods
        % Constructor
        % Initializes the antenna's height
        function obj = Antenna(Xa, Ya, Ha)
            obj.ha = Ha;
            obj.xa = Xa;
            obj.ya = Ya;
        end
    end
end

