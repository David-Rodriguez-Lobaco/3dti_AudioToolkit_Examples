function [ITDg, f] = GDelay(Obj, azmth, elev)
% GDELAY Estimates ITD using group delay method for a given angle
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
S = length(thetaL);
fs = Obj.Data.SamplingRate;
OS = 1;


%% Derivamos la fase respecto a la frecuencia:
h = fs*OS/S; %%Step size
dL = diff(thetaL)./h;
dR = diff(thetaR)./h;

% figure();
% plot(f(1:end-1), dL);
% title('Channel dL');
% xlabel 'Frequency (Hz)';
% ylabel 'dPhase / df';
% grid on;

%% Aplicamos fórmula:
% Definition 3: ITDg refers to interaural group delay difference, which is
% defined as the interaural difference in the slope of HRTF phase divided
% by (-2pi)
ITDg = -(dL - dR)/(2*pi);
figure();
plot(f(2:end), ITDg, 'g', f(2:end), ITDw(2:end), 'r');
title('ITD (Delay Group)');
xlabel 'Frequency (Hz)';
ylabel 'ITDg (s)';
axis([-1500 1500 -4*max(abs(ITDg))/3 4*max(abs(ITDg))/3]);

grid on;
end