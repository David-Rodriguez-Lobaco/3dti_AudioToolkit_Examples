function [ITD, Obj] = MetodoUmbral(Obj, azmth, elev, fc, Um)
% THRESHOLD 
%   Estimates ITD using Threshold method for a given angle
%   ITD -> output variable
%   Obj -> SOFA file
%   azmt -> azimut angle
%   elev -> elevation angle
%   fc -> frecuencia de corte
%   Um -> Umbral

%% Searching position
fs = Obj.Data.SamplingRate;
pos = find(Obj.SourcePosition(:,2) == elev &  Obj.SourcePosition(:,1) == azmth);

A = reshape(Obj.Data.IR(pos,1,:), [1, length(Obj.Data.IR(pos,1,:))]); %%convertimos este vector en 1x256
B = reshape(Obj.Data.IR(pos,2,:), [1, length(Obj.Data.IR(pos,2,:))]);

%% Oversampling
OS = 10; % Oversampling factor
ta = 0:1/fs:(length(A)-1)/fs;
ty = 0:1/(OS*fs):(length(A)-1)/(fs);
if strcmp(Obj.GLOBAL_DatabaseName, 'CIPIC') %CIPIC tiene los datos al reves
    R = interp1(ta,A,ty); %% Oversampling x10
    L = interp1(ta,B,ty);
else
    L = interp1(ta,A,ty); %% Oversampling x10
    R = interp1(ta,B,ty);
end

%Filtro Butterworth de orden 10
%la frecuencia de corte hay que conveertirla a radianes
[b,a] = butter(10,fc/(fs/2),"low");
[U, I, O, P] = butter(10,fc/(fs/2),"low");
sos = ss2sos(U,I,O,P);

%Se aplica el filtro
FL = filter(b, a, L);
FR = filter(b, a, R);


%Filtro Savitzky-Golay
% FL = sgolayfilt(L,3,31);
% FR = sgolayfilt(R,3,31);

% %Dibujar el filtro
%   k = 1:length(FR); 
%   figure;
%   plot(k,FR)
%   hold off;
%% Apply Threshold Method.
%Find the first value that surpass the maximun

tL = find(FL > max(FL)*Um,1);
Obj.Data.Delay(pos,1) = round(tL/10);  %%Rellena la tabla Delay
tL = tL/(OS*fs);

tR = find(FR > max(FR)*Um,1);
Obj.Data.Delay(pos,2) = round(tR/10); %%Rellena la tabla Delay
tR = tR/(OS*fs);

ITD = tL-tR;
end
