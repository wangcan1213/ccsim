function h = mywaitbar(x, whichbar, varargin)
if ischar(whichbar) || iscellstr(whichbar)   %���ø�ʽΪh = mywaitbar(p, 'title' , h_figure, x, y)
    if nargin >= 5
        h_f = waitbar(x, whichbar, 'visible', 'off');  %����һ����ʱ������
        h1 = findall(h_f, 'type', 'axes');  %���ҽ������ڵ�������
        h_axs = copyobj(h1, varargin{1});   %���������ڵ������ἰ���Ӷ��󿽱���ָ��������
        delete(h_f);
        set(h_axs , 'Units' , 'normalized');
        set(h_axs , 'visible', 'on');
        pos = get(h_axs, 'position');
        set(h_axs, 'position', [varargin{2}, varargin{3}, varargin{4}, varargin{5}])
    end
elseif isnumeric(whichbar)                  %���ø�ʽΪmywaitbar(p, h)��mywaitbar(p, h, 'title')
    h_axs = whichbar;
    p = findobj(h_axs,'Type','patch');
    set(p, 'XData', [0 100*x 100*x 0])
    if nargin == 3                          %���ø�ʽΪmywaitbar(p, h, 'title')
        hTitle = get(h_axs, 'title');
        set(hTitle, 'string', varargin{1});
    end
end
if nargout == 1                             %������Ƕ�������ľ��
    h = h_axs;
end
