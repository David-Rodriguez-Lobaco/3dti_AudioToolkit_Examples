function ITDt = demoCCross(Obj)
% DEMOCCROSS Estimates ITD by Cross-Correlation method for a SOFA given around
% all horizontal plane.
% 
%Obj -> SOFA file given
%
%ITDt -> ITD vector with all angles on horizontal plane
    Phor = find(abs(Obj.SourcePosition(:,2)) < 10^-10); % Obtención de las muestras en el plano horizontal.
    ITDt = zeros(1,length(Phor));
    ITDw = zeros(1,length(Phor));
    theta = Obj.SourcePosition(Phor,1);
    for x = 1:length(Phor)
        ITDt(x) = CCross(Obj, Obj.SourcePosition(Phor(x),1), Obj.SourcePosition(Phor(x),2));
        if theta(x) > 90 && theta(x) < 270
            theta(x) = 180-theta(x);
        elseif theta(x) >= 270
            theta(x) = theta(x) - 360;    
        end
        ITDw(x) = -(0.09/344)*(theta(x)*pi/180 + sin(theta(x)*pi/180));
        if strcmp(Obj.GLOBAL_DatabaseName, 'CIPIC')
            ITDw(x) = -1*ITDw(x);
        end
    end    
    
    figure();
    stem(Obj.SourcePosition(Phor), ITDt, 'k'); title([Obj.GLOBAL_ListenerShortName ' ' Obj.GLOBAL_DatabaseName ' Cross-Correlation']);
    xlabel('Azimuth (º)'); ylabel('ITDt (s)'); grid on; hold on;
    stem(Obj.SourcePosition(Phor,1), ITDw, 'g');
    legend('Estimated', 'Theoretical');
    
    ECM = sum((ITDw-ITDt).^2)/length(ITDt)
end