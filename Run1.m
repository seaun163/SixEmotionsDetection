close all;clear all;clc;

load('data/TargetData');
load('data/norm_location_train.mat');
load('data/norm_angle_train.mat');
load('data/FLDFeature.mat');
load('data/norm_location_test2.mat');
warning('off','all');
warning;

featureTrain=prDataTransfer(norm_location_train, distance_train, anglelist_train)-0.5;
test=prDataTransfer(norm_location_test, distance_test, anglelist_test)-0.5;

dataAN=[featureTrain TargetRefine('AN',target)];
dataDI=[featureTrain TargetRefine('DI',target)];
dataFE=[featureTrain TargetRefine('FE',target)];
dataHA=[featureTrain TargetRefine('HA',target)];
dataNE=[featureTrain TargetRefine('NE',target)];
dataSA=[featureTrain TargetRefine('SA',target)];
dataSU=[featureTrain TargetRefine('SU',target)];

classifer.name='FLD';

classiferAN=prTrainClassifer([dataAN(:,featureAN) dataAN(:,end)],classifer);
classiferDI=prTrainClassifer([dataDI(:,featureDI) dataDI(:,end)],classifer);
classiferFE=prTrainClassifer([dataFE(:,featureFE) dataFE(:,end)],classifer);
classiferHA=prTrainClassifer([dataHA(:,featureHA) dataHA(:,end)],classifer);
classiferNE=prTrainClassifer([dataNE(:,featureNE) dataNE(:,end)],classifer);
classiferSA=prTrainClassifer([dataSA(:,featureSA) dataSA(:,end)],classifer);
classiferSU=prTrainClassifer([dataSU(:,featureSU) dataSU(:,end)],classifer);

dsAN=prRunClassifer(classiferAN,dataAN(:,featureAN));
dsDI=prRunClassifer(classiferDI,dataDI(:,featureDI));
dsFE=prRunClassifer(classiferFE,dataFE(:,featureFE));
dsHA=prRunClassifer(classiferHA,dataHA(:,featureHA));
dsNE=prRunClassifer(classiferNE,dataNE(:,featureNE));
dsSA=prRunClassifer(classiferSA,dataSA(:,featureSA));
dsSU=prRunClassifer(classiferSU,dataSU(:,featureSU));

dsTestAN=prRunClassifer(classiferAN,test(:,featureAN));
dsTestDI=prRunClassifer(classiferDI,test(:,featureDI));
dsTestFE=prRunClassifer(classiferFE,test(:,featureFE));
dsTestHA=prRunClassifer(classiferHA,test(:,featureHA));
dsTestNE=prRunClassifer(classiferNE,test(:,featureNE));
dsTestSA=prRunClassifer(classiferSA,test(:,featureSA));
dsTestSU=prRunClassifer(classiferSU,test(:,featureSU));

[wAN,pAN]=prEmotion(dsTestAN,dsAN,dataAN(:,end));
[wDI,pDI]=prEmotion(dsTestDI,dsDI,dataDI(:,end));
[wFE,pFE]=prEmotion(dsTestFE,dsFE,dataFE(:,end));
[wHA,pHA]=prEmotion(dsTestHA,dsHA,dataHA(:,end));
[wNE,pNE]=prEmotion(dsTestNE,dsNE,dataNE(:,end));
[wSA,pSA]=prEmotion(dsTestSA,dsSA,dataSA(:,end));
[wSU,pSU]=prEmotion(dsTestSU,dsSU,dataSU(:,end));

ret=nan(size(wAN,2),7);
for i=1:size(wAN,2)
    w=wAN(i)*pAN(i)+wDI(i)*pDI(i)+wFE(i)*pFE(i)+wHA(i)*pHA(i)+wNE(i)*pNE(i)+wSA(i)*pSA(i)+wSU(i)*pSU(i);
    ret(i,1)=wAN(i)*pAN(i)/w;
    ret(i,2)=wDI(i)*pDI(i)/w;
    ret(i,3)=wFE(i)*pFE(i)/w;
    ret(i,4)=wHA(i)*pHA(i)/w;
    ret(i,5)=wNE(i)*pNE(i)/w;
    ret(i,6)=wSA(i)*pSA(i)/w;
    ret(i,7)=wSU(i)*pSU(i)/w;
end

ret(ret<0.01)=0;
fileinfo = dir('./data/test/*.jpg');
Labels={'AN';'DI';'FE';'HA';'NE';'SA';'SU'};
for j = 1:length(fileinfo),
  im=imread(strcat('./data/test/',fileinfo(j).name));
  figure,subplot(2,1,1),imshow(im);
  subplot(2,1,2),bar(ret(j,:));
  set(gca, 'XTick', 1:7, 'XTickLabel', Labels);
end


