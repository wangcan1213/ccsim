function [ TAZMoneyResult ] = MoneySim( result_withoutMoney, consume_prob, expenditure_distr, NTAZ )
%已经进行了空间行为模拟之后，对消费进行模拟
% [ TAZMoneyResult ] = MoneySim( result_withoutMoney, consume_prob, expenditure_distr, NTAZ)
%输入：result_withoutMoney，空间行为模拟结果, consume_prob：每个TAZ消费的概率，NTAZ：小区数
%expenditure_distr：每个TAZ如果消费，消费额的分布
%输出：TAZMoneyResult，集合层面带消费的模拟结果：4列，第1列TAZ编号，第2列TAZ人数，第3列消费比例，第4列消费总额
%以前的消费模拟是用万达模拟的程序，每个路径每个TAZ去模拟，但想想看个体模拟好像是意义也不是很大，只需要模拟到小区即可，可以更快一点，所以那个
%MoneySim_GUI_before_too_complex_use_new是老的，就先不用了
% 改成单次模拟！！！！！

crt_result = result_withoutMoney;
clear result_withoutMoney
% for j = 1:length(result)
%     crt_result=result(j).taz;           %当前结果：TAZ集计层面
crt_result = sortrows(crt_result, 1);       %担心小区编号不是按顺序
if size(crt_result, 1) == NTAZ+1
    crt_result = crt_result(1:end-1, :);        %把最后一行的回家去掉
elseif size(crt_result, 1) < NTAZ | size(crt_result, 1) >= NTAZ+2
    errordlg('Invalid result input or NTAZ')
    return
end

for i = 1 : size(crt_result, 1)
    crtTAZ = crt_result(i, 1);
    crt_result_crt_taz_NPED = crt_result(i, 2);        %当前集计结果当前TAZ的消费者数量
    crt_taz_consume_prob = consume_prob(crtTAZ);        %当前TAZ的消费比率
    crt_taz_expenditure_distr = expenditure_distr{crtTAZ, 2};   %当前TAZ的消费额分布
    ri = rand(crt_result_crt_taz_NPED, 1);         %有N个人，就生成N个随机数
    crt_result_crt_taz_NPED_Consume = sum(ri < crt_taz_consume_prob);   %当前TAZ消费的人数
    crt_result(i, 3) = crt_result_crt_taz_NPED_Consume / crt_result_crt_taz_NPED;  %第3列，消费比例
    %用crt_taz_expenditure_distr生成crt_result_crt_taz_NPED_Consume个消费额，并与0取大保证非负，再加起来
    crt_result(i, 4) = sum(max(0, random(crt_taz_expenditure_distr, crt_result_crt_taz_NPED_Consume, 1)));
end
%     MoneyResult{j, 1} = crt_result;
% end
TAZMoneyResult = crt_result;

