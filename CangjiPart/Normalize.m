function Normalize(Method)


% normalize the result
% to make sure every face is normalized?




if strcmp(Method, 'train')
    
load('facedetect_train.mat');


for i=1:size(result,3),
    middle = ones(49,1)*result(13,:,i);
    point_loc_befo = result(:,:,i)-middle;
    
    figure
%     
%   normalize the nose

%     x = point_loc_befo(11:14,1);
%     y = point_loc_befo(11:14,2);
%     p = polyfit(x,y,1);
%     theta = 90-atand(p(1));
%     a = [cosd(theta) -sind(theta);sind(theta) cos(theta)];
%     
%     for k=1:49,
%         point_loc_befo(k,:) = a*point_loc_befo(k,:)';
%     end
    
    normlength=max(point_loc_befo(:,1))*1.2-min(point_loc_befo(:,1))*1.2;
    point_loc_nor = point_loc_befo/normlength + ones(49,2)*0.5;
    
    norm_location_train(:,:,i) = point_loc_nor;
    
    plot(point_loc_nor(:,1),point_loc_nor(:,2));
    %plot(point_loc_nor(:,1),point_loc_nor(:,2),'g*','markersize',2);
    for j = 1:48
        distance_train(i,j) = norm(point_loc_nor(j+1,:)-point_loc_nor(j,:));
    end
end


save('norm_location_train.mat','norm_location_train','distance_train');

end


if strcmp(Method, 'test')
 
    load('facedetect_test.mat');


for i=1:size(result,3),
    middle = ones(49,1)*result(13,:,i);
    point_loc_befo = result(:,:,i)-middle;
    
    figure
%     
%   normalize the nose

%     x = point_loc_befo(11:14,1);
%     y = point_loc_befo(11:14,2);
%     p = polyfit(x,y,1);
%     theta = 90-atand(p(1));
%     a = [cosd(theta) -sind(theta);sind(theta) cos(theta)];
%     
%     for k=1:49,
%         point_loc_befo(k,:) = a*point_loc_befo(k,:)';
%     end
    
    normlength=max(point_loc_befo(:,1))*1.2-min(point_loc_befo(:,1))*1.2;
    point_loc_nor = point_loc_befo/normlength + ones(49,2)*0.5;
    
    norm_location_test(:,:,i) = point_loc_nor;
    
    plot(point_loc_nor(:,1),point_loc_nor(:,2));
    %plot(point_loc_nor(:,1),point_loc_nor(:,2),'g*','markersize',2);
    for j = 1:48
        distance_test(i,j) = norm(point_loc_nor(j+1,:)-point_loc_nor(j,:));
    end
end


save('norm_location_test.mat','norm_location_test','distance_test');
    
    
end


end

