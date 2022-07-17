function [ result_ped,result_taz ] = CCSSRwithTIME_GUI(EV,IND, B , TM)
%[����] Commercial Complex Simulation Single Run with TIME: in GUI
%[����] EV�������Ա����� IND�������Ա�����B���Ա���������TM��ʱ�����
%[���] result_ped:�����ģ������result_taz��С����ģ����
%[EV�ṹ��] area�����; dist:TAZ��ˮƽ����; dist_ent:�����ˮƽ����; stdf:TAZ���������;
%stdf_ent:������������; NTAZ:TAZ����
%[IND�ṹ��] ent_distrib: ����������߷ֲ�; familarity:��������Ϥ��; NPED������������
%EntTime_distrib ��������ڵ�ʱ��ֲ�   %EntTime_distrib_type ��������ڵ�ʱ��ֲ����ͣ���1�����Ƶĺ��ܶȣ�2���Զ�����ۻ��ֲ���3�������¼��
%[B�ṹ��] area, familarity, dist, stdf, visited, past
%[TM�ṹ��]: StayTime, TrafficTime



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

StayTime = TM.StayTime;
TrafficTime = TM.TrafficTime;
TrafficTime_taz_mu = TrafficTime.taz.mu;
TrafficTime_taz_sigma = TrafficTime.taz.sigma;
TrafficTime_ent_mu = TrafficTime.ent.mu;
TrafficTime_ent_sigma = TrafficTime.ent.sigma;

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

if X_ent_distrib_type == 1;
    %��ʱΪ���������Ϣ
    X_ent_distrib_aggr = X_ent_distrib;
    for j = 1 : NPED
        X_ent_distrib_ind(j , 1) = tochoose([[1:NENT]',X_ent_distrib_aggr]);
    end
    X_ent_distrib = X_ent_distrib_ind;
end

%���ʱ��ֲ�
EntTime_distrib = IND.EntTime_distrib;
EntTime_distrib_type = IND.EntTime_distrib_type;
if EntTime_distrib_type == 1
    %������ɸ����¼�й��Ƴ��ĺ��ܶ�
    Ind_EntTime = round(random(EntTime_distrib, NPED, 1));                  %ȡround����Ϊ���ɵ�������Ƿ��Ӳ�����С�������Ľ��һ����С��
    judge = Ind_EntTime >= 0 & Ind_EntTime <= 1440;
    while sum(judge) ~= NPED
        Ind_EntTime = round(random(EntTime_distrib, NPED, 1));
        judge = Ind_EntTime >= 0 & Ind_EntTime <= 1440;
    end
    Ind_EntTime = WDtimeConvert(Ind_EntTime, 3);
elseif EntTime_distrib_type == 2
    %��������Լ�������ۻ��ܶȷֲ�
    cumProb = EntTime_distrib(:, 2);
    temp = rand(1, NPED);
    temp2 = bsxfun(@minus, cumProb, temp);
    for ti = 1 : NPED
        crt_EntTime_upper_index = find(temp2(:, ti) >= 0);      %�ҳ����ģ��������ɵ��������ģ���ʵֻҪ��һ�������ɸ�ת���ģ���Ϊ�Ͻ�
        crt_EntTime_upper = EntTime_distrib(crt_EntTime_upper_index(1), 1);
        crt_EntTime_lower = EntTime_distrib(crt_EntTime_upper_index - 1, 1);
        crt_EntTime = unifrnd(crt_EntTime_lower, crt_EntTime_upper);
        crt_time_vec = datevec(crt_EntTime);
        Ind_EntTime(ti, 1) = crt_time_vec(4)*100 + crt_time_vec(5);
    end
elseif EntTime_distrib_type == 3
    %��ȷ�ĸ����¼
    Ind_EntTime = EntTime_distrib;
end


% hint: Ind_EntTime��һ��NPED*1����������Ϊÿ���˵��볡ʱ�䣨HHMMģʽ��
%       X_ent_distrib��һ��NPED*1����������Ϊÿ���˵ĳ����
%       X_familarity��һ��NTAZ*NPED�ľ��󣬵�i���˶�����TAZ����Ϥ����X_familarity(:, i)


result_ped = cell(NPED,6);                                                  %NPED*5
%ע�����ӵĵ�5�������洢���ʱ�䣨1-�����߱�ţ�2-���ID��3-·����4-ȥ�˶��ٵأ�5-���ʱ�䣻6-����ʱ�䣩����ҪΪ��ȷ�����ʱ������Сʱ��
result_taz = 1:NALT;
result_taz = [result_taz',zeros(NALT,1)];                                   %46*2

CheckEveryOneReachExit = zeros(NPED,1);                                     %��������Ƿ�ÿ���˶����ѡ���˳��ڣ����Ƿ����������·��

for i=1:NPED
    result_ped{i,1} = i;                                                    %cell��1�м���PED���
    crtFamilarity = X_familarity(: , i);                                    %��ǰ�����TAZ����ʶ����Ϥ�ȣ���for-loop�ﱣ�ֲ���,45*2
    crtVstd = zeros(NTAZ,1);                                                %TAZ�Ƿ���ȥ����45*1
    crtPstArN = 0;                                                          %�ѻ��εĴ���
    crtEntranceTime = Ind_EntTime(i);                                       %��ǰ��������ʱ��
    %��¼��ǰʱ��crtTime:ע�⣬crtTime���û�׼���Ӳ���б��
    crtTime = WDtimeConvert(crtEntranceTime,1);                             %��ǰ����ġ���ǰʱ�䡱�����ʱ��
    
    %��ڽ׶�ѡ��
    %   ����׼������ڽ׶Σ�
    crtEntrance = X_ent_distrib(i);                                         %��ǰ���
    result_ped{i,2} = crtEntrance;                                          %cell��2�м������
    result_ped{i,5} = crtEntranceTime;                                      %cell��5�м������ʱ��
    crtDist = X_dist_ent(: , crtEntrance);                                  %��ǰ��ڵ���TAZ�ľ��룬NTAZ*1
    crtStDf = X_stdf_ent(: , crtEntrance);                                  %��ǰ��ڵ���TAZ��������죬NTAZ*1
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
    crtVstd(crtChoice) = crtVstd(crtChoice) + 1;                            %������ȥ���ĵط����ۼ�ʽ����ע�⣬��ڽ׶��ѱ�֤������ѡ����ڣ�46����NTAZ*1
    crtRoute = crtChoice;                                                   %��ǰ·���ĵ�һ��Ԫ��Ϊ���ѡ����
    
    %��ڵ���һ��·��TAZ�Ľ�ͨʱ��
    crt_traffic_time_mu = TrafficTime_ent_mu(crtChoice, crtEntrance);
    crt_traffic_time_sigma = TrafficTime_ent_sigma(crtChoice, crtEntrance);
    crt_traffic_time = round(normrnd(crt_traffic_time_mu, crt_traffic_time_sigma));
    while crt_traffic_time < 0
        crt_traffic_time = round(normrnd(crt_traffic_time_mu, crt_traffic_time_sigma));
    end
    crtTime = crtTime + crt_traffic_time;                                   %��ǰʱ�䣺�ߵ��˵�1��·��TAZ
    crtRoute_ActStartTime = WDtimeConvert(crtTime, 3);                      %��ǰ·���ĵ�һTAZ��Ŀ�ʼʱ�䣺���ǵ�ǰʱ�䣬ת����1940��ʽ
    
    %   �����¼����ڣ�
    result_ped{i , 4} = 1;                                                  %cell��4�и���Ϊ1��ʾ����1���ط�
    result_taz(crtChoice,2) = result_taz(crtChoice,2) + 1;                  %taz����ж�Ӧ��taz����+1
    
    
    %   ��һ��·��TAZ��ʱ������
    crtStayTime_distr_index = find(cell2mat(StayTime(:,1)) == crtChoice);       %��΢��ֹһ��С����Ų��Ǵ�1��NTAZ����ò�Ҫ�����������
    crtStayTime_distr = StayTime{crtStayTime_distr_index, 2};
    crtLastTime = round(random(crtStayTime_distr));                         %�ӷֲ��г�ȡ�������ȡ��
    while crtLastTime <= 0                                                    %��֤ͣ��ʱ��Ϊ��
        crtLastTime = round(random(crtStayTime_distr));
    end
    crtRoute_ActLastTime = crtLastTime;                                     %ͣ��ʱ��ȷ��Ϊ���󣬼�¼��·�������У���ʼ����������end+1�ķ�ʽ��׺���룩
    %   ��̬���µ�ǰʱ��
    crtTime = crtTime + crtLastTime;                                        %��ǰʱ�䣺·���е�һ��TAZ��ѽ�����׼������һ�εľ���
    
    %���ν׶�
    while 1
        crtFrom = crtRoute(end);                                            %��ǰѭ����ѡ�񣩵�����λ�ã�������һ��ѡ��Ľ��
        %   ����׼�������Σ�
        crtDist = X_dist(: , crtFrom);                                      %��ǰλ�õ���TAZ�ľ��룬NTAZ*1
        crtStDf = X_stdf(: , crtFrom);                                      %��ǰλ�õ���TAZ��������죬45*1
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
        if crtChoice~=NALT                                                  %���ѡ������Ϊ����
            %   ��̬������������ݣ����Σ�
            crtPstArN = crtPstArN + 1;                                      %�����ѻ��εĴ���,scalar
            crtVstd(crtChoice) = crtVstd(crtChoice) + 1;                    %������ȥ���ĵط����ۼ�ʽ����ע��,��ʱ��ѭ��������֤��û��ѡ����ڣ�NALT����NTAZ*1
            crtRoute(end+1) = crtChoice;                                    %��ǰ·���ĵ�һ��Ԫ��Ϊ���ѡ��������̬�仯����
            
            
            %��ͨʱ��
            crt_traffic_time_mu = TrafficTime_taz_mu(crtChoice, crtFrom);           %%%%%%��һ���ǲ��ǶԳƵ�
            crt_traffic_time_sigma = TrafficTime_taz_sigma(crtChoice, crtFrom);     %%%%%%��һ���ǲ��ǶԳƵ�
            crt_traffic_time = round(normrnd(crt_traffic_time_mu, crt_traffic_time_sigma));
            while crt_traffic_time < 0
                crt_traffic_time = round(normrnd(crt_traffic_time_mu, crt_traffic_time_sigma));
            end
             %��һ��crtTime�Ǽ�����һ�λ�ĳ���ʱ��֮�����һ��������ʱ�䣬�����Ѿ������˾��ߣ��ټ��ϵ������Ľ�ͨʱ��
            crtTime = crtTime + crt_traffic_time;                           %��ǰʱ�䣺������һ��·��TAZ�㣬׼����������ʼ��׼��Ҫ����crtLastTime��                        
            crtRoute_ActStartTime(end+1) = WDtimeConvert(crtTime, 3);       %��ǰʱ�伴�ǵ�ǰ��Ŀ�ʼʱ�䣬����֮
            
            
            %   �����¼����ڣ�
            result_ped{i,4} = result_ped{i,4} + 1;                          %cell��4�и���,+1��ʾ��ȥ��һ���ط�
            result_taz(crtChoice,2) = result_taz(crtChoice,2) + 1;          %taz����ж�Ӧ��taz����+1  
            
            
            %   ʱ������
            crtStayTime_distr_index = find(cell2mat(StayTime(:,1)) == crtChoice);       %��΢��ֹһ��С����Ų��Ǵ�1��NTAZ����ò�Ҫ�����������
            crtStayTime_distr = StayTime{crtStayTime_distr_index, 2};
            crtLastTime = round(random(crtStayTime_distr));                         %�ӷֲ��г�ȡ�������ȡ��
            while crtLastTime <= 0                                                    %��֤ͣ��ʱ��Ϊ��
                crtLastTime = round(random(crtStayTime_distr));
            end
            crtRoute_ActLastTime(end+1) = crtLastTime;                                     %ͣ��ʱ��ȷ��Ϊ���󣬼�¼��·�������У���end+1�ķ�ʽ��׺���룩

            %   ��̬���µ�ǰʱ��
            crtTime = crtTime + crtLastTime;                                %��ǰʱ�䣺��ǰ���ʼ+��ǰ��ĳ���=��ǰ�������׼����һ��ѭ������������һ�λ��ѡ��
           
        else                                                                %���ѡ�������ǳ���
             result_taz(crtChoice,2) = result_taz(crtChoice,2) + 1;          %�ճ�����taz����ж�Ӧ��taz����+1����ʱ��Ϊ���һ��gohomeѡ��+1
            CheckEveryOneReachExit(i) = 1;                                  %���¸�PED�ĵ�����ڼ������
            result_ped{i,6} = WDtimeConvert(crtTime, 3);                     %cell��6�м������ʱ��
        end
        %   �����еĳ��ڽ׶�
        if crtChoice == NALT;
            break                                                           %�ܳ�����ѭ��
        end
    end
    
    result_ped{i,3} = [crtRoute; crtRoute_ActStartTime; crtRoute_ActLastTime];
    
end




