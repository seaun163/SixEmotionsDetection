function [targetEmotion]=prTargetGenerate()
D = dir('data/train/*.tiff');
targetEmotion = nan(numel(D),1);

for i=1:numel(D)
    emotion=D(i).name(4:5);
    degree=str2double(D(i).name(6:6));
    if(strcmp(emotion,'AN'))
       targetEmotion(i)= degree+0;
    elseif(strcmp(emotion,'DI'))
        targetEmotion(i)= degree+10;
    elseif(strcmp(emotion,'FE'))
        targetEmotion(i)= degree+20;
    elseif(strcmp(emotion,'HA'))
        targetEmotion(i)= degree+30;
    elseif(strcmp(emotion,'NE'))
        targetEmotion(i)= degree+40;
    elseif(strcmp(emotion,'SA'))
        targetEmotion(i)= degree+50;
    elseif(strcmp(emotion,'SU'))
        targetEmotion(i)= degree+60;
    end
end

end
