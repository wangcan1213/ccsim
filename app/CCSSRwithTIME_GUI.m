function [ result_ped,result_taz ] = CCSSRwithTIME_GUI(EV,IND, B , TM)
%[功能] Commercial Complex Simulation Single Run with TIME: in GUI
%[输入] EV：环境自变量； IND：个体自变量；B：自变量参数；TM：时间变量
%[输出] result_ped:个体的模拟结果；result_taz：小区的模拟结果
%[EV结构体] area：面积; dist:TAZ间水平距离; dist_ent:出入口水平距离; stdf:TAZ间竖向距离;
%stdf_ent:出入口竖向距离; NTAZ:TAZ数量
%[IND结构体] ent_distrib: 出入口消费者分布; familarity:消费者熟悉度; NPED：消费者数量
%EntTime_distrib 消费者入口的时间分布   %EntTime_distrib_type 消费者入口的时间分布类型：（1，估计的核密度；2，自定义的累积分布；3，个体记录）
%[B结构体] area, familarity, dist, stdf, visited, past
%[TM结构体]: StayTime, TrafficTime



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
        crt_EntTime_upper_index = find(temp2(:, ti) >= 0);      %找出正的，即比生成的随机数大的，其实只要第一个，即由负转正的，作为上界
        crt_EntTime_upper = EntTime_distrib(crt_EntTime_upper_index(1), 1);
        crt_EntTime_lower = EntTime_distrib(crt_EntTime_upper_index - 1, 1);
        crt_EntTime = unifrnd(crt_EntTime_lower, crt_EntTime_upper);
        crt_time_vec = datevec(crt_EntTime);
        Ind_EntTime(ti, 1) = crt_time_vec(4)*100 + crt_time_vec(5);
    end
elseif EntTime_distrib_type == 3
    %精确的个体记录
    Ind_EntTime = EntTime_distrib;
end


% hint: Ind_EntTime是一个NPED*1的列向量，为每个人的入场时间（HHMM模式）
%       X_ent_distrib是一个NPED*1的列向量，为每个人的出入口
%       X_familarity是一个NTAZ*NPED的矩阵，第i个人对所有TAZ的熟悉度是X_familarity(:, i)


result_ped = cell(NPED,6);                                                  %NPED*5
%注：增加的第5列用来存储入口时间（1-消费者编号；2-入口ID；3-路径；4-去了多少地；5-入口时间；6-出口时间），主要为了确定最大时间与最小时间
result_taz = 1:NALT;
result_taz = [result_taz',zeros(NALT,1)];                                   %46*2

CheckEveryOneReachExit = zeros(NPED,1);                                     %用来检查是否每个人都最后选择了出口，即是否完成了完整路径

for i=1:NPED
    result_ped{i,1} = i;                                                    %cell第1列记入PED编号
    crtFamilarity = X_familarity(: , i);                                    %当前个体对TAZ的认识和熟悉度，在for-loop里保持不变,45*2
    crtVstd = zeros(NTAZ,1);                                                %TAZ是否已去过：45*1
    crtPstArN = 0;                                                          %已回游的次数
    crtEntranceTime = Ind_EntTime(i);                                       %当前个体的入口时间
    %记录当前时间crtTime:注意，crtTime采用基准分钟差进行标记
    crtTime = WDtimeConvert(crtEntranceTime,1);                             %当前个体的“当前时间”：入口时间
    
    %入口阶段选择
    %   数据准备（入口阶段）
    crtEntrance = X_ent_distrib(i);                                         %当前入口
    result_ped{i,2} = crtEntrance;                                          %cell第2列记入入口
    result_ped{i,5} = crtEntranceTime;                                      %cell第5列记入入口时间
    crtDist = X_dist_ent(: , crtEntrance);                                  %当前入口到各TAZ的距离，NTAZ*1
    crtStDf = X_stdf_ent(: , crtEntrance);                                  %当前入口到各TAZ的竖向差异，NTAZ*1
    crtXTAZ = [X_area, crtFamilarity, crtDist, crtStDf, crtVstd];           %TAZ可见效用，NTAZ*5
    crtXHOME = [crtPstArN];                                                 %HOME可见效用，1*1
    
    %   计算效用与执行选择（入口阶段）
    crtVTAZ = crtXTAZ * BTAZ;                                               %taz可见效用,NTAZ*1
    crtVHOME = crtXHOME * BHOME;                                            %home可见效用,1*1
    crtV = [crtVTAZ ; crtVHOME];                                            %置于一起,NALT*1
    crtEV = exp(crtV);                                                      %eV
    crtProb = crtEV / sum(crtEV);                                           %选择概率,NALT*1
    crtToChooseX = [[1:NALT]' , crtProb];                                   %能被tochoose调用的自变量，第一列为备选项编号，第二列为概率，NALT*2
    crtChoice = tochoose(crtToChooseX);                                     %选择结果
    while crtChoice == NALT                                                 %保证不能在入口就选择出口
        crtChoice = tochoose(crtToChooseX);
    end
    
    %   动态更新链相关数据（入口）
    crtPstArN = crtPstArN + 1;                                              %更新已回游的次数
    crtVstd(crtChoice) = crtVstd(crtChoice) + 1;                            %更新已去过的地方（累加式），注意，入口阶段已保证不可能选择出口（46），NTAZ*1
    crtRoute = crtChoice;                                                   %当前路径的第一个元素为入口选择结果
    
    %入口到第一个路径TAZ的交通时间
    crt_traffic_time_mu = TrafficTime_ent_mu(crtChoice, crtEntrance);
    crt_traffic_time_sigma = TrafficTime_ent_sigma(crtChoice, crtEntrance);
    crt_traffic_time = round(normrnd(crt_traffic_time_mu, crt_traffic_time_sigma));
    while crt_traffic_time < 0
        crt_traffic_time = round(normrnd(crt_traffic_time_mu, crt_traffic_time_sigma));
    end
    crtTime = crtTime + crt_traffic_time;                                   %当前时间：走到了第1个路径TAZ
    crtRoute_ActStartTime = WDtimeConvert(crtTime, 3);                      %当前路径的第一TAZ活动的开始时间：就是当前时间，转换成1940格式
    
    %   结果记录（入口）
    result_ped{i , 4} = 1;                                                  %cell第4列更新为1表示到了1个地方
    result_taz(crtChoice,2) = result_taz(crtChoice,2) + 1;                  %taz结果中对应的taz计数+1
    
    
    %   第一个路径TAZ的时间消耗
    crtStayTime_distr_index = find(cell2mat(StayTime(:,1)) == crtChoice);       %稍微防止一下小区编号不是从1到NTAZ，最好不要发生这种情况
    crtStayTime_distr = StayTime{crtStayTime_distr_index, 2};
    crtLastTime = round(random(crtStayTime_distr));                         %从分布中抽取随机数，取整
    while crtLastTime <= 0                                                    %保证停留时间为正
        crtLastTime = round(random(crtStayTime_distr));
    end
    crtRoute_ActLastTime = crtLastTime;                                     %停留时间确认为正后，记录到路径数据中（初始化，下面用end+1的方式后缀加入）
    %   动态更新当前时间
    crtTime = crtTime + crtLastTime;                                        %当前时间：路径中第一个TAZ活动已结束，准备做下一次的决定
    
    %回游阶段
    while 1
        crtFrom = crtRoute(end);                                            %当前循环（选择）的所处位置，等于上一次选择的结果
        %   数据准备（回游）
        crtDist = X_dist(: , crtFrom);                                      %当前位置到各TAZ的距离，NTAZ*1
        crtStDf = X_stdf(: , crtFrom);                                      %当前位置到各TAZ的竖向差异，45*1
        crtXTAZ=[X_area, crtFamilarity, crtDist, crtStDf,crtVstd];          %TAZ可见效用，NTAZ*5
        crtXHOME = [crtPstArN];                                             %HOME可见效用，1*1
        
        %   计算效用与执行选择（回游）
        crtVTAZ = crtXTAZ * BTAZ;                                           %taz可见效用,NTAZ*1
        crtVHOME = crtXHOME * BHOME;                                        %home可见效用,1*1
        crtV = [crtVTAZ ; crtVHOME];                                        %置于一起,NALT*1
        crtEV = exp(crtV);                                                  %eV
        crtProb = crtEV / sum(crtEV);                                       %选择概率初始化,NALT*1
        crtToChooseX = [[1:NALT]',crtProb];                                 %能被tochoose调用的自变量，第一列为备选项编号，第二列为概率，NALT*2
        crtChoice = tochoose(crtToChooseX);                                 %选择结果
        if crtChoice~=NALT                                                  %如果选择结果不为出口
            %   动态更新链相关数据（回游）
            crtPstArN = crtPstArN + 1;                                      %更新已回游的次数,scalar
            crtVstd(crtChoice) = crtVstd(crtChoice) + 1;                    %更新已去过的地方（累加式），注意,此时的循环条件保证了没有选择出口（NALT），NTAZ*1
            crtRoute(end+1) = crtChoice;                                    %当前路径的第一个元素为入口选择结果，动态变化数组
            
            
            %交通时间
            crt_traffic_time_mu = TrafficTime_taz_mu(crtChoice, crtFrom);           %%%%%%查一查是不是对称的
            crt_traffic_time_sigma = TrafficTime_taz_sigma(crtChoice, crtFrom);     %%%%%%查一查是不是对称的
            crt_traffic_time = round(normrnd(crt_traffic_time_mu, crt_traffic_time_sigma));
            while crt_traffic_time < 0
                crt_traffic_time = round(normrnd(crt_traffic_time_mu, crt_traffic_time_sigma));
            end
             %上一个crtTime是加了上一次活动的持续时间之后的上一个活动的完结时间，现在已经做完了决策，再加上到这个活动的交通时间
            crtTime = crtTime + crt_traffic_time;                           %当前时间：到达下一个路径TAZ点，准备活动（即活动开始，准备要加上crtLastTime）                        
            crtRoute_ActStartTime(end+1) = WDtimeConvert(crtTime, 3);       %当前时间即是当前活动的开始时间，更新之
            
            
            %   结果记录（入口）
            result_ped{i,4} = result_ped{i,4} + 1;                          %cell第4列更新,+1表示多去了一个地方
            result_taz(crtChoice,2) = result_taz(crtChoice,2) + 1;          %taz结果中对应的taz计数+1  
            
            
            %   时间消耗
            crtStayTime_distr_index = find(cell2mat(StayTime(:,1)) == crtChoice);       %稍微防止一下小区编号不是从1到NTAZ，最好不要发生这种情况
            crtStayTime_distr = StayTime{crtStayTime_distr_index, 2};
            crtLastTime = round(random(crtStayTime_distr));                         %从分布中抽取随机数，取整
            while crtLastTime <= 0                                                    %保证停留时间为正
                crtLastTime = round(random(crtStayTime_distr));
            end
            crtRoute_ActLastTime(end+1) = crtLastTime;                                     %停留时间确认为正后，记录到路径数据中（用end+1的方式后缀加入）

            %   动态更新当前时间
            crtTime = crtTime + crtLastTime;                                %当前时间：当前活动开始+当前活的持续=当前活动结束，准备下一次循环，即决策下一次活动的选择
           
        else                                                                %如果选择结果就是出口
             result_taz(crtChoice,2) = result_taz(crtChoice,2) + 1;          %照常更新taz结果中对应的taz计数+1，此时就为最后一个gohome选项+1
            CheckEveryOneReachExit(i) = 1;                                  %更新该PED的到达出口检查数据
            result_ped{i,6} = WDtimeConvert(crtTime, 3);                     %cell第6列记入出口时间
        end
        %   回游中的出口阶段
        if crtChoice == NALT;
            break                                                           %跑出回游循环
        end
    end
    
    result_ped{i,3} = [crtRoute; crtRoute_ActStartTime; crtRoute_ActLastTime];
    
end




