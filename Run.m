close all;clc;clear all;
load('data/TargetData');
load('data/FeatureData');

feature=squeeze([feature(:,1,:);feature(:,2,:)])';
target=target<10;
data=[feature target];

attribute={'DLRT',5};
[pf,pd]=prKCrossValidation(data,10,attribute);
figure,plot(pf,pd);
xlabel('pf');ylabel('pd');
title('DLRT Classifer');
% auc(i)=prAUC(pf,pd);




