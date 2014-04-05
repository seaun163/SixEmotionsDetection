function [averPf,averPd] = prKCrossValidation(data,numFolds,classifer)
key0 = rem(1:length(data(data(:,end)==0)),numFolds)+1;
key0 = key0(randperm(length(key0)));
key1 = rem(1:length(data(data(:,end)==1)),numFolds)+1;
key1 = key1(randperm(length(key1)));

key=[key0';key1'];
data=[data(data(:,end)==0,:);data(data(:,end)==1,:)];
data=[data key];

num=102;
pd=zeros(num,1);
pf=zeros(num,1);
attribute={num};

for fold = 1:numFolds
    trainData=data(data(:,end)~=fold,1:end-1);
    classifer=prTrainClassifer(trainData,classifer);
    
    testData=data(data(:,end)==fold,1:end-2);
    target=data(data(:,end)==fold,end-1);
    ds=prRunClassifer(classifer,testData);
    
    [p_f,p_d]=prGenerateRoc(ds,target,attribute);
    pf=pf+p_f;
    pd=pd+p_d;
end

averPf=pf/numFolds;
averPd=pd/numFolds;
end

