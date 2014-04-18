function [ ds ] = prRunClassifer(classifer,test)
len=size(test,1);
ds=nan(len,1);

if(strcmpi(classifer.name,'Bayes'))
    miu0=classifer.miu0;
    miu1=classifer.miu1;
    c0=classifer.c0;
    c1=classifer.c1;
    p0=classifer.p0;
    p1=classifer.p1;

    for i=1:1:len
        x=test(i,:)';
        g0=-0.5*(x-miu0)'*(inv(c0))*(x-miu0)-0.5*log(det(c0))+log(p0);
        g1=-0.5*(x-miu1)'*(inv(c1))*(x-miu1)-0.5*log(det(c1))+log(p1);
        ds(i)=g1-g0;
    end
end

if(strcmpi(classifer.name,'DLRT'))
    n0=classifer.n0;
    n1=classifer.n1;
    D=classifer.D;
    K=classifer.K;
    data=classifer.data;
    
    data0=data(data(:,end)==0,1:end-1);
    data1=data(data(:,end)==1,1:end-1);
  
    for i=1:1:len  
        delta0=prFindKthDistance(test(i,:),data0,K);
        delta1=prFindKthDistance(test(i,:),data1,K);
        ds(i)=log(n0/n1)+D*(log(delta0)-log(delta1));
    end  
end

if(strcmpi(classifer.name,'FLD'))
    w=classifer.w;
    for i=1:1:len  
        ds(i)=w'*test(i,:)';
    end  
end

if(strcmpi(classifer.name,'SVM'))
%     ds= svmclassify(classifer,test,'Showplot',true);
      [ds,x]=svmdecision(test,classifer);
end

end

