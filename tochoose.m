function [ choice] = tochoose( prob1 )
%功能：给定选择概率进行选择
%输入：N*2的矩阵，第一列为选项编码，第二列为对应的选择概率
NALT=size(prob1,1);
%检查概率之和是否为1
if sum(prob1(:,2))-1==0
    prob=prob1;
elseif sum(prob1(:,2))-1~=0 & abs(sum(prob1(:,2))-1)<=0.0001
    prob=[prob1(:,1),prob1(:,2)/sum(prob1(:,2))];                           %放缩至1
else
    disp('概率之和不为1')
    return;
end

prob=[prob,cumsum(prob(:,2))];                                              %3'：累积概率
a=rand;
judge=prob(:,3)-a;
judge1=find(judge>=0);
choice=prob(judge1(1),1);



end

