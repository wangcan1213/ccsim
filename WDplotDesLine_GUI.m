function [ h ] = WDplotDesLine_GUI( x,XYZ, threshold,colorflag )
%�ڵõ�ģ�����󣬻�TAZ֮���������
%����x��NTAZ*NTAZ�ľ��󣬱�ʾ����������
%����XYZ:TAZ�ĵ�ͼ������Ϣ
%����threshold����ֵ�������еĽ�ͨ��ϵȫ������׼��Ϊ0-10֮�䣬threshold������>���ٵĲ������Ĭ����1
%����colorflag����ɫ����1Ϊ��ɫ��ʵ�ʣ�2Ϊ��ɫ��ģ�⣬Ĭ����1
%���h��ͼ����

if nargin==1
    threshold=1;
    colorflag=1;
elseif nargin==2
    colorflag=1;
end



%------------����-----------------%
x=round(x);
NTAZ = size(x, 1);
max_x=max(max(x));
x=(x-0)/max_x;
x=x*10;
for i=1:NTAZ
    for j=i+1:NTAZ
        crt_count=x(i,j)+x(j,i);
        if  crt_count>threshold
            frompolygon=XYZ(XYZ(:,1)==i,2:4);
            topolygon=XYZ(XYZ(:,1)==j,2:4);
            fromcenter=mean(frompolygon);
            tocenter=mean(topolygon);
            hold on
            if colorflag==2
                plot3([fromcenter(1);tocenter(1)],[fromcenter(2);tocenter(2)],[fromcenter(3);tocenter(3)],'r-','linewidth',crt_count)
            else
                plot3([fromcenter(1);tocenter(1)],[fromcenter(2);tocenter(2)],[fromcenter(3);tocenter(3)],'b-','linewidth',crt_count)
            end
        end
    end
end


h=gcf;

end

