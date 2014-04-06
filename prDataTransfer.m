function [ feature ] = prDataTransfer(position,distance,angle )
norm_location=squeeze([position(:,1,:);position(:,2,:)])'  ;
norm_location(:,[13 62])=[];
feature=[norm_location distance angle];
end

