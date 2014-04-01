close all;clc;clear all;
load('data/TargetData');
load('data/FeatureData');

x=[FeatureData(:,1,:);FeatureData(:,2,:)];
y=nan(98,213);

y(:,:)=x(:,1,:);
y=y';

FeatureData=y;

TargetData=TargetData<10;
data=[FeatureData TargetData];

attribution={'DLRT',5};
test=data(end-21:end,:);
data=data(1:end-20,:);
classifer=prTrainClassifer(data(1:end-10,:),attribution);


ds=prRunClassifer(classifer,test(:,1:end-1));




