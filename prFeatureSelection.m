 function [maxAuc,featureDecision] = prFeatureSelection(data,classifer,option)
 
dim=1:1:(size(data,2)-1);

chosedFeature=size(data,2);
maxAuc=0;

if(strcmpi('sequential',option))
    len=size(data,2)-1;
    result=nan(len,1);
    for i=1:len
        auc=0;
        index=0;
        for j=1:1:length(dim);
            chosedFeature=[dim(j) chosedFeature];
            data(:,chosedFeature);
            [averPf,averPd]=prKCrossValidation(data(:,chosedFeature),10,classifer);
         
            ret= prAUC(averPf,averPd);
            
            if(ret<=0)
                x=1;
            end
            if(auc<ret)
                auc=ret;
                index=j;
            end
            chosedFeature(1)=[];
        end
        
        chosedFeature=sort([dim(index) chosedFeature]);
        result(i)=auc;
        dim(index)=[];
        if(maxAuc<=auc)
            maxAuc=auc;
            featureDecision=chosedFeature;
        end
    end
    figure,plot(result);
    title('Auc with different Dimention');
    ylabel('Auc');xlabel('Dimention');
end
featureDecision=featureDecision(:,1:end-1);

end

