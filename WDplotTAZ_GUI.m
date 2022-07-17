function [ h ] = WDplotTAZ_GUI( x,xyz,colorflag,markersize, ax )
%�ڵõ�ģ�����󣬻�ÿ��TAZ������ɢ��ͼ: GUI��
%��ʽ��[ h ] = WDplotTAZ_GUI( x )
%����x���������������������ȵ�ͬ��NTAZ����ʾÿ��TAZ�ж�����
%����xyz��ÿ��TAZ��XYZ
%����colorflag��1Ϊ��ɫ��ʵ�ʣ���2Ϊ��ɫ��Ԥ�⣩��Ĭ��Ϊ1
%����markersize����Ĵ�С��Ĭ��Ϊ5��������ʱ��һЩ�����ʱ��5Ч����ã���ʱ�������ƫС
%���h��ͼ����

% if nargin==1
%     colorflag=1;
%     markersize=5;
% elseif nargin==2
%     markersize=5;
% end
if nargin == 4
    ax = gca;
end
%------------��ͼ-----------------%

%------------����-----------------%
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

