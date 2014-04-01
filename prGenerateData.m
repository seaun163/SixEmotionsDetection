function [data] = prGenerateData()
largeOddNumber = 1421387450; 
rng(largeOddNumber);

num0=500;
miu0=[-1 -1]';
C0=[1 -0.4;-0.4 1.5];

num1=500;
miu1=[2 1]';
C1=[2 0.9;0.9 1];

ds0=mvnrnd(miu0,C0,num0);
ds1=mvnrnd(miu1,C1,num1);
t0=zeros(num0,1);
t1=ones(num1,1);

data=[ds0 t0;ds1 t1];
end

