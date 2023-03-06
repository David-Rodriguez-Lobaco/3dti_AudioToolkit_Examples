function G = GraficaSinRet(obj, pos, tret, lado)
%Grafica la función sin retardo
%obj es el archivo sofa
%pos es la posición en la estructura
%tret es el tiempo que tiene de retardo
%lado indica si el lado izquierdo(1) o el derecho(2)

fs = obj.Data.SamplingRate;

A = reshape(obj.Data.IR(pos, lado, :), [1, length(obj.Data.IR(pos, lado, :))]);
A(:,[1:tret]) = []; %Elimino los datos de retardo
A(1,256) = 0;
%% Oversampling
OS = 10; % Oversampling factor
ta = 0:1/fs:(length(A)-1)/fs;
ty = 0:1/(OS*fs):(length(A)-1)/(fs);
L = interp1(ta,A,ty); %% Oversampling x10

%% LP FIR

if strcmp(obj.GLOBAL_DatabaseName, 'ARI')
    fc = 2000
    P = 0.22;
elseif strcmp(obj.GLOBAL_DatabaseName, 'CIPIC')
    fc = 3000
    P = 0.3;
elseif strcmp(obj.GLOBAL_DatabaseName, 'LISTEN')
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
k = 1:(length(FL)-orden); %k = 1:(length(FR)-128);
G = plot(k,FL(orden:length(FL)-1));
hold on;
end

