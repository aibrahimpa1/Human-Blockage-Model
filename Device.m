classdef Device < handle
    properties
      xd, yd, hd;
    end
    methods
        % Constructor
        % Initializes the device's height
        function obj = Device (Xd, Yd, Hd)
            obj.hd = Hd;
            obj.xd = Xd;
            obj.yd = Yd;
        end
    end
end
