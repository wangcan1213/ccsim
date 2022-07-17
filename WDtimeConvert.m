function [ index ] = WDtimeConvert( crttime ,flag)
%时间转换，输入格式：1945——（19:45）
%[ index ] = WDtimeConvert( crttime ,flag)
%基准时间为00:00
%flag:1为将真实时间（19：45）转换为数值编码（与基准时间的分钟差）
%flag:2为将数值编码（与基准时间的分钟差）转换为真实时间，小时与分钟为两个元素
%flag:3为将数值编码（与基准时间的分钟差）转换为真实时间，小时与分钟合在一起:1940=19:40
if flag==1
    crthour=floor(crttime/100);
    crtmin=crttime-100*crthour;
    diff_hour=crthour;
    diff_min=crtmin;
    index=diff_hour*60+diff_min;
elseif flag==2
    diff_hour=floor(crttime/60);
    diff_min=crttime-60*diff_hour;
    
%     index=(14+diff_date)*10000+diff_hour*100+diff_min;
    index=[diff_hour,diff_min];
elseif flag==3
    diff_hour=floor(crttime/60);
    diff_min=crttime-60*diff_hour;
    
%     index=(14+diff_date)*10000+diff_hour*100+diff_min;
    index=diff_hour*100+diff_min;
    

end


end

