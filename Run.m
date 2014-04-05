close all;clc;clear all;
load('data/TargetData');
load('data/47RelatedAngle');

feature=anglelist;

target=target<10;
data=[feature target];

% classifer.name='SVM';
% classifer.Name='kernel_function';
% classifer.Value='linear';

classifer.name='FLD';
[auc,selectFeature]=prFeatureSelection(data,classifer,'sequential');

% classifer=prTrainClassifer(data(20:end,:),classifer);
% ds=prRunClassifer(classifer,data(1:19,1:end-1));
% ret=[ds data(1:19,end)]






% close all;clc;clear all;
% load('data/TargetData');
% load('data/FeatureData');
% feature=squeeze([feature(:,1,:);feature(:,2,:)])';
% target=target<10;
% data=[feature target];
% 
% classifer.name='FLD';
% [pf,pd]=prKCrossValidation(data,10,classifer);
% 
% figure,plot(pf,pd);
% xlabel('pf');ylabel('pd');
% % auc(i)=prAUC(pf,pd);