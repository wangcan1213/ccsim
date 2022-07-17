function [ h ] = WDplotDesLine_GUI( x,XYZ, threshold,colorflag )
%在得到模拟结果后，画TAZ之间的期望线
%输入x：NTAZ*NTAZ的矩阵，表示交换出行量
%输入XYZ:TAZ的底图坐标信息
%输入threshold：阈值——所有的交通联系全部被标准化为0-10之间，threshold控制了>多少的才输出，默认是1
%输入colorflag：颜色——1为蓝色表实际，2为红色表模拟，默认是1
%输出h：图像句柄

if nargin==1
    threshold=1;
    colorflag=1;
elseif nargin==2
    colorflag=1;
end



%------------数据-----------------%
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

