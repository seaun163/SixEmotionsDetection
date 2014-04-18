close all;clear all;clc;

load('data/TargetData');
load('data/norm_location_train.mat');
load('data/norm_angle_train.mat');

featureTrain=prDataTransfer(norm_location_train, distance_train, anglelist_train)-0.5;
dataAN=[featureTrain TargetRefine('AN',target)];
dataDI=[featureTrain TargetRefine('DI',target)];
dataFE=[featureTrain TargetRefine('FE',target)];
dataHA=[featureTrain TargetRefine('HA',target)];
dataNE=[featureTrain TargetRefine('NE',target)];
dataSA=[featureTrain TargetRefine('SA',target)];
dataSU=[featureTrain TargetRefine('SU',target)];

classifer.name='FLD';
[auc featureAN]=prFeatureSelection(dataAN,classifer,'sequential');
[auc featureDI]=prFeatureSelection(dataDI,classifer,'sequential');
[auc featureFE]=prFeatureSelection(dataFE,classifer,'sequential');
[auc featureHA]=prFeatureSelection(dataHA,classifer,'sequential');
[auc featureNE]=prFeatureSelection(dataNE,classifer,'sequential');
[auc featureSA]=prFeatureSelection(dataSA,classifer,'sequential');
[auc featureSU]=prFeatureSelection(dataSU,classifer,'sequential');


classiferAN=prTrainClassifer([dataAN(:,featureAN) dataAN(:,end)],classifer);
classiferDI=prTrainClassifer([dataDI(:,featureDI) dataDI(:,end)],classifer);
classiferFE=prTrainClassifer([dataFE(:,featureFE) dataFE(:,end)],classifer);
classiferHA=prTrainClassifer([dataHA(:,featureHA) dataHA(:,end)],classifer);
classiferNE=prTrainClassifer([dataNE(:,featureNE) dataNE(:,end)],classifer);
classiferSA=prTrainClassifer([dataSA(:,featureSA) dataSA(:,end)],classifer);
classiferSU=prTrainClassifer([dataSU(:,featureSU) dataSU(:,end)],classifer);

dsAN=prRunClassifer(classiferAN,dataAN(:,featureAN));
dsDI=prRunClassifer(classiferDI,dataDI(:,featureDI));
dsFE=prRunClassifer(classiferFE,dataFE(:,featureFE));
dsHA=prRunClassifer(classiferHA,dataHA(:,featureHA));
dsNE=prRunClassifer(classiferNE,dataNE(:,featureNE));
dsSA=prRunClassifer(classiferSA,dataSA(:,featureSA));
dsSU=prRunClassifer(classiferSU,dataSU(:,featureSU));

threAN=min(dsAN(dataAN(:,end)));
threDI=min(dsDI(dataDI(:,end)));
threFE=min(dsFE(dataFE(:,end)));
threHA=min(dsHA(dataHA(:,end)));
threNE=min(dsNE(dataNE(:,end)));
threSA=min(dsSA(dataSA(:,end)));
threSU=min(dsSU(dataSU(:,end)));


result=nan(size(test,1));

for i=1:size(test,1)
	dsAN1=prRunClassifer(classiferAN,test(i,featureAN));
	dsDI1=prRunClassifer(classiferDI,test(i,featureDI));
	dsFE1=prRunClassifer(classiferFE,test(i,featureFE));
	dsHA1=prRunClassifer(classiferHA,test(i,featureHA));
	dsNE1=prRunClassifer(classiferNE,test(i,featureNE));
	dsSA1=prRunClassifer(classiferSA,test(i,featureSA));
	dsSU1=prRunClassifer(classiferSU,test(i,featureSU));

	if(dsAN1>=threAN)
	    result(i)=1;
	elseif(dsDI1>=threDI)
		result(i)=2;
	elseif(dsFE1>=threFE)
		result(i)=3;
	elseif(dsHA1>=threHA)
		result(i)=4;
	elseif(dsNE1>=threNE)
		result(i)=5;
	elseif(dsSA1>=threSA)
		result(i)=6;
	elseif(dsSU1>=threSU)
		result(i)=7;
	else
		result(i)=0;	
	end
end



