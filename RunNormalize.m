close all;clc;clear all;
load('data/TargetData');
load('data/norm_location.mat');
load('data/norm_angle.mat');
warning('off','all');
warning;

feature=prDataTransfer(norm_location,distance,testanglelist);

target=target<10;
data=[feature target];

classifer.name='FLD';
[auc,selectFeature]=prFeatureSelection(data,classifer,'sequential');

classifer=prTrainClassifer([data(:,selectFeature) data(:,end)],classifer);

ds=prRunClassifer(classifer,test(:,selectFeature));


attribute={103};
[pf,pd]=prGenerateRoc(ds,testData(:,end),attribute);

figure,plot(pf,pd);
