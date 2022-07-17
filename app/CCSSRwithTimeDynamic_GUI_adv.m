function [ result_ped, result_taz, TimelyTAZ_Stat, TimeSerie] = CCSSRwithTimeDynamic_GUI_adv(EV,IND, B, VN, TM, DY)
%[功能] Commercial Complex Simulation Single Run, in GUI, 高级模式
%[输入] EV：环境自变量； IND：个体自变量；B：自变量参数；all_var_name：所有变量名
%[输出] result_ped:个体的模拟结果；result_taz：小区的模拟结果
%[EV结构体] X：除了familarity以外的各自变量，作为环境变量; NTAZ:TAZ数量
%[IND结构体] ent_distrib: 出入口消费者分布; familarity:消费者熟悉度; NPED：消费者数量
%EntTime_distrib 消费者入口的时间分布   %EntTime_distrib_type 消费者入口的时间分布类型：（1，估计的核密度；2，自定义的累积分布；3，个体记录）
%[B结构体] 各个系数
%[VN结构体]： non_time_var_name：所有非时间变量的集合，time_var_name:所有时间变量的集合
%[TM结构体]: StayTime, TrafficTime
%[DY结构体]：动态相关，包括容量，[当前人数，当前密度，排队人数，排队时间]的系数
%[TimlyTAZ_Stat结构体]：直接在这里面就把TAZ在时间层面的结果统计好：TAZ_NIND是分时人数；
%TAZ_Queue是分时排队人数；TAZ_QueueTime是分时排队时长
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
%这些都是两行，第一行是分段点，第二行是系数，且永远把-inf~第一分段点的系数设为基准0
%比如[-3, 0, 8; 1, 2, 3]：-inf~-3系数为0； -3~0系数为1； 0~8系数为2； 8~-inf系数为3
%另外还有type,如果是1，则为数值变量，直接乘即可；如果是2，才是分类变量，像上面的做法
X_beta_volumn = X_beta_dynamic.volumn;
X_beta_density = X_beta_dynamic.density;
X_beta_queue = X_beta_dynamic.queue;
%将不用的动态变量搞掉
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


%     %===调试用
% %     TAZ_Capacity = inf(NTAZ, 1);
% TAZ_Capacity(22) = 10; 
% X_beta_queue.value = [-inf; -1000];
% X_beta_volumn.type = 2;
% X_beta_volumn.value = [5 10 15; -2, -10, 100];

X_ent_distrib = IND.ent_distrib ;
X_familarity = IND.familarity;
NPED = IND.NPED;
%-----------------------------%
%熟悉度：单独处理：注意，进入这里的熟悉度已经都是二维的了（1维同质扩展，没有该变量则全0）
if size(X_familarity , 2) ~= NPED
    sample_f = unidrnd(size(X_familarity , 2) , NPED ,1);
    X_familarity = X_familarity(: , sample_f);
end
%-----------------------------%
%以下：出入口时空分布的边界条件%
if size(X_ent_distrib, 2) == 2 & size(X_ent_distrib, 1) ~= NPED
    %人数不一致，一律视为不完全的个体信息，由此导出集合信息再做
    tab_ent_distrib = tabulate(X_ent_distrib(:,2));
    tab_ent_distrib = tab_ent_distrib(: , 3) / 100;
    X_ent_distrib = tab_ent_distrib;        %原来的不完全的个体信息用集合信息替代
    X_ent_distrib_type = 1;
elseif size(X_ent_distrib, 2) == 2 & size(X_ent_distrib, 1) == NPED
    X_ent_distrib =  X_ent_distrib(:,2);
    X_ent_distrib_type = 2;
else
    X_ent_distrib_type = 1;  
end

if X_ent_distrib_type == 1;  
    %此时为集计入口信息
    X_ent_distrib_aggr = X_ent_distrib;
    for j = 1 : NPED
        X_ent_distrib_ind(j , 1) = tochoose([[1:NENT]',X_ent_distrib_aggr]);
    end
    X_ent_distrib = X_ent_distrib_ind;
end

%入口时间分布
EntTime_distrib = IND.EntTime_distrib;
EntTime_distrib_type = IND.EntTime_distrib_type;
if EntTime_distrib_type == 1
    %如果是由个体记录中估计出的核密度
    Ind_EntTime = round(random(EntTime_distrib, NPED, 1));                  %取round是因为生成的随机数是分钟差，如果有小数，最后的结果一样有小数
    judge = Ind_EntTime >= 0 & Ind_EntTime <= 1440;
    while sum(judge) ~= NPED
        Ind_EntTime = round(random(EntTime_distrib, NPED, 1));
        judge = Ind_EntTime >= 0 & Ind_EntTime <= 1440;
    end
    Ind_EntTime = WDtimeConvert(Ind_EntTime, 3);
elseif EntTime_distrib_type == 2
    %如果是由自己定义的累积密度分布
    cumProb = EntTime_distrib(:, 2);
    temp = rand(1, NPED);
    temp2 = bsxfun(@minus, cumProb, temp);
    for ti = 1 : NPED
        Crt_EntTime_upper_index = find(temp2(:, ti) >= 0);      %找出正的，即比生成的随机数大的，其实只要第一个，即由负转正的，作为上界
        Crt_EntTime_upper = EntTime_distrib(Crt_EntTime_upper_index(1), 1);
        Crt_EntTime_lower = EntTime_distrib(Crt_EntTime_upper_index - 1, 1);
        Crt_EntTime = unifrnd(Crt_EntTime_lower, Crt_EntTime_upper);
        Crt_time_vec = datevec(Crt_EntTime);
        Ind_EntTime(ti, 1) = Crt_time_vec(4)*100 + Crt_time_vec(5);
    end
elseif EntTime_distrib_type == 3
    %精确的个体记录
    Ind_EntTime = EntTime_distrib;
end
%以上：出入口时空分布的边界条件%
%-----------------------------%
%各种时间变量
StayTime = TM.StayTime;
TrafficTime = TM.TrafficTime;
TrafficTime_taz_mu = TrafficTime.taz.mu;
TrafficTime_taz_sigma = TrafficTime.taz.sigma;
TrafficTime_ent_mu = TrafficTime.ent.mu;
TrafficTime_ent_sigma = TrafficTime.ent.sigma;
time_var = TM.time_var;

NVAR_NT = length(non_time_var_name);        %_NT表示NON TIME，非时间的解释变量
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
%注意，以上BTAZ与BHOME中变量的排序是按照B中变量名来的（即non_time_var_name，与time_var_name），而且都是排完了非时间变量后再排时间变量
NVAR_T = length(time_var_name);         %时间变量的个数
for i = 1 : NVAR_T
    Crt_var = time_var_name{i};
    %判断是不是给回家的，前两种情况是回家的，最后一种是一般TAZ的
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
IndTime = WDtimeConvert(Ind_EntTime,1);                                     %个体的个人时间——全部采用分钟差形式
CrtTime = min(IndTime) - 1;
%NextDecisionStage = -1 * ones(NPED,1);                                       %个人决策状态：-1为入口，0为回游，1为出口
%CrtStatus = zeros(NPED, 1);                                                 %个人状态：0为非活动（未进入或退出），1为停留，2为排队，3为交通
%---------------------------%
%按以前的格式生常规结果
result_ped = cell(NPED,5);                                                  %NPED*6
%注：增加的第5列用来存储入口时间（1-消费者编号；2-入口ID；3-路径；4-去了多少地；5-入口时间；6-出口时间），主要为了确定最大时间与最小时间
result_taz = 1:NALT;
result_taz = [result_taz',zeros(NALT,1)];                                   
%--------------------------------------------%
for i = 1 : NPED
    result_ped{i,1} = i;                                                    %cell第1列记入PED编号
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
%     %查错用
%         a = 1;
%     end
%     if CrtTime > WDtimeConvert(2400,1)
%         disp([num2str(WDtimeConvert(CrtTime - 1440,3))]);
%     else
%         disp([num2str(WDtimeConvert(CrtTime,3))]);
%     end
%     if CrtTime > 2000               %查错用
%         a = 11;
%     end
    TimeSerie = [TimeSerie, WDtimeConvert(CrtTime, 3)];
    for i = 1 : NPED
%         if i == 29          %查错用
%             a = 1;
%         end
        if ~isequal(Ind(i).NextDecisonTime, CrtTime)                     %未到决定时
            if Ind(i).NextDecisionStage ~= 0
                Ind(i).CrtStatus = 0;
            else
                if CrtTime < Ind(i).NextArriveTime  
                    Ind(i).CrtStatus = 3;
                    Ind(i).NextEntryTime = -9999;                           %用来代替原来的Unkonw
                    Ind(i).NextDecisonTime = -9999;                         %用来代替原来的Unkonw
                elseif CrtTime == Ind(i).NextArriveTime 
                    %-------判断排队时间-------%
                    Crt_queue_time = CrtTimeTAZ_QueueTime(Ind(i).Route(end));
                    Ind(i).CrtQueueTime = Crt_queue_time;
                    Ind(i).NextEntryTime = Ind(i).NextArriveTime + Crt_queue_time;
                    %-------------------------%
                    CrtStayTime_distr_index = cell2mat(StayTime(:,1)) == Ind(i).Route(end);       %稍微防止一下小区编号不是从1到NTAZ，最好不要发生这种情况
                    CrtStayTime_distr = StayTime{CrtStayTime_distr_index, 2};
                    CrtLastTime = round(random(CrtStayTime_distr));                         %从分布中抽取随机数，取整
                    while CrtLastTime <= 0                                                    %保证停留时间为正
                        CrtLastTime = round(random(CrtStayTime_distr));
                    end
                    Ind(i).CrtStayTime = CrtLastTime;
                    Ind(i).NextDecisonTime = Ind(i).NextEntryTime + CrtLastTime;
                    Ind(i).ActLastTime = [Ind(i).ActLastTime, Crt_queue_time + CrtLastTime];
                    result_ped{i, 3} = [Ind(i).Route; Ind(i).ActStartTime; Ind(i).ActLastTime];
                    if CrtTime < Ind(i).NextEntryTime                           
                        %同样，NextEntryTime = CrtTime +
                        %非负数，所以要么大，要么等于，如果大，说明排队时间不为0，现在状态为排队，否则说明排队时间为0，直接入场
                        Ind(i).CrtStatus = 2;               %排队
                    elseif CrtTime == Ind(i).NextEntryTime
                        %既然排队时间为0，现在就正好入场，入场之后再决定停留多长时间
                        Ind(i).CrtStatus = 1;               %停留
                    end
                elseif CrtTime > Ind(i).NextArriveTime                      %注意：只有在当前时间=到达入口时间时，才会生成预期排队与预期参观时间，如果已过了，只需要判断即可
                    if CrtTime < Ind(i).NextEntryTime
                        Ind(i).CrtStatus = 2;               %排队
                    elseif CrtTime > Ind(i).NextEntryTime
                        Ind(i).CrtStatus = 1;               %停留
                    end
                end
                if CrtTime == Ind(i).NextArriveTime
                    CrtTimeTAZ_NIND(Ind(i).Route(end)) = CrtTimeTAZ_NIND(Ind(i).Route(end)) + 1;     %到达
                    CrtTimeTAZ_Queue = max(CrtTimeTAZ_NIND - TAZ_Capacity, 0);
                end
            end
        else                                                                %决定
            if Ind(i).NextDecisionStage == -1                                  %入口决定
                CrtEntrance = X_ent_distrib(i);                              %当前入口
                result_ped{i,2} = CrtEntrance;                                          %cell第2列记入入口
                result_ped{i,5} = WDtimeConvert(CrtTime, 3);                            %cell第5列记入入口时间
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
            %   计算效用与执行选择（入口阶段）
            CrtVTAZ = CrtXTAZ * BTAZ;                                               %taz可见效用,NTAZ*1
            CrtVHOME = CrtXHOME * BHOME;                                            %home可见效用,1*1
            % --------------------------------------------- %
            %增加额外的动态效用（人数/密度/排队）
            if ~isempty(TAZ_NIND)                                               %第1分钟没任何记录
                CrtVolumnX = TAZ_NIND(:, end);                      
            else
                CrtVolumnX = zeros(NTAZ, 1);
            end
            CrtDensityX = CrtVolumnX ./ TAZ_BaseArea;
            if ~isempty(TAZ_QueueTime)                                          %第1分钟没任何记录
                CrtQueueX = TAZ_QueueTime(:, end);                                  %用的是排队时间
            else
                CrtQueueX = zeros(NTAZ,  1);
            end
            CrtXTAZ_additional = [];
            BTAZ_additional = [];
            if  X_beta_volumn.type == 2
                cutpoints = X_beta_volumn.value(1, :);
                cutpoints = [cutpoints, inf];
                temp = CrtVolumnX;
                CrtVolumnX = [];                        %以temp为临时过渡，转成dummy
                for jj = 1 : length(cutpoints) - 1
                    CrtVolumnX(:, jj) = temp >= cutpoints(jj) & temp < cutpoints(jj+1);
                end
            end
            if  X_beta_density.type == 2
                cutpoints = X_beta_density.value(1, :);
                cutpoints = [cutpoints, inf];
                temp = CrtDensityX;
                CrtDensityX = [];                        %以temp为临时过渡，转成dummy
                for jj = 1 : length(cutpoints) - 1
                    CrtDensityX(:, jj) = temp >= cutpoints(jj) & temp < cutpoints(jj+1);
                end
            end
            if  X_beta_queue.type == 2
                cutpoints = X_beta_queue.value(1, :);
                cutpoints = [cutpoints, inf];
                temp = CrtQueueX;
                CrtQueueX = [];                        %以temp为临时过渡，转成dummy
                for jj = 1 : length(cutpoints) - 1
                    CrtQueueX(:, jj) = temp >= cutpoints(jj) & temp < cutpoints(jj+1);
                end
            end
            CrtXTAZ_additional = [CrtXTAZ_additional, CrtVolumnX, CrtDensityX, CrtQueueX];
            BTAZ_additional = [BTAZ_additional; X_beta_volumn.value(2,:)'; X_beta_density.value(2,:)'; X_beta_queue.value(2,:)'];
            CrtVTAZ_additional = CrtXTAZ_additional * BTAZ_additional ;
            CrtVTAZ = CrtVTAZ + CrtVTAZ_additional;
            % --------------------------------------------- %
            CrtV = [CrtVTAZ ; CrtVHOME];                                            %置于一起,NALT*1
            CrtEV = exp(CrtV);                                                      %eV
            CrtProb = CrtEV / sum(CrtEV);                                           %选择概率,NALT*1
            CrtToChooseX = [[1:NALT]' , CrtProb];                                   %能被tochoose调用的自变量，第一列为备选项编号，第二列为概率，NALT*2
            CrtChoice = tochoose(CrtToChooseX);                                     %选择结果
            while CrtChoice == NALT & Ind(i).NextDecisionStage == -1                %保证不能在入口就选择出口
                CrtChoice = tochoose(CrtToChooseX);
            end
            result_taz(CrtChoice,2) = result_taz(CrtChoice,2) + 1; 
            if CrtChoice == NTAZ + 1                                        %已到出口
                result_ped{i, 6} = WDtimeConvert(CrtTime, 3);
                Ind(i).NextDecisionStage = 1;
                Ind(i).CrtStatus = 0;
                CrtTimeTAZ_NIND(CrtDecisionPlace) = CrtTimeTAZ_NIND(CrtDecisionPlace) - 1;      %离开
                CrtTimeTAZ_Queue = max(CrtTimeTAZ_NIND - TAZ_Capacity, 0);
                Ind(i).NextDecisonTime = inf;
                continue
            end
            Ind(i).Route = [Ind(i).Route, CrtChoice];
            %   动态更新链相关数据
            CrtPstArN = CrtPstArN + 1;                                              %更新已回游的次数
            CrtVstd(CrtChoice) = CrtVstd(CrtChoice) + 1;                            %更新已去过的地方（累加式），注意，入口阶段已保证不可能选择出口（46），NTAZ*1
            Ind(i).CrtPstArN = CrtPstArN;
            Ind(i).CrtVstd = CrtVstd;
            result_ped{i, 4} = Ind(i).CrtPstArN;
            %到第一个路径TAZ的交通时间
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
            Ind(i).NextArriveTime = CrtTime + Crt_traffic_time;         %当前时间+交通时间=到达下一个点的时间
            Ind(i).ActStartTime = [Ind(i).ActStartTime, WDtimeConvert(Ind(i).NextArriveTime, 3)];

            if CrtTime < Ind(i).NextArriveTime                              %最正常的情况：交通时间不为0
                Ind(i).CrtStatus = 3;               %交通
                Ind(i).NextEntryTime = -9999;                   %用来代替原来的Unkonw
                Ind(i).NextDecisonTime = -9999;                 %用来代替原来的Unkonw
            elseif CrtTime == Ind(i).NextArriveTime                       
                 %少见的情况：交通时间为0——由于NextArriveTime =
                 %CrtTime+非负数，所以不可能出现后者更大的情况。如果相等就说明已经走过了，现在可以评估排队时间了
                %-------判断排队时间-------%
                Crt_queue_time = CrtTimeTAZ_QueueTime(Ind(i).Route(end));
                Ind(i).CrtQueueTime = Crt_queue_time;
                Ind(i).NextEntryTime = Ind(i).NextArriveTime + Crt_queue_time;
                %-------------------------%
                CrtStayTime_distr_index = cell2mat(StayTime(:,1)) == CrtChoice;       %稍微防止一下小区编号不是从1到NTAZ，最好不要发生这种情况
                CrtStayTime_distr = StayTime{CrtStayTime_distr_index, 2};
                CrtLastTime = round(random(CrtStayTime_distr));                         %从分布中抽取随机数，取整
                while CrtLastTime <= 0                                                    %保证停留时间为正
                    CrtLastTime = round(random(CrtStayTime_distr));
                end
                Ind(i).CrtStayTime = CrtLastTime;
                Ind(i).NextDecisonTime = Ind(i).NextEntryTime + CrtLastTime;
                Ind(i).ActLastTime = [Ind(i).ActLastTime, Crt_queue_time + CrtLastTime];
                result_ped{i, 3} = [Ind(i).Route; Ind(i).ActStartTime; Ind(i).ActLastTime];
                if CrtTime < Ind(i).NextEntryTime                           
                    %同样，NextEntryTime = CrtTime +
                    %非负数，所以要么大，要么等于，如果大，说明排队时间不为0，现在状态为排队，否则说明排队时间为0，直接入场
                    Ind(i).CrtStatus = 2;               %排队
                elseif CrtTime == Ind(i).NextEntryTime      
                    %既然排队时间为0，现在就正好入场，入场之后再决定停留多长时间
                    Ind(i).CrtStatus = 1;               %停留
                end
            end
            %更新当前TAZ
            if Ind(i).NextDecisionStage == 0
                CrtTimeTAZ_NIND(CrtDecisionPlace) = CrtTimeTAZ_NIND(CrtDecisionPlace) - 1;      %离开
            end
            if CrtTime == Ind(i).NextArriveTime
                CrtTimeTAZ_NIND(Ind(i).Route(end)) = CrtTimeTAZ_NIND(Ind(i).Route(end)) + 1;     %到达
            end
            CrtTimeTAZ_Queue = max(CrtTimeTAZ_NIND - TAZ_Capacity, 0);
            for kkk = 1 : NTAZ
                CrtQueue = CrtTimeTAZ_Queue(kkk);
                CrtStayTime_distr_index = find(cell2mat(StayTime(:,1)) == kkk);       %稍微防止一下小区编号不是从1到NTAZ，最好不要发生这种情况
                CrtStayTime_distr = StayTime{CrtStayTime_distr_index, 2};
                CrtLastTime4CrtQueue = round(max(random(CrtStayTime_distr, CrtQueue, 1), 0));                         %从分布中抽取随机数，取整
                CrtTimeTAZ_QueueTime(kkk, 1) = round(sum(CrtLastTime4CrtQueue) / TAZ_Capacity(kkk));
                %上一步取整是关键，因为前面首先要判断当前时间是否已经到了下一步决策时间（是否==），如果到了，就会进行新的选择，同时会把
                %再一步的决策时间往前推，使得当前时间永远<=下一步决策时间，但由于算排队时有小数，会出现虽然到了那个占为，但~=的情况
                %跳过了下一步开展新的选择的时候，以至于出现当前时间>下一步选择时间，无限制地停留下去。。。！！！
            end
            Ind(i).NextDecisionStage = 0;                   %如果下一步是出口的话，早就跳出了，在这里才设置是为了保证前面更新TAZ时入口阶段没有“离开”概念
%             if i == 29          %查错用
%                 Ind(i)
%             end
        end
%         if i == 29            %查错用
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
CrtXHOME = [];              %初始化
%先是所有的非时间变量
for kk = 1 : NVAR_NT
    Crt_var_name = non_time_var_name{kk};
    if ~isequal(Crt_var_name, 'past') & ~isequal(Crt_var_name, 'familarity') & ~isequal(Crt_var_name, 'visited')
        Crt_var_X = getfield(X, Crt_var_name);
        if isempty(Crt_var_X)
            errordlg('Something strange happen, see error 5001')
            return
        end
        if ~isstruct(Crt_var_X)
            CrtXTAZ = [CrtXTAZ, Crt_var_X];                             %不是结构体，应该就是一列变量
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
CrtXHOME = [CrtPstArN];         %HOME可见效用
% 然后是时间变量：入口时间判断
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
    else    %时间段开始时间为空，说明上界无控制，只要不晚于结束时间即可
        after_start = 1;
    end
    if ~isempty(Crt_end_time)
        if CrtTime <= WDtimeConvert(Crt_end_time, 1)
            before_end = 1;
        else
            before_end = 0;
        end
    else        %时间段结束时间为空，说明下界无控制，只要不早于开始时间即可
        before_end = 1;
    end
    if after_start == 1 & before_end == 1
        %只有在时间范围内，在需要理会
        if Crt_origin == 1 & isequal(Crt_var.interaction_var_name, 'Past')
            timeXHOME = [timeXHOME, CrtPstArN];                           %交互：1*CrtPstArN = CrtPstArN
        elseif Crt_origin == 2 & isequal(Crt_var.X_created_interaction_var, [zeros(NTAZ, 1);1])
            timeXHOME = [timeXHOME, 1];                                   %交互：1*1 = 1
        else
            %属于小区的变量，需要先判断来源，如果是已存在的变量，需要找出来index，如果是自己临时定义的，要提取，并保证其长度为NTAZ
            if Crt_origin == 1
                Crt_time_var_interaction_var_name = Crt_var.interaction_var_name;
                %来自已定义的变量名，对于基本模式的变量名需要转一下
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
            else            %来自于自己定义的变量
                Crt_X_interaction = Crt_var.X_created_interaction_var;
            end
            if length(Crt_X_interaction) ~= NTAZ
                errordlg('Strange thinghs happend, interacton variables length do not equals NTAZ, see error 9379', 'Error')
                return
            end
            timeXTAZ= [timeXTAZ, Crt_X_interaction];
        end
    else
        %不在此时间段，无论是TAZ还是回家，都设为0即可
        if Crt_origin == 1 & isequal(Crt_var.interaction_var_name, 'Past')
            timeXHOME = [timeXHOME, 0];                                  %交互：0*CrtPstArN = 0
        elseif Crt_origin == 2 & isequal(Crt_var.X_created_interaction_var, [zeros(NTAZ, 1);1])
            timeXHOME = [timeXHOME, 0];                                  %交互：0*1 = 0
        else
            Crt_X_interaction = zeros(NTAZ, 1);                         %不在时间段与小区交互，直接全是0
            timeXTAZ= [timeXTAZ, Crt_X_interaction];
        end
    end
end
%合并时间与非时间变量
CrtXTAZ = [CrtXTAZ, timeXTAZ];
CrtXHOME = [CrtXHOME, timeXHOME];            



