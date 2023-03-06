function ITDfit = fit(Obj, azmth, elev, f1, f2)
% FIT Estimates ITD using fit method for a given angle
% 
%   ITD -> output variable (s)
%
%   Obj -> SOFA file
%   azmth -> azimuth angle
%   elev -> elevation angle
%   f1 -> lower limit of the frequency interval
%   f2 -> upper limit of the frequency interval
%% Método de ajuste lineal
% Definition 7: ITDfit is obtained from linear curve fitting.

%% Finding Orientation
pos = find(Obj.SourcePosition(:,2) == elev &  Obj.SourcePosition(:,1) == azmth);

L = reshape(Obj.Data.IR(pos,1,:), [1, length(Obj.Data.IR(pos,1,:))]); %%convertimos los datos en 1x512
R = reshape(Obj.Data.IR(pos,2,:), [1, length(Obj.Data.IR(pos,2,:))]); 

fs = Obj.Data.SamplingRate;
%ty = 0:1/(fs):(length(L)-1)/(fs);

%% FFT
Lf = fft(L);
Rf = fft(R);

S = length(Lf);
f = (-S/2:(S/2) - 1).*(fs./S);
%% Phase
thetaL = angle(Lf);
thetaR = angle(Rf);
% figure(); plot(f, thetaR, f, thetaL, 'red'); grid on;

%% Unwrap
uthetaR = unwrap(thetaR); 
uthetaL = unwrap(thetaL);
% figure(); plot(f, uthetaR, f, uthetaL, 'red'); grid on;
cero = find(f==0,1);
uthetaR = uthetaR - uthetaR(cero);
uthetaL = uthetaL - uthetaL(cero);

%% Fit
pos1 = find(f>=f1,1);
pos2 = find(f<=f2);
pos2 = pos2(end);


coefR = polyfit(f(pos1:pos2),uthetaR(pos1:pos2), 1);
coefL = polyfit(f(pos1:pos2),uthetaL(pos1:pos2), 1);

fitR = polyval(coefR, f(pos1:pos2));
fitL = polyval(coefL, f(pos1:pos2));
ITDfit = -(coefL(1) - coefR(1))/(2*pi);
% figure(); plot(f(pos1:pos2), uthetaR(pos1:pos2), 'red', f(pos1:pos2), fitR,'red+', f(pos1:pos2), uthetaL(pos1:pos2), 'blue', f(pos1:pos2), fitL, 'blue+'); grid on;
% axis([f(pos1) f(pos2) min([min(uthetaR(pos1:pos2)), min(uthetaL(pos1:pos2))])*6/5 max([max(uthetaR(pos1:pos2)), max(uthetaL(pos1:pos2))])*6/5 ]);
% title([Obj.GLOBAL_DatabaseName ' ' Obj.GLOBAL_ListenerShortName ' azmth=' num2str(azmth) ' elev=' num2str(elev) ' ITD=' num2str(ITDfit*10^3) ' ms']);
% xlabel 'Frequency (Hz)'; ylabel 'Phase (rad)';
end