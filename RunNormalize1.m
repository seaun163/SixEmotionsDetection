
close all;clc;clear all;
load('data/TargetData');
load('data/norm_location_train.mat');
load('data/norm_angle_train.mat');
load('data/norm_angle_test.mat');
load('data/norm_location_test.mat');
warning('off','all');
warning;
%jige data raw process
featureTrain=prDataTransfer(norm_location_train, distance_train, anglelist_train);
featureTest=prDataTransfer(norm_location_test, distance_test, anglelist_test);
testData=featureTest;
%target defined for train data
target=(target<39&target>29);
data=[featureTrain target];

%trainData set
trainData=data;

%classifer specification
classifer.name='FLD';
[auc,selectFeature]=prFeatureSelection(trainData,classifer,'sequential');
 
%train classifier with selected feature set
classifer=prTrainClassifer([trainData(:,selectFeature) trainData(:,end)],classifer);
ds=prRunClassifer(classifer,testData(:,selectFeature));
% 
% ds=prRunClassifer(classifer,data(1:50,1:end-1));
% target=data(1:50,end);
% [pf,pd]=prGenerateRoc(ds,testTarget,attribute);
% figure,plot(pf,pd);

testTarget=[1 0 0 1 0 0 0 0 0 0 0 1 0 0 0 1 1 0 0 0 0];
attribute={103};
[pf,pd]=prGenerateRoc(ds,testTarget,attribute);

figure,plot(pf,pd);


