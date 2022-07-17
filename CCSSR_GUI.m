function [ result_ped,result_taz ] = CCSSR_GUI(EV,IND, B)
%[功能] Commercial Complex Simulation Single Run, in GUI
%[输入] EV：环境自变量； IND：个体自变量；B：自变量参数
%[输出] result_ped:个体的模拟结果；result_taz：小区的模拟结果
%[EV结构体] area：面积; dist:TAZ间水平距离; dist_ent:出入口水平距离; stdf:TAZ间竖向距离;
%stdf_ent:出入口竖向距离; NTAZ:TAZ数量
%[IND结构体] ent_distrib: 出入口消费者分布; familarity:消费者熟悉度; NPED：消费者数量
%[B结构体] area, familarity, dist, stdf, visited, past

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

% if max(X_ent_distrib) < 1 & NENT ~= 1
if X_ent_distrib_type == 1;  
    %此时为集计入口信息
    X_ent_distrib_aggr = X_ent_distrib;
    for j = 1 : NPED
        X_ent_distrib_ind(j , 1) = tochoose([[1:NENT]',X_ent_distrib_aggr]);
    end
    X_ent_distrib = X_ent_distrib_ind;
end
             
result_ped = cell(NPED,4);                                                  %NPED*4
result_taz = 1:NALT;
result_taz = [result_taz',zeros(NALT,1)];                                   %46*2

CheckEveryOneReachExit = zeros(NPED,1);                                     %用来检查是否每个人都最后选择了出口，即是否完成了完整路径

for i = 1 : NPED
    result_ped{i,1} = i;                                                    %cell第1列记入PED编号
    crtFamilarity = X_familarity(: , i);                                    %当前个体对TAZ的认识和熟悉度，在for-loop里保持不变,45*2
    crtVstd = zeros(NTAZ,1);                                                %TAZ是否已去过：45*1
    crtPstArN = 0;                                                          %已回游的次数
%     crtPstDist=0;                                                          %已走过的距离
%     crtPstStDf=0;                                                          %已走过的竖向差
    
    %入口阶段选择
    %   数据准备（入口阶段）   
    crtEntrance = X_ent_distrib(i);                                         %当前入口
    result_ped{i,2} = crtEntrance;                                          %cell第2列记入入口
    crtDist = X_dist_ent(: , crtEntrance);                                  %当前入口到各TAZ的距离，NTAZ*1
    crtStDf = X_stdf_ent(: , crtEntrance);                                  %当前入口到各TAZ的竖向差异，NTAZ*1
%     crtCntgHrz=contiguity_horizon_entrance(:,crtEntrance);                  %当前入口到各TAZ的水平相邻关系，45*1
%     crtCntgEsc=contiguity_escalator_entrance(:,crtEntrance);                %当前入口到TAZ的扶梯相邻关系，45*1
%     crtCntgElv=contiguity_elevator_entrance(:,crtEntrance);                 %当前入口到TAZ的电梯相邻关系，45*1
%     crtEntDistConvert=crtDist;                                              %平面回游效应在入口处等同于到入口的距离（past=0,1-past=1），45*1
%     crtEntStDfConvert=crtStDf;                                              %竖向回游效应在入口处等同于到入口的竖向差(past=0,1-past=1)，45*1
%     crtBckHrz=ones(NALT-1,1);                                               %第一步不存在平面回头，均为1，45*1                                                          
%     crtBckVtc=ones(NALT-1,1);                                               %第一步不存在竖向回头，均为1：45*1
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
%     crtPstDist=crtPstDist+dist_entrance(crtChoice,crtEntrance);             %更新已走过的距离
%     crtPstStDf=crtPstStDf+stair_entrance(crtChoice,crtEntrance);            %更新已走过的竖向差
    crtVstd(crtChoice) = crtVstd(crtChoice) + 1;                            %更新已去过的地方（累加式），注意，入口阶段已保证不可能选择出口（46），NTAZ*1
    crtRoute = crtChoice;                                                   %当前路径的第一个元素为入口选择结果
    %   结果记录（入口）
    result_ped{i , 4} = 1;                                                  %cell第4列更新为1表示到了1个地方
    result_taz(crtChoice,2) = result_taz(crtChoice,2) + 1;                  %taz结果中对应的taz计数+1
    
    %回游阶段
    while 1
        crtFrom = crtRoute(end);                                            %当前循环（选择）的所处位置，等于上一次选择的结果
%         if length(crtRoute)>1                                               %当前循环的上一步位置，如果只有一个路径点，则没有上一步
%             lastStop=crtRoute(end-1);
%         else
%             lastStop=nan;
%         end
    %   数据准备（回游）   
        crtDist = X_dist(: , crtFrom);                                      %当前位置到各TAZ的距离，NTAZ*1
        crtStDf = X_stdf(: , crtFrom);                                      %当前位置到各TAZ的竖向差异，45*1
%         crtCntgHrz=contiguity_horizon(:,crtFrom);                           %当前位置到各TAZ的水平相邻关系，45*1
%         crtCntgEsc=contiguity_escalator(:,crtFrom);                         %当前位置到TAZ的扶梯相邻关系，45*1
%         crtCntgElv=contiguity_elevator(:,crtFrom);                          %当前位置到TAZ的电梯相邻关系，45*1
%         crtPstDistConvert=1-(crtPstDist/200);                               %为计算平面回游效应，将已走过的距离进行转化，阈值200，scalar
%         crtEntDistConvert=dist_entrance(:,crtEntrance)*crtPstDistConvert;   %平面回游效应，前项为各TAZ到入口距离，与后者相乘，45*1
%         crtPstStDfConvert=1-(crtPstStDf/1);                                 %为计算竖向回游效应，将已走过的竖向差异进行转化，阈值1，scalar
%         crtEntStDfConvert=stair_entrance(:,crtEntrance)*crtPstStDfConvert;  %竖向回游效应,前项为各TAZ到入口竖向差异，与后者相乘，45*1
        
%         if isnan(lastStop)~=1
%             for ii=1:NALT-1                                                 %通过循环方法，调用goBack中的数据
%                 nextTo=ii;
%                 lastCrtNextIndex=lastStop*10000+crtFrom*100+nextTo;
%                 crtBckHrz(ii)=goBack(goBack(:,4)==lastCrtNextIndex,9);      %水平折返，45*1
%                 crtBckVtc(ii)=goBack(goBack(:,4)==lastCrtNextIndex,10);     %垂直折返，45*1
%             end                                   
%         else
%             crtBckHrz=ones(NALT-1,1);                                       %如果没有上一步（其实是入口，暂不考虑），则暂认为不存在水平折返，45*1
%             crtBckVtc=ones(NALT-1,1);                                       %如果没有上一步（其实是入口，暂不考虑），则暂认为不存在竖向折返，45*1
%         end
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
        if crtChoice ~= NALT                                                %如果选择结果不为出口
        %   动态更新链相关数据（回游）    
            crtPstArN = crtPstArN + 1;                                      %更新已回游的次数,scalar
%             crtPstDist=crtPstDist+dist(crtChoice,crtFrom);                  %更新已走过的距离,scalar
%             crtPstStDf=crtPstStDf+stair(crtChoice,crtFrom);                 %更新已走过的竖向差,scalar
            crtVstd(crtChoice) = crtVstd(crtChoice) + 1;                    %更新已去过的地方（累加式），注意,此时的循环条件保证了没有选择出口（NALT），NTAZ*1
            crtRoute(end+1) = crtChoice;                                    %当前路径的第一个元素为入口选择结果，动态变化数组
        %   结果记录（入口）
            result_ped{i,4} = result_ped{i,4} + 1;                          %cell第4列更新,+1表示多去了一个地方
            result_taz(crtChoice,2) = result_taz(crtChoice,2) + 1;          %taz结果中对应的taz计数+1  
        else                                                                %如果选择结果就是出口
            result_taz(crtChoice,2) = result_taz(crtChoice,2) + 1;          %照常更新taz结果中对应的taz计数+1，此时就为最后一个gohome选项+1
            CheckEveryOneReachExit(i) = 1;                                  %更新该PED的到达出口检查数据
        end
        %   回游中的出口阶段
        if crtChoice == NALT;
            break                                                           %跑出回游循环
        end
    end
    
    result_ped{i,3} = crtRoute;

end

    
% %检验结果
% if isequal(CheckEveryOneReachExit,ones(NPED,1))==1
%     disp('所有人都走完了路径')    
% else
%     disp('有问题，不是所有人都走完了路径！！')
% end




