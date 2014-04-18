close all;clc;clear all;
load('data/TargetData');
load('data/norm_location_train.mat');
load('data/norm_angle_train.mat');
load('data/norm_angle_test.mat');
load('data/norm_location_test.mat');
load('data/facedetect_test_extend.mat');
warning('off','all');
warning;
%jige data raw process
featureTrain=prDataTransfer(norm_location_train, distance_train, anglelist_train)-0.5;
featureTest=prDataTransfer(norm_location_test, distance_test, anglelist_test)-0.5;
testData=featureTest;
%target defined for train data
target=(target<50&target>39);
data=[featureTrain target];

%trainData set
trainData=data;

%classifer specification
classifer.name='FLD';
[auc,selectFeature]=prFeatureSelection(trainData,classifer,'sequential');
 
%train classifier with selected feature set
classifer=prTrainClassifer([trainData(:,selectFeature) trainData(:,end)],classifer);
ds=prRunClassifer(classifer,testData(:,selectFeature));

testTarget=[0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 1 ]';

dsSelf=prRunClassifer(classifer,trainData(:,selectFeature));
SelfTarget=trainData(:,end);

% SVM shreshold selection
dataSVM=[dsSelf SelfTarget];
sortrows(dataSVM)
testSVM=ds;
classifer.name='SVM';
classifer.Name='kernel_function';
classifer.Value='mlp';
classifer=prTrainClassifer(dataSVM,classifer);
dsSVM=prRunClassifer(classifer,testSVM);

% draw ROC
attribute={103};
[pf,pd]=prGenerateRoc(ds,testTarget,attribute);
figure,plot(pf,pd,'linewidth',8);
title('Roc curve on Star Face Emotion Detection');
xlabel('pf');ylabel('pd');


