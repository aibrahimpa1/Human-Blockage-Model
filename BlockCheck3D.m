function [ blocked ] = BlockCheck3D(antenna, pedestrian, device)
    if BlockCheck2D(antenna, pedestrian, device)
        % do extra steps
        % extract required variables 
        Xa = antenna.xa;
        Ya = antenna.ya;
        Ha = antenna.ha;
        Xp = pedestrian.x;
        Yp = pedestrian.y;
        Hp = pedestrian.h;
        Xd = device.xd;
        Yd = device.yd;
        Hd = device.hd;
        % project into line connecting receiver to antenna 
        DP = [Xp - Xd; Yp - Yd];
        DA = [Xa - Xd; Ya - Yd];
        a1 = (DP' * DA) / norm(DA);
        L = norm(DA);
        % checking if pedestrian is tall enough to block LOS
        EF = a1 * (Ha-Hd)/ (L-a1);
        if (Hp >= EF + Hd)
            blocked = true;
        else
            blocked = false;
        end
    else
        % return false because it is not blocked in 2D, so it is not
        % blocked in 3D as well
        blocked = false;
    end
end

