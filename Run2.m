close all;clc;clear all;
load('data/TargetData');
load('data/47RelatedAngle');
load('data/TestResult');

feature=anglelist;
target=target<10;
data=[feature target];
test=testanglelist;

classifer.name='FLD';
% classifer.Name='kernel_function';
% classifer.Value='linear';

classifer=prTrainClassifer(data,classifer);
ds=prRunClassifer(classifer,test);


% classifer.name='DLRT';
% classifer.K=7;
% [pf,pd]=prKCrossValidation(data,10,classifer);
% figure,plot(pf,pd);
% xlabel('pf');ylabel('pd');
% auc=prAUC(pf,pd)

