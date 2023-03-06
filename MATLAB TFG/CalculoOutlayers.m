function porcAciertos = CalculoOutlayers(ITDt,ITDww)
%ITDt = reshape(ITDt,[8802 21]);  %añadido
DITD = ITDt - ITDww;

%%% (coger X maximos valores y crear unos limites con ellos)
copia_DITD = sort(abs(DITD),'descend');
porciento = round(length(DITD)*0.01); %%Porciento de datos que cojo
DifMax = [];
Umbral = 0.1:0.01:0.6;
%Umbral = 0.2:0.01:0.3;
%Umbral = 0.26;
DifMax(porciento,length(Umbral)) = 0;

for j=1:length(Umbral)
    for i=1:porciento
        DifMax(i,j) = copia_DITD(i,j);
    end
end

MEDIA = mean(DifMax);
aciertos = zeros(1,length(Umbral));
IntSup = ITDww + 2*MEDIA;
IntInf = ITDww - 2*MEDIA;
for i=1:length(Umbral)
    for j=1:length(DITD)
        if IntSup(j,i) > DITD(j,i) && IntInf(j,i) < DITD(j,i)
            aciertos(i) = aciertos(i)+1;
        end
    end
end
porcAciertos = aciertos*100/length(DITD);


end

