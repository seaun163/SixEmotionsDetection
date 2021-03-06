close all;clear all;clc;

load('data/TargetData');
load('data/norm_location_train.mat');
load('data/norm_angle_train.mat');
load('data/FLDFeature.mat');
load('data/norm_location_test2.mat');
warning('off','all');
warning;

featureTrain=prDataTransfer(norm_location_train, distance_train, anglelist_train)-0.5;
test=prDataTransfer(norm_location_test, distance_test, anglelist_test)-0.5;

dataAN=[featureTrain TargetRefine('AN',target)];
dataDI=[featureTrain TargetRefine('DI',target)];
dataFE=[featureTrain TargetRefine('FE',target)];
dataHA=[featureTrain TargetRefine('HA',target)];
dataNE=[featureTrain TargetRefine('NE',target)];
dataSA=[featureTrain TargetRefine('SA',target)];
dataSU=[featureTrain TargetRefine('SU',target)];

classifer.name='FLD';
[auc featureAN]=prFeatureSelection(dataAN,classifer,'back');
[auc featureDI]=prFeatureSelection(dataDI,classifer,'back');
[auc featureFE]=prFeatureSelection(dataFE,classifer,'back');
[auc featureHA]=prFeatureSelection(dataHA,classifer,'back');
[auc featureNE]=prFeatureSelection(dataNE,classifer,'back');
[auc featureSA]=prFeatureSelection(dataSA,classifer,'back');
[auc featureSU]=prFeatureSelection(dataSU,classifer,'back');


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

threAN=min(dsAN(dataAN(:,end)==1));
threDI=min(dsDI(dataDI(:,end)==1));
threFE=min(dsFE(dataFE(:,end)==1));
threHA=min(dsHA(dataHA(:,end)==1));
threNE=min(dsNE(dataNE(:,end)==1));
threSA=min(dsSA(dataSA(:,end)==1));
threSU=min(dsSU(dataSU(:,end)==1));


result=nan(size(test,1),1);

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
%     if(dsDI1>=threDI)
%  		result(i)=2;
%     if(dsFE1>=threFE)
% 		result(i)=3;
%     elseif(dsHA1>=threHA)
% 		result(i)=4;
% 	if(dsNE1>=threNE)
% 		result(i)=5;
%      if(dsSA1>=threSA)
% 		result(i)=6;
% 	if(dsSU1>=threSU)
% 		result(i)=7;
	else
		result(i)=0;	
	end
end



