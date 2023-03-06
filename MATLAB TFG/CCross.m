function ITD = CCross(Obj, azmth, elev)
% CCROSS Estimates ITD using Cross-Correlation method for a given angle
% 
%   ITD -> output variable (s)
%
%   Obj -> SOFA file
%   azmth -> azimuth angle
%   elev -> elevation angle

%% Buscamos la posición del ángulo dado:
pos = find(Obj.SourcePosition(:,2) == elev &  Obj.SourcePosition(:,1) == azmth);
fs = Obj.Data.SamplingRate;
OS = 10;

A = reshape(Obj.Data.IR(pos,1,:), [1, length(Obj.Data.IR(pos,1,:))]); %%convertimos los datos en 1x512
B = reshape(Obj.Data.IR(pos,2,:), [1, length(Obj.Data.IR(pos,2,:))]); 

%% Oversampling
ta = 0:1/fs:(length(A)-1)/fs;
ty = 0:1/(OS*fs):(length(A)-1)/(fs);
Y = interp1(ta,A,ty); %% Oversampling x10
Z = interp1(ta,B,ty);

%% LPF
if strcmp(Obj.GLOBAL_DatabaseName, 'ARI')
    fc = 2000;
elseif strcmp(Obj.GLOBAL_DatabaseName, 'CIPIC')
    fc = 3000;
elseif strcmp(Obj.GLOBAL_DatabaseName, 'LISTEN')
    fc = 500;
else
    fc = 5000;
end

FIR = designfilt('lowpassfir', 'FilterOrder', 128, 'CutoffFrequency', fc, 'SampleRate', fs*OS); % Generación de coeficientes FIR
FL = filter(FIR, Y);
FR = filter(FIR, Z);

% figure(); 
% subplot(1, 2, 1); plot(ty, Y, ty, FL, 'red'); grid on;
% xlabel('Time (s)');
% ylabel('Amplitude');
% title(['Left']);
% 
% subplot(1, 2, 2); plot(ty, Z, ty, FR, 'red'); grid on;
% xlabel('Time (s)');
% ylabel('Amplitude');
% title(['Right']);

%% Cross-Correlation function
[C, T] = xcorr(FL,FR);
% figure(); 
% stem(T,C);
% grid on;
%%ITD será el valor del eje de abscisa donde se encuentre el valor máximo
%%de los valores obtenidos por la Correlación Cruzada
Tmax = find(C == max(C),1) - (length(C)+1)/2;
ITD = Tmax/(fs*OS);
end