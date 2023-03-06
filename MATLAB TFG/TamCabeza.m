function rCabeza = TamCabeza(hrtf)
%%Buscamos las posiciones más proximas a los oidos
Pos = [];

DifA1 = hrtf.SourcePosition(:,1)-90;
DifA2 = hrtf.SourcePosition(:,1)-270;
DifE = hrtf.SourcePosition(:,2)-0;

Dif1 = abs(DifA1) + abs(DifE);
Dif2 = abs(DifA2) + abs(DifE);
[md1,pd1] = min(Dif1);
[md2,pd2] = min(Dif2);

Pos = [pd1 pd2];

 %%Calculamos el ITD en esos puntos y el tamaño de la cabeza
 c = 343.2;
 for x = 1:length(Pos)
    ITD = CCross(hrtf, hrtf.SourcePosition(Pos(x),1),hrtf.SourcePosition(Pos(x),2));
    theta = deg2rad(hrtf.SourcePosition(Pos(x),1));
%     cociente = fix(theta/pi);
    residuo = rem(theta,pi);
    e = deg2rad(abs(hrtf.SourcePosition(Pos(x),2)));
    
%     if (theta >= 0) && (theta <= (pi/2+pi*cociente)) %[0 <= theta <= pi/2]
%        a(x) = (ITD*c)/(cos(e)*(residuo + sin(residuo)));
%     else                                               %[pi/2 <= theta <= pi]
%        a(x) = (ITD*c)/(cos(e)*((pi - residuo) + sin(residuo)));
%     end
    
    if (theta >= 0) && (theta < (pi/2)) 
        a(x) = -(ITD*c)/(cos(e)*(residuo + sin(residuo)));
    elseif (theta >= pi/2) && (theta < pi)
        a(x) = -(ITD*c)/(cos(e)*((pi - residuo) + sin(residuo))); %* ITDporcentaje; * cos(e);
    elseif (theta >= pi) && (theta < (3*pi/2))
        a(x) = (ITD*c)/(cos(e)*(residuo + sin(residuo)));
    elseif (theta >= 3*pi/2) && (theta <= 2*pi)
        a(x) = (ITD*c)/(cos(e)*((pi - residuo) + sin(residuo)));
    end
 end
%%Calculamos el tamaño medio
a;
rCabeza = mean(abs(a));

end

