function [distance] = prFindKthDistance( point,data,K)
point=repmat(point,size(data,1),1);
dis=sqrt(sum(((data-point).^2),2));

dis=sort(dis);
distance=dis(K);
end

