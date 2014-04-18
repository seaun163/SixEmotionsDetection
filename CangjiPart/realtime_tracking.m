% Signature: 
%   realtime_tracking
%
% Usage:
%   This function demonstrates how to use xx_track_detect in realtime demo.
%   The image frame is captured from a camera.
%
% Params:
%   None
%
% Return: None
%
% Author: 
%   Xuehan Xiong, xiong828@gmail.com
% 
% Citation:
%   Xuehan Xiong, Fernando de la Torre, Supervised Descent Method and Its
%   Application to Face Alignment. CVPR, 2013
%


function realtime_tracking

disp('Initializing tracker...');
[DM,TM,option] = xx_initialize;

frame_w = 640;
frame_h = 480;

S.fh = figure('units','pixels',...
              'position',[100 50 frame_w frame_h+50],...
              'menubar','none',...
              'name','INTRAFACE_TRACKER',...              
              'numbertitle','off',...
              'resize','off',...
              'renderer','painters');

S.ax = axes('units','pixels',...
            'position',[1 51 frame_w frame_h],...
            'drawmode','fast');

stop_button_im = imresize(imread('stop.jpg'),[30 30]);
S.pb = uicontrol('style','push',...
                 'units','pixels',...
                 'position',[281 6 40 40],...
                 'cdata',stop_button_im,...
                 'fontsize',12,...
                 'callback',{@pb_call});
               
S.im_h = imshow(cv.resize(imread('cute1.jpg'),[frame_w, frame_h]));
               
% Now we create a menu for the figure itself.
S.fm = uimenu(S.fh,'label','Source');
% check the OS
if ispc
  info = imaqhwinfo('winvideo');
elseif ismac
  info = imaqhwinfo('macvideo');
else
  info = imaqhwinfo('linuxvideo');
end
nr_cameras = length(info.DeviceInfo);

cameraID = zeros(nr_cameras,1);
cameraIndex = 1:nr_cameras;
camera_selected = -1;

for i = 1:nr_cameras
  S.fm(i+1) = uimenu(S.fm(1),'label',info.DeviceInfo(i).DeviceName);
  cameraID(i) = info.DeviceInfo(i).DeviceID-1;
end

set(S.fm(2:i+1),'callback',{@fm_call});
drawnow;

while camera_selected < 0
  pause(0.03);
  if ~ishandle(S.fh)
    return;
  end
  drawnow;
end

stop_pressed = false;
drawed = false;
output.pred = [];
linel = 60;
loc = [70 70];

cap = cv.VideoCapture(cameraID(camera_selected));
cap.set('FrameWidth',frame_w);
cap.set('FrameHeight',frame_h);
hold on;

%% tracking and detection

while ~stop_pressed
  tic;
  im = cap.read;
  if isempty(im), error('can not read stream from camera'); end
  
  output = xx_track_detect(DM,TM,im,output.pred,option);
  set(S.im_h,'cdata',im);
  te = toc;
  if isempty(output.pred)
    if drawed, delete_handlers(); end
  else
    update_GUI();
  end
  
  drawnow;
end
close;





%%
        % private function for drawing handlers
    function delete_handlers() 
      delete(S.pts_h); delete(S.time_h);
      delete(S.hh{1}); delete(S.hh{2}); delete(S.hh{3});
      drawed = false;
    end
  
    function p2D = projpose(pose,l)
      po = [0,0,0; l,0,0; 0,l,0; 0,0,l];
      p2D = po*pose.rot(1:2,:)';
    end
  
    % private function for updating drawing
    function update_GUI()
    
      if drawed
        p2D  = projpose(output.pose,linel); 
        set(S.hh{1},'xdata',[p2D(1,1) p2D(2,1)]+loc(1),'ydata',[p2D(1,2) p2D(2,2)]+loc(2));
        set(S.hh{2},'xdata',[p2D(1,1) p2D(3,1)]+loc(1),'ydata',[p2D(1,2) p2D(3,2)]+loc(2));
        set(S.hh{3},'xdata',[p2D(1,1) p2D(4,1)]+loc(1),'ydata',[p2D(1,2) p2D(4,2)]+loc(2));
        
        set(S.pts_h, 'xdata', output.pred(:,1), 'ydata',output.pred(:,2));
        set(S.time_h, 'string', sprintf('%d FPS',uint8(1/te)));
      else
        p2D  = projpose(output.pose,linel);
        
        S.hh{1}=line([p2D(1,1) p2D(2,1)]+loc(1),[p2D(1,2) p2D(2,2)]+loc(2));
        set(S.hh{1},'Color','r','LineWidth',3);
        
        
        S.hh{2}=line([p2D(1,1) p2D(3,1)]+loc(1),[p2D(1,2) p2D(3,2)]+loc(2));
        set(S.hh{2},'Color','g','LineWidth',3);
        
        S.hh{3}=line([p2D(1,1) p2D(4,1)]+loc(1),[p2D(1,2) p2D(4,2)]+loc(2));
        set(S.hh{3},'Color','b','LineWidth',3);
        
        S.pts_h   = plot(output.pred(:,1), output.pred(:,2), 'g*','markersize',2);
        S.time_h  = text(frame_w-100,50,sprintf('%d FPS',uint8(1/te)),'fontsize',20,'color','m');
        drawed = true;
      end
    end

      % private callback function 
      function [] = pb_call(varargin)
        % Callback for pushbutton
        stop_pressed = true;
      end
    
      function [] = fm_call(varargin)
        camera_selected = cameraIndex(S.fm(2:end) == varargin{1});
      end
    
  
end
