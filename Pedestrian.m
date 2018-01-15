classdef Pedestrian < handle
    properties
        x, y, h, r, w, l;
    end
    methods
        % Constructor
        % Initializes the Pedestrian parameters
        function obj = Pedestrian(W, L)
            obj.w = W;
            obj.l = L;
            obj.x = randi([1,W]);
            obj.y = randi([1,L]);
            obj.h = normrnd(170,10);
            obj.r = normrnd(3,0.5);
        end
        
        % Walk Method
        % Updated Pedestrian position, gives the pedestrian a new random
        % velocity and takes care of boundaries
        function obj = Walk(obj, dt)
            vx = randi([-5, 5]);
            vy = randi([-5, 5]);
            if nargin == 1
                dx = vx;
                dy = vy;
            else
                dx = vx*dt;
                dy = vy*dt; 
            end
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
        end
    end
end
