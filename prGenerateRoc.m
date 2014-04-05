function [Pf,Pd ] = prGenerateRoc(ds,target,attribute)
pair=zeros(length(target),2);
pair(:,1)=ds;
pair(:,2)=target;
pair=sortrows(pair,1);

ds1=pair(pair(:,2)==1,1);
ds0=pair(pair(:,2)==0,1);

%fixd Pfas
num=attribute{1}-3;
step=0.99/num;
pfa=0:step:0.99;
index_beta=ceil(length(ds0)-pfa*length(ds0))';
beta=ds0(index_beta(:,1),1);

beta = [Inf; beta(:); -Inf]; 
numBeta = length(beta);

Pf = [0,pfa,1]';
Pd = nan(numBeta,1);

for thisBeta = 1:1:numBeta
    Pd(thisBeta)=length(find(ds1>=beta(thisBeta)))/length(ds1);
end

end

