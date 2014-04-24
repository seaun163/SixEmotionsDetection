close all;clc;clear all;
load('data/TargetData');
load('data/norm_location_train.mat');
load('data/norm_angle_train.mat');
load('data/norm_angle_test.mat');
load('data/norm_location_test.mat');
warning('off','all');
warning;
%jige data raw process
featureTrain=prDataTransfer(norm_location_train, distance_train, anglelist_train)-0.5;
featureTest=prDataTransfer(norm_location_test, distance_test, anglelist_test)-0.5;
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
testTarget=[1 0 0 1 0 0 0 0 0 0 0 1 0 0 0 1 1 0 1 0 0]';

plotdata1=ds(testTarget==1);
plotdata2=ds(testTarget==0);

figure,plot(plotdata1,'ro');
hold on;
plot(plotdata2,'b*');

dsSelf=prRunClassifer(classifer,trainData(:,selectFeature));
SelfTarget=trainData(:,end);

H1Ds=dsSelf(SelfTarget==1);
H0Ds=dsSelf(SelfTarget==0);

H1Mean=mean(H1Ds);
H0Mean=mean(H0Ds);

H1Std=std(H1Ds);
H0Std=std(H0Ds);

pH1=normcdf(ds,H1Mean,H1Std);
pH0=1-normcdf(ds,H0Mean,H0Std);

[pH1' pH0' ds'/1000 testTarget]

plotdata1=dsSelf(SelfTarget==1);
plotdata2=dsSelf(SelfTarget==0);

figure,plot(plotdata1,'ro');
hold on;
plot(plotdata2,'b*');
plot(ds(testTarget==1),'ko');
plot(ds(testTarget==0),'co');


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


