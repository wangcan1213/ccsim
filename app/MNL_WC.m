function [ paramhat, stderr, t_stat, p_value, LL0, LLM, MR2 ] = MNL_WC( lhs, rhs, NALT )
%估计MNL模型
%输入：lhs-因变量，长表格式的一列；rhs-自变量，长表格式的多列，有几个变量就是几列；NALT-选项个数；注，只能估计选项个数不变的模型
%输出：paramhat-参数估计结果；stderr-标准误；t-stat-t检验结果；p-value-p值；LL0-初始LL；LLM-模型LL；MR2-R平方
choice = lhs;
choice = reshape(choice, NALT, length(choice) / NALT);
choice = choice';
for i = 1 : size(choice , 1)
    Y(i , 1) = find(choice(i,:) == 1);
end
NCS = length(lhs) / NALT;
for i = 1 : NCS
    crtdata = rhs((i-1)*NALT+(1:NALT) , :);
    for k = 1 : size(crtdata, 1)
        Z(i, :, k) = crtdata(k, :);
    end
end
MAXITERS=[15000];
PARAMTOL=[1e-10];
LLTOL=[1e-10];
tic
options=optimset('Disp','none','LargeScale','on','MaxFunEvals',2000000,'MaxIter',MAXITERS,'TolX',PARAMTOL,'Tolfun',LLTOL,'GradObj','on','DerivativeCheck','off','FinDiffType','central');
startval = zeros(size(Z, 2) , 1);
[paramhat,fval,exitflag,output,grad,hessian] = fminunc('clogit',startval,options,[],Y,[],Z);
hessian = full(hessian);
ihess=inv(hessian);
stderr=sqrt(diag(ihess));
t_stat = paramhat ./ stderr;
p_value = 2 * (1 - normcdf(abs(t_stat)));
disp(['Estimation Finished']);
    if exitflag == 1
%         disp('Convergence achieved.');
    elseif exitflag == 2
%         disp('Convergence achieved by criterion based on change in parameters.');
%         if size(PARAMTOL,1)>0
%             disp(['Parameters changed less than PARAMTOL= ' num2str(PARAMTOL)]);
%         else
%             disp('Parameters changed less than PARAMTOL=0.000001, set by default.');
%         end
%         %         disp('You might want to check whether this is actually convergence.');
%         %         disp('The gradient vector is');
%         %         grad
    elseif exitflag == 3
%         disp('Convergence achieved by criterion based on change in log-likelihood value.');
%         if size(PARAMTOL,1)>0
%             disp(['Log-likelihood value changed less than LLTOL= ' num2str(LLTOL)]);
%         else
%             disp('Log-likelihood changed less than LLTOL=0.000001, set by default.');
%         end

    else
        disp('Convergence not achieved.');
%         disp('The current value of the parameters and hessian');
%         disp('can be accesses as variables paramhat and hessian.');
        return
    end
    
    null_ll = log(1/NALT) * NCS;
    mr2 = 1 - (-fval)/null_ll;
    LL0 = null_ll;
    LLM = -fval;
    MR2 = mr2;
%     disp(' ');
%     disp(['Value of the log-likelihood function of null model: ' num2str(null_ll)]);
    disp(['Value of the log-likelihood function at convergence: ' num2str(-fval)]);
    disp(['Value of the McFadden R-squre: ' num2str(mr2)]);
    
    
    %Calculate standard errors of parameters
    %     disp('Taking inverse of hessian for standard errors.');
    %     disp(['The value of grad*inv(hessian)*grad is: ' num2str(grad'*ihess*grad)]);
    %
%     disp(' ');
%     disp('ESTIMATION RESULTS');
%     disp(' ')
%     disp('                   -------------------------------------------- ');
%     disp('                      Coef         SE      t-stat      p-value');
%     for r=1:size(NAMES,2);
%         fprintf('%-15s %12.6f %10.4f %10.4f %10.4f\n', NAMES{1,r}, [paramhat(r,1) stderr(r,1) t_stat(r,1), p_value(r,1) ]);
%     end
%     disp(' ');
%     
%     disp(' ');
%     disp('END OF ESTIMATION RESULTS')
%     disp(' ');
%     disp(' ');

end

