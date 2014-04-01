function [ ds ] = prRunClassifer(classifer,test)
name=classifer{1};
len=size(test,1);
ds=nan(len,1);

if(strcmpi(name,'Bayes'))
    miu0=classifer{2};
    miu1=classifer{3};
    c0=classifer{4};
    c1=classifer{5};
    p0=classifer{6};
    p1=classifer{7};

    for i=1:1:len
        x=test(i,:)';
        g0=-0.5*(x-miu0)'*(inv(c0))*(x-miu0)-0.5*log(det(c0))+log(p0);
        g1=-0.5*(x-miu1)'*(inv(c1))*(x-miu1)-0.5*log(det(c1))+log(p1);
        ds(i)=g1-g0;
    end
end

if(strcmpi(name,'DLRT'))
    n0=classifer{2};
    n1=classifer{3};
    D=classifer{4};
    K=classifer{5};
    data=classifer{6};
    
    data0=data(data(:,end)==0,1:end-1);
    data1=data(data(:,end)==1,1:end-1);
  
    for i=1:1:len  
        delta0=prFindKthDistance(test(i,:),data0,K);
        delta1=prFindKthDistance(test(i,:),data1,K);
        ds(i)=log(n0/n1)+D*(log(delta0)-log(delta1));
    end  
end

if(strcmpi(name,'FLD'))
    w=classifer{2};
    for i=1:1:len  
        ds(i)=w'*test(i,:)';
    end  
end

end

