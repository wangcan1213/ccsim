function [taz_taz_traffic_time, taz_ent_traffic_time] = traffic_time_GUI(space_time_path_rawdata, NTAZ, NENT)
%为了估计交通时间而写的小程序，输入的space_time_path_rawdata是一个cell，其中，第一列是消费者编号；
%第二列是入口信息（1*2：入口编号，入口时间），第三列是TAZ信息（N*3：TAZ编号，TAZ时间，TAZ停留）
%%%%%!!!!以主文件里的那个为准%%%
taz_taz_traffic_time_mu = nan(NTAZ, NTAZ);
taz_taz_traffic_time_sigma = nan(NTAZ, NTAZ);
taz_ent_traffic_time_mu = nan(NTAZ, NENT);
taz_ent_traffic_time_sigma = nan(NTAZ, NENT);
taz_taz_traffic_time_rawdata = cell(NTAZ, NTAZ);
taz_ent_traffic_time_rawdata = cell(NTAZ, NENT);
for i = 1 : size(space_time_path_rawdata, 1)
    crt_ent_data = space_time_path_rawdata{i, 2};
    crt_path_data = space_time_path_rawdata{i, 3};
    crt_entID = crt_ent_data(1);
    first_tazID = crt_path_data(1, 1);
    try
        crt_entTime = WDtimeConvert(crt_ent_data(2), 2);
        first_tazTime = WDtimeConvert(crt_path_data(1, 2), 2);
    catch
        errordlg('Invalid data format: check your time data', 'Error');
    end
    taz_ent_traffic_time_rawdata{first_tazID, crt_entID}(end+1) = [max(0, first_tazTime - crt_entTime)];
    for k = 1 : size(crt_path_data, 2) - 1
        crt_path_crt_taz = crt_path_data(k, 1);
        crt_path_next_taz = crt_path_data(k+1, 1);
        crt_path_crt_stay = crt_path_data(k, 3);
        try
            crt_path_crt_time = WDtimeConvert(crt_path_data(k, 2), 2);
            crt_path_next_time = WDtimeConvert(crt_path_data(k+1, 2), 2);
        catch
            errordlg('Invalid data format: check your time data', 'Error');
        end
        taz_taz_traffic_time_rawdata{crt_path_crt_taz, crt_path_next_taz}(end+1) = max(0, crt_path_next_time  - (crt_path_crt_time + crt_path_crt_stay));
        taz_taz_traffic_time_rawdata{crt_path_next_taz, crt_path_crt_taz}(end+1) = max(0, crt_path_next_time  - (crt_path_crt_time + crt_path_crt_stay));
    end
end

for i = 1 : NTAZ
    for j = 1 :NTAZ
        taz_taz_traffic_time_mu(i, j) = mean(taz_taz_traffic_time_rawdata{i, j});
        taz_taz_traffic_time_sigma(i, j) = sigma(taz_taz_traffic_time_rawdata{i, j});
    end
end
for i = 1 : NTAZ
    for j = 1 : NENT
        taz_ent_traffic_time_mu(i, j) = mean(taz_ent_traffic_time_rawdata{i, j});
        taz_ent_traffic_time_sigma(i, j) = sigma(taz_ent_traffic_time_rawdata{i, j});
    end
end
taz_taz_traffic_time.mu = taz_taz_traffic_time_mu;
taz_taz_traffic_time.sigma = taz_taz_traffic_time_sigma;
taz_ent_traffic_time.mu = taz_ent_traffic_time_mu;
taz_ent_traffic_time.sigma = taz_ent_traffic_time.sigma;

end

