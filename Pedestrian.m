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
            
            if X<0
                X=-X;
            else
                if X>obj.w
                    X=obj.w-(X-obj.w);
                end
            end

            if Y<0
                Y=-Y;
            else 
                if Y>obj.l
                    Y=obj.l-(Y-obj.l);
                end 
            end
            
            obj.x = X;
            obj.y = Y;
        end
    end
end
