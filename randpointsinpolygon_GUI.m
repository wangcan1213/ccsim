function [ xcoord,ycoord,zcoord] = randpointsinpolygon_GUI( taz, num ,XYZ )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
polygon_index=find(XYZ(:,1)==taz);
boundary=XYZ(polygon_index,2:4);
minX=min(boundary(:,1));
maxX=max(boundary(:,1));
minY=min(boundary(:,2));
maxY=max(boundary(:,2));
minZ=min(boundary(:,3));
maxZ=max(boundary(:,3));
if minZ==maxZ
    Z=minZ;
else
    msgbox(['ZÖµ´íÎó','TAZ±àºÅÎª£º',num2str(taz)])
end
t=0;
while t<num
    rX=unifrnd(minX,maxX,1,1);
    rY=unifrnd(minY,maxY,1,1);
    while inpolygon(rX,rY,boundary(:,1),boundary(:,2))==0;
        rX=unifrnd(minX,maxX,1,1);
        rY=unifrnd(minY,maxY,1,1);
    end
    t=t+1;
    xcoord(t,1)=rX;
    ycoord(t,1)=rY;
    zcoord(t,1)=Z;
end



end

