function [ blocked ] = BlockCheck2D(Xa, Ya, Xp, Yp, Xr, Yr, dr)

    if Xr < Xa
        Xmin=Xr;
        Xmax=Xa;
    else
        Xmin=Xa;
        Xmax=Xr;
    end

    if Yr < Ya
        Ymin=Yr;
        Ymax=Ya;
    else
        Ymin=Ya;
        Ymax=Yr;
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
        RP = [Xp - Xr; Yp - Yr];
        RT = [Xa - Xr; Ya - Yr];
        a1 = (RP' * RT) / norm(RT);
        dp = sqrt(norm(RP)^2 - a1^2);
        if dr<=dp
            blocked=false;
        else
            blocked=true;
        end
    else
        blocked=false;
    end
end

