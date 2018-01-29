function [ blocked ] = BlockCheck2D(antenna, pedestrian, device)

    Xa = antenna.xa;
    Ya = antenna.ya;
    Xp = pedestrian.x;
    Yp = pedestrian.y;
    Xd = device.xd;
    Yd = device.yd;
    dr = pedestrian.r;

    if Xd < Xa
        Xmin=Xd;
        Xmax=Xa;
    else
        Xmin=Xa;
        Xmax=Xd;
    end

    if Yd < Ya
        Ymin=Yd;
        Ymax=Ya;
    else
        Ymin=Ya;
        Ymax=Yd;
    end
      
    if Xmax-Xmin<dr 
        Xmin=Xmin-dr;
        Xmax=Xmax+dr;
    end
    
    if Ymax-Ymin<dr
        Ymin=Ymin-dr;
        Ymax=Ymax+dr;
    end
    
    if Xmin <= Xp && Xp <= Xmax && Ymin <= Yp && Yp <= Ymax
        DP = [Xp - Xd; Yp - Yd];
        DA = [Xa - Xd; Ya - Yd];
        a1 = (DP' * DA) / norm(DA);
        dp = sqrt(norm(DP)^2 - a1^2);
        if dr<=dp
            blocked=false;
        else
            blocked=true;
        end
    else
        blocked=false;
    end
end

