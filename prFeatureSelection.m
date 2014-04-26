 function [maxAuc,featureDecision] = prFeatureSelection(data,classifer,option)
 
if(strcmpi('sequential',option))
    dim=1:1:(size(data,2)-1);
    chosedFeature=size(data,2);
    maxAuc=0;
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
            
            if(auc<ret)
                auc=ret;
                index=j;
            end
            
            chosedFeature(1)=[];
        end
        chosedFeature=sort([dim(index) chosedFeature]);
        result(i)=auc;
        dim(index)=[];
        if(maxAuc<auc)
            maxAuc=auc;
            featureDecision=chosedFeature;
        end
        
        if(maxAuc==1)
           break;
        end
    end
    figure,plot(result);
    title('Auc with different Dimention');
    ylabel('Auc');xlabel('Dimention');
    featureDecision=featureDecision(:,1:end-1);
end

if(strcmpi('back',option))
    len=size(data,2)-1;
    chosedFeature=1:1:size(data,2);

    result=nan(len,1);
    [averPf,averPd]=prKCrossValidation(data,10,classifer);
    maxAuc=prAUC(averPf,averPd);
    result(len)=maxAuc;
    featureDecision=chosedFeature;
        
    for i=len-1:-1:1
        auc=0;
        index=0;
        for j=1:length(chosedFeature)-1;
            temp=chosedFeature;
            chosedFeature(j)= [];
            [averPf,averPd]=prKCrossValidation(data(:,chosedFeature),10,classifer);
         
            ret= prAUC(averPf,averPd);
            
            if(auc<ret)
                auc=ret;
                index=j;
            end           
            chosedFeature=temp;
        end
        
        chosedFeature(index)=[];
        result(i)=auc;
        if(maxAuc<=auc)
            maxAuc=auc;
            featureDecision=chosedFeature;
        end     
    end
    figure,plot(result);
    title('Auc with different Dimention');
    ylabel('Auc');xlabel('Dimention');
    featureDecision=featureDecision(:,1:end-1);
end


end

