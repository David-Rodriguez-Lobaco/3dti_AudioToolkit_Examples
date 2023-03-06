function [thetaL, thetaR, f] = init(Obj, azmth, elev)
% INIT gives phase and frequency vector for a given angle
% 
%   thetaL -> Phase vector of left channel
%   thetaR -> Phase vector of right channel
%   f -> Frequency vector
%
%   Obj -> SOFA file
%   azmth -> azimuth angle
%   elev -> elevation angle

%% Buscamos la posición del ángulo dado:
pos = find(Obj.SourcePosition(:,2) == elev &  Obj.SourcePosition(:,1) == azmth);

A = reshape(Obj.Data.IR(pos,1,:), [1, length(Obj.Data.IR(pos,1,:))]); %%convertimos los datos en 1x512
B = reshape(Obj.Data.IR(pos,2,:), [1, length(Obj.Data.IR(pos,2,:))]); 

%B = [zeros(1,50), B(1:end-50)]; %Añadimos ceros al principio 
fs = Obj.Data.SamplingRate;
OS = 1; %% Factor de sobremuestreo

ta = 0:1/fs:(length(A)-1)/fs;
ty = 0:1/(OS*fs):(length(A)-1)/(fs);
L = interp1(ta,A,ty); %% Oversampling x10
R = interp1(ta,B,ty);

%% Transformada de Fourier
Lf = fft(L);
Rf = fft(R);
Lf = fftshift(Lf);
Rf = fftshift(Rf);

S = length(Lf);
%%f = (-S/2:S/2 - 1)/S*(fs*OS);
f = (-S/2:(S/2) - 1).*(fs*OS./S);
%% Obtenemos la fase:
thetaL = angle(Lf);
thetaR = angle(Rf);
thetaL = unwrap(thetaL);
thetaR = unwrap(thetaR);

cero = find(f==0,1);
thetaR = thetaR - thetaR(cero);
thetaL = thetaL - thetaL(cero);


%Representamos:
figure();
plot(f, thetaL, f, thetaR);
title('HRTF Phase');
xlabel 'Frequency (Hz)';
ylabel 'Phase (rad)';
% axis([-1500 1500 -4*thetaL(find)/3 4*max(abs(thetaL))/3]);
grid on;

% figure();
% plot(f, thetaR);
% title('Channel R');
% xlabel 'Frequency (Hz)';
% ylabel 'Phase (rad)';
% % axis([-1500 1500 -4*max(abs(thetaR))/3 4*max(abs(thetaR))/3]);
% grid on;
end