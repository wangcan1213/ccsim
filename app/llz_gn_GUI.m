function [gini]=llz_gn_GUI(volume,flag,colorflag)
%2015-11-29
%洛伦兹曲线-GUI中画图用！
N = length(volume);
population = ones(N, 1);
if nargin==2
    flag=1;
end

%按客流量大小排序
N=length(volume);
density=volume./population;
[density2,index]=sort(density);
population2=population(index);
volume2=volume(index);

for i=1:N
    p(i)=sum(population2(1:i))/sum(population2);
    y(i)=sum(volume2(1:i))/sum(volume2);
end

p=[0,p];
y=[0,y];
gini=2*(0.5-trapz(p,y));


if flag==1
    if colorflag == 1
        plot(p ,y , 'b' , 'LineWidth' , 1.5)
    elseif colorflag == 2
        plot(p , y , 'r' , 'LineWidth' , 1.5)
    end
    grid on
    hold on
    plot([0,1] , [0,1])
    axis equal
    xlim([0,1])
    ylim([0,1])
    set(gcf,'color','w')
    
    set(gca,'xtick',0:0.1:1)
    set(gca,'ytick',0:0.1:1)
elseif flag==2
    hold on
    if colorflag == 1
        plot(p ,y , 'b' , 'LineWidth' , 1.5)
    elseif colorflag == 2
        plot(p , y , 'r' , 'LineWidth' , 1.5)
    end
    
end




end