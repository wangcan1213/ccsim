function [ h ] = WDplotTAZ_GUI( x,xyz,colorflag,markersize, ax )
%在得到模拟结果后，画每个TAZ的人数散点图: GUI版
%格式：[ h ] = WDplotTAZ_GUI( x )
%输入x：行向量或列向量，长度等同于NTAZ，表示每个TAZ有多少人
%输入xyz：每个TAZ的XYZ
%输入colorflag：1为蓝色（实际），2为红色（预测），默认为1
%输入markersize：点的大小，默认为5——所有时刻一些输出的时候，5效果最好，分时输入可能偏小
%输出h：图像句柄

% if nargin==1
%     colorflag=1;
%     markersize=5;
% elseif nargin==2
%     markersize=5;
% end
if nargin == 4
    ax = gca;
end
%------------底图-----------------%

%------------数据-----------------%
h = cell(0);
k = 1;
for i = 1 : length(x)
    crtTAZ = i;
    crtCount = x(i);
    if crtCount > 0
        [crtX,crtY,crtZ] = randpointsinpolygon_GUI(crtTAZ , crtCount, xyz);
        hold on
        if colorflag == 1
            h{k} = plot3(ax, crtX, crtY, crtZ, 'b.', 'markersize', markersize );
            k = k + 1;
        elseif colorflag == 2
            h{k} = plot3(ax, crtX, crtY, crtZ, 'r.', 'markersize', markersize );
            k = k + 1;
        end
    end
end

% h=gcf;

end

