function [ result_ped,result_taz ] = CCSSR_GUI(EV,IND, B, all_var_name)
%[����] Commercial Complex Simulation Single Run, in GUI, �߼�ģʽ
%[����] EV�������Ա����� IND�������Ա�����B���Ա���������all_var_name�����б�����
%[���] result_ped:�����ģ������result_taz��С����ģ����
%[EV�ṹ��] X������familarity����ĸ��Ա�������Ϊ��������; NTAZ:TAZ����
%[IND�ṹ��] ent_distrib: ����������߷ֲ�; familarity:��������Ϥ��; NPED������������
%[B�ṹ��] ����ϵ��
%[all_var_nameԪ��]�� ���б�����

X = EV.X;
NTAZ = EV.NTAZ;
NENT = EV.NENT;
NALT = NTAZ + 1;

X_ent_distrib = IND.ent_distrib ;
X_familarity = IND.familarity;
NPED = IND.NPED;

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

NVAR = length(all_var_name);
BTAZ = [];
BHOME = [];
for i = 1 :NVAR
    crt_var = all_var_name{i};
    if ~isequal(crt_var, 'past')
        BTAZ = [BTAZ; getfield(B, crt_var)];
    else
        BHOME = [BHOME; getfield(B, crt_var)];
    end
end
%ע�⣬����BTAZ�б����������ǰ���B�б��������ģ���all_var_name��



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
    
    %��ڽ׶�ѡ��
    %   ����׼������ڽ׶Σ�   
    crtEntrance = X_ent_distrib(i);                                         %��ǰ���
    result_ped{i,2} = crtEntrance;                                          %cell��2�м������
    
    %������ǰX
    crtXTAZ = [];
    for kk = 1 : NVAR
        crt_var = all_var_name{kk};
        if ~isequal(crt_var, 'past') & ~isequal(crt_var, 'familarity') & ~isequal(crt_var, 'visited')
            crt_var_X = getfield(X, crt_var);
            if isempty(crt_var_X)
                errordlg('Something strange happen, see error 5001')
            end
            if ~isstruct(crt_var_X) 
                crtXTAZ = [crtXTAZ, crt_var_X];                             %���ǽṹ�壬Ӧ�þ���һ�б���
            else
                crtXTAZ = [crtXTAZ, crt_var_X.ent(:, crtEntrance)];
            end
        elseif isequal(crt_var, 'familarity')
            crt_var_X = X_familarity(: , i);
            crtXTAZ = [crtXTAZ, crt_var_X]; 
        elseif isequal(crt_var, 'visited')
            crtXTAZ = [crtXTAZ, crtVstd];
        end
    end
    
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
        %������ǰX�����ν׶Σ�
        crtXTAZ = [];
        for kk = 1 : NVAR
            crt_var = all_var_name{kk};
            if ~isequal(crt_var, 'past') & ~isequal(crt_var, 'familarity') & ~isequal(crt_var, 'visited')
                crt_var_X = getfield(X, crt_var);
                if isempty(crt_var_X)
                    errordlg('Something strange happen, see error 5001')
                end
                if ~isstruct(crt_var_X)
                    crtXTAZ = [crtXTAZ, crt_var_X];                             %���ǽṹ�壬Ӧ�þ���һ�б���
                else
                    crtXTAZ = [crtXTAZ, crt_var_X.taz(:, crtFrom)];             %�ǽṹ�壬Ӧ����һ������dist������stdf���������е�taz����
                end
            elseif isequal(crt_var, 'familarity')
                crt_var_X = X_familarity(: , i);
                crtXTAZ = [crtXTAZ, crt_var_X];
            elseif isequal(crt_var, 'visited')
                crtXTAZ = [crtXTAZ, crtVstd];
            end
        end
        
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




