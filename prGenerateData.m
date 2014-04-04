function [data] = prGenerateData()
% largeOddNumber = 1421387450; 
% rng(largeOddNumber);
% 
% num00=490;
% num01=10;
% num10=490;
% num11=10;
% 
% miu00=[-1 -1]';
% miu01=[0 0]';
% miu10=[2 1]';
% miu11=[0 0]';
% 
% C0=[1 -0.4;-0.4 1.5];
% C1=[2 0.9;0.9 1];
% Cout=[50 -30;-30 50];
% 
% ds00=mvnrnd(miu00,C0,num00);
% ds01=mvnrnd(miu01,Cout,num01);
% ds10=mvnrnd(miu10,C1,num10);
% ds11=mvnrnd(miu11,Cout,num11);
% 
% t0=zeros(num00+num01,1);
% t1=ones(num10+num11,1);
% 
% ds0=[ds00;ds01];
% ds1=[ds10;ds11];
% 
% data=[ds0 t0;ds1 t1];

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

