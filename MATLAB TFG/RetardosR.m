function tR = RetardosR(Obj, azmth, elev)
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



A = reshape(Obj.Data.IR(pos,1,:), [1, length(Obj.Data.IR(pos,1,:))]); %%convertimos este vector en 1x256
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
    fc = 2000
    P = 0.22;
elseif strcmp(Obj.GLOBAL_DatabaseName, 'CIPIC')
    fc = 3000
    P = 0.3;
elseif strcmp(Obj.GLOBAL_DatabaseName, 'LISTEN')
    fc = 500
    P = 0.2;
else
    fc = 5000; %5000
    P = 0.3;
end

orden = 128; %128
FIR = designfilt('lowpassfir', 'FilterOrder', orden, ...
    'CutoffFrequency', fc, 'SampleRate', fs*OS);
FL = filter(FIR, L);
FR = filter(FIR, R);
k = 1:(length(FR)-orden); %k = 1:(length(FR)-128);
plot(k,FR(orden:length(FR)-1))
hold on;
% for k = 1:(length(FR)-128);
%     if (FR(k+128) > 0.050415155958105)
%         plot(k,FR(k+128),'g*')
%         hold on;
%     end
% end

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

tR = find(FR > max(FR)*P,1) - orden;
tR = tR/(OS*fs);

end