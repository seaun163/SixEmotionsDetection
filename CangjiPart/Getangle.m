function Getangle (Method)


% for all picture detection, there are 49 points on each face,
% so we can get the angles relation according to the these locations.


if strcmp(Method, 'train')
load('facedetect_train.mat');

for i=1:size(result,3),
vectorx=result(2:49,1,i)-result(1:48,1,i);
vectory=result(2:49,2,i)-result(1:48,2,i);

% There are 48 unrelated angle information;
vectorangle = atan2d(vectory,vectorx);

% There are 47 related angle information.

oneface = 180+vectorangle(2:48)-vectorangle(1:47);
for j = 1:47,
    if oneface(j,1) < 0
%         if abs(oneface(j,1))>90,
            oneface(j,1)= oneface(j,1)+360;
%         else
%             oneface(j,1)= abs(oneface(j,1));
%         end
    end
    
    if oneface(j,1) > 360
            oneface(j,1)= oneface(j,1)-360;

    end
end
% normalize
anglelist(:,i) =1/360* oneface';
%anglelist(:,i) = oneface';
end

anglelist = anglelist';
anglelist_train = anglelist;

save('norm_angle_train.mat','anglelist_train');

end


if strcmp(Method, 'test')
load('facedetect_test.mat');

for i=1:size(result,3),
vectorx=result(2:49,1,i)-result(1:48,1,i);
vectory=result(2:49,2,i)-result(1:48,2,i);

% There are 48 unrelated angle information;
vectorangle = atan2d(vectory,vectorx);

% There are 47 related angle information.

oneface = 180+vectorangle(2:48)-vectorangle(1:47);
for j = 1:47,
    if oneface(j,1) < 0
%         if abs(oneface(j,1))>90,
            oneface(j,1)= oneface(j,1)+360;
%         else
%             oneface(j,1)= abs(oneface(j,1));
%         end
    end
    
    if oneface(j,1) > 360
            oneface(j,1)= oneface(j,1)-360;

    end
end
% normalize
anglelist(:,i) =1/360* oneface';
%anglelist(:,i) = oneface';
end

anglelist = anglelist';
anglelist_test = anglelist;

save('norm_angle_test.mat','anglelist_test');

end
