function [ index ] = WDtimeConvert( crttime ,flag)
%ʱ��ת���������ʽ��1945������19:45��
%[ index ] = WDtimeConvert( crttime ,flag)
%��׼ʱ��Ϊ00:00
%flag:1Ϊ����ʵʱ�䣨19��45��ת��Ϊ��ֵ���루���׼ʱ��ķ��Ӳ
%flag:2Ϊ����ֵ���루���׼ʱ��ķ��Ӳת��Ϊ��ʵʱ�䣬Сʱ�����Ϊ����Ԫ��
%flag:3Ϊ����ֵ���루���׼ʱ��ķ��Ӳת��Ϊ��ʵʱ�䣬Сʱ����Ӻ���һ��:1940=19:40
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

