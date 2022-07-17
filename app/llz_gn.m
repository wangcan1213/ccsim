function [gini]=llz_gn(population,volume,flag)
%2014-12-1
%���������������ϵ��

if nargin==2
    flag=1;
end

%����������С����
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
    close all
    plot(p,y,'LineWidth',1.5)
    grid on
    hold on
    plot([0,1],[0,1])
    axis equal
    xlim([0,1])
    ylim([0,1])
    set(gcf,'color','w')
%     xlabel('ͳ�Ƶ�Ԫ����','fontsize',13,'fontname','΢���ź�')
%     ylabel('ͣ���˴α���','fontsize',13,'fontname','΢���ź�')
%     title('�ռ�ֲ�����������','fontsize',20,'fontname','΢���ź�')
    xlabel('ͳ�Ƶ�Ԫ����','fontsize',13,'fontname','Microsoft YaHei')
    ylabel('ͣ���˴α���','fontsize',13,'fontname','Microsoft YaHei')
    title('�ռ�ֲ�����������','fontsize',20,'fontname','Microsoft YaHei')
%     text(0.05,0.9,['����ϵ���� ',num2str(gini)],'fontsize',16,'fontname','΢���ź�','BackgroundColor',[.7 .9 .7])
    set(gca,'xtick',0:0.1:1)
    set(gca,'ytick',0:0.1:1)
elseif flag==2
    hold on
    plot(p,y,'r','LineWidth',1.5)
    
end




end