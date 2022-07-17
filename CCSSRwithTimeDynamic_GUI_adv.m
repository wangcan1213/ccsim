function [ result_ped, result_taz, TimelyTAZ_Stat, TimeSerie] = CCSSRwithTimeDynamic_GUI_adv(EV,IND, B, VN, TM, DY)
%[����] Commercial Complex Simulation Single Run, in GUI, �߼�ģʽ
%[����] EV�������Ա����� IND�������Ա�����B���Ա���������all_var_name�����б�����
%[���] result_ped:�����ģ������result_taz��С����ģ����
%[EV�ṹ��] X������familarity����ĸ��Ա�������Ϊ��������; NTAZ:TAZ����
%[IND�ṹ��] ent_distrib: ����������߷ֲ�; familarity:��������Ϥ��; NPED������������
%EntTime_distrib ��������ڵ�ʱ��ֲ�   %EntTime_distrib_type ��������ڵ�ʱ��ֲ����ͣ���1�����Ƶĺ��ܶȣ�2���Զ�����ۻ��ֲ���3�������¼��
%[B�ṹ��] ����ϵ��
%[VN�ṹ��]�� non_time_var_name�����з�ʱ������ļ��ϣ�time_var_name:����ʱ������ļ���
%[TM�ṹ��]: StayTime, TrafficTime
%[DY�ṹ��]����̬��أ�����������[��ǰ��������ǰ�ܶȣ��Ŷ��������Ŷ�ʱ��]��ϵ��
%[TimlyTAZ_Stat�ṹ��]��ֱ����������Ͱ�TAZ��ʱ�����Ľ��ͳ�ƺã�TAZ_NIND�Ƿ�ʱ������
%TAZ_Queue�Ƿ�ʱ�Ŷ�������TAZ_QueueTime�Ƿ�ʱ�Ŷ�ʱ��
clc
X = EV.X;
NTAZ = EV.NTAZ;
NENT = EV.NENT;
NALT = NTAZ + 1;
non_time_var_name = VN.non_time_var_name;
time_var_name = VN.time_var_name;

TAZ_Capacity = DY.TAZ_Capacity;
TAZ_BaseArea = DY.TAZ_BaseArea;
X_beta_dynamic = DY.X_beta_dynamic;
%��Щ�������У���һ���Ƿֶε㣬�ڶ�����ϵ��������Զ��-inf~��һ�ֶε��ϵ����Ϊ��׼0
%����[-3, 0, 8; 1, 2, 3]��-inf~-3ϵ��Ϊ0�� -3~0ϵ��Ϊ1�� 0~8ϵ��Ϊ2�� 8~-infϵ��Ϊ3
%���⻹��type,�����1����Ϊ��ֵ������ֱ�ӳ˼��ɣ������2�����Ƿ�������������������
X_beta_volumn = X_beta_dynamic.volumn;
X_beta_density = X_beta_dynamic.density;
X_beta_queue = X_beta_dynamic.queue;
%�����õĶ�̬�������
if X_beta_volumn.use == 0
    X_beta_volumn.type = 1;
    X_beta_volumn.value = [-inf; 0];
end
if X_beta_density.use == 0
    X_beta_density.type = 1;
    X_beta_density.value = [-inf; 0];
end
if X_beta_queue.use == 0
    X_beta_queue.type = 1;
    X_beta_queue.value = [-inf; 0];
end


%     %===������
% %     TAZ_Capacity = inf(NTAZ, 1);
% TAZ_Capacity(22) = 10; 
% X_beta_queue.value = [-inf; -1000];
% X_beta_volumn.type = 2;
% X_beta_volumn.value = [5 10 15; -2, -10, 100];

X_ent_distrib = IND.ent_distrib ;
X_familarity = IND.familarity;
NPED = IND.NPED;
%-----------------------------%
%��Ϥ�ȣ���������ע�⣬�����������Ϥ���Ѿ����Ƕ�ά���ˣ�1άͬ����չ��û�иñ�����ȫ0��
if size(X_familarity , 2) ~= NPED
    sample_f = unidrnd(size(X_familarity , 2) , NPED ,1);
    X_familarity = X_familarity(: , sample_f);
end
%-----------------------------%
%���£������ʱ�շֲ��ı߽�����%
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
        Crt_EntTime_upper_index = find(temp2(:, ti) >= 0);      %�ҳ����ģ��������ɵ��������ģ���ʵֻҪ��һ�������ɸ�ת���ģ���Ϊ�Ͻ�
        Crt_EntTime_upper = EntTime_distrib(Crt_EntTime_upper_index(1), 1);
        Crt_EntTime_lower = EntTime_distrib(Crt_EntTime_upper_index - 1, 1);
        Crt_EntTime = unifrnd(Crt_EntTime_lower, Crt_EntTime_upper);
        Crt_time_vec = datevec(Crt_EntTime);
        Ind_EntTime(ti, 1) = Crt_time_vec(4)*100 + Crt_time_vec(5);
    end
elseif EntTime_distrib_type == 3
    %��ȷ�ĸ����¼
    Ind_EntTime = EntTime_distrib;
end
%���ϣ������ʱ�շֲ��ı߽�����%
%-----------------------------%
%����ʱ�����
StayTime = TM.StayTime;
TrafficTime = TM.TrafficTime;
TrafficTime_taz_mu = TrafficTime.taz.mu;
TrafficTime_taz_sigma = TrafficTime.taz.sigma;
TrafficTime_ent_mu = TrafficTime.ent.mu;
TrafficTime_ent_sigma = TrafficTime.ent.sigma;
time_var = TM.time_var;

NVAR_NT = length(non_time_var_name);        %_NT��ʾNON TIME����ʱ��Ľ��ͱ���
BTAZ = [];
BHOME = [];
for i = 1 :NVAR_NT
    Crt_var = non_time_var_name{i};
    if ~isequal(Crt_var, 'past')
        BTAZ = [BTAZ; getfield(B, Crt_var)];
    else
        BHOME = [BHOME; getfield(B, Crt_var)];
    end
end
%ע�⣬����BTAZ��BHOME�б����������ǰ���B�б��������ģ���non_time_var_name����time_var_name�������Ҷ��������˷�ʱ�����������ʱ�����
NVAR_T = length(time_var_name);         %ʱ������ĸ���
for i = 1 : NVAR_T
    Crt_var = time_var_name{i};
    %�ж��ǲ��Ǹ��ؼҵģ�ǰ��������ǻؼҵģ����һ����һ��TAZ��
    if isequal(time_var{i}.name , Crt_var)
        if time_var{i}.origin == 1 & isequal(time_var{i}.interaction_var_name, 'Past')
            BHOME = [BHOME; getfield(B, Crt_var)];
        elseif time_var{i}.origin == 2 & isequal(time_var{i}.X_created_interaction_var, [zeros(NTAZ, 1);1])
            BHOME = [BHOME; getfield(B, Crt_var)];
        else
            BTAZ = [BTAZ; getfield(B, Crt_var)];
        end
    else
        errordlg('Starange Error, see error 3209', 'Error')
        return
    end
end
%--------------------------------------------------------------------------------------------%
IndTime = WDtimeConvert(Ind_EntTime,1);                                     %����ĸ���ʱ�䡪��ȫ�����÷��Ӳ���ʽ
CrtTime = min(IndTime) - 1;
%NextDecisionStage = -1 * ones(NPED,1);                                       %���˾���״̬��-1Ϊ��ڣ�0Ϊ���Σ�1Ϊ����
%CrtStatus = zeros(NPED, 1);                                                 %����״̬��0Ϊ�ǻ��δ������˳�����1Ϊͣ����2Ϊ�Ŷӣ�3Ϊ��ͨ
%---------------------------%
%����ǰ�ĸ�ʽ��������
result_ped = cell(NPED,5);                                                  %NPED*6
%ע�����ӵĵ�5�������洢���ʱ�䣨1-�����߱�ţ�2-���ID��3-·����4-ȥ�˶��ٵأ�5-���ʱ�䣻6-����ʱ�䣩����ҪΪ��ȷ�����ʱ������Сʱ��
result_taz = 1:NALT;
result_taz = [result_taz',zeros(NALT,1)];                                   
%--------------------------------------------%
for i = 1 : NPED
    result_ped{i,1} = i;                                                    %cell��1�м���PED���
    Ind(i).ID = i;
    Ind(i).NextDecisonTime = WDtimeConvert(Ind_EntTime(i),1);
    Ind(i).NextDecisionStage = -1;
    %     Ind(i).CrtStatus = 0;
    Ind(i).CrtPstArN = 0;
    Ind(i).CrtVstd = zeros(NTAZ, 1);
    Ind(i).X_familarity = X_familarity(: , i);
    Ind(i).Route = [];
    Ind(i).ActStartTime = [];
    Ind(i).ActLastTime = [];
end
All_DecisionStage = struct2table(Ind);
All_DecisionStage = table2array(All_DecisionStage(:,3));
TimeSerie = [];
TAZ_NIND = [];
TAZ_Queue = [];
TAZ_QueueTime = [];
CrtTimeTAZ_NIND = zeros(NTAZ, 1);
while ~isequal(All_DecisionStage, ones(NPED,1))
    CrtTime = CrtTime + 1;
%     if WDtimeConvert(CrtTime, 3) == 1500
%     %�����
%         a = 1;
%     end
%     if CrtTime > WDtimeConvert(2400,1)
%         disp([num2str(WDtimeConvert(CrtTime - 1440,3))]);
%     else
%         disp([num2str(WDtimeConvert(CrtTime,3))]);
%     end
%     if CrtTime > 2000               %�����
%         a = 11;
%     end
    TimeSerie = [TimeSerie, WDtimeConvert(CrtTime, 3)];
    for i = 1 : NPED
%         if i == 29          %�����
%             a = 1;
%         end
        if ~isequal(Ind(i).NextDecisonTime, CrtTime)                     %δ������ʱ
            if Ind(i).NextDecisionStage ~= 0
                Ind(i).CrtStatus = 0;
            else
                if CrtTime < Ind(i).NextArriveTime  
                    Ind(i).CrtStatus = 3;
                    Ind(i).NextEntryTime = -9999;                           %��������ԭ����Unkonw
                    Ind(i).NextDecisonTime = -9999;                         %��������ԭ����Unkonw
                elseif CrtTime == Ind(i).NextArriveTime 
                    %-------�ж��Ŷ�ʱ��-------%
                    Crt_queue_time = CrtTimeTAZ_QueueTime(Ind(i).Route(end));
                    Ind(i).CrtQueueTime = Crt_queue_time;
                    Ind(i).NextEntryTime = Ind(i).NextArriveTime + Crt_queue_time;
                    %-------------------------%
                    CrtStayTime_distr_index = cell2mat(StayTime(:,1)) == Ind(i).Route(end);       %��΢��ֹһ��С����Ų��Ǵ�1��NTAZ����ò�Ҫ�����������
                    CrtStayTime_distr = StayTime{CrtStayTime_distr_index, 2};
                    CrtLastTime = round(random(CrtStayTime_distr));                         %�ӷֲ��г�ȡ�������ȡ��
                    while CrtLastTime <= 0                                                    %��֤ͣ��ʱ��Ϊ��
                        CrtLastTime = round(random(CrtStayTime_distr));
                    end
                    Ind(i).CrtStayTime = CrtLastTime;
                    Ind(i).NextDecisonTime = Ind(i).NextEntryTime + CrtLastTime;
                    Ind(i).ActLastTime = [Ind(i).ActLastTime, Crt_queue_time + CrtLastTime];
                    result_ped{i, 3} = [Ind(i).Route; Ind(i).ActStartTime; Ind(i).ActLastTime];
                    if CrtTime < Ind(i).NextEntryTime                           
                        %ͬ����NextEntryTime = CrtTime +
                        %�Ǹ���������Ҫô��Ҫô���ڣ������˵���Ŷ�ʱ�䲻Ϊ0������״̬Ϊ�Ŷӣ�����˵���Ŷ�ʱ��Ϊ0��ֱ���볡
                        Ind(i).CrtStatus = 2;               %�Ŷ�
                    elseif CrtTime == Ind(i).NextEntryTime
                        %��Ȼ�Ŷ�ʱ��Ϊ0�����ھ������볡���볡֮���پ���ͣ���೤ʱ��
                        Ind(i).CrtStatus = 1;               %ͣ��
                    end
                elseif CrtTime > Ind(i).NextArriveTime                      %ע�⣺ֻ���ڵ�ǰʱ��=�������ʱ��ʱ���Ż�����Ԥ���Ŷ���Ԥ�ڲι�ʱ�䣬����ѹ��ˣ�ֻ��Ҫ�жϼ���
                    if CrtTime < Ind(i).NextEntryTime
                        Ind(i).CrtStatus = 2;               %�Ŷ�
                    elseif CrtTime > Ind(i).NextEntryTime
                        Ind(i).CrtStatus = 1;               %ͣ��
                    end
                end
                if CrtTime == Ind(i).NextArriveTime
                    CrtTimeTAZ_NIND(Ind(i).Route(end)) = CrtTimeTAZ_NIND(Ind(i).Route(end)) + 1;     %����
                    CrtTimeTAZ_Queue = max(CrtTimeTAZ_NIND - TAZ_Capacity, 0);
                end
            end
        else                                                                %����
            if Ind(i).NextDecisionStage == -1                                  %��ھ���
                CrtEntrance = X_ent_distrib(i);                              %��ǰ���
                result_ped{i,2} = CrtEntrance;                                          %cell��2�м������
                result_ped{i,5} = WDtimeConvert(CrtTime, 3);                            %cell��5�м������ʱ��
                Stage = -1;
                CrtDecisionPlace = CrtEntrance;
            elseif Ind(i).NextDecisionStage == 0
                Stage = 0;
                CrtDecisionPlace = Ind(i).Route(end);
            end
            CrtPstArN = Ind(i).CrtPstArN;
            CrtVstd = Ind(i).CrtVstd;
            CrtX_familarity = Ind(i).X_familarity;
            [CrtXTAZ, CrtXHOME] = ...
                GenerateTimeX(CrtTime, Stage, CrtDecisionPlace,...
                NTAZ, CrtPstArN, CrtVstd, CrtX_familarity,...
                NVAR_NT, non_time_var_name, X,...
                NVAR_T, time_var_name, time_var);
            %   ����Ч����ִ��ѡ����ڽ׶Σ�
            CrtVTAZ = CrtXTAZ * BTAZ;                                               %taz�ɼ�Ч��,NTAZ*1
            CrtVHOME = CrtXHOME * BHOME;                                            %home�ɼ�Ч��,1*1
            % --------------------------------------------- %
            %���Ӷ���Ķ�̬Ч�ã�����/�ܶ�/�Ŷӣ�
            if ~isempty(TAZ_NIND)                                               %��1����û�κμ�¼
                CrtVolumnX = TAZ_NIND(:, end);                      
            else
                CrtVolumnX = zeros(NTAZ, 1);
            end
            CrtDensityX = CrtVolumnX ./ TAZ_BaseArea;
            if ~isempty(TAZ_QueueTime)                                          %��1����û�κμ�¼
                CrtQueueX = TAZ_QueueTime(:, end);                                  %�õ����Ŷ�ʱ��
            else
                CrtQueueX = zeros(NTAZ,  1);
            end
            CrtXTAZ_additional = [];
            BTAZ_additional = [];
            if  X_beta_volumn.type == 2
                cutpoints = X_beta_volumn.value(1, :);
                cutpoints = [cutpoints, inf];
                temp = CrtVolumnX;
                CrtVolumnX = [];                        %��tempΪ��ʱ���ɣ�ת��dummy
                for jj = 1 : length(cutpoints) - 1
                    CrtVolumnX(:, jj) = temp >= cutpoints(jj) & temp < cutpoints(jj+1);
                end
            end
            if  X_beta_density.type == 2
                cutpoints = X_beta_density.value(1, :);
                cutpoints = [cutpoints, inf];
                temp = CrtDensityX;
                CrtDensityX = [];                        %��tempΪ��ʱ���ɣ�ת��dummy
                for jj = 1 : length(cutpoints) - 1
                    CrtDensityX(:, jj) = temp >= cutpoints(jj) & temp < cutpoints(jj+1);
                end
            end
            if  X_beta_queue.type == 2
                cutpoints = X_beta_queue.value(1, :);
                cutpoints = [cutpoints, inf];
                temp = CrtQueueX;
                CrtQueueX = [];                        %��tempΪ��ʱ���ɣ�ת��dummy
                for jj = 1 : length(cutpoints) - 1
                    CrtQueueX(:, jj) = temp >= cutpoints(jj) & temp < cutpoints(jj+1);
                end
            end
            CrtXTAZ_additional = [CrtXTAZ_additional, CrtVolumnX, CrtDensityX, CrtQueueX];
            BTAZ_additional = [BTAZ_additional; X_beta_volumn.value(2,:)'; X_beta_density.value(2,:)'; X_beta_queue.value(2,:)'];
            CrtVTAZ_additional = CrtXTAZ_additional * BTAZ_additional ;
            CrtVTAZ = CrtVTAZ + CrtVTAZ_additional;
            % --------------------------------------------- %
            CrtV = [CrtVTAZ ; CrtVHOME];                                            %����һ��,NALT*1
            CrtEV = exp(CrtV);                                                      %eV
            CrtProb = CrtEV / sum(CrtEV);                                           %ѡ�����,NALT*1
            CrtToChooseX = [[1:NALT]' , CrtProb];                                   %�ܱ�tochoose���õ��Ա�������һ��Ϊ��ѡ���ţ��ڶ���Ϊ���ʣ�NALT*2
            CrtChoice = tochoose(CrtToChooseX);                                     %ѡ����
            while CrtChoice == NALT & Ind(i).NextDecisionStage == -1                %��֤��������ھ�ѡ�����
                CrtChoice = tochoose(CrtToChooseX);
            end
            result_taz(CrtChoice,2) = result_taz(CrtChoice,2) + 1; 
            if CrtChoice == NTAZ + 1                                        %�ѵ�����
                result_ped{i, 6} = WDtimeConvert(CrtTime, 3);
                Ind(i).NextDecisionStage = 1;
                Ind(i).CrtStatus = 0;
                CrtTimeTAZ_NIND(CrtDecisionPlace) = CrtTimeTAZ_NIND(CrtDecisionPlace) - 1;      %�뿪
                CrtTimeTAZ_Queue = max(CrtTimeTAZ_NIND - TAZ_Capacity, 0);
                Ind(i).NextDecisonTime = inf;
                continue
            end
            Ind(i).Route = [Ind(i).Route, CrtChoice];
            %   ��̬�������������
            CrtPstArN = CrtPstArN + 1;                                              %�����ѻ��εĴ���
            CrtVstd(CrtChoice) = CrtVstd(CrtChoice) + 1;                            %������ȥ���ĵط����ۼ�ʽ����ע�⣬��ڽ׶��ѱ�֤������ѡ����ڣ�46����NTAZ*1
            Ind(i).CrtPstArN = CrtPstArN;
            Ind(i).CrtVstd = CrtVstd;
            result_ped{i, 4} = Ind(i).CrtPstArN;
            %����һ��·��TAZ�Ľ�ͨʱ��
            if Stage == -1
                Crt_traffic_time_mu = TrafficTime_ent_mu(CrtChoice, CrtDecisionPlace);
                Crt_traffic_time_sigma = TrafficTime_ent_sigma(CrtChoice, CrtDecisionPlace);
            else
                Crt_traffic_time_mu = TrafficTime_taz_mu(CrtChoice, CrtDecisionPlace);
                Crt_traffic_time_sigma = TrafficTime_taz_sigma(CrtChoice, CrtDecisionPlace);
            end
            Crt_traffic_time = round(normrnd(Crt_traffic_time_mu, Crt_traffic_time_sigma));
            while Crt_traffic_time < 0
                Crt_traffic_time = round(normrnd(Crt_traffic_time_mu, Crt_traffic_time_sigma));
            end
            Ind(i).LastDecisionTime = CrtTime;
            Ind(i).CrtTrafficTime = Crt_traffic_time;
            Ind(i).NextArriveTime = CrtTime + Crt_traffic_time;         %��ǰʱ��+��ͨʱ��=������һ�����ʱ��
            Ind(i).ActStartTime = [Ind(i).ActStartTime, WDtimeConvert(Ind(i).NextArriveTime, 3)];

            if CrtTime < Ind(i).NextArriveTime                              %���������������ͨʱ�䲻Ϊ0
                Ind(i).CrtStatus = 3;               %��ͨ
                Ind(i).NextEntryTime = -9999;                   %��������ԭ����Unkonw
                Ind(i).NextDecisonTime = -9999;                 %��������ԭ����Unkonw
            elseif CrtTime == Ind(i).NextArriveTime                       
                 %�ټ����������ͨʱ��Ϊ0��������NextArriveTime =
                 %CrtTime+�Ǹ��������Բ����ܳ��ֺ��߸��������������Ⱦ�˵���Ѿ��߹��ˣ����ڿ��������Ŷ�ʱ����
                %-------�ж��Ŷ�ʱ��-------%
                Crt_queue_time = CrtTimeTAZ_QueueTime(Ind(i).Route(end));
                Ind(i).CrtQueueTime = Crt_queue_time;
                Ind(i).NextEntryTime = Ind(i).NextArriveTime + Crt_queue_time;
                %-------------------------%
                CrtStayTime_distr_index = cell2mat(StayTime(:,1)) == CrtChoice;       %��΢��ֹһ��С����Ų��Ǵ�1��NTAZ����ò�Ҫ�����������
                CrtStayTime_distr = StayTime{CrtStayTime_distr_index, 2};
                CrtLastTime = round(random(CrtStayTime_distr));                         %�ӷֲ��г�ȡ�������ȡ��
                while CrtLastTime <= 0                                                    %��֤ͣ��ʱ��Ϊ��
                    CrtLastTime = round(random(CrtStayTime_distr));
                end
                Ind(i).CrtStayTime = CrtLastTime;
                Ind(i).NextDecisonTime = Ind(i).NextEntryTime + CrtLastTime;
                Ind(i).ActLastTime = [Ind(i).ActLastTime, Crt_queue_time + CrtLastTime];
                result_ped{i, 3} = [Ind(i).Route; Ind(i).ActStartTime; Ind(i).ActLastTime];
                if CrtTime < Ind(i).NextEntryTime                           
                    %ͬ����NextEntryTime = CrtTime +
                    %�Ǹ���������Ҫô��Ҫô���ڣ������˵���Ŷ�ʱ�䲻Ϊ0������״̬Ϊ�Ŷӣ�����˵���Ŷ�ʱ��Ϊ0��ֱ���볡
                    Ind(i).CrtStatus = 2;               %�Ŷ�
                elseif CrtTime == Ind(i).NextEntryTime      
                    %��Ȼ�Ŷ�ʱ��Ϊ0�����ھ������볡���볡֮���پ���ͣ���೤ʱ��
                    Ind(i).CrtStatus = 1;               %ͣ��
                end
            end
            %���µ�ǰTAZ
            if Ind(i).NextDecisionStage == 0
                CrtTimeTAZ_NIND(CrtDecisionPlace) = CrtTimeTAZ_NIND(CrtDecisionPlace) - 1;      %�뿪
            end
            if CrtTime == Ind(i).NextArriveTime
                CrtTimeTAZ_NIND(Ind(i).Route(end)) = CrtTimeTAZ_NIND(Ind(i).Route(end)) + 1;     %����
            end
            CrtTimeTAZ_Queue = max(CrtTimeTAZ_NIND - TAZ_Capacity, 0);
            for kkk = 1 : NTAZ
                CrtQueue = CrtTimeTAZ_Queue(kkk);
                CrtStayTime_distr_index = find(cell2mat(StayTime(:,1)) == kkk);       %��΢��ֹһ��С����Ų��Ǵ�1��NTAZ����ò�Ҫ�����������
                CrtStayTime_distr = StayTime{CrtStayTime_distr_index, 2};
                CrtLastTime4CrtQueue = round(max(random(CrtStayTime_distr, CrtQueue, 1), 0));                         %�ӷֲ��г�ȡ�������ȡ��
                CrtTimeTAZ_QueueTime(kkk, 1) = round(sum(CrtLastTime4CrtQueue) / TAZ_Capacity(kkk));
                %��һ��ȡ���ǹؼ�����Ϊǰ������Ҫ�жϵ�ǰʱ���Ƿ��Ѿ�������һ������ʱ�䣨�Ƿ�==����������ˣ��ͻ�����µ�ѡ��ͬʱ���
                %��һ���ľ���ʱ����ǰ�ƣ�ʹ�õ�ǰʱ����Զ<=��һ������ʱ�䣬���������Ŷ�ʱ��С�����������Ȼ�����Ǹ�ռΪ����~=�����
                %��������һ����չ�µ�ѡ���ʱ�������ڳ��ֵ�ǰʱ��>��һ��ѡ��ʱ�䣬�����Ƶ�ͣ����ȥ������������
            end
            Ind(i).NextDecisionStage = 0;                   %�����һ���ǳ��ڵĻ�����������ˣ��������������Ϊ�˱�֤ǰ�����TAZʱ��ڽ׶�û�С��뿪������
%             if i == 29          %�����
%                 Ind(i)
%             end
        end
%         if i == 29            %�����
%             a = 1;
%             disp(['Decision Stage: ', num2str(Ind(i).NextDecisionStage), ', Current Status: ', num2str(Ind(i).CrtStatus)])
%         end
    end
    
    TAZ_NIND = [TAZ_NIND, CrtTimeTAZ_NIND];
    TAZ_Queue = [TAZ_Queue, CrtTimeTAZ_Queue];
    TAZ_QueueTime = [TAZ_QueueTime, CrtTimeTAZ_QueueTime];
    All_DecisionStage_table = struct2table(Ind);
    All_DecisionStage = table2array(All_DecisionStage_table(:,3));
%         tabulate( All_DecisionStage)
end
TimelyTAZ_Stat.TAZ_NIND = TAZ_NIND;
TimelyTAZ_Stat.TAZ_Queue  = TAZ_Queue ;
TimelyTAZ_Stat.TAZ_QueueTime = TAZ_QueueTime;
A = 1;





%-----------------------------------------------------------------------------------------------------------------------------------------%%%

%-----------------------------------------------------------------------------------------------------------------------------------------%%%






function [CrtXTAZ, CrtXHOME] = ...
    GenerateTimeX(CrtTime, Stage, CrtDecisionPlace,...
    NTAZ, CrtPstArN, CrtVstd,X_familarity,...
    NVAR_NT, non_time_var_name, X,...
    NVAR_T, time_var_name, time_var)
CrtXTAZ = [];
CrtXHOME = [];              %��ʼ��
%�������еķ�ʱ�����
for kk = 1 : NVAR_NT
    Crt_var_name = non_time_var_name{kk};
    if ~isequal(Crt_var_name, 'past') & ~isequal(Crt_var_name, 'familarity') & ~isequal(Crt_var_name, 'visited')
        Crt_var_X = getfield(X, Crt_var_name);
        if isempty(Crt_var_X)
            errordlg('Something strange happen, see error 5001')
            return
        end
        if ~isstruct(Crt_var_X)
            CrtXTAZ = [CrtXTAZ, Crt_var_X];                             %���ǽṹ�壬Ӧ�þ���һ�б���
        else
            if Stage == -1
                CrtXTAZ = [CrtXTAZ, Crt_var_X.ent(:, CrtDecisionPlace)];
            elseif Stage == 0
                CrtXTAZ = [CrtXTAZ, Crt_var_X.taz(:, CrtDecisionPlace)];
            end
        end
    elseif isequal(Crt_var_name, 'familarity')
        Crt_var_X = X_familarity;
        CrtXTAZ = [CrtXTAZ, Crt_var_X];
    elseif isequal(Crt_var_name, 'visited')
        CrtXTAZ = [CrtXTAZ, CrtVstd];
    end
end
CrtXHOME = [CrtPstArN];         %HOME�ɼ�Ч��
% Ȼ����ʱ����������ʱ���ж�
timeXTAZ = [];
timeXHOME = [];
for kk = 1 : NVAR_T
    Crt_var_name = time_var_name{kk};
    Crt_var = time_var{kk};
    Crt_start_time = Crt_var.start_time;
    Crt_end_time = Crt_var.end_time;
    Crt_origin = Crt_var.origin;
    if ~isempty(Crt_start_time)
        if CrtTime >= WDtimeConvert(Crt_start_time, 1)
            after_start = 1;
        else
            after_start = 0;
        end
    else    %ʱ��ο�ʼʱ��Ϊ�գ�˵���Ͻ��޿��ƣ�ֻҪ�����ڽ���ʱ�伴��
        after_start = 1;
    end
    if ~isempty(Crt_end_time)
        if CrtTime <= WDtimeConvert(Crt_end_time, 1)
            before_end = 1;
        else
            before_end = 0;
        end
    else        %ʱ��ν���ʱ��Ϊ�գ�˵���½��޿��ƣ�ֻҪ�����ڿ�ʼʱ�伴��
        before_end = 1;
    end
    if after_start == 1 & before_end == 1
        %ֻ����ʱ�䷶Χ�ڣ�����Ҫ���
        if Crt_origin == 1 & isequal(Crt_var.interaction_var_name, 'Past')
            timeXHOME = [timeXHOME, CrtPstArN];                           %������1*CrtPstArN = CrtPstArN
        elseif Crt_origin == 2 & isequal(Crt_var.X_created_interaction_var, [zeros(NTAZ, 1);1])
            timeXHOME = [timeXHOME, 1];                                   %������1*1 = 1
        else
            %����С���ı�������Ҫ���ж���Դ��������Ѵ��ڵı�������Ҫ�ҳ���index��������Լ���ʱ����ģ�Ҫ��ȡ������֤�䳤��ΪNTAZ
            if Crt_origin == 1
                Crt_time_var_interaction_var_name = Crt_var.interaction_var_name;
                %�����Ѷ���ı����������ڻ���ģʽ�ı�������Ҫתһ��
                if isequal( Crt_time_var_interaction_var_name, 'Area')
                    Crt_time_var_interaction_var_name = 'area';
                elseif isequal( Crt_time_var_interaction_var_name, 'Attractiveness')
                    Crt_time_var_interaction_var_name = 'familarity';
                elseif isequal( Crt_time_var_interaction_var_name, 'Distance')
                    Crt_time_var_interaction_var_name = 'dist';
                elseif isequal( Crt_time_var_interaction_var_name, 'Stair(Difference)')
                    Crt_time_var_interaction_var_name = 'stdf';
                elseif isequal( Crt_time_var_interaction_var_name, 'Visited')
                    Crt_time_var_interaction_var_name = 'visited';
                elseif isequal( Crt_time_var_interaction_var_name, 'Past')
                    Crt_time_var_interaction_var_name = 'past';
                end
                if isfield(X, Crt_time_var_interaction_var_name)
                    Crt_time_var_interaction = getfield(X, Crt_time_var_interaction_var_name);
                    if ~isstruct(Crt_time_var_interaction)
                        Crt_X_interaction = Crt_time_var_interaction;
                    else
                        if Stage == -1
                            Crt_X_interaction = Crt_time_var_interaction.ent(:, CrtDecisonPlace);
                        else Stage == 0
                            Crt_X_interaction = Crt_time_var_interaction.taz(:, CrtDecisionPlace);
                        end
                    end
                elseif isequal(Crt_time_var_interaction_var_name, 'visited')
                    Crt_X_interaction = CrtVstd;
                elseif isequal(Crt_time_var_interaction_var_name, 'familarity')
                    Crt_X_interaction = X_familarity(: , i);
                else
                    errordlg('Strange: can not find the interaction variable in the X, see error 7362', 'Error')
                    return
                end
            else            %�������Լ�����ı���
                Crt_X_interaction = Crt_var.X_created_interaction_var;
            end
            if length(Crt_X_interaction) ~= NTAZ
                errordlg('Strange thinghs happend, interacton variables length do not equals NTAZ, see error 9379', 'Error')
                return
            end
            timeXTAZ= [timeXTAZ, Crt_X_interaction];
        end
    else
        %���ڴ�ʱ��Σ�������TAZ���ǻؼң�����Ϊ0����
        if Crt_origin == 1 & isequal(Crt_var.interaction_var_name, 'Past')
            timeXHOME = [timeXHOME, 0];                                  %������0*CrtPstArN = 0
        elseif Crt_origin == 2 & isequal(Crt_var.X_created_interaction_var, [zeros(NTAZ, 1);1])
            timeXHOME = [timeXHOME, 0];                                  %������0*1 = 0
        else
            Crt_X_interaction = zeros(NTAZ, 1);                         %����ʱ�����С��������ֱ��ȫ��0
            timeXTAZ= [timeXTAZ, Crt_X_interaction];
        end
    end
end
%�ϲ�ʱ�����ʱ�����
CrtXTAZ = [CrtXTAZ, timeXTAZ];
CrtXHOME = [CrtXHOME, timeXHOME];            



