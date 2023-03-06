function hrtf = GuardarSofaConRetardos(hrtf,name,Umbral)
%%Fills the cell Delay after Threshold method and save 
%%the HRTF in a new sofa

ITDt(length(hrtf.SourcePosition(:,1)),1)=0;
for x = 1:length(hrtf.SourcePosition(:,1))
    [ITDt(x,1),hrtf] = MetodoUmbral(hrtf,hrtf.SourcePosition(x,1), hrtf.SourcePosition(x,2), 3000, Umbral);
end
P = num2str(Umbral*100);
txt = convertStringsToChars(name + "_0_" + P +".sofa");
SOFAsave(txt,hrtf,0);
end

