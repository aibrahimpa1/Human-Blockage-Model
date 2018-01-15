classdef Pedestrian < handle
    properties
        x, y, h, r, w, l, vx, vy;
    end
    methods
        % Constructor
        % Initializes the Pedestrian parameters
        function obj = Pedestrian(W, L)
            obj.w = W;
            obj.l = L;
            obj.x = RandomIn(1,W);
            obj.y = RandomIn(1,L);
            obj.h = normrnd(170,10);
            obj.r = normrnd(3,0.5);
            obj.vx = RandomIn(-5, 5);
            obj.vy = RandomIn(-5, 5);
        end
        
        % Walk Method
        % Updated Pedestrian position, gives the pedestrian a new random
        % velocity and takes care of boundaries
        function obj = Walk(obj)
            % compute new position
            dx = obj.vx;
            dy = obj.vy;
            X = obj.x + dx;
            Y = obj.y + dy;
        
            % check if pedestrian goes out of the left or right border
            if (X<1)
                X=obj.w;
            end
            if(X>obj.w)
                X=1;
            end
            % check if pedestrian goes out of upper and lower border
            if(Y<1)
                Y=obj.l;
            end
            if(Y>obj.l)
                Y=1;
            end
            % update pedestrian position
            obj.x = X;
            obj.y = Y;
            % update pedestrian velocity
            dvx = RandomIn(-2, 2);
            dvy = RandomIn(-2, 2);
            obj.vx = obj.vx + dvx;
            obj.vy = obj.vy + dvy;
        end
    end
end
