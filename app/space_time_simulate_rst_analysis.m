%C------------------------%\
%基本检查，后来看如果直接跟在时空模拟结果后面按最小精度生成，就不需要了%
% if ~isfield(handles, 'NTAZ')
%     errordlg('You must firstly set the Num. of TAZ', 'Error')
%     return
% else
%     NTAZ = handles.NTAZ;
% end
% if ~isfield(handles, 'NENT')
%     errordlg('You must firstly set the Num. of Entrances', 'Error')
%     return
%     NENT = handles.NENT;
% end
% 
% if ~isfield(handles, 'result') | ~isfield(handles, 'space_time_result_flag')
%     errordlg('There is
% else NO spatiotemporal simulation result.', 'Error')
%     return
% else
%     result = handles.result;
% end
%----------------------%
%设定结果的起始时间与时间距
%现在如果采用最小精度，也不需要指定了
% prompt = {'Enter the start time for result display (Format: HHMM):','Enter the end time for result display (Format: HHMM):',...
%     'Enter the time step size for result display (Unit: min)'};
% dlg_title = 'Time';
% num_lines = 1;
% default_interval = {'0900','2300', '30'};
% time_interval_def = inputdlgWC(prompt, dlg_title, num_lines, default_interval);
% if isempty(time_interval_def)
%     return
% end
% try
%     start_time = str2num(time_interval_def{1});
%     end_time = str2num(time_interval_def{2});
%     step_size = str2num(time_interval_def{3});
% catch
%     errordlg('Invalid input', 'Error')
%     return
% end
% if isempty(start_time) | isempty(end_time) | isempty(step_size)
%     return
% elseif ~isempty(start_time) & (start_time<0 | start_time> 2400 | ~isequal(start_time, round(start_time)))
%     errordlg('Invalid start time input', 'Error')
%     return
% elseif ~isempty(end_time) & (end_time<0 | end_time> 2400 | ~isequal(end_time, round(end_time)))
%     errordlg('Invalid end time input', 'Error')
%     return
% elseif ~isempty(step_size) & (step_size<0 | ~isequal(step_size, round(step_size)))
%     errordlg('Invalid step size input', 'Error')
%     return
% elseif WDtimeConvert(end_time, 1) < WDtimeConvert(start_time, 1)
%     errordlg('End time should not be smaller than start time', 'Error')
%     return
% end
%指定最小&最大时间与步长
step_size = 1;
entry_time = [];
for i = 1 : length(result)
    entry_time = [entry_time; cell2mat(result(i).ped(:,5))];
end
start_time = min(entry_time);
start_time = max(entry_time);
%----------------------%
crtTime = start_time;
%时间统计的间隔，time_statistic_interval,_diff是以分钟差形式,_origin是原始的1940形式
time_stat_intv_diff = WDtimeConvert(start_time, 1) : step_size : WDtimeConvert(end_time, 1);
time_stat_intv_origin = WDtimeConvert(time_stat_intv_diff, 3);

for i = 1 : length(result)
    crt_path_cell = result(i).ped;
    NPED = size(crt_path_cell, 1);
    crt_timely_taz_stat = zeros(NTAZ , length(time_stat_intv_diff));
    %入口、回游相关统计
    for j = 1 : NPED
        crt_ped_entrance = crt_path_cell{j,2};
        crt_ped_path_with_TIME = crt_path_cell{j,3};
        crt_ped_path = crt_ped_path_with_TIME(1,:);
        crt_ped_path_StartTime = crt_ped_path_with_TIME(2,:);
        crt_ped_path_LastTime = crt_ped_path_with_TIME(3,:);
        for k=1 : length(crt_ped_path)-1
            %时间统计
            crt_ped_crt_start_time = crt_ped_path_StartTime(k);
            crt_ped_next_start_time = crt_ped_path_StartTime(k+1);
            crt_ped_crt_start_time2 = WDtimeConvert(crt_ped_crt_start_time,1);      %后缀2为分钟差形式
            crt_ped_next_start_time2 = WDtimeConvert(crt_ped_next_start_time,1);
            crt_ped_crt_last_time = crt_ped_path_LastTime(k);
            for kk = 1 : length(time_stat_intv_diff)
                %                 if time_stat_intv_diff(kk) >= crt_ped_crt_start_time2  &  time_stat_intv_diff(kk) < crt_ped_next_start_time2
                if time_stat_intv_diff(kk) >= crt_ped_crt_start_time2  &  ...
                        time_stat_intv_diff(kk) < crt_ped_crt_start_time2 + crt_ped_crt_last_time
                    %以前是不考虑交通时间的，现在把交通时间剔掉，逻辑是：在小区A起始时间 < 兴趣时间 < 在小区A结束时间（以前是在下一个小区起始时间）
                    %那么在兴趣时间点这一时刻（不是用的时间区间，而是一个时间切片），他一定还在小区A
                    %比如：当前活动开始时间（crt_ped_crt_start_time2）为9:00，加上活动持续时间60m，活动末要走时为10：00，统计时间为9:30，即930>900且930<1000，那么显然此时正在
                    crt_timely_taz_stat(crt_ped_path(k) , kk) = crt_timely_taz_stat(crt_ped_p    ath(k) , kk) + 1;
                    %-------------------%有争议，如果严格到当时的时间切片瞬间的话，这种大（统计区间）包小（活动区间）的情况，小区间就不被
                    %统计到了，但确实也没办法，想想也是，
                    %如果一个超级大的区间（9：00~22：00），几乎所有的活动都成了大包小，总不能把人都算进去啊，防止这种情况只能细化时间区间，比如用5分钟尺度，下面
                    %105-107行的comment类似
%                 elseif kk<=length(time_stat_intv_diff)-1 & time_stat_intv_diff(kk) < crt_ped_crt_start_time2 & ...
%                         time_stat_intv_diff(kk) < crt_ped_next_start_time2  & time_stat_intv_diff(kk+1) >= crt_ped_crt_start_time2 + crt_ped_crt_last_time
%                     %这里可能有点争议，考虑的情况是，如果时间切片画的太大，比如9：00-10：00，但消费者在9:20-9:40去了一个小区，那么它在这个小区的停留就不会被任何时间点记录到
%                     %所以才加了这么一段，算是他在一个以当前切片点为起点的时间区间内来过
%                     crt_timely_taz_stat(crt_ped_path(k) , kk) = crt_timely_taz_stat(crt_ped_path(k) , kk) + 1;
                end
            end
        end
        %最后一步要用到持续时间
        crt_ped_EndAction_start_time = crt_ped_path_StartTime(end);
        crt_ped_EndAction_start_time2 = WDtimeConvert(crt_ped_EndAction_start_time,1);
        crt_ped_EndAction_over_time2 = crt_ped_EndAction_start_time2 + crt_ped_path_LastTime(end);
        for kk=1:length(time_stat_intv_diff)
            if time_stat_intv_diff(kk) >= crt_ped_EndAction_start_time2 & time_stat_intv_diff(kk) <= crt_ped_EndAction_over_time2
                crt_timely_taz_stat(crt_ped_path(end) , kk) = crt_timely_taz_stat(crt_ped_path(end) , kk) + 1;
%             elseif kk<=length(time_stat_intv_diff)-1 & time_stat_intv_diff(kk) < crt_ped_crt_start_time2 ...
%                     & time_stat_intv_diff(kk) < crt_ped_next_start_time2  & time_stat_intv_diff(kk+1) >= crt_ped_next_start_time2
%                 crt_timely_taz_stat(crt_ped_path(end),kk) = crt_timely_taz_stat(crt_ped_path(end),kk) + 1;
            end
        end
        
    end
    timely_taz_stat(:,:,i)=crt_timely_taz_stat;  
end
timely_taz_stat_mean = mean(timely_taz_stat , 3);                           %将多次模拟的结果平均
timely_taz_stat_result.detail = timely_taz_stat;
timely_taz_stat_result.mean = timely_taz_stat_mean;
timely_taz_stat_result.time_par = [start_time; step_size; end_time];
handles.timely_taz_stat_result = timely_taz_stat_result;
guidata(hObject, handles);
