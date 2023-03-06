function W = ITDw(a,c,theta,e)
%This Gives Woodworth's Formula for Interaural Time Delay (ITD): This model is a simplification
% a: radius of the head (Centimetre). Nominally 0.088 m
% c: The Speed of sound (m/s). Nominally 343.2 m/s
% theta: The bearing of a far-field source in rad
% e: Elevation in degres
% fix(X): Redondea x al entero más cercano a 0

cociente = fix(theta/pi);
residuo = rem(theta,pi);
e = deg2rad(e);

% if (theta >= pi*cociente) && (theta <= (pi/2+pi*cociente)) %[0 <= theta <= pi/2]
%     W = ((a/c)*(residuo + sin(residuo))) * cos(e); %* cos(e); * ITDporcentaje
% else                                               %[pi/2 <= theta <= pi]
%     W = ((a/c)*((pi - residuo) + sin(residuo)) * cos(e)); %* ITDporcentaje; * cos(e);
% end

% if (theta >= 0) && (theta < (pi/2)) 
%     W = -((a/c)*(residuo + sin(residuo))) * cos(e);
% elseif (theta >= pi/2) && (theta < pi)
%     W = -((a/c)*((pi - residuo) + sin(residuo)) * cos(e)); 
% elseif (theta >= pi) && (theta < (3*pi/2))
%     W = ((a/c)*(residuo + sin(residuo))) * cos(e);
% elseif (theta >= 3*pi/2) && (theta <= 2*pi)
%     W = ((a/c)*((pi - residuo) + sin(residuo)) * cos(e));
% end
if (theta >= 0) && (theta < (pi/2)) 
    W = -((a/c)*(residuo + sin(residuo))* cos(e)) ;
elseif (theta >= pi/2) && (theta < pi)
    W = -((a/c)*((pi - residuo) + sin(residuo)) * cos(e)); 
elseif (theta >= pi) && (theta < (3*pi/2))
    W = ((a/c)*(residuo + sin(residuo))) * cos(e);
elseif (theta >= 3*pi/2) && (theta <= 2*pi)
    W = ((a/c)*((pi - residuo) + sin(residuo)) * cos(e));
end
end

