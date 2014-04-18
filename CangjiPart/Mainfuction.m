function  Mainfuction( Method )
%MAINFUCTION Summary of this function goes here
%   Detailed explanation goes here
if strcmp(Method,'train')
   
    %filepath = './data/train';
  fileinfo = dir('./data/train/*.tiff'); 
  %input = './data/KA.FE1.45.tiff';
  for j = 1:length(fileinfo),
  %for j = 1:1,
  % read image from input file
  im=imread(strcat('./data/train/',fileinfo(j).name));
  %figure;
  % load model and parameters, type 'help xx_initialize' for more details
  [DM,TM,option] = xx_initialize;
  
  
    % perform face alignment in one image, type 'help xx_track_detect' for
    % more details
    faces = DM{1}.fd_h.detect(im,'MinNeighbors',option.min_neighbors,...
      'ScaleFactor',1.2,'MinSize',option.min_face_size);
    %imshow(im); hold on;
    for i = 1:length(faces)
      output = xx_track_detect(DM,TM,im,faces{i},option);
      if ~isempty(output.pred)
        %plot(output.pred(:,1),output.pred(:,2),'g*','markersize',2);
        result(:,:,j) = output.pred;
      end
    end
    hold off

  end
  save('facedetect_train.mat','result');
end

if strcmp(Method, 'test')
    
  fileinfo = dir('./data/test/*.jpg'); 

  for j = 1:length(fileinfo),
  %for j = 1:1,
  % read image from input file
  im=imread(strcat('./data/test/',fileinfo(j).name));
  figure;
  fileinfo(j).name
  % load model and parameters, type 'help xx_initialize' for more details
  [DM,TM,option] = xx_initialize;
  
  
    % perform face alignment in one image, type 'help xx_track_detect' for
    % more details
    faces = DM{1}.fd_h.detect(im,'MinNeighbors',option.min_neighbors,...
      'ScaleFactor',1.2,'MinSize',option.min_face_size);
    imshow(im); hold on;
    for i = 1:length(faces)
      output = xx_track_detect(DM,TM,im,faces{i},option);
      if ~isempty(output.pred)
        plot(output.pred(:,1),output.pred(:,2),'g*','markersize',2);
        result(:,:,j) = output.pred;
      end
    end
    hold off

  end
  
        
   save('facedetect_test.mat','result');
   end
    
end



 