function ITDave = average(Obj, azmth, elev)
% AVERAGE Estimates ITD using time average method for a given angle
% 
%   ITD -> output variable (s)
%
%   Obj -> SOFA file
%   azmth -> azimuth angle
%   elev -> elevation angle

%% ITDave pertains to interaural average (central) time difference

%% Finding Orientation
pos = find(Obj.SourcePosition(:,2) == elev &  Obj.SourcePosition(:,1) == azmth);

L = reshape(Obj.Data.IR(pos,1,:), [1, length(Obj.Data.IR(pos,1,:))]); %%convertimos los datos en 1x512
R = reshape(Obj.Data.IR(pos,2,:), [1, length(Obj.Data.IR(pos,2,:))]); 

%% Oversampling
fs = Obj.Data.SamplingRate;
t = 0:1/fs:(length(L)-1)/fs;

OS = 1; %% Factor de sobremuestreo
ty = 0:1/(OS*fs):(length(L)-1)/(fs);
L = interp1(t,L,ty); %% Oversampling x10
R = interp1(t,R,ty);

%% ITD TIME AVERAGE
TL = sum(ty.*L.^2)/sum(L.^2);
TR = sum(ty.*R.^2)/sum(R.^2);

ITDave = TL - TR;
end