%C------------------------%\
%������飬���������ֱ�Ӹ���ʱ��ģ�������水��С�������ɣ��Ͳ���Ҫ��%
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
%�趨�������ʼʱ����ʱ���
%�������������С���ȣ�Ҳ����Ҫָ����
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
%ָ����С&���ʱ���벽��
step_size = 1;
entry_time = [];
for i = 1 : length(result)
    entry_time = [entry_time; cell2mat(result(i).ped(:,5))];
end
start_time = min(entry_time);
start_time = max(entry_time);
%----------------------%
crtTime = start_time;
%ʱ��ͳ�Ƶļ����time_statistic_interval,_diff���Է��Ӳ���ʽ,_origin��ԭʼ��1940��ʽ
time_stat_intv_diff = WDtimeConvert(start_time, 1) : step_size : WDtimeConvert(end_time, 1);
time_stat_intv_origin = WDtimeConvert(time_stat_intv_diff, 3);

for i = 1 : length(result)
    crt_path_cell = result(i).ped;
    NPED = size(crt_path_cell, 1);
    crt_timely_taz_stat = zeros(NTAZ , length(time_stat_intv_diff));
    %��ڡ��������ͳ��
    for j = 1 : NPED
        crt_ped_entrance = crt_path_cell{j,2};
        crt_ped_path_with_TIME = crt_path_cell{j,3};
        crt_ped_path = crt_ped_path_with_TIME(1,:);
        crt_ped_path_StartTime = crt_ped_path_with_TIME(2,:);
        crt_ped_path_LastTime = crt_ped_path_with_TIME(3,:);
        for k=1 : length(crt_ped_path)-1
            %ʱ��ͳ��
            crt_ped_crt_start_time = crt_ped_path_StartTime(k);
            crt_ped_next_start_time = crt_ped_path_StartTime(k+1);
            crt_ped_crt_start_time2 = WDtimeConvert(crt_ped_crt_start_time,1);      %��׺2Ϊ���Ӳ���ʽ
            crt_ped_next_start_time2 = WDtimeConvert(crt_ped_next_start_time,1);
            crt_ped_crt_last_time = crt_ped_path_LastTime(k);
            for kk = 1 : length(time_stat_intv_diff)
                %                 if time_stat_intv_diff(kk) >= crt_ped_crt_start_time2  &  time_stat_intv_diff(kk) < crt_ped_next_start_time2
                if time_stat_intv_diff(kk) >= crt_ped_crt_start_time2  &  ...
                        time_stat_intv_diff(kk) < crt_ped_crt_start_time2 + crt_ped_crt_last_time
                    %��ǰ�ǲ����ǽ�ͨʱ��ģ����ڰѽ�ͨʱ���޵����߼��ǣ���С��A��ʼʱ�� < ��Ȥʱ�� < ��С��A����ʱ�䣨��ǰ������һ��С����ʼʱ�䣩
                    %��ô����Ȥʱ�����һʱ�̣������õ�ʱ�����䣬����һ��ʱ����Ƭ������һ������С��A
                    %���磺��ǰ���ʼʱ�䣨crt_ped_crt_start_time2��Ϊ9:00�����ϻ����ʱ��60m���ĩҪ��ʱΪ10��00��ͳ��ʱ��Ϊ9:30����930>900��930<1000����ô��Ȼ��ʱ����
                    crt_timely_taz_stat(crt_ped_path(k) , kk) = crt_timely_taz_stat(crt_ped_p    ath(k) , kk) + 1;
                    %-------------------%�����飬����ϸ񵽵�ʱ��ʱ����Ƭ˲��Ļ������ִ�ͳ�����䣩��С������䣩�������С����Ͳ���
                    %ͳ�Ƶ��ˣ���ȷʵҲû�취������Ҳ�ǣ�
                    %���һ������������䣨9��00~22��00�����������еĻ�����˴��С���ܲ��ܰ��˶����ȥ������ֹ�������ֻ��ϸ��ʱ�����䣬������5���ӳ߶ȣ�����
                    %105-107�е�comment����
%                 elseif kk<=length(time_stat_intv_diff)-1 & time_stat_intv_diff(kk) < crt_ped_crt_start_time2 & ...
%                         time_stat_intv_diff(kk) < crt_ped_next_start_time2  & time_stat_intv_diff(kk+1) >= crt_ped_crt_start_time2 + crt_ped_crt_last_time
%                     %��������е����飬���ǵ�����ǣ����ʱ����Ƭ����̫�󣬱���9��00-10��00������������9:20-9:40ȥ��һ��С������ô�������С����ͣ���Ͳ��ᱻ�κ�ʱ����¼��
%                     %���Բż�����ôһ�Σ���������һ���Ե�ǰ��Ƭ��Ϊ����ʱ������������
%                     crt_timely_taz_stat(crt_ped_path(k) , kk) = crt_timely_taz_stat(crt_ped_path(k) , kk) + 1;
                end
            end
        end
        %���һ��Ҫ�õ�����ʱ��
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
timely_taz_stat_mean = mean(timely_taz_stat , 3);                           %�����ģ��Ľ��ƽ��
timely_taz_stat_result.detail = timely_taz_stat;
timely_taz_stat_result.mean = timely_taz_stat_mean;
timely_taz_stat_result.time_par = [start_time; step_size; end_time];
handles.timely_taz_stat_result = timely_taz_stat_result;
guidata(hObject, handles);
