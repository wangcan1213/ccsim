function [ TAZMoneyResult ] = MoneySim( result_withoutMoney, consume_prob, expenditure_distr, NTAZ )
%�Ѿ������˿ռ���Ϊģ��֮�󣬶����ѽ���ģ��
% [ TAZMoneyResult ] = MoneySim( result_withoutMoney, consume_prob, expenditure_distr, NTAZ)
%���룺result_withoutMoney���ռ���Ϊģ����, consume_prob��ÿ��TAZ���ѵĸ��ʣ�NTAZ��С����
%expenditure_distr��ÿ��TAZ������ѣ����Ѷ�ķֲ�
%�����TAZMoneyResult�����ϲ�������ѵ�ģ������4�У���1��TAZ��ţ���2��TAZ��������3�����ѱ�������4�������ܶ�
%��ǰ������ģ���������ģ��ĳ���ÿ��·��ÿ��TAZȥģ�⣬�����뿴����ģ�����������Ҳ���Ǻܴ�ֻ��Ҫģ�⵽С�����ɣ����Ը���һ�㣬�����Ǹ�
%MoneySim_GUI_before_too_complex_use_new���ϵģ����Ȳ�����
% �ĳɵ���ģ�⣡��������

crt_result = result_withoutMoney;
clear result_withoutMoney
% for j = 1:length(result)
%     crt_result=result(j).taz;           %��ǰ�����TAZ���Ʋ���
crt_result = sortrows(crt_result, 1);       %����С����Ų��ǰ�˳��
if size(crt_result, 1) == NTAZ+1
    crt_result = crt_result(1:end-1, :);        %�����һ�еĻؼ�ȥ��
elseif size(crt_result, 1) < NTAZ | size(crt_result, 1) >= NTAZ+2
    errordlg('Invalid result input or NTAZ')
    return
end

for i = 1 : size(crt_result, 1)
    crtTAZ = crt_result(i, 1);
    crt_result_crt_taz_NPED = crt_result(i, 2);        %��ǰ���ƽ����ǰTAZ������������
    crt_taz_consume_prob = consume_prob(crtTAZ);        %��ǰTAZ�����ѱ���
    crt_taz_expenditure_distr = expenditure_distr{crtTAZ, 2};   %��ǰTAZ�����Ѷ�ֲ�
    ri = rand(crt_result_crt_taz_NPED, 1);         %��N���ˣ�������N�������
    crt_result_crt_taz_NPED_Consume = sum(ri < crt_taz_consume_prob);   %��ǰTAZ���ѵ�����
    crt_result(i, 3) = crt_result_crt_taz_NPED_Consume / crt_result_crt_taz_NPED;  %��3�У����ѱ���
    %��crt_taz_expenditure_distr����crt_result_crt_taz_NPED_Consume�����Ѷ����0ȡ��֤�Ǹ����ټ�����
    crt_result(i, 4) = sum(max(0, random(crt_taz_expenditure_distr, crt_result_crt_taz_NPED_Consume, 1)));
end
%     MoneyResult{j, 1} = crt_result;
% end
TAZMoneyResult = crt_result;

