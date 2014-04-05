 function [maxAuc,featureDecision] = prFeatureSelection(data,classifer,option)
 
dim=1:1:size(data,2)-1;

chosedFeature=size(data,2);
maxAuc=0;
if(strcmpi('sequential',option))     
    for i=1:size(data,2)-1
        auc=0;
        index=0;
        for j=1:1:length(dim);
            chosedFeature=[dim(j) chosedFeature];
            data(:,chosedFeature);
            [averPf,averPd]=prKCrossValidation(data(:,chosedFeature),10,classifer);
            ret= prAUC(averPf,averPd);
            if(auc<ret)
                auc=ret;
                index=j;
            end
            chosedFeature(1)=[];
        end

        chosedFeature=sort([dim(index) chosedFeature]);
        
        dim(index)=[];
        if(maxAuc<auc)
            maxAuc=auc;
            featureDecision=chosedFeature;
        end
        
    end
end


end

