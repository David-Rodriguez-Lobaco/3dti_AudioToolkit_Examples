function Reordenar(hrtf,gradosA,gradosE,valores)
%REORDENAR Summary of this function goes here
% Comprueba que los vectores sean iguales

if (length(gradosA) ~= length(gradosE)) || (length(gradosA) ~= length(valores))
    error('Different length vectors')
end

%% Construir una matriz regular
    
m = unique(gradosA);
n = unique(gradosE);
datos = nan(length(m),length(n));
for i = 1:length(valores)
    datos(m==gradosA(i),n==gradosE(i)) = valores(i);
end
%datos(:,n==-90) = 0; datos(:,n==90) = 0;

if strcmp(hrtf.GLOBAL_DatabaseName, 'CIPIC') || strcmp(hrtf.GLOBAL_DatabaseName, 'ARI')
    hold on;
    for i =1:length(valores)
        plot3(gradosA(i),gradosE(i),valores(i),'.','MarkerEdgeColor',"#EDB120")
    end
else
    surf(m',n',datos','EdgeColor',"#EDB120",'FaceAlpha','0.5','FaceColor',"#EDB120")
end
end

