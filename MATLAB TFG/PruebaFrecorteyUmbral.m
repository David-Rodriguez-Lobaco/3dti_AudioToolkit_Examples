function [ITDt, ITDww, TdiffITD, bestUmbral] = PruebaFrecorteyUmbral(hrtf,name)


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
% Umbral = 0.1:0.01:0.6;
Umbral = 0.15:0.01:0.35;
FC = 2000:250:5000;
ITDt(length(hrtf.SourcePosition),length(FC),length(Umbral)) = 0;


for x = 1:length(hrtf.SourcePosition(:,1))
    for i=1:length(FC)
        for j=1:length(Umbral)
            ITDt(x,i,j) = MetodoUmbral(hrtf,hrtf.SourcePosition(x,1), hrtf.SourcePosition(x,2), FC(i), Umbral(j));
        end
    end
    ITDww(x,3) = ITDw(TCabeza,343.2,deg2rad(hrtf.SourcePosition(x,1)),hrtf.SourcePosition(x,2));
end

% carp = uigetdir('C:\Users\Ludio\Desktop\TFG\Imagenes ITDs', name);
% % carp2 = carp+"\archivo figura";
% for i=1:length(FC)
%     for j=1:length(Umbral)
%         figure
%         surf(rtograd,b,T','EdgeColor',"none",'EdgeColor',"#0072BD",'FaceAlpha',1); ylabel('Elevacion'); xlabel('Azimut');
%         %txt = name + " 2 Umbral= " + num2str(Umbral(i));
%         txt = name + " 2 FC= " + num2str(FC(i)) + " Umbral= " + num2str(Umbral(j));
%         title(txt,'Interpreter','none');
%         hold on;
%         Reordenar(hrtf,ITDww(:,1),ITDww(:,2),ITDt(:,i,j));
%         fig = gcf;
%         %txt2 = [carp2+"\"+txt];
%         txt =[carp+"\"+txt];
%     %     savefig(txt2+'.fig');
%         saveas(fig,txt+'.jpg');
%         hold off;
%         %    -----------------------------------------------------------------------
%         figure
%     %     txt = name + " 1 Umbral= " + num2str(Umbral(i));
%         txt = name + " 1 FC= " + num2str(FC(i)) + " Umbral= " + num2str(Umbral(j));
%         m = unique(ITDww(:,1));
%         n = unique(ITDww(:,2));
%         datos = nan(length(m),length(n));
%         view([-37.5 30]);
%         for p = 1:length(ITDt(:,i,j))
%             datos(m==ITDww(p,1),n==ITDww(p,2)) = ITDt(p,i,j);
%         end
%         %datos(:,n==-90) = 0; datos(:,n==90) = 0;
%         if strcmp(hrtf.GLOBAL_DatabaseName, 'CIPIC') || strcmp(hrtf.GLOBAL_DatabaseName, 'ARI')
%             hold on;
%             for q =1:length(ITDt(:,i,j))
%                 plot3(ITDww(q,1),ITDww(q,2),ITDt(q,i,j),'.','MarkerEdgeColor',"#EDB120")
%             end
%         else
%             surf(m',n',datos');
%         end
%         ylabel('Elevacion'); xlabel('Azimut');
%         title(txt,'Interpreter','none');
%         fig = gcf;
%     %     txt2 = [carp2+"\"+txt];
%         txt =[carp+"\"+txt];
%     %     savefig(txt2+'.fig');
%         saveas(fig,txt+'.jpg');
%     end
% end

%%%%%%%%%%%%----DIFERENCIA DE ITD----%%%%%%%%%%%%%

diffITD = [];
format long;
nr = 0; nc = 0;
[nr,nc,nd] = size(ITDt); %numero de filas, columnas y profundidad
diffITD(nr,nc,nd) = 0;
diffITD = ITDt-ITDww(:,3);
SUM(length(nc),length(nd)) = 0;
for i = 1:nc
    for j = 1:nd
     SUM(i,j) = sum(diffITD(:,i,j).^2);
    end
end
% [~,mu] = min(SUM); %mu: Posicion del minimo umbral
TdiffITD = SUM;
%bestUmbral = Umbral(SUM==min(SUM));
% bestUmbral = [FC(SUM==min(SUM)),Umbral(SUM==min(SUM))] ;
bestUmbral = min(min(SUM));
[bestUmbralr,bestUmbralc] = find(TdiffITD==bestUmbral);
bestUmbral = [FC(bestUmbralr) Umbral(bestUmbralc)];

end
