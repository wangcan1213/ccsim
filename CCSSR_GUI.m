function [ result_ped,result_taz ] = CCSSR_GUI(EV,IND, B)
%[����] Commercial Complex Simulation Single Run, in GUI
%[����] EV�������Ա����� IND�������Ա�����B���Ա�������
%[���] result_ped:�����ģ������result_taz��С����ģ����
%[EV�ṹ��] area�����; dist:TAZ��ˮƽ����; dist_ent:�����ˮƽ����; stdf:TAZ���������;
%stdf_ent:������������; NTAZ:TAZ����
%[IND�ṹ��] ent_distrib: ����������߷ֲ�; familarity:��������Ϥ��; NPED������������
%[B�ṹ��] area, familarity, dist, stdf, visited, past

X_area = EV.area;
X_dist = EV.dist;
X_dist_ent = EV.dist_ent;
X_stdf = EV.stdf;
X_stdf_ent = EV.stdf_ent;
X_ent_distrib = IND.ent_distrib ;
X_familarity = IND.familarity;
NPED = IND.NPED;
NTAZ = EV.NTAZ;
NENT = EV.NENT;
NALT = NTAZ + 1;
b_area = B.area;
b_familarity = B.familarity;
b_dist = B.dist;
b_stdf = B.stdf;
b_visited = B.visited;
b_past = B.past;
BTAZ = [b_area , b_familarity , b_dist , b_stdf , b_visited ]';
BHOME = b_past;

if size(X_familarity , 2) ~= NPED
    sample_f = unidrnd(size(X_familarity , 2) , NPED ,1);
    X_familarity = X_familarity(: , sample_f);
end

   
if size(X_ent_distrib, 2) == 2 & size(X_ent_distrib, 1) ~= NPED
    %������һ�£�һ����Ϊ����ȫ�ĸ�����Ϣ���ɴ˵���������Ϣ����
    tab_ent_distrib = tabulate(X_ent_distrib(:,2));
    tab_ent_distrib = tab_ent_distrib(: , 3) / 100;
    X_ent_distrib = tab_ent_distrib;        %ԭ���Ĳ���ȫ�ĸ�����Ϣ�ü�����Ϣ���
    X_ent_distrib_type = 1;
elseif size(X_ent_distrib, 2) == 2 & size(X_ent_distrib, 1) == NPED
    X_ent_distrib =  X_ent_distrib(:,2);
    X_ent_distrib_type = 2;
else
    X_ent_distrib_type = 1;  
end

% if max(X_ent_distrib) < 1 & NENT ~= 1
if X_ent_distrib_type == 1;  
    %��ʱΪ���������Ϣ
    X_ent_distrib_aggr = X_ent_distrib;
    for j = 1 : NPED
        X_ent_distrib_ind(j , 1) = tochoose([[1:NENT]',X_ent_distrib_aggr]);
    end
    X_ent_distrib = X_ent_distrib_ind;
end
             
result_ped = cell(NPED,4);                                                  %NPED*4
result_taz = 1:NALT;
result_taz = [result_taz',zeros(NALT,1)];                                   %46*2

CheckEveryOneReachExit = zeros(NPED,1);                                     %��������Ƿ�ÿ���˶����ѡ���˳��ڣ����Ƿ����������·��

for i = 1 : NPED
    result_ped{i,1} = i;                                                    %cell��1�м���PED���
    crtFamilarity = X_familarity(: , i);                                    %��ǰ�����TAZ����ʶ����Ϥ�ȣ���for-loop�ﱣ�ֲ���,45*2
    crtVstd = zeros(NTAZ,1);                                                %TAZ�Ƿ���ȥ����45*1
    crtPstArN = 0;                                                          %�ѻ��εĴ���
%     crtPstDist=0;                                                          %���߹��ľ���
%     crtPstStDf=0;                                                          %���߹��������
    
    %��ڽ׶�ѡ��
    %   ����׼������ڽ׶Σ�   
    crtEntrance = X_ent_distrib(i);                                         %��ǰ���
    result_ped{i,2} = crtEntrance;                                          %cell��2�м������
    crtDist = X_dist_ent(: , crtEntrance);                                  %��ǰ��ڵ���TAZ�ľ��룬NTAZ*1
    crtStDf = X_stdf_ent(: , crtEntrance);                                  %��ǰ��ڵ���TAZ��������죬NTAZ*1
%     crtCntgHrz=contiguity_horizon_entrance(:,crtEntrance);                  %��ǰ��ڵ���TAZ��ˮƽ���ڹ�ϵ��45*1
%     crtCntgEsc=contiguity_escalator_entrance(:,crtEntrance);                %��ǰ��ڵ�TAZ�ķ������ڹ�ϵ��45*1
%     crtCntgElv=contiguity_elevator_entrance(:,crtEntrance);                 %��ǰ��ڵ�TAZ�ĵ������ڹ�ϵ��45*1
%     crtEntDistConvert=crtDist;                                              %ƽ�����ЧӦ����ڴ���ͬ�ڵ���ڵľ��루past=0,1-past=1����45*1
%     crtEntStDfConvert=crtStDf;                                              %�������ЧӦ����ڴ���ͬ�ڵ���ڵ������(past=0,1-past=1)��45*1
%     crtBckHrz=ones(NALT-1,1);                                               %��һ��������ƽ���ͷ����Ϊ1��45*1                                                          
%     crtBckVtc=ones(NALT-1,1);                                               %��һ�������������ͷ����Ϊ1��45*1
    crtXTAZ = [X_area, crtFamilarity, crtDist, crtStDf, crtVstd];           %TAZ�ɼ�Ч�ã�NTAZ*5 
    crtXHOME = [crtPstArN];                                                 %HOME�ɼ�Ч�ã�1*1
    %   ����Ч����ִ��ѡ����ڽ׶Σ�
    crtVTAZ = crtXTAZ * BTAZ;                                               %taz�ɼ�Ч��,NTAZ*1
    crtVHOME = crtXHOME * BHOME;                                            %home�ɼ�Ч��,1*1
    crtV = [crtVTAZ ; crtVHOME];                                            %����һ��,NALT*1
    crtEV = exp(crtV);                                                      %eV
    crtProb = crtEV / sum(crtEV);                                           %ѡ�����,NALT*1
    crtToChooseX = [[1:NALT]' , crtProb];                                   %�ܱ�tochoose���õ��Ա�������һ��Ϊ��ѡ���ţ��ڶ���Ϊ���ʣ�NALT*2
    crtChoice = tochoose(crtToChooseX);                                     %ѡ����
    while crtChoice == NALT                                                 %��֤��������ھ�ѡ�����
        crtChoice = tochoose(crtToChooseX);
    end
    %   ��̬������������ݣ���ڣ�
    crtPstArN = crtPstArN + 1;                                              %�����ѻ��εĴ���
%     crtPstDist=crtPstDist+dist_entrance(crtChoice,crtEntrance);             %�������߹��ľ���
%     crtPstStDf=crtPstStDf+stair_entrance(crtChoice,crtEntrance);            %�������߹��������
    crtVstd(crtChoice) = crtVstd(crtChoice) + 1;                            %������ȥ���ĵط����ۼ�ʽ����ע�⣬��ڽ׶��ѱ�֤������ѡ����ڣ�46����NTAZ*1
    crtRoute = crtChoice;                                                   %��ǰ·���ĵ�һ��Ԫ��Ϊ���ѡ����
    %   �����¼����ڣ�
    result_ped{i , 4} = 1;                                                  %cell��4�и���Ϊ1��ʾ����1���ط�
    result_taz(crtChoice,2) = result_taz(crtChoice,2) + 1;                  %taz����ж�Ӧ��taz����+1
    
    %���ν׶�
    while 1
        crtFrom = crtRoute(end);                                            %��ǰѭ����ѡ�񣩵�����λ�ã�������һ��ѡ��Ľ��
%         if length(crtRoute)>1                                               %��ǰѭ������һ��λ�ã����ֻ��һ��·���㣬��û����һ��
%             lastStop=crtRoute(end-1);
%         else
%             lastStop=nan;
%         end
    %   ����׼�������Σ�   
        crtDist = X_dist(: , crtFrom);                                      %��ǰλ�õ���TAZ�ľ��룬NTAZ*1
        crtStDf = X_stdf(: , crtFrom);                                      %��ǰλ�õ���TAZ��������죬45*1
%         crtCntgHrz=contiguity_horizon(:,crtFrom);                           %��ǰλ�õ���TAZ��ˮƽ���ڹ�ϵ��45*1
%         crtCntgEsc=contiguity_escalator(:,crtFrom);                         %��ǰλ�õ�TAZ�ķ������ڹ�ϵ��45*1
%         crtCntgElv=contiguity_elevator(:,crtFrom);                          %��ǰλ�õ�TAZ�ĵ������ڹ�ϵ��45*1
%         crtPstDistConvert=1-(crtPstDist/200);                               %Ϊ����ƽ�����ЧӦ�������߹��ľ������ת������ֵ200��scalar
%         crtEntDistConvert=dist_entrance(:,crtEntrance)*crtPstDistConvert;   %ƽ�����ЧӦ��ǰ��Ϊ��TAZ����ھ��룬�������ˣ�45*1
%         crtPstStDfConvert=1-(crtPstStDf/1);                                 %Ϊ�����������ЧӦ�������߹�������������ת������ֵ1��scalar
%         crtEntStDfConvert=stair_entrance(:,crtEntrance)*crtPstStDfConvert;  %�������ЧӦ,ǰ��Ϊ��TAZ�����������죬�������ˣ�45*1
        
%         if isnan(lastStop)~=1
%             for ii=1:NALT-1                                                 %ͨ��ѭ������������goBack�е�����
%                 nextTo=ii;
%                 lastCrtNextIndex=lastStop*10000+crtFrom*100+nextTo;
%                 crtBckHrz(ii)=goBack(goBack(:,4)==lastCrtNextIndex,9);      %ˮƽ�۷���45*1
%                 crtBckVtc(ii)=goBack(goBack(:,4)==lastCrtNextIndex,10);     %��ֱ�۷���45*1
%             end                                   
%         else
%             crtBckHrz=ones(NALT-1,1);                                       %���û����һ������ʵ����ڣ��ݲ����ǣ���������Ϊ������ˮƽ�۷���45*1
%             crtBckVtc=ones(NALT-1,1);                                       %���û����һ������ʵ����ڣ��ݲ����ǣ���������Ϊ�����������۷���45*1
%         end
        crtXTAZ=[X_area, crtFamilarity, crtDist, crtStDf,crtVstd];          %TAZ�ɼ�Ч�ã�NTAZ*5 
        crtXHOME = [crtPstArN];                                             %HOME�ɼ�Ч�ã�1*1
        
        %   ����Ч����ִ��ѡ�񣨻��Σ�
        crtVTAZ = crtXTAZ * BTAZ;                                           %taz�ɼ�Ч��,NTAZ*1
        crtVHOME = crtXHOME * BHOME;                                        %home�ɼ�Ч��,1*1
        crtV = [crtVTAZ ; crtVHOME];                                        %����һ��,NALT*1
        crtEV = exp(crtV);                                                  %eV
        crtProb = crtEV / sum(crtEV);                                       %ѡ����ʳ�ʼ��,NALT*1
        crtToChooseX = [[1:NALT]',crtProb];                                 %�ܱ�tochoose���õ��Ա�������һ��Ϊ��ѡ���ţ��ڶ���Ϊ���ʣ�NALT*2
        crtChoice = tochoose(crtToChooseX);                                 %ѡ����
        if crtChoice ~= NALT                                                %���ѡ������Ϊ����
        %   ��̬������������ݣ����Σ�    
            crtPstArN = crtPstArN + 1;                                      %�����ѻ��εĴ���,scalar
%             crtPstDist=crtPstDist+dist(crtChoice,crtFrom);                  %�������߹��ľ���,scalar
%             crtPstStDf=crtPstStDf+stair(crtChoice,crtFrom);                 %�������߹��������,scalar
            crtVstd(crtChoice) = crtVstd(crtChoice) + 1;                    %������ȥ���ĵط����ۼ�ʽ����ע��,��ʱ��ѭ��������֤��û��ѡ����ڣ�NALT����NTAZ*1
            crtRoute(end+1) = crtChoice;                                    %��ǰ·���ĵ�һ��Ԫ��Ϊ���ѡ��������̬�仯����
        %   �����¼����ڣ�
            result_ped{i,4} = result_ped{i,4} + 1;                          %cell��4�и���,+1��ʾ��ȥ��һ���ط�
            result_taz(crtChoice,2) = result_taz(crtChoice,2) + 1;          %taz����ж�Ӧ��taz����+1  
        else                                                                %���ѡ�������ǳ���
            result_taz(crtChoice,2) = result_taz(crtChoice,2) + 1;          %�ճ�����taz����ж�Ӧ��taz����+1����ʱ��Ϊ���һ��gohomeѡ��+1
            CheckEveryOneReachExit(i) = 1;                                  %���¸�PED�ĵ�����ڼ������
        end
        %   �����еĳ��ڽ׶�
        if crtChoice == NALT;
            break                                                           %�ܳ�����ѭ��
        end
    end
    
    result_ped{i,3} = crtRoute;

end

    
% %������
% if isequal(CheckEveryOneReachExit,ones(NPED,1))==1
%     disp('�����˶�������·��')    
% else
%     disp('�����⣬���������˶�������·������')
% end




