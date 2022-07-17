function [like,grad]=clogit(b,restrMat,Y,X,Z,baseAlt)


% error checking
assert((~isempty(X) || ~isempty(Z)) && ~isempty(Y),'You must supply data to the model');

N  = size(Y,1);                     %选择次数
nb = size(X,2);                     %asc个数
nb2= size(Z,2);                     %一般系数的个数
nc = numel(unique(Y));              %number of choice? 备选项数！

assert(ndims(Y)==2 && size(Y,2)==1 ,'Y must be a vector');
% assert(  min(Y)==1 && max(Y)==nc   ,'Y should contain integers numbered consecutively from 1 through J');
if ~isempty(X)
	assert(ndims(X)==2  ,'X must be a 2-dimensional matrix');
	assert(size(X,1)==N ,'The 1st dimension of X should equal the number of observations in Y');
end
if ~isempty(Z)
	assert(ndims(Z)==3  ,'Z must be a 3-dimensional array');
	assert(size(Z,1)==N ,'The 1st dimension of Z should equal the number of observations in Y');
% 	assert(size(Z,3)==nc,'The 3rd dimension of Z should equal the number of alternatives in Y');
    nc = size(Z,3);
end

% apply restrictions as defined in restrMat
if ~isempty(restrMat)
	b = applyRestr(restrMat,b);
end

if nargin==5 || isempty(baseAlt)
	baseAlt = nc;
end
b2   = b(nb*(nc-1)+1:nb*(nc-1)+nb2);        %nb(nc-1):这些都是ASC系数
num  = zeros(N,1);
dem  = zeros(N,1);

if nb2>0 && nb>0
	% sets BASEALT to be the alternative that is normalized to zero
	k = 1;
	for j=setdiff(1:nc,baseAlt)
		temp=X*b((k-1)*nb+1:k*nb)+(Z(:,:,j)-Z(:,:,baseAlt))*b2;
		num=(Y==j).*temp+num;
		dem=exp(temp)+dem;
		k = k+1;
	end
	dem=dem+1;
	
	like=sum(log(dem)-num);
	
	% analytical gradient
	numg = zeros(nb2,1);
	demg = zeros(nb2,1);
	
	k = 1;
	grad = zeros(size(b));
	for j=setdiff(1:nc,baseAlt)
		temp=X*b((k-1)*nb+1:k*nb)+(Z(:,:,j)-Z(:,:,baseAlt))*b2;
		grad((k-1)*nb+1:k*nb)=-X'*((Y==j)-exp(temp)./dem);
		k = k+1;
	end
	k = 1;
	for j=setdiff(1:nc,baseAlt)
		temp = X*b((k-1)*nb+1:k*nb)+(Z(:,:,j)-Z(:,:,baseAlt))*b2;
		numg = -(Z(:,:,j)-Z(:,:,baseAlt))'*(Y==j)+numg;
		demg = -(Z(:,:,j)-Z(:,:,baseAlt))'*(exp(temp)./dem)+demg;
		k = k+1;
	end
	grad(nb*(nc-1)+1:nb*(nc-1)+nb2)=numg-demg;
	if ~isempty(restrMat)
		grad = applyRestrGrad(restrMat,grad);
	end
elseif nb>0 && nb2==0
	% sets BASEALT to be the alternative that is normalized to zero
	k = 1;
	for j=setdiff(1:nc,baseAlt)
		temp=X*b((k-1)*nb+1:k*nb);
		num=(Y==j).*temp+num;
		dem=exp(temp)+dem;
		k = k+1;
	end
	dem=dem+1;
	
	like=sum(log(dem)-num);
	
	% analytical gradient
	k = 1;
	grad = zeros(size(b));
	for j=setdiff(1:nc,baseAlt)
		temp=X*b((k-1)*nb+1:k*nb);
		grad((k-1)*nb+1:k*nb)=-X'*((Y==j)-exp(temp)./dem);
		k = k+1;
	end
	if ~isempty(restrMat)
		grad = applyRestrGrad(restrMat,grad);
	end
elseif nb==0 && nb2>0                                                       %这个才是重点----单纯的clogit
	k = 1;
	for j=setdiff(1:nc,baseAlt)     %对于每一个非参考项的选项
		temp=(Z(:,:,j)-Z(:,:,baseAlt))*b2;          %每一次选择情景中，当前选项与参考项做差，乘以系数：1761*1
        %下一行：对于每一次选择，被选中的选项与基准选项的效用差。 
        %1761*1，注意Y==j也是一个1761R*1，判断对于该次选择，是否选择了当前选项，如果选了，才算效用，
        %所有选项循环完之后，被选中的那一项总会加上去的。num是一个长度为选项个数的初始为0的向量，只有选择了该选项，才计算该选项的效用差
		num=(Y==j).*temp+num;
		dem=exp(temp)+dem;                       %注意，这个是不管是不是被选中，都做exp加上去了，这个实际是分母的求和项
		k = k+1;
	end
	dem=dem+1;               %加1是因为上面只循环了非基准项，最后一个基准项与自己的效应差为0，所以exp是1
    
     %其实num才是分子，是每一次选择中实际被选择的选项与基准项的效用差，不用exp，因为只有一项，exp与log消掉了，fminunc是最小化，所以做了相反数
	like=sum(log(dem)-num);
	
	% analytical gradient
	numg = zeros(nb2,1);
	demg = zeros(nb2,1);
	
	grad = zeros(size(b));
	k = 1;
	for j=setdiff(1:nc,baseAlt)
		temp = (Z(:,:,j)-Z(:,:,baseAlt))*b2;
		numg = -(Z(:,:,j)-Z(:,:,baseAlt))'*(Y==j)+numg;
		demg = -(Z(:,:,j)-Z(:,:,baseAlt))'*(exp(temp)./dem)+demg;
		k = k+1;
	end
	grad(nb*(nc-1)+1:nb*(nc-1)+nb2)=numg-demg;
	if ~isempty(restrMat)
		grad = applyRestrGrad(restrMat,grad);
	end
end