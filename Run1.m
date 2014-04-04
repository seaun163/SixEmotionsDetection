close all;clc;clear all;
load('data/TargetData');
load('data/FeatureData');

feature=squeeze([feature(:,1,:);feature(:,2,:)])';
target=target<10;
data=[feature target];

classifer.name='SVM';
classifer.Name='kernel_function';
classifer.Value='linear';

classifer=prTrainClassifer(data(1:end-21,:),classifer);
ds=prRunClassifer(classifer,data(end-20:end,1:end-1));

ret=[ds data(end-20:end,end)];

