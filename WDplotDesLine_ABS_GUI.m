function [ h ] = WDplotDesLine_ABS_GUI( x,XYZ, maxv, minv,colorflag )
%�ڵõ�ģ�����󣬻�TAZ֮���������
%����x��NTAZ*NTAZ�ľ��󣬱�ʾ����������
%����XYZ:TAZ�ĵ�ͼ������Ϣ
%����max, min����ֵ�������еĽ�ͨ��ϵȫ����[min, max]��׼��Ϊ0-10֮�䣬ֻ�д˼�Ĳ����
%����colorflag����ɫ����1Ϊ��ɫ��ʵ�ʣ�2Ϊ��ɫ��ģ�⣬Ĭ����1
%���h��ͼ����



%------------����-----------------%
x=round(x);
NTAZ = size(x, 1);
x=(x-minv)/maxv;
x=x*10;
for i=1:NTAZ
    for j=i+1:NTAZ
        crt_count=x(i,j)+x(j,i);
        if  crt_count>0 & crt_count<=10
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

