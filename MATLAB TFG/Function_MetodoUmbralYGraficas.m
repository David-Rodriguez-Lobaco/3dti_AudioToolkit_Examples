function [ITDt, ITDww, TdiffITD, bestUmbral,hrtf] = Function_MetodoUmbralYGraficas(hrtf,carpeta, name, Umbral)


TdiffITD=0; 
bestUmbral=0;

a = 0:0.01:2*pi;
rtograd = a * 180/pi;
b = -90:90;
T(length(a), length(b)) = 0;
TCabeza = TamCabeza(hrtf);
for x=1:length(a)
    for y = 1:length(b)
        T(x,y) = ITDw(TCabeza,343.2, a(x),b(y));
    end
end

ITDww = hrtf.SourcePosition;
format long;

if(length(Umbral)>1)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    ITDww = [hrtf.SourcePosition(:,1) hrtf.SourcePosition(:,2)];
    ITDt(length(hrtf.SourcePosition(:,1)),1)=0;

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    for x = 1:length(hrtf.SourcePosition(:,1))
    %for x = 1:length(PosE)
        for i=1:length(Umbral)
            [ITDt(x,i),hrtf] = MetodoUmbral(hrtf,hrtf.SourcePosition(x,1), hrtf.SourcePosition(x,2), 3000, Umbral(i));
        end
%         for i=1:length(FC)
%             [ITDt(x,i),hrtf] = MetodoUmbral(hrtf, hrtf.SourcePosition(x,1), hrtf.SourcePosition(x,2), FC(i), Umbral);
%         end
        ITDww(x,3) = ITDw(TCabeza,343.2,deg2rad(hrtf.SourcePosition(x,1)),hrtf.SourcePosition(x,2));
    end

    for i=1:length(Umbral)
        figure
        surf(rtograd,b,T','EdgeColor',"none",'EdgeColor',"#0072BD",'FaceAlpha',1); ylabel('Elevacion'); xlabel('Azimut');
    %    plot(hrtf.SourcePosition(PosE(index)),ITDww(:,3)); ylabel('Elevacion'); xlabel('Azimut')
        txt = name + " WW Umbral=" + num2str(Umbral(i),'%.2f') + " FC=3000";
        title(txt,'Interpreter','none');
        hold on;
        Reordenar(hrtf,ITDww(:,1),ITDww(:,2),ITDt(:,i));
       % plot(hrtf.SourcePosition(PosE(index)),ITDt(:,i));
        legend('ITD Woodworth',"ITD Umbral = " + num2str(Umbral(i),'%.2f') + "FC = " + num2str(3000,'%u'));
        fig = gcf;
        %txt2 = [carp2+"\"+txt];
        %txt =[carp+"\"+txt];
    %     savefig(txt2+'.fig');
        saveas(fig,carpeta+txt+'.jpg');
        close(fig);
        hold off;
        %    -----------------------------------------------------------------------
%         figure
%     %     txt = name + " 1 Umbral= " + num2str(Umbral(i));
%         txt = name + " wo_W Umbral=" + num2str(Umbral(i),'%.2f') + " FC=3000";
%         m = unique(ITDww(:,1));
%         n = unique(ITDww(:,2));
%         datos = nan(length(m),length(n));
%         view([-37.5 30]);
%         for p = 1:length(ITDt(:,i))
%             datos(m==ITDww(p,1),n==ITDww(p,2)) = ITDt(p,i);
%         end
%         %datos(:,n==-90) = 0; datos(:,n==90) = 0;
%         if strcmp(hrtf.GLOBAL_DatabaseName, 'CIPIC') || strcmp(hrtf.GLOBAL_DatabaseName, 'ARI')
%             hold on;
%             for q =1:length(ITDt(:,i))
%                 plot3(ITDww(q,1),ITDww(q,2),ITDt(q,i),'.','MarkerEdgeColor',"#EDB120")
%             end
%         else
%             surf(m',n',datos');
%         end
%         ylabel('Elevacion'); xlabel('Azimut');
%         title(txt,'Interpreter','none');
%         fig = gcf;
%     %    txt2 = [carp2+"\"+txt];
%        % txt =[carp+"\"+txt];
%     %    savefig(txt2+'.fig');
%         saveas(fig,carpeta+txt+'.jpg');
%      %   close(fig);
    end
else %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %FC = 0:1000:10000;
    %FC = [1000,2000,3000,4000,5000,6000,7000,8000,9000,10000];
    FC = 3000;

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    ITDww = [hrtf.SourcePosition(:,1) hrtf.SourcePosition(:,2)];
    ITDt(length(hrtf.SourcePosition(:,1)),1)=0;

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    for x = 1:length(hrtf.SourcePosition(:,1))

        for i=1:length(FC)
            [ITDt(x,i),hrtf] = MetodoUmbral(hrtf, hrtf.SourcePosition(x,1), hrtf.SourcePosition(x,2), FC(i), Umbral);
        end
        ITDww(x,3) = ITDw(TCabeza,343.2,deg2rad(hrtf.SourcePosition(x,1)),hrtf.SourcePosition(x,2));
    end

    for i=1:length(FC)
        figure
        surf(rtograd,b,T','EdgeColor',"none",'EdgeColor',"#0072BD",'FaceAlpha',1); ylabel('Elevacion'); xlabel('Azimut');
    %    plot(hrtf.SourcePosition(PosE(index)),ITDww(:,3)); ylabel('Elevacion'); xlabel('Azimut')
    %    txt = name + " 2 Umbral= " + num2str(Umbral(i),'%.2f');
      %   txt = name + " 2 FC= " + num2str(FC(i));
                 txt = name + " WW Umbral=" + num2str(Umbral(i),'%.2f') + " FC=3000";
        title(txt,'Interpreter','none');
        hold on;
         Reordenar(hrtf,ITDww(:,1),ITDww(:,2),ITDt(:,i));
        %plot(hrtf.SourcePosition(PosE(index)),ITDt(:,i));
        
       % legend('ITD Woodworth',"ITD Umbral = " + num2str(Umbral(i),'%.2f') + "FC = " + num2str(FC(i),'%u'));
        fig = gcf;
        %txt2 = [carp2+"\"+txt];
        %txt =[carp+"\"+txt];
    %     savefig(txt2+'.fig');
        saveas(fig,txt+'.jpg');
       % close(fig);
        hold off;
        %    -----------------------------------------------------------------------
%         figure
%     %    surf(rtograd,b,T','EdgeColor',"none",'EdgeColor',"#0072BD",'FaceAlpha',1); ylabel('Elevacion'); xlabel('Azimut');
%     %     txt = name + " 1 Umbral= " + num2str(Umbral(i));
%         txt = name + " 1 Umbral=" + num2str(Umbral,'%.2f') + " FC=" + num2str(FC(i),'%u');
%         m = unique(ITDww(:,1));
%         n = unique(ITDww(:,2));
%         datos = nan(length(m),length(n));
%         view([-37.5 30]);
%         for p = 1:length(ITDt(:,i))
%             datos(m==ITDww(p,1),n==ITDww(p,2)) = ITDt(p,i);
%         end
%         %datos(:,n==-90) = 0; datos(:,n==90) = 0;
%         if strcmp(hrtf.GLOBAL_DatabaseName, 'CIPIC') || strcmp(hrtf.GLOBAL_DatabaseName, 'ARI')
%             hold on;
%             for q =1:length(ITDt(:,i))
%                 plot3(ITDww(q,1),ITDww(q,2),ITDt(q,i),'.','MarkerEdgeColor',"#EDB120")
%             end
%         else
%             surf(m',n',datos');
%         end
%         ylabel('Elevacion'); xlabel('Azimut');
%         title(txt,'Interpreter','none');
%         fig = gcf;
%         saveas(fig,carpeta+txt+'.jpg');
%         close(fig);
    end
end
%%%%%%%%%%%%----DIFERENCIA DE ITD----%%%%%%%%%%%%%

% diffITD = [];
% format long;
% nr = 0; nc = 0;
% [nr,nc] = size(ITDt);
% diffITD(nr,nc) = 0;
% diffITD = ITDt-ITDww(:,3);
% SUM(length(nc)) = 0;
% for i = 1:nc
%     SUM(i) = sum(diffITD(:,i).^2);
% end
% [~,mu] = min(SUM); %mu: Posicion del minimo umbral
% TdiffITD = SUM;
% bestUmbral = Umbral(SUM==min(SUM));
% bestUmbral = FC(SUM==min(SUM));

end

