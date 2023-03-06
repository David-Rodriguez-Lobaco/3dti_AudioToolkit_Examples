function Graficas_elevacion_0(hrtf,name,title)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%  a = 0:0.01:2*pi;
% % rtograd = a * 180/pi;
%  b = -90:90;
%  T(length(a), length(b)) = 0;
%  TCabeza = TamCabeza(hrtf);
% for x=1:length(a)
%     for y = 1:length(b)
%         T(x,y) = ITDw(TCabeza,343.2, a(x),b(y));
%     end
% end

format long;
%Umbral = 0.10:0.01:0.60;
Umbral = 0.23;
PosE = find(abs(hrtf.SourcePosition(:,2)) < 10^-10, 600); %posicion elevacion. Busco las muestras que hay
[~, index] = sort(hrtf.SourcePosition(PosE,1));
%ITDww = [hrtf.SourcePosition(PosE,1) hrtf.SourcePosition(PosE,2)];
ITDt(length(PosE),length(Umbral)) = 0;
%ITDt2 = ITDt;
% if strcmp(hrtf.GLOBAL_DatabaseName, 'CIPIC')
     %ITDww = [hrtf.SourcePosition(PosE(index),1) hrtf.SourcePosition(PosE(index),2)];
% end

 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 for x = 1:length(PosE)
    for i=1:length(Umbral)
        ITDt(x,i) = MetodoUmbral(hrtf,hrtf.SourcePosition(PosE(index(x)),1), hrtf.SourcePosition(PosE(index(x)),2), 7000, Umbral);
    end
%     ITDt2(x,1) = CorrelacionCruzada(hrtf,hrtf.SourcePosition(PosE(index(x)),1), hrtf.SourcePosition(PosE(index(x)),2), 3000);
    %ITDww(x,3) = ITDw(TCabeza,343.2,deg2rad(hrtf.SourcePosition(PosE(index(x)),1)),hrtf.SourcePosition(PosE(index(x)),2));
 end

 %%%%%%%%%%%%%%%%%%%%%%%%%%%%% Guardado %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %%isoutlier(ITDt,"mean")
%ITDt = smoothdata(ITDt,"sgolay");
%filloutliers(ITDt,"linear")
 
 %carp = uigetdir('C:\Users\Ludio\Desktop\TFG\Imagenes ITDs', name);

for i=1:length(Umbral)
    figure
    txt = title + " Umbral= " + num2str(Umbral(i),'%.2f');
    %plot(hrtf.SourcePosition(PosE(index)),ITDww(:,3)); ylabel('Elevacion'); xlabel('Azimut')
    %title(txt,'Interpreter','none');
    hold on;
      %ITDg = sgolayfilt(ITDt,1,9);
%      ITDg = sgolayfilt(ITDg,3,13);
    plot(hrtf.SourcePosition(PosE(index)),ITDt(:,i));
   % plot(hrtf.SourcePosition(PosE(index)),ITDt2(:,1));
    %plot(hrtf.SourcePosition(PosE(index)),ITDg);
    %%legend('ITD Woodworth',"ITD Umbral = " + num2str(Umbral(i),'%.2f'));
    legend("ITD = " + num2str(Umbral(i), '%.2f'), 'Location', 'northwest'); set(legend,'fontsize',14);  ylabel('tL-tR'); xlabel('Azimut')
    fig = gcf;
    txt = name+txt;
    saveas(fig,txt+'.jpg');
    close(fig);
    hold off;
end