function [w, p ] = prEmotion(testDs,ds,target)
H1Ds=ds(target==1);
H0Ds=ds(target==0);

H1Mean=mean(H1Ds);
H0Mean=mean(H0Ds);

H1Std=std(H1Ds);
H0Std=std(H0Ds);

pH1=normcdf(testDs,H1Mean,H1Std);
pH0=1-normcdf(testDs,H0Mean,H0Std);

w=pH1;
p=pH1./(pH1+pH0);
end

