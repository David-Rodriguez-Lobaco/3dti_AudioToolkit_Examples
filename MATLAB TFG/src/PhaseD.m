function [ITDp, f] = PhaseD(Obj, azmth, elev)
% GDELAY Estimates ITD using phase difference method for a given angle
% 
%   ITDg -> output variable (s)
%   f -> frequency vector
%
%   Obj -> SOFA file
%   azmth -> azimuth angle
%   elev -> elevation angle

%% Método 3: Retardo de grupo
%Valido para valores de frecuencia inferiores a 1.5KHz

[thetaL, thetaR, f] = init(Obj, azmth, elev);


%% Calculo de ITDp

% Definition 1: ITDp pertains to interaural phase delay diference:

ITDp = -(thetaL - thetaR)./(2*pi.*f);

ITDw = zeros(length(f), 1);
for x=1:length(f)
    ITDw(x) = -(0.09/344)*(azmth*pi/180 + sin(azmth*pi/180));
    if strcmp(Obj.GLOBAL_DatabaseName, 'CIPIC')
        ITDw(x) = -1*ITDw(x);
    end
end

figure();
plot(f, ITDp, 'g', f, ITDw, 'r');
title('ITD (Phase Difference)');
xlabel 'Frequency (Hz)';
ylabel 'ITDp (s)';
axis([-1500 1500 -4*max(abs(ITDp))/3 4*max(abs(ITDp))/3]);
grid on;

end