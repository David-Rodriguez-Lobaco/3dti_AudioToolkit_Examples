 % SCRIPT TO:(1) read sofa files and remove a specific position 
%            (2) Send OSC commands to change the source position, load the
%            HRTF and record the output
%            (3) Plot BITA output (HRIRs)
% OSC communicacion: using oscsend funtion from Copyright (c) 2011, Mark Marijnissen downloaded from: https://es.mathworks.com/matlabcentral/fileexchange/31400-send-open-sound-control-osc-messages?s_tid=mwa_osa_a
% Creation Date: 04/12/2020

% Important note: Change SVN personal path

% SCRIP MANUAL modifications: fs, HRTF file names, personal_path and dir_path

%FIRST STEPS:
%Open BiTA, set fs and add the audio file (sweep_log_4800_30s_0.05.wav)
%Add OSC_BiTA folder to matlab path (folder and subfolders)
%In Matlab work in the folder od the repository (OSC_BiTA)

close all;
clear;
clc;

a_index = 0;
%Select with azimuth you want to show
%for az =0:15:180
for az=89
           
    %Resel all variable values except the ones used for the loop and for
    %storing the final results
    disp('PAUSE 0, Start')
    pause;
    clearvars -except az a_index SD_withoutSeparateITD_left SD_withSeparateITD_left SD_withoutSeparateITD_right SD_withSeparateITD_right;
    close all;
     
    personal_path = 'C:\Users\Ludio\Documents\MATLAB\TFG\';
    dir_path = 'C:\Users\Ludio\Documents\MATLAB\TFG\'; %dirección del script
    sofaFile_paths = 'HRTFs'; %'\API_MO\';

%%----------------------------------------------------------------------------------------------
%% HANDLE sofa FILES: Load files, remove specific position and save in SOFA format

    addpath ([personal_path,sofaFile_paths]);
    HRTF_sofaFiles_path = 'VERSION ANTERIOR APIMO\HRTFs\SADIE\D1_HRIR_SOFA\';
    HRTF_sofaFiles = {'D1_44K_16bit_256tap_FIR_SOFA.sofa','D1_48K_24bit_256tap_FIR_SOFA.sofa'}; %,'D1_44K_24bit_256tap_FIR_SOFA.sofa'
    fs = 44100; %48000;
    
    a_index = a_index +1;
    missing_azimuth_deg = az; %direction to be removed
    missing_elevation_deg = 0;

    SOFAstart;

    for i= 1:size(HRTF_sofaFiles,2)
        
        obj = SOFAload([HRTF_sofaFiles_path,HRTF_sofaFiles{i}]);
        obj_orientationMissing = obj; %Copy the obj to keep both matrices

        %% Get pos
        A = (obj_orientationMissing.SourcePosition(:,1) == missing_azimuth_deg & obj_orientationMissing.SourcePosition(:,2) == missing_elevation_deg);
        row_pos = find(A==1);
        obj_orientationMissing.SourcePosition(row_pos,:) = [];
        obj_orientationMissing.Data.IR(A,:,:)= [];
        obj_orientationMissing.Data.Delay = zeros(8802, 2)
        obj_orientationMissing.Data.Delay(A,:,:)= [];

        A_afterRemoving = (obj_orientationMissing.SourcePosition(:,1) == missing_azimuth_deg & obj_orientationMissing.SourcePosition(:,2) == missing_elevation_deg);
        HRIR_pos = squeeze(obj_orientationMissing.Data.IR(A_afterRemoving,:,:));
        if isempty(HRIR_pos); disp('Position REMOVED'); end

        %Save obj into SOFA file
        HRTF_name = erase(HRTF_sofaFiles{i},'.sofa');
        new_HRTF_sofaFiles{i} = [HRTF_name, '_missingAz',num2str(missing_azimuth_deg),'.sofa'];
        SOFAsave([HRTF_sofaFiles_path, new_HRTF_sofaFiles{i}],obj_orientationMissing);
    end
    
    
%%----------------------------------------------------------------------------------------------
%% COMMUNICATION WITH BITA: configure the scene and record the output. Also plot the output (HRIRs)

    %Plot wav file created from MATLAB
    %openPort
    u = udp('127.0.0.1',12300);
    fopen(u);

    HRTF_sofaFiles = {HRTF_sofaFiles{2},  new_HRTF_sofaFiles{1}, new_HRTF_sofaFiles{2}};
    colors = {'b-', 'r--', 'g-'};
    HRTF_ID = erase(HRTF_sofaFiles{1},'.sofa');

    %1.Place the source
    az = deg2rad( missing_azimuth_deg);
    el = deg2rad( missing_elevation_deg );
    d  = 6;
    [X,Y,Z] = sph2cart(az,el,d);
    oscsend(u,'/3DTI-OSC/v1/source1/location','fff',X,Y,Z);

    %2. Deactivate distance effect and reverb
    oscsend(u,'/3DTI-OSC/v1/source1/anechoic/nearfield','s','false');
    oscsend(u,'/3DTI-OSC/v1/source1/anechoic/farfield','s','false');
    oscsend(u,'/3DTI-OSC/v1/source1/anechoic/distance','s','false');
    oscsend(u,'/3DTI-OSC/v1/source1/environment/enable','s','false');


    for i=1:size(HRTF_sofaFiles,2)

    HRTF_name = erase(HRTF_sofaFiles{i},'.sofa');
    audioOutput_name = ['output_', HRTF_name];

    %Load HRTF
    %-----------------
    disp('PAUSE 1, press a key to LOAD THE HRTF')
    pause;
    HRTFfile_path = [dir_path, HRTF_sofaFiles_path, HRTF_sofaFiles{i}];
    oscsend(u,'/3DTI-OSC/v1/listener/loadHRTF','s',HRTFfile_path);

     %2. Record BiTA output signal
     %-----------------
     disp('PAUSE 2, press a key to RECORD OUTPUT')
     pause;
     oscsend(u,'/3DTI-OSC/v1/record','sssf',[dir_path,'records/'], audioOutput_name,'true',30);

     %3. Plot recorded audio output
     disp('PAUSE 3, press a key to PLOT RECORDED SIGNAL')
     pause;
     output_signal = audioread([dir_path,'records/', audioOutput_name, '.wav']);

     %Plot and store left ear HRIR power
     figure (2*a_index-1);
     [output_signal_freq,f] = pwelch(output_signal(:,1),1024,[],[],fs);
     pxx_left(:,i) = output_signal_freq;
     semilogx(f/1000,10*log10(output_signal_freq), colors{i});
     hold on;

     %Plot and store right ear HRIR power
     figure(2*a_index);
     [output_signal_freq,f] = pwelch(output_signal(:,2),1024,[],[],fs);
     pxx_right(:,i) = output_signal_freq;
     semilogx(f/1000,10*log10(output_signal_freq), colors{i});
     hold on;
    end

    % Configure in the same way both figures (left and right).
    for j=1:2
        figure(2*a_index-1 + j-1);
        if j == 1
            title (['Left ear (\theta=',num2str(missing_azimuth_deg),'{\circ},\phi=0{\circ})'],'Interpreter', 'tex');
            leg=legend('HRIR from the database','HRIR interpolated using not-aligned HRIRs', 'HRIR interpolated using aligned HRIRs', 'Location', 'Best');
        else
            title (['Right ear (\theta=',num2str(missing_azimuth_deg),'{\circ},\phi=0{\circ})'],'Interpreter', 'tex');
        end
        ylabel('|HRIR| (dB/Hz)')
        xlabel('Frequency (kHz)')
        ylim([-120 -60]);
        xlim([200/1000, 20000/1000]);
        set(gca,'XTick',[0.1,0.2,0.5,1,2,3,4,5,6,8,10,20]);
        grid on
        set(gca, 'FontName', 'Arial');
        set(gca,'FontSize',14);
        leg.FontSize = 14;
        set(gcf,'color','w');

        savefig(['figures/figs/',HRTF_ID,'_', num2str(missing_azimuth_deg),'Az_',num2str(j),'.fig']);
        saveas(gcf,['figures/',HRTF_ID,'_', num2str(missing_azimuth_deg),'Az_',num2str(j),'.png']);
    end
  
end

fclose(u);

