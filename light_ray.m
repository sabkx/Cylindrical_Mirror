classdef light_ray
    %light_ray Class for a light ray
    %   To make coding easier, we use this class to model light rays
    %   Each light ray is modelled to have an intensity, position, and
    %   angle

    properties
        % hasHitEndPoint;
        position;
        direction;
        distance;
    end

    methods
        function obj = light_ray(position,direction,distance)
            obj.position=position;
            obj.direction=direction./norm(direction);
            obj.distance=distance;
        end
        function [flag,obj] = shine(obj,length,radius)
            if obj.position(3)>=length
                % hasHitEndpoint=true;
                flag=true;
                return
            end
            t1=(sqrt((obj.position(1).*obj.direction(1) ...
                +obj.position(2).*obj.direction(2)).^2+(radius.^2- ...
                (norm(obj.position(1:2)).^2)).* ...
                (norm(obj.direction(1:2)).^2))-(obj.position(1) ...
                .*obj.direction(1)+obj.position(2).*obj.direction(2))) ...
            ./(norm(obj.direction(1:2)).^2);
            t2=(length-obj.position(3))./obj.direction(3);
            % disp(t1);
            % disp(t2);
            if t2<t1
                flag=true;
                obj.position=obj.position+t2.*obj.direction;
                obj.distance=obj.distance+norm(t2.*obj.direction);
                return
            end
            flag=false;
            obj.position=obj.position+t1.*obj.direction;
            obj.distance=obj.distance+norm(t1.*obj.direction);
            n=[-obj.position(2),obj.position(1)];
            n=n./norm(n);
            obj.direction(1:2)=-obj.direction(1:2)+2.*dot(obj. ...
                direction(1:2),n).*n;
            % disp(obj.direction);
            % if obj.direction(3)<0
            %     obj.direction=-obj.direction;
            % end
            obj.direction=obj.direction./(norm(obj.direction));
            new_angle=normrnd(asin(obj.direction(3)),pi./36);
            obj.direction(3)=abs(sin(new_angle));
            % disp(obj.direction(3));
        end
    end
end