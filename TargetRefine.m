function [target] = TargetRefine( emotion,target)
if(strcmp(emotion,'AN'))
       upper=9;lower=0;
elseif(strcmp(emotion,'DI'))
        upper=19;lower=10;
elseif(strcmp(emotion,'FE'))
        upper=29;lower=20;
elseif(strcmp(emotion,'HA'))
        upper=39;lower=30;
elseif(strcmp(emotion,'NE'))
        upper=49;lower=40;
elseif(strcmp(emotion,'SA'))
        upper=59;lower=50;
elseif(strcmp(emotion,'SU'))
        upper=69;lower=60;
end
target=(target<upper&target>lower);
end

