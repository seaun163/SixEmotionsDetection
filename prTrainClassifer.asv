function [classifer] = prTrainClassifer(data,classifer)

if(strcmpi(classifer.name,'Bayes'))
    x0=data(data(:,end)==0,1:end-1);
    x1=data(data(:,end)==1,1:end-1);

    classifer.miu0=mean(x0)';
    classifer.miu1=mean(x1)';

    classifer.c0=cov(x0);
    classifer.c1=cov(x1);

    classifer.p0=length(x0)/(length(x0)+length(x1));
    classifer.p1=length(x1)/(length(x0)+length(x1));
end


if(strcmpi(classifer.name,'DLRT'))
    classifer.n0=length(data(data(:,end)==0));
    classifer.n1=length(data(data(:,end)==1));
    classifer.D=length(data(1,1:end-1));
    classifer.data=data;
end

if(strcmpi(classifer.name,'FLD'))
    x0=data(data(:,end)==0,1:end-1);
    x1=data(data(:,end)==1,1:end-1);

    m0=mean(x0)';
    m1=mean(x1)';

    s0=cov(x0);
    s1=cov(x1);

    s=s0+s1;
    
    classifer.w=inv(s)*(m1-m0);

end

if(strcmpi(classifer.name,'SVM'))
    classifer=svmtrain(data(:,1:end-1),data(:,end),classifer.Name,classifer.Value,'autoscale',false);
    classifer.name='SVM';
end


end

