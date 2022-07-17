function varargout = ccsim_editor(varargin)
% ccsim_editor M-file for ccsim_editor.fig
%      ccsim_editor, by itself, creates a new ccsim_editor or raises the existing
%      singleton*.
%
%      H = ccsim_editor returns the handle to a new ccsim_editor or the handle to
%      the existing singleton*.
%
%      ccsim_editor('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ccsim_editor.M with the given input arguments.
%
%      ccsim_editor('Property','Value',...) creates a new ccsim_editor or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MATHCAD_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ccsim_editor_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help ccsim_editor

% Last Modified by GUIDE v2.5 29-Dec-2015 17:18:40

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ccsim_editor_OpeningFcn, ...
                   'gui_OutputFcn',  @ccsim_editor_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before ccsim_editor is made visible.
function ccsim_editor_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ccsim_editor (see VARARGIN)

% Choose default command line output for ccsim_editor
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ccsim_editor wait for user response (see UIRESUME)
% uiwait(handles.figure1);
set(handles.axis_on, 'value', 1);
handles.axis_flag = 1;
handles.sc = 1;
zf = 9;
sc = 1;
handles.zf = zf;
handles.NTAZ = 0;
NTAZ = 0;
handles.TAZ_plotID = 0;
handles.ENT_plotID = 0;
handles.NENT = 0;
NENT = 0;
TAZ_h = {};
ENT_h = {};
handles.TAZ_h = TAZ_h;
handles.ENT_h = ENT_h;
set(gca,'color',[.2 .2 .2])
set(gcf,'color',[.2 .2 .2])
axis equal
axis([0 750 0 500])
set(gca,'XTick',0:50:750)
set(gca,'Ycolor',[.6 .6 .6])
set(gca,'Xcolor',[.6 .6 .6])
set(gca,'Zcolor',[.2 .2 .2])
view(2)
box off
grid on
% 检查有没有来自主界面的输入  %
if length(varargin) == 2
    if size(varargin{1}, 2) == 4
        XYZ = varargin{1};
        taz_id = unique(XYZ(:,1));
        NTAZ = length(taz_id);
        handles.NTAZ = NTAZ;
        TAZ_plotID = max(taz_id);
        handles.TAZ_plotID = TAZ_plotID;
        TAZ_h{TAZ_plotID} = {};         %初始化
    end
    if size(varargin{2}, 2) == 4
        ENTXYZ = varargin{2};
        ent_id = ENTXYZ(:,1);
        NENT = length(ent_id);
        handles.NENT = NENT;
        ENT_plotID = max(ent_id);
        handles.ENT_plotID = ENT_plotID;
        ENT_h{ENT_plotID} = {};         %初始化
    end
    
    %设定X-Y合理的尺度
    if exist('XYZ', 'var') & exist('ENTXYZ', 'var')
        max_x = max(max(XYZ(:,2)), max(ENTXYZ(:,2)));
        max_y = max(max(XYZ(:,3)), max(ENTXYZ(:,3)));
        min_x = min(min(XYZ(:,2)), min(ENTXYZ(:,2)));
        min_y = min(min(XYZ(:,3)), min(ENTXYZ(:,3)));
    elseif exist('XYZ', 'var') & ~exist('ENTXYZ', 'var')
        max_x = max(max(XYZ(:,2)), -inf);
        max_y = max(max(XYZ(:,3)), -inf);
        min_x = min(min(XYZ(:,2)), inf);
        min_y = min(min(XYZ(:,3)), inf);
    elseif ~exist('XYZ', 'var') & exist('ENTXYZ', 'var')
        max_x = max(-inf, max(ENTXYZ(:,2)));
        max_y = max(-inf, max(ENTXYZ(:,3)));
        min_x = min(inf, min(ENTXYZ(:,2)));
        min_y = min(inf, min(ENTXYZ(:,3)));
    else
        return
    end
    x_length = max_x - min_x;
    y_length = max_y - min_y;
    x_length_factor = x_length / (750*0.9);
    y_length_factor = y_length / (500*0.9);
    sc = max(x_length_factor, y_length_factor);
    %%%经过权衡，还是决定：对于过小的不要变换尺度
    sc = max(sc, 1);
    handles.sc = sc;
    
    xlabel_cell = mat2cell( round(sc*[0:50:750]), 1, ones(1,length([0:50:750]))  );
    set(gca,'XTicklabel', xlabel_cell);
    ylabel_cell = mat2cell( round(sc*[0:50:500]), 1, ones(1,length([0:50:500]))  );
    set(gca, 'Yticklabel', ylabel_cell);
    
    %平移原始数据使之适应：只有当超出范围了才换
    %原来是改到右下点，现在将其comment掉，变成改到中心点
    if min_x < 0 | min_y < 0 | max_x > 750*sc | max_y > 500*sc
        if exist('XYZ', 'var')
%             XYZ(:, 2) = XYZ(:, 2) - (min_x - sc*37.5);
%             XYZ(:, 3) = XYZ(: ,3) - (min_y - sc*25);
            XYZ(:, 2) = XYZ(:, 2) - ((min_x+max_x)/2 - 750*sc/2);
            XYZ(:, 3) = XYZ(: ,3) - ((min_y+max_y)/2 - 500*sc/2);
            handles.XYZ = XYZ;
        end
        if exist('ENTXYZ', 'var')
%             ENTXYZ(:, 2) = ENTXYZ(:, 2) - (min_x - sc*37.5);
%             ENTXYZ(: ,3) = ENTXYZ(:, 3) - (min_y - sc*25);
            ENTXYZ(:, 2) = ENTXYZ(:, 2) - ((min_x+max_x)/2 - 750*sc/2);
            ENTXYZ(: ,3) = ENTXYZ(:, 3) - ((min_y+max_y)/2 - 500*sc/2);
            handles.ENTXYZ = ENTXYZ;
        end
    else
        if exist('XYZ', 'var')
            handles.XYZ = XYZ;
        end
        if exist('ENTXYZ', 'var')
            handles.ENTXYZ = ENTXYZ;
        end
    end
    %画XYZ
    hold on
    if exist('ENTXYZ', 'var')
        for k = 1 : NENT
            crtID_ent = ent_id(k);
            crtENTXYZ = ENTXYZ(ENTXYZ(:,1) == crtID_ent, 2:4);
            ENT_h{crtID_ent} = plot3(crtENTXYZ(1)/sc, crtENTXYZ(2)/sc, crtENTXYZ(3)*zf,...
                'wp', 'markersize',20,'markerfacecolor','r');
        end
        handles.ENT_h = ENT_h;
        axis([0 750 0 500])
    end
    if exist('XYZ', 'var')
        for i = 1 : NTAZ
            crtID = taz_id(i);
            crtXYZ = XYZ(XYZ(:,1) == crtID, 2:4);
            TAZ_h{crtID} = patch(crtXYZ(:,1)/sc, crtXYZ(:,2)/sc, crtXYZ(:,3)*zf, [.2 .2 .2], ...
                'facecolor', 'none', 'edgecolor', 'w');
        end
        axis([0 750 0 500])
        handles.TAZ_h = TAZ_h;
    end
    hold off
end
 
set(handles.dia2, 'string', ['Num. TAZ: ', num2str(NTAZ), ' ;      Num. Entrance: ', num2str(NENT), ...
    ' ;      Scale Factor: ' , num2str(sc),  ' ;      Z Display Factor: ' , num2str(zf),     ' '])
guidata(hObject, handles);
clear
clc




% for i=1:5;
%
%     if i==1
%         [x(i),y(i)]=ginput(1);
%     else
%
%         [x(i),y(i)]=ginput(1);
%         plot(x(1:i),y(1:i),'w')
%         axis([0 10 0 10])
%
%         set(gca,'color','k')
%         set(gcf,'color','k')
%         hold on
%         pause(0.25)
%     end
% end

% --- Outputs from this function are returned to the command line.
function varargout = ccsim_editor_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in draw_entrance.
function draw_entrance_Callback(hObject, eventdata, handles)
% hObject    handle to draw_entrance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
hold on
ENT_plotID = handles.ENT_plotID;
sc = handles.sc;
zf = handles.zf;
ENT_h = handles.ENT_h;
if isfield(handles, 'ENTXYZ')
    ENTXYZ = handles.ENTXYZ;
else
    ENTXYZ = [];
end
crt_NENT = size(ENTXYZ, 1);
set(handles.dia1,'string','>> Enter the entrance point ...')
[a1,b1]=ginput(1);
axis([0 750 0 500])
% set(gca,'XTick',0:50:750)
% set(gca,'color','k')
% set(gcf,'color','k')
set(gca,'color',[.2 .2 .2])
set(gcf,'color',[.2 .2 .2])
z1 = inputdlgWC('Input the Z-coordinate, otherwise it is set to 0', 'Z-coordinate');
if isempty(z1)
    z = 0;
else
    z = z1{1};
    try
        z = str2double(z);
        if isnan(z)
            z = 0;
        end
    catch
        z = 0;
    end
end
z_display = z * zf;
ENT_h{end+1} = plot3([a1],[b1],z_display, 'wp', 'markersize',20,'markerfacecolor','r');
handles.ENT_h = ENT_h ;
ENT_plotID = ENT_plotID + 1;
handles.ENT_plotID = ENT_plotID;
ENTXYZ = [ENTXYZ; [ENT_plotID, sc*a1,sc*b1,z]];
handles.ENTXYZ = ENTXYZ;
NTAZ = handles.NTAZ;
NENT = crt_NENT + 1;
handles.NENT = NENT;
guidata(hObject, handles);
set(handles.dia1,'string',['>> Entrance, No.', num2str(ENT_plotID), ' DONE...'])
set(handles.dia2, 'string', ['Num. TAZ: ', num2str(NTAZ), ' ;      Num. Entrance: ', num2str(NENT),...
    ' ;      Scale Factor: ' , num2str(sc), ' ;      Z Display Factor: ' , num2str(zf), ' '])
hold off

% --- Executes on button press in draw_taz.
function draw_taz_Callback(hObject, eventdata, handles)
% hObject    handle to draw_taz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
hold on
sc = handles.sc;
zf = handles.zf;
TAZ_plotID = handles.TAZ_plotID;
TAZ_h = handles.TAZ_h;
if isfield(handles, 'XYZ')
    XYZ = handles.XYZ;
    crt_NTAZ = length(unique(XYZ(:,1)));
else
    XYZ = [];
    crt_NTAZ = 0;
end
set(handles.dia1,'string','>> Select the first Corner ...')
hold on
figure(gcf)
[a1,b1]=ginput(1);
set(handles.dia1,'string','>> Select the second Corner ... (Press Enter to cancel)')
pause(0.25)
[a2,b2]=ginput(1);
if isempty(a2) | isempty(b2)
    return
end
hold on
hold off
axis([0 750 0 500])
z1 = inputdlgWC('Input the Z-coordinate, otherwise it is set to 0', 'Z-coordinate');
if isempty(z1)
    z = 0;
else
    z = z1{1};
    try
        z = str2double(z);
        if isnan(z)
            z = 0;
        end
    catch
        z = 0;
    end
end
z_display = z * zf;
TAZ_h{end+1} = patch([a1;a2;a2;a1;a1], [b1;b1;b2;b2;b1], ones(5,1)*z_display, [.2 .2 .2],...
    'facecolor', 'none', 'edgecolor', 'w');
TAZ_plotID = TAZ_plotID + 1;
handles.TAZ_plotID = TAZ_plotID;
crt_XYZ = [TAZ_plotID*ones(5,1), sc*[a1;a2;a2;a1;a1], sc*[b1;b1;b2;b2;b1], ones(5,1)*z];
XYZ = [XYZ ; crt_XYZ];
handles.XYZ = XYZ;
handles.TAZ_h = TAZ_h;
set(handles.dia1,'string',['>> TAZ, No.', num2str(TAZ_plotID), ' DONE...'])
NTAZ = crt_NTAZ + 1;
NENT = handles.NENT;
handles.NTAZ = NTAZ;
guidata(hObject, handles)
set(handles.dia2, 'string', ['Num. TAZ: ', num2str(NTAZ), ' ;      Num. Entrance: ', num2str(NENT),...
    ' ;      Scale Factor: ' , num2str(sc),' ;      Z Display Factor: ' ,  num2str(zf), ' '])
hold off


function dia2_Callback(hObject, eventdata, handles)
% hObject    handle to dia2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dia2 as text
%        str2double(get(hObject,'String')) returns contents of dia2 as a double


% --- Executes during object creation, after setting all properties.
function dia2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dia2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function dia1_Callback(hObject, eventdata, handles)
% hObject    handle to dia1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dia1 as text
%        str2double(get(hObject,'String')) returns contents of dia1 as a double


% --- Executes during object creation, after setting all properties.
function dia1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dia1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on button press in nett.
function nett_Callback(hObject, eventdata, handles)
% hObject    handle to nett (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
web(['http://www.esnips.com/web/matlabusers'], '-browser');



% --------------------------------------------------------------------
function Nem_Callback(hObject, eventdata, handles)
% hObject    handle to Nem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function pho_Callback(hObject, eventdata, handles)
% hObject    handle to pho (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

web(['http://www.esnips.com/doc/4f4afbfc-4a27-46c8-b431-11ec11c91ee8/MATHCAD-photo'], '-browser');
% --------------------------------------------------------------------
function cli_Callback(hObject, eventdata, handles)
% hObject    handle to cli (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
web(['http://www.esnips.com/doc/5154461b-b165-41d0-8ec9-a4c35c5dbcf5/MATHCAD-tutorial_1'], '-browser');

% --------------------------------------------------------------------
function Untitled_8_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_2_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_4_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function me_Callback(hObject, eventdata, handles)
% hObject    handle to me (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
web(['http://www.esnips.com/user/ABDEL-RAHMAN'], '-browser');

% --------------------------------------------------------------------
function Untitled_3_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_9_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes on button press in re.
function re_Callback(hObject, eventdata, handles)
% hObject    handle to re (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
hold on

cla reset
set(gca,'color',[.2 .2 .2])
set(gcf,'color',[.2 .2 .2])
axis equal
axis([0 750 0 500])
set(gca,'XTick',0:50:750)
set(gca,'Ycolor',[.6 .6 .6])
set(gca,'Xcolor',[.6 .6 .6])
box off
grid on
if handles.axis_flag == 0
    axis off
end
set(handles.dia1,'string','>> RESET DONE...')
hold off
if isfield(handles, 'XYZ')
    handles = rmfield(handles, 'XYZ');
end
if isfield(handles, 'ENTXYZ')
    handles = rmfield(handles, 'ENTXYZ');
end
handles.sc = 1;
guidata(hObject, handles);
set(handles.dia2, 'string', ['Num. TAZ: ', num2str(0), ' ;      Num. Entrance: ', num2str(0), ...
    ' ;      Scale Factor: ' , num2str(1),  ' ;      Z Display Factor: ' , num2str(9),     ' '])


% --------------------------------------------------------------------
function Key1_Callback(hObject, eventdata, handles)
% hObject    handle to Key1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
web(['http://www.esnips.com/doc/f254ba06-361e-4593-bbb5-291d45e16828/MATHCAD-operation-of-keys'], '-browser');



% --- Executes during object creation, after setting all properties.
function text4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function axes2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes2


% --- Executes on button press in ok_button.
function ok_button_Callback(hObject, eventdata, handles)
% hObject    handle to ok_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% m_h = findall(0, 'type', 'figure', 'name', 'Commercial Complex SIMlator');  %主界面句柄
m_h_2 = findall(0 , 'type', 'figure', 'tag', 'figure1');        %会找到两个
for tt = 1 : length(m_h_2)
    if ~strcmp(get(m_h_2(tt), 'name'), 'ccsim editor')
        m_h = m_h_2(tt);
    end
end
m_handles = guidata(m_h);       %主界面handles
v_h = findall(0, 'type', 'figure', 'name', 'ccsim editor'); %次界面句柄
if isfield(handles, 'XYZ')
    %做一下ID转换
    XYZ = handles.XYZ;
    unique_ID = unique(XYZ(:,1));
    NTAZ = length(unique_ID);
    m_handles.NTAZ = NTAZ;
    set(m_handles.Num_TAZ, 'string', num2str(NTAZ));
    if min(unique_ID)~=1 | max(unique_ID)~=NTAZ
        XYZ_newID = [];
        for k = 1 : NTAZ
            crt_former_ID = unique_ID(k);
            crt_former_XYZ = XYZ(XYZ(:,1)==crt_former_ID, 2:4);
            crt_XYZ_newID = [ones(size(crt_former_XYZ,1),1)*k, crt_former_XYZ];
            XYZ_newID = [XYZ_newID; crt_XYZ_newID];
        end
        m_handles.XYZ = XYZ_newID;
    else
         m_handles.XYZ = XYZ;
    end
else
    NTAZ = 0;
    set(m_handles.Num_TAZ, 'string', '');
    if isfield(m_handles, 'XYZ')
        m_handles = rmfield(m_handles, 'XYZ');
    end
end
if isfield(handles, 'ENTXYZ')
    ENTXYZ = handles.ENTXYZ;
    NENT = size(ENTXYZ, 1);
    m_handles.NENT = NENT;
    set(m_handles.Num_ent, 'string', num2str(NENT));
    former_ID = ENTXYZ(:,1);
    if min(former_ID)~=1 | max(former_ID)~=NENT
        ENTXYZ_new_ID = ENTXYZ;
        ENTXYZ_new_ID(:,1) = [1:NENT]';
        m_handles.ENTXYZ = ENTXYZ_new_ID;
    else
        m_handles.ENTXYZ = ENTXYZ;
    end
else
    NENT = 0;
    set(m_handles.Num_ent, 'string', '');
    if isfield(m_handles, 'ENTXYZ')
        m_handles = rmfield(m_handles, 'ENTXYZ');
    end
end
guidata(m_h, m_handles);
msgbox(['Totally ', num2str(NTAZ), ' TAZs and ', num2str(NENT), ' entrances go back to CCSIM.'],...
    'Summary')
close(v_h)




% --- Executes on button press in Set_Scale.
function Set_Scale_Callback(hObject, eventdata, handles)
% hObject    handle to Set_Scale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
old_sc = handles.sc;
sc = inputdlgWC(...
    'The range of drawing area is 0-750 in X-dimension and 0-500 in Y-dimension, you can rescale it by a factor.', 'Scale');
if isempty(sc)
    return
end
sc = sc{1};
if isempty(sc)
    return
end
sc = str2double(sc);
if isnan(sc)
    errordlg('Wrong input!')
    return
end
if sc <= 0
    errordlg('Scale factor must above 0', 'Scale');
    return
end
handles.sc = sc;
if isfield(handles, 'XYZ') | isfield(handles, 'ENTXYZ')
    choice = questdlg('For TAZs and entraces already exist, do you want to scale their data by the scale factor, or just keep the data?', ...
        'Data Already Exsit', 'Keep the Data', 'Scale the Data', 'Keep the Data');
end

if isequal(choice, 'Keep the Data')
    main_fig = findall(0, 'type', 'figure', 'name', 'ccsim editor');
    allpatch = findall(main_fig, 'type', 'patch');
    for k = 1 : length(allpatch)
        old_xyz  = get(allpatch(k), 'Vertices');
        new_xyz = old_xyz;
        new_xyz(:,1:2) = (new_xyz(:,1:2)*old_sc)/sc;
        set(allpatch(k), 'Vertices', new_xyz);
    end
    allentrance = findall(main_fig, 'type', 'line', 'marker', 'pentagram');
    for k = 1 : length(allentrance)
        set(allentrance(k), 'XData', (get(allentrance(k),'XData')*old_sc)/sc);
        set(allentrance(k), 'YData', (get(allentrance(k),'YData')*old_sc)/sc);
    end
    
else
    if isfield(handles, 'XYZ')
        XYZ = handles.XYZ;
        XYZ(:,2:3) = (XYZ(:,2:3)/old_sc) * sc;
        handles.XYZ = XYZ;
    end
    if isfield(handles, 'ENTXYZ')
        ENTXYZ = handles.ENTXYZ;
        ENTXYZ(:,2:3) = (ENTXYZ(:,2:3)/old_sc) * sc;
        handles.ENTXYZ = ENTXYZ;
    end
end
axis_flag = handles.axis_flag;
if axis_flag
    xlabel_cell = mat2cell( round(sc*[0:50:750]), 1, ones(1,length([0:50:750]))  );
    set(gca,'XTicklabel', xlabel_cell);
    ylabel_cell = mat2cell( round(sc*[0:50:500]), 1, ones(1,length([0:50:500]))  );
    set(gca, 'Yticklabel', ylabel_cell);
end
guidata(hObject, handles);
NTAZ = handles.NTAZ;
NENT = handles.NENT;
zf = handles.zf;
set(handles.dia2, 'string', ['Num. TAZ: ', num2str(NTAZ), ' ;      Num. Entrance: ', num2str(NENT), ...
    ' ;      Scale Factor: ' , num2str(sc), ' ;      Z Display Factor: ' , num2str(zf),' '])
set(handles.dia1,'string','>> Set scale ...DONE')

%     handles.sc = 1;
%     guidata(hObject, handles);


% --- Executes on button press in axis_on.
function axis_on_Callback(hObject, eventdata, handles)
% hObject    handle to axis_on (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axis_flag = get(hObject, 'value');
handles.axis_flag = axis_flag;
guidata(hObject, handles);
if axis_flag
    axis on
    sc = handles.sc;
    xlabel_cell = mat2cell( round(sc*[0:50:750]), 1, ones(1,length([0:50:750]))  );
    set(gca,'XTicklabel', xlabel_cell);
    ylabel_cell = mat2cell( round(sc*[0:50:500]), 1, ones(1,length([0:50:500]))  );
    set(gca, 'Yticklabel', ylabel_cell);
else
    axis off
end

% Hint: get(hObject,'Value') returns toggle state of axis_on



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to dia2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dia2 as text
%        str2double(get(hObject,'String')) returns contents of dia2 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dia2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Delete_TAZ.
function Delete_TAZ_Callback(hObject, eventdata, handles)
% hObject    handle to Delete_TAZ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
hold on
NTAZ = handles.NTAZ;
NENT = handles.NENT;
TAZ_h = handles.TAZ_h;
sc = handles.sc;
zf = handles.zf;
if NTAZ == 0
    return
end
set(handles.dia1,'string','>> Select a point in the TAZ ...')
[a0 , b0] = ginput(1);
a = a0 * sc;
b = b0 * sc;
XYZ = handles.XYZ;
uniqueTAZID = unique(XYZ(:,1));
for i = 1 : length(uniqueTAZID);
    crtXY = XYZ(XYZ(:,1) == uniqueTAZID(i), 2:3);
    inout(i,1) = inpolygon(a, b, crtXY(:,1), crtXY(:,2));
end
if sum(inout) == 0
    msgbox('No TAZ Selected');
    return
elseif sum(inout) == 1
    findID = uniqueTAZID(inout==1);
    findXY = XYZ(XYZ(:,1) == findID, 2:3);
    findZ = XYZ(XYZ(:,1) == findID, 4);
    highlight{1} = patch(findXY(:,1)/sc, findXY(:,2)/sc, findZ*zf, [1 .7 .7],'facealpha', .5);
    delete_confirm = questdlg('Are you going to delete the selected TAZ?', 'Delete Confirm',...
        'Yes', 'No', 'Yes');
    if isequal(delete_confirm, 'Yes')
        XYZ(XYZ(:,1) == findID, :) = [];
        delete(TAZ_h{findID});
        set(handles.dia1,'string','>> TAZ delete... DONE!')
        NTAZ = NTAZ - 1;
    end
    
else
    findID = uniqueTAZID(inout==1);
    ID_Z = unique(XYZ(:,[1 4]), 'rows');
    for j = 1 : length(findID)
        str{j} = ['TAZ Num. ', num2str(findID(j)), '    ( Z = ',  num2str(ID_Z(ID_Z(:,1)==findID(j),2)), ' )'];
    end
    [sel, ok] = listdlg('liststring', str, 'selectionMode', 'multiple', 'name', 'To Be Deleted');
    if ok == 0
        return
    end
    deleteID = findID(sel);
    for k = 1 : length(deleteID)
        findXY = XYZ(XYZ(:,1) == deleteID(k), 2:3);
        findZ = ID_Z(ID_Z(:,1)==deleteID(k) ,2);
        highlight{k} = patch(findXY(:,1)/sc, findXY(:,2)/sc, findZ*zf*ones(size(findXY,1),1), [1 .7 .7],'facealpha', .5);
    end
    delete_confirm = questdlg('Are you going to delete the selected TAZ?', 'Delete Confirm',...
        'Yes', 'No', 'Yes');
    if isequal(delete_confirm, 'Yes')
        for k = 1 : length(deleteID)
            XYZ(XYZ(:,1) == deleteID(k), :) = [];
            delete(TAZ_h{deleteID(k)});
            NTAZ = NTAZ - 1;
        end
        set(handles.dia1,'string','>> TAZ delete... DONE!')
    end
end
if exist('highlight', 'var')
    for k = 1 : length(highlight)
        delete(highlight{k});
    end
    clear highlight
end
handles.NTAZ = NTAZ;
handles.XYZ = XYZ;
guidata(hObject, handles);
set(handles.dia2, 'string', ['Num. TAZ: ', num2str(NTAZ), ' ;      Num. Entrance: ', num2str(NENT), ...
    ' ;      Scale Factor: ' , num2str(sc), ' ;      Z Display Factor: ' , num2str(zf),' '])
set(handles.dia1,'string','>> Delete TAZ ... DONE')
hold off


% --- Executes on button press in delete_ent.
function delete_ent_Callback(hObject, eventdata, handles)
% hObject    handle to delete_ent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
hold on
NTAZ = handles.NTAZ;
NENT = handles.NENT;
ENT_h = handles.ENT_h;

sc = handles.sc;
zf = handles.zf;
if NENT == 0
    return
end
if isfield(handles, 'ENTXYZ')
    ENTXYZ = handles.ENTXYZ;
else
    return
end
set(handles.dia1,'string','>> Select the first corner ...')
[a01 , b01] = ginput(1);
if isempty(a01) | isempty(b01)
            set(handles.dia1,'string','>> Delete ... CANCELLED')
            if exist('highlight', 'var')
                for m = 1 : length(highlight)
                    delete(highlight{m})
                end
            end
            clear hightlight
            return
        end
a1 = a01 * sc;
b1 = b01 * sc;
set(handles.dia1,'string','>> Select the second corner ... (Press Enter to cancel)')
pause(0.25)
[a02 , b02] = ginput(1);
if isempty(a02) | isempty(b02)
            set(handles.dia1,'string','>> Delete ... CANCELLED')
            if exist('highlight', 'var')
                for m = 1 : length(highlight)
                    delete(highlight{m})
                end
            end
            clear hightlight
            return
        end
a2 = a02 * sc;
b2 = b02 * sc;
inout = inpolygon(ENTXYZ(:,2), ENTXYZ(:,3), [a1 a2 a2 a1 a1], [b1 b1 b2 b2 b1]);
if sum(inout) == 0
    msgbox('No Entrance Selected');
    return
elseif sum(inout) == 1
    findID = ENTXYZ(inout==1, 1);
    crtXY = ENTXYZ(inout==1, 2:3);
    findZ = ENTXYZ(inout==1, 4);
    highlight{1} = plot3(crtXY(1)/sc, crtXY(2)/sc, findZ*zf, 'wo', 'markersize', 24);
    delete_confirm = questdlg('Are you going to delete the selected Entrance?', 'Delete Confirm',...
        'Yes', 'No', 'Yes');
    if isequal(delete_confirm, 'Yes')
        ENTXYZ(ENTXYZ(:,1) == findID, :) = [];
        delete(ENT_h{findID});
        set(handles.dia1,'string','>> Entrance delete... DONE!')
        NENT = NENT - 1;
    end
else
    findID = ENTXYZ(inout == 1, 1);
    for j = 1 : length(findID)
        str{j} = ['Entrance Num. ', num2str(findID(j)), '    ( Z = ',  num2str(ENTXYZ(ENTXYZ(:,1)==findID(j) ,4)), ' )'];
    end
    [sel, ok] = listdlg('liststring', str, 'selectionMode', 'multiple', 'name', 'To Be Deleted');
    if ok == 0
        return
    end
    deleteID = findID(sel);
    for k = 1 : length(deleteID)
        highlight{k} = plot3(ENTXYZ(ENTXYZ(:,1)==deleteID(k), 2)/sc, ENTXYZ(ENTXYZ(:,1)==deleteID(k), 3)/sc, ...
           ENTXYZ(ENTXYZ(:,1)==deleteID(k), 4)*zf , 'wo', 'markersize', 24);
    end
    delete_confirm = questdlg('Are you going to delete the selected Entrance?', 'Delete Confirm',...
        'Yes', 'No', 'Yes');
    if isequal(delete_confirm, 'Yes')
        for k = 1 : length(deleteID)
            ENTXYZ(ENTXYZ(:,1) == deleteID(k), :) = [];
            delete(ENT_h{deleteID(k)});
            NENT = NENT - 1;
        end
        set(handles.dia1,'string','>> Entrance delete... DONE!')
    end
end
if exist('highlight', 'var')
    for k = 1 : length(highlight)
        delete(highlight{k});
    end
    clear highlight
end
handles.NENT = NENT;
handles.ENTXYZ = ENTXYZ;
guidata(hObject, handles);
set(handles.dia2, 'string', ['Num. TAZ: ', num2str(NTAZ), ' ;      Num. Entrance: ', num2str(NENT), ...
    ' ;      Scale Factor: ' , num2str(sc), ' ;      Z Display Factor: ' , num2str(zf),' '])
set(handles.dia1,'string','>> Delete entrance ...DONE')
hold off
    


% --- Executes on button press in copy_taz.
function copy_taz_Callback(hObject, eventdata, handles)
% hObject    handle to copy_taz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
hold on
cm = get(handles.copy_mode, 'value');
XYZ = handles.XYZ;
ID_Z = unique(XYZ(:,[1 4]), 'rows');
NTAZ = handles.NTAZ;
NENT = handles.NENT;
TAZ_h = handles.TAZ_h;
sc = handles.sc;
zf = handles.zf;
TAZ_plotID = handles.TAZ_plotID;

set(handles.dia1,'string','>> Select a point in the TAZ ...')
[a0 , b0] = ginput(1);
a = a0 * sc;
b = b0 * sc;
uniqueTAZID = unique(XYZ(:,1));
for i = 1 : length(uniqueTAZID);
    crtXY = XYZ(XYZ(:,1) == uniqueTAZID(i), 2:3);
    inout(i,1) = inpolygon(a, b, crtXY(:,1), crtXY(:,2));
end
if sum(inout) == 0
    msgbox('No TAZ Selected');
    return
elseif sum(inout) == 1
    findID = uniqueTAZID(inout==1);
    findXY = XYZ(XYZ(:,1) == findID, 2:3);
    findZ = ID_Z(ID_Z(:,1) == findID , 2);
    highlight{1} = patch(findXY(:,1)/sc, findXY(:,2)/sc, findZ*zf*ones(size(findXY,1),1), [1  .7 .7],'facealpha', .5);
    if cm ~= 4
        set(handles.dia1,'string','>> Select the original base point ... (Press Enter to cancel)')
        [a01 , b01] = ginput(1);
        if isempty(a01) | isempty(b01)
            set(handles.dia1,'string','>> Copy ... CANCELLED')
            if exist('highlight', 'var')
                for m = 1 : length(highlight)
                    delete(highlight{m})
                end
            end
            clear hightlight
            return
        end
        a1 = a01 * sc;
        b1 = b01 * sc;
        pause(.25);
        set(handles.dia1,'string','>> Select the destination base point ... (Press Enter to cancel)')
        [a02 , b02] = ginput(1);
        if isempty(a02) | isempty(b02)
            set(handles.dia1,'string','>> Copy ... CANCELLED')
            if exist('highlight', 'var')
                for m = 1 : length(highlight)
                    delete(highlight{m})
                end
            end
            clear hightlight
            return
        end
        a2 = a02 * sc;
        b2 = b02 * sc;
        x_move = (a2-a1) * sc;
        y_move = (b2-b1) * sc;
        switch cm
            case 1
                newXY = [findXY(:,1) + x_move  ,  findXY(:,2) + y_move];
            case 2
                newXY = [findXY(:,1) + x_move  ,  findXY(:,2)];
            case 3
                newXY = [findXY(:,1)  ,  findXY(:,2) + y_move];
        end
    else
        newXY = findXY;
    end
    newZ1 = inputdlgWC('Input the Z-coordinate, otherwise it is set to be the SAME with its original TAZ', 'Z-coordinate');
    if isempty(newZ1)
        newZ = findZ;
    else
        newZ = newZ1{1};
        try
            newZ = str2double(newZ);
            if isnan(newZ)
                newZ = findZ;
            end
        catch
            newZ = findZ;
        end
    end
    newZ_display = newZ * zf;
    highlight_copy{1} = patch(newXY(:,1)/sc, newXY(:,2)/sc, ...
        newZ_display*ones(size(newXY,1),1), [.7 1 .7],'facealpha', .5);
    TAZ_plotID = TAZ_plotID + 1;
    crt_XYZ = [TAZ_plotID*ones(size(newXY,1),1), newXY, ones(size(newXY,1),1)*newZ];
    XYZ = [XYZ; crt_XYZ];
    copy_confirm = questdlg('Are you going to copy the selected TAZ?', 'Copy Confirm',...
        'Yes', 'No', 'Yes');
    if isequal(copy_confirm, 'Yes')
        TAZ_h{end+1} = patch(newXY(:,1)/sc, newXY(:,2)/sc, ...
            newZ_display*ones(size(newXY,1),1), [.2 .2 .2],'facecolor', 'none', 'edgecolor', 'w');
        NTAZ = NTAZ + 1;
        handles.NTAZ = NTAZ;
        handles.XYZ = XYZ;
        handles.TAZ_h = TAZ_h;
        handles.TAZ_plotID = TAZ_plotID;
    end
else
    findID = uniqueTAZID(inout==1);
    for j = 1 : length(findID)
        str{j} = ['TAZ Num. ', num2str(findID(j)), '    ( Z = ',  num2str(ID_Z(ID_Z(:,1)==findID(j),2)), ' )'];
    end
    [sel, ok] = listdlg('liststring', str, 'selectionMode', 'multiple', 'name', 'To Be Deleted');
    if ok == 0
        return
    end
    copyID = findID(sel);
    findXY_multi = [];
    find_IDXYZ_multi = [];
    for k = 1 : length(copyID)
        findXY = XYZ(XYZ(:,1) == copyID(k), 2:3);
        find_IDXYZ = XYZ(XYZ(:,1) == copyID(k), :);
        findXY_multi = [findXY_multi; findXY];
        find_IDXYZ_multi = [find_IDXYZ_multi; find_IDXYZ];
        findZ(k, 1) = ID_Z(ID_Z(:,1)==copyID(k), 2);
        highlight{k} = patch(findXY(:,1)/sc, findXY(:,2)/sc, findZ(k,1)*zf*ones(size(findXY,1),1) ,...
            [1 .7 .7],'facealpha', .5);
    end
    
    if cm ~= 4
        set(handles.dia1,'string','>> Select the original base point ... (Press Enter to cancel)')
        [a01 , b01] = ginput(1);
        if isempty(a01) | isempty(b01)
            set(handles.dia1,'string','>> Copy ... CANCELLED')
            if exist('highlight', 'var')
                for m = 1 : length(highlight)
                    delete(highlight{m})
                end
            end
            clear hightlight
            return
        end
        a1 = a01 * sc;
        b1 = b01 * sc;
        pause(.25);
        set(handles.dia1,'string','>> Select the destination base point ... (Press Enter to cancel)')
        [a02 , b02] = ginput(1);
        if isempty(a02) | isempty(b02)
            set(handles.dia1,'string','>> Copy ... CANCELLED')
            if exist('highlight', 'var')
                for m = 1 : length(highlight)
                    delete(highlight{m})
                end
            end
            clear hightlight
            return
        end
        a2 = a02 * sc;
        b2 = b02 * sc;
        x_move = (a2-a1) * sc;
        y_move = (b2-b1) * sc;
        switch cm
            case 1
                newXY_multi = [findXY_multi(:,1) + x_move  ,  findXY_multi(:,2) + y_move];
                newIDXYZ_multi = [find_IDXYZ_multi(:,1), ...
                    find_IDXYZ_multi(:,2)+x_move, find_IDXYZ_multi(:,3)+y_move, find_IDXYZ_multi(:,4)];
            case 2
                newXY_multi = [findXY_multi(:,1) + x_move  ,  findXY_multi(:,2)];
                newIDXYZ_multi = [find_IDXYZ_multi(:,1), ...
                    find_IDXYZ_multi(:,2)+x_move, find_IDXYZ_multi(:,3), find_IDXYZ_multi(:,4)];
            case 3
                newXY_multi = [findXY_multi(:,1)  ,  findXY_multi(:,2) + y_move];
                newIDXYZ_multi = [find_IDXYZ_multi(:,1), ...
                    find_IDXYZ_multi(:,2), find_IDXYZ_multi(:,3)+y_move, find_IDXYZ_multi(:,4)];
        end
    else
        newXY_multi = findXY_multi;
        newIDXYZ_multi = find_IDXYZ_multi;
    end
    newZ1 = inputdlgWC('Input the Z-coordinate for all copyed new TAZs, otherwise they are set to be the SAME with their original TAZs',...
        'Z-coordinate');
    if isempty(newZ1)
        newZ = findZ;               %%% 注意：新方法下，不用newZ了，而统一采用newIDXYZ_multi， 如果是没有输入，采用原Z，那其实就不调整，这一步没影响。
    else
        newZ = newZ1{1};
        try
            newZ = str2double(newZ);
            if isnan(newZ)
                newZ = findZ;
            else
                newZ = newZ * ones(length(findZ) , 1);
                newIDXYZ_multi(:,4) = newZ;         %有影响时，调整到统一。
            end
        catch
            newZ = findZ;
        end
    end
    
%     %   以前是通过固定5个来做的   %
%     for k = 1 : 5: size(newXY_multi,1)-4
%         highlight_copy{ceil(k/5)} = patch(newXY_multi(k:k+4 , 1)/sc, newXY_multi(k:k+4 , 2)/sc, ...
%             newZ(ceil(k/5))*zf*ones(size(newXY_multi,1),1), [.7 1 .7],'facealpha', .5);
%         TAZ_plotID = TAZ_plotID + 1;
%         crt_XYZ = [TAZ_plotID*ones(size(newXY_multi,1),1), newXY_multi(k:k+4 , :), ones(size(newXY_multi,1),1)*newZ(ceil(k/5))];
%         XYZ = [XYZ; crt_XYZ];
%     end
%     copy_confirm = questdlg('Are you going to copy the selected TAZ?', 'Copy Confirm',...
%         'Yes', 'No', 'Yes');
%     if isequal(copy_confirm, 'Yes')
%         for k = 1 : 5: size(newXY_multi,1)-4
%             TAZ_h{end+1} = patch(newXY_multi(k:k+4 , 1), newXY_multi(k:k+4 , 2),...
%                 newZ(ceil(k/5))*zf*ones(size(newXY_multi,1),1), [.2 .2 .2],'facecolor', 'none', 'edgecolor', 'w');
%             NTAZ = NTAZ + 1;
%         end
%         handles.TAZ_h = TAZ_h;
%         handles.TAZ_plotID = TAZ_plotID;
%         handles.XYZ = XYZ;
%         handles.NTAZ = NTAZ;
%     end
%      %   以前是通过固定5个来做的   %

    unique_newIDXYZ_multi_ID = unique(newIDXYZ_multi(:,1));
    NnewTAZ = length(unique_newIDXYZ_multi_ID);
    for k = 1 : NnewTAZ
        crt = newIDXYZ_multi(newIDXYZ_multi(:,1) == unique_newIDXYZ_multi_ID(k), 2:4);
        highlight_copy{k} = patch(crt(:,1)/sc, crt(:,2)/sc, ...
            crt(:,3)*zf, [.7 1 .7],'facealpha', .5);
        TAZ_plotID = TAZ_plotID + 1;
        crt_XYZ = [TAZ_plotID*ones(size(crt,1),1), crt];
        XYZ = [XYZ; crt_XYZ];
    end
    copy_confirm = questdlg('Are you going to copy the selected TAZ?', 'Copy Confirm',...
        'Yes', 'No', 'Yes');
    if isequal(copy_confirm, 'Yes')
        for k = 1 : NnewTAZ
            crt = newIDXYZ_multi(newIDXYZ_multi(:,1) == unique_newIDXYZ_multi_ID(k), 2:4);
            TAZ_h{end+1} = patch(crt(:,1)/sc, crt(:,2)/sc, ...
                crt(:,3)*zf, [.2 .2 .2],'facecolor', 'none', 'edgecolor', 'w');
            NTAZ = NTAZ + 1;
        end
        handles.TAZ_h = TAZ_h;
        handles.TAZ_plotID = TAZ_plotID;
        handles.XYZ = XYZ;
        handles.NTAZ = NTAZ;
    end

     
end
if exist('highlight', 'var')
    for k = 1 : length(highlight)
        delete(highlight{k});
    end
    clear highlight
end
if exist('highlight_copy', 'var')
    for k = 1 : length(highlight_copy)
        delete(highlight_copy{k});
    end
    clear highlight_copy
end
guidata(hObject, handles);
set(handles.dia2, 'string', ['Num. TAZ: ', num2str(NTAZ), ' ;      Num. Entrance: ', num2str(NENT), ...
    ' ;      Scale Factor: ' , num2str(sc), ' ;      Z Display Factor: ' , num2str(zf),' '])
set(handles.dia1,'string','>> Copy TAZ ... DONE')
hold off






% --- Executes on selection change in copy_mode.
function copy_mode_Callback(hObject, eventdata, handles)
% hObject    handle to copy_mode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns copy_mode contents as cell array
%        contents{get(hObject,'Value')} returns selected item from copy_mode


% --- Executes during object creation, after setting all properties.
function copy_mode_CreateFcn(hObject, eventdata, handles)
% hObject    handle to copy_mode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on mouse press over axes background.
function axes2_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
highlights = findall(hObject,'type','patch','facealpha', .5);
for k = 1 : length(highlights)
    delete(highlights(k))
end


% --- Executes on button press in z_display.
function z_display_Callback(hObject, eventdata, handles)
% hObject    handle to z_display (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
old_zf = handles.zf;
sc = handles.sc;
zf = inputdlgWC(...
    'You can rescale the Z value, but this factor WILL NOT AFFECT the real Z-coordinate, it only affect the display in this figure', 'Scale');
if isempty(zf)
    return
end
zf = zf{1};
if isempty(zf)
    return
end
zf = str2double(zf);
if isnan(zf)
    errordlg('Wrong input!')
    return
end
if zf <= 0
    errordlg('Scale factor must above 0', 'Scale');
    return
end
handles.zf = zf;


main_fig = findall(0, 'type', 'figure', 'name', 'ccsim editor');
allpatch = findall(main_fig, 'type', 'patch');
for k = 1 : length(allpatch)
    old_xyz  = get(allpatch(k), 'Vertices');
    new_xyz = old_xyz;
    new_xyz(:,3) = (new_xyz(:,3)/old_zf)*zf;
    set(allpatch(k), 'Vertices', new_xyz);
end

allentrance = findall(main_fig, 'type', 'line', 'marker', 'pentagram');
for k = 1 : length(allentrance)
    set(allentrance(k), 'ZData', (get(allentrance(k),'ZData')/old_zf)*zf);
end

NTAZ = handles.NTAZ;
NENT = handles.NENT;
guidata(hObject, handles);
set(handles.dia2, 'string', ['Num. TAZ: ', num2str(NTAZ), ' ;      Num. Entrance: ', num2str(NENT), ...
    ' ;      Scale Factor: ' , num2str(sc), ' ;      Z Display Factor: ' , num2str(zf),' '])
set(handles.dia1,'string','>> Set Z display ... DONE')


