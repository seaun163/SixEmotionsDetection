function[] = prVisualizeClassifer(trainData,classifer)
x1 = linspace(min(trainData(:,1))-0.2*abs(min(trainData(:,1))),max(trainData(:,1))+0.2*abs(max(trainData(:,1))),251);
x2 = linspace(min(trainData(:,2))-0.2*abs(min(trainData(:,2))),max(trainData(:,2))+0.2*abs(max(trainData(:,2))),251);

[xTest1,xTest2] = meshgrid(x1,x2);
xTest = [xTest1(:) xTest2(:)]; 

dsTest = prRunClassifer(classifer,xTest);

dsTest = reshape(dsTest,length(x2),length(x1));

figure,imagesc(x1([1 end]),x2([1 end]),dsTest)

hold on
plot(trainData(trainData(:,3)==0,1),trainData(trainData(:,3)==0,2),'b*'); 
plot(trainData(trainData(:,3)==1,1),trainData(trainData(:,3)==1,2),'ro');
legend('h0','h1');
end

