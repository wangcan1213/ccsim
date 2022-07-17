function [like,grad]=clogit(b,restrMat,Y,X,Z,baseAlt)


% error checking
assert((~isempty(X) || ~isempty(Z)) && ~isempty(Y),'You must supply data to the model');

N  = size(Y,1);                     %ѡ�����
nb = size(X,2);                     %asc����
nb2= size(Z,2);                     %һ��ϵ���ĸ���
nc = numel(unique(Y));              %number of choice? ��ѡ������

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
b2   = b(nb*(nc-1)+1:nb*(nc-1)+nb2);        %nb(nc-1):��Щ����ASCϵ��
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
elseif nb==0 && nb2>0                                                       %��������ص�----������clogit
	k = 1;
	for j=setdiff(1:nc,baseAlt)     %����ÿһ���ǲο����ѡ��
		temp=(Z(:,:,j)-Z(:,:,baseAlt))*b2;          %ÿһ��ѡ���龰�У���ǰѡ����ο����������ϵ����1761*1
        %��һ�У�����ÿһ��ѡ�񣬱�ѡ�е�ѡ�����׼ѡ���Ч�ò 
        %1761*1��ע��Y==jҲ��һ��1761R*1���ж϶��ڸô�ѡ���Ƿ�ѡ���˵�ǰѡ����ѡ�ˣ�����Ч�ã�
        %����ѡ��ѭ����֮�󣬱�ѡ�е���һ���ܻ����ȥ�ġ�num��һ������Ϊѡ������ĳ�ʼΪ0��������ֻ��ѡ���˸�ѡ��ż����ѡ���Ч�ò�
		num=(Y==j).*temp+num;
		dem=exp(temp)+dem;                       %ע�⣬����ǲ����ǲ��Ǳ�ѡ�У�����exp����ȥ�ˣ����ʵ���Ƿ�ĸ�������
		k = k+1;
	end
	dem=dem+1;               %��1����Ϊ����ֻѭ���˷ǻ�׼����һ����׼�����Լ���ЧӦ��Ϊ0������exp��1
    
     %��ʵnum���Ƿ��ӣ���ÿһ��ѡ����ʵ�ʱ�ѡ���ѡ�����׼���Ч�ò����exp����Ϊֻ��һ�exp��log�����ˣ�fminunc����С�������������෴��
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