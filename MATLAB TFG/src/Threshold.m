function ITD = Threshold(Obj, azmth, elev)
% THRESHOLD 
%   ITD = Threshold(Obj, azmth, elev)
%   Estimates ITD using Threshold method for a given angle
% 
%   ITD -> output variable (s)
%
%   Obj -> SOFA file
%   azmth -> azimuth angle
%   elev -> elevation angle

%% Searching position
fs = Obj.Data.SamplingRate;
pos = find(Obj.SourcePosition(:,2) == elev &  Obj.SourcePosition(:,1) == azmth);



A = reshape(Obj.Data.IR(pos,1,:), [1, length(Obj.Data.IR(pos,1,:))]); %%convertimos este vector en 1x512
B = reshape(Obj.Data.IR(pos,2,:), [1, length(Obj.Data.IR(pos,2,:))]);

%% Oversampling
OS = 10; % Oversampling factor
ta = 0:1/fs:(length(A)-1)/fs;
ty = 0:1/(OS*fs):(length(A)-1)/(fs);
L = interp1(ta,A,ty); %% Oversampling x10
R = interp1(ta,B,ty);


% figure();
% plot(ty,L,'r-o', ta, A, 'b-*');
% xlabel('Time');
% grid on;
%% LP FIR

if strcmp(Obj.GLOBAL_DatabaseName, 'ARI')
    fc = 2000;
    P = 0.22;
elseif strcmp(Obj.GLOBAL_DatabaseName, 'CIPIC')
    fc = 3000;
    P = 0.3;
elseif strcmp(Obj.GLOBAL_DatabaseName, 'LISTEN')
    fc = 500;
    P = 0.2;
else
    fc = 5000;
    P = 0.3;
end
FIR = designfilt('lowpassfir', 'FilterOrder', 128, ...
    'CutoffFrequency', fc, 'SampleRate', fs*OS)
sos = FIR.Coefficients
FL = filter(FIR, L);
FR = filter(FIR, R);

% figure(); 
% % % subplot(1, 2, 1);
% plot(ty, L, ty, FL, 'red'); grid on;
% xlabel('Time (s)');
% ylabel('Amplitude');
% title(['Left']);
% 
% subplot(1, 2, 2); plot(ty, R, ty, FR, 'red'); grid on;
% xlabel('Time (s)');
% ylabel('Amplitude');
% title(['Right']);

%% Apply Threshold Method.

tL = find(FL > max(FL)*P,1);
tL = tL/(OS*fs);

tR = find(FR > max(FR)*P,1);
tR = tR/(OS*fs);

ITD = tL - tR;
end