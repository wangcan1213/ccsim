function [ choice] = tochoose( prob1 )
%���ܣ�����ѡ����ʽ���ѡ��
%���룺N*2�ľ��󣬵�һ��Ϊѡ����룬�ڶ���Ϊ��Ӧ��ѡ�����
NALT=size(prob1,1);
%������֮���Ƿ�Ϊ1
if sum(prob1(:,2))-1==0
    prob=prob1;
elseif sum(prob1(:,2))-1~=0 & abs(sum(prob1(:,2))-1)<=0.0001
    prob=[prob1(:,1),prob1(:,2)/sum(prob1(:,2))];                           %������1
else
    disp('����֮�Ͳ�Ϊ1')
    return;
end

prob=[prob,cumsum(prob(:,2))];                                              %3'���ۻ�����
a=rand;
judge=prob(:,3)-a;
judge1=find(judge>=0);
choice=prob(judge1(1),1);



end

