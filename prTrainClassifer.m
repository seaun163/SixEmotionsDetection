function [classifer] = prTrainClassifer(data,attribute)
name=attribute{1};
if(strcmpi(name,'Bayes'))
    x0=data(data(:,end)==0,1:end-1);
    x1=data(data(:,end)==1,1:end-1);

    miu0=mean(x0)';
    miu1=mean(x1)';

    c0=cov(x0);
    c1=cov(x1);

    p0=length(x0)/(length(x0)+length(x1));
    p1=length(x1)/(length(x0)+length(x1));

    classifer={name miu0 miu1 c0 c1 p0 p1};
end


if(strcmpi(name,'DLRT'))
    n0=length(data(data(:,end)==0));
    n1=length(data(data(:,end)==1));
    D=length(data(1,1:end-1));
    K=attribute{2};
    classifer={name n0 n1 D K data};
end

if(strcmpi(name,'FLD'))
    x0=data(data(:,end)==0,1:end-1);
    x1=data(data(:,end)==1,1:end-1);

    m0=mean(x0)';
    m1=mean(x1)';

    s0=cov(x0);
    s1=cov(x1);

    s=s0+s1;
    
    w=inv(s)*(m1-m0);

    classifer={name w};
end


end

