close all;clc;clear all;
load('data/TargetData');
load('data/norm_location.mat');
warning('off','all');
warning;

norm_location=squeeze([norm_location(:,1,:);norm_location(:,2,:)])'  ;
feature=[norm_location distance];


target=target<10;
data=[feature target];

classifer.name='FLD';
[auc,selectFeature]=prFeatureSelection(data,classifer,'sequential');