function varargout = gulangyu(varargin)
% GULANGYU MATLAB code for gulangyu.fig
%      GULANGYU, by itself, creates a new GULANGYU or raises the existing
%      singleton*.
%
%      H = GULANGYU returns the handle to a new GULANGYU or the handle to
%      the existing singleton*.
%
%      GULANGYU('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GULANGYU.M with the given input arguments.
%
%      GULANGYU('Property','Value',...) creates a new GULANGYU or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gulangyu_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gulangyu_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gulangyu

% Last Modified by GUIDE v2.5 02-Dec-2016 23:00:22

% Begin initialization code - DO NOT EDIT
clc
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gulangyu_OpeningFcn, ...
                   'gui_OutputFcn',  @gulangyu_OutputFcn, ...
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

% --- Executes just before gulangyu is made visible.
function gulangyu_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gulangyu (see VARARGIN)

% Choose default command line output for gulangyu
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% This sets up the initial plot - only do when we are invisible
% so window can get raised using gulangyu.
if strcmp(get(hObject,'Visible'),'off')
    cla reset
    axis off
end
% b_area = str2double(get(handles.e_a , 'string'));
% handles.b_area = b_area;
% b_familarity = str2double(get(handles.e_b , 'string'));
% handles.b_familarity = b_familarity;
% b_dist = str2double(get(handles.e_c , 'string'));
% handles.b_dist = b_dist;
% b_stdf = str2double(get(handles.edit_b_stdf , 'string'));
% handles.b_stdf = b_stdf;
% b_visited = str2double(get(handles.edit_b_visited , 'string'));
% handles.b_visited = b_visited;
% b_past = str2double(get(handles.edit_b_past , 'string'));
% handles.b_past = b_past;
% handles.az = -37;
% handles.el = 19;
% handles.queue_on = 0;
% handles.queue_bar.use = 1;
% handles.queue_bar.reference_value = 30;
% handles.queue_bar.reference_length = 5;
% handles.queue_bar.width = 10;
cla reset
set(gcf,'color','w')
axis equal
axis off
if ~isfield(handles, 'adv_mode')
    handles.adv_mode = 0;
    guidata(hObject, handles);
%     set(handles.adv_def_var, 'enable', 'off')
%     set(handles.input_user_def_vars, 'enable', 'off');
%     set(handles.def_time_var, 'enable', 'off');
%     set(handles.def_dyn_var, 'enable', 'off');
%     set(handles.queue_on_check, 'enable', 'off');
end
%实时状态，用来判断是否是需要保存
active_handles = handles;
handles.active_handles = active_handles;
handles.blank_handles = active_handles;
guidata(hObject , handles);




% UIWAIT makes gulangyu wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gulangyu_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% javaFrame = get(gcf,'JavaFrame');
% set(javaFrame,'Maximized',1);

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1);
cla;

popup_sel_index = get(handles.popupmenu1, 'Value');
switch popup_sel_index
    case 1
        plot(rand(5));
    case 2
        plot(sin(1:0.01:25.99));
    case 3
        bar(1:.5:10);
    case 4
        plot(membrane);
    case 5
        surf(peaks);
end


% --------------------------------------------------------------------
function FileMenu_Callback(hObject, eventdata, handles)
% hObject    handle to FileMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function OpenMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to OpenMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
file = uigetfile('*.fig');
if ~isequal(file, 0)
    open(file);
end

% --------------------------------------------------------------------
function PrintMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to PrintMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
printdlg(handles.figure1)

% --------------------------------------------------------------------
function CloseMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to CloseMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selection = questdlg(['Close ' get(handles.figure1,'Name') '?'],...
                     ['Close ' get(handles.figure1,'Name') '...'],...
                     'Yes','No','Yes');
if strcmp(selection,'No')
    return;
end

delete(handles.figure1)


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
     set(hObject,'BackgroundColor','white');
end

set(hObject, 'String', {'plot(rand(5))', 'plot(sin(1:0.01:25))', 'bar(1:.5:10)', 'plot(membrane)', 'surf(peaks)'});



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit13_Callback(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit13 as text
%        str2double(get(hObject,'String')) returns contents of edit13 as a double


% --- Executes during object creation, after setting all properties.
function edit13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit14_Callback(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit14 as text
%        str2double(get(hObject,'String')) returns contents of edit14 as a double


% --- Executes during object creation, after setting all properties.
function edit14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit15_Callback(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit15 as text
%        str2double(get(hObject,'String')) returns contents of edit15 as a double


% --- Executes during object creation, after setting all properties.
function edit15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit16_Callback(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit16 as text
%        str2double(get(hObject,'String')) returns contents of edit16 as a double


% --- Executes during object creation, after setting all properties.
function edit16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit17_Callback(hObject, eventdata, handles)
% hObject    handle to edit17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit17 as text
%        str2double(get(hObject,'String')) returns contents of edit17 as a double


% --- Executes during object creation, after setting all properties.
function edit17_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit18_Callback(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit18 as text
%        str2double(get(hObject,'String')) returns contents of edit18 as a double


% --- Executes during object creation, after setting all properties.
function edit18_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit10 as text
%        str2double(get(hObject,'String')) returns contents of edit10 as a double


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit11_Callback(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit11 as text
%        str2double(get(hObject,'String')) returns contents of edit11 as a double


% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit12_Callback(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit12 as text
%        str2double(get(hObject,'String')) returns contents of edit12 as a double


% --- Executes during object creation, after setting all properties.
function edit12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu3.
function popupmenu3_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu3


% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%------------utilitys----------%
function close_other_figurs()
all_figs = findall(0, 'type', 'figure');
for af_i = 1 : length(all_figs)
    crt_fig_in_all_figs = all_figs(af_i);
    if ~isequal(get(crt_fig_in_all_figs, 'tag') , 'figure1')
        delete(crt_fig_in_all_figs)
    end
end

function set_font_utility(hObject, Event)
new_font = uisetfont;
if isequal(new_font, 0)
    return
end
set(hObject, 'FontName', new_font.FontName,...
    'FontWeight', new_font.FontWeight,...
    'FontAngle', new_font.FontAngle,...
    'FontUnits', new_font.FontUnits,...
    'FontSize', new_font.FontSize);

function [target_time, ok_flag] = input_one_time()
%指定出一个0-24点的时间，返回具体时间HHMM，以及有没有成功
target_time = inputdlgWC('Input the interested time (Format: HHMM, Range: 0000~2400): ',...
    'Time', 1);
if isempty(target_time) | (~isempty(target_time) & isempty(target_time{:}))
    ok_flag = 0;
    return
end
try
    target_time = str2double(target_time{:});
catch
    errordlg('Invalid input.', 'Error')
    ok_flag = 0;
    return
end
target_time_h = floor(target_time / 100);
target_time_m = target_time -target_time_h*100;
if target_time_h < 0 | target_time_h > 24
    errordlg('Invalid hour format.', 'Error')
    ok_flag = 0;
    return
end
if target_time_m < 0 | target_time_m > 59
    errordlg('Invalid minute format.', 'Error')
    ok_flag = 0;
    return
end
if WDtimeConvert(target_time, 1) < WDtimeConvert(0000, 1) | ...
        WDtimeConvert(target_time, 1) > WDtimeConvert(2400, 1)
    errordlg('Invalid input: time should be in range 0000~2400', 'Error')
    ok_flag = 0;
    return
end
ok_flag = 1;

function t = add_time_title(ax, target_time, xyz)
%ax，要加时间标题的坐标轴
%target_time:HHMM格式
%xyz：变换好的xyz范围，该乘以什么scale_factor要先乘好
%返回：t为标题句柄
target_time_h = floor(target_time / 100);
target_time_m = target_time -target_time_h*100;
target_time_h = num2str(target_time_h);
target_time_m = num2str(target_time_m);
if length(target_time_h) == 1
    target_time_h = strcat('0', target_time_h);
end
if length(target_time_m) == 1
    target_time_m = strcat('0', target_time_m);
end
target_time_str = strcat(target_time_h, ':', target_time_m);
max_x = max(xyz(:,2));
min_x = min(xyz(:,2));
max_y = max(xyz(:,3));
min_y = min(xyz(:,3));
max_z = max(xyz(:,4));
median_x = (max_x + min_x) / 2;
median_y = (max_y + min_y) / 2;
t = title(ax, target_time_str, 'position', ...
    [median_x, median_y, max_z*1.07], 'fontsize', 15,...
    'ButtonDownFcn', @set_font_utility);


function [data, flag] = open_csv(fullname, NVAR, varnames, string)
%打开一个csv文件，如果带表头，按默认表头变量名读取， 否则按顺序读取
%输入：fullname为路径；NVAR为几个变量，varnames为NVAR个对应的默认变量名
%   string是如果没找到默认变量名，给的提示变量名
%返回：data即为数据，没打开为空，flag为成功与否，1为成功
table_data = importdata(fullname);
if isfield(table_data, 'colheaders')
    colheaders = table_data.colheaders;
    for i = 1 : NVAR
        crt_varname = varnames{i};
        crtIndex = find(ismember(colheaders, crt_varname));
        if isempty(crtIndex)
            crtIndex = listdlg('PromptString',...
                ['Select ''', string{i} ,''' Variable:'],...
                'SelectionMode','single',...
                'ListString',colheaders);
            if isempty(crtIndex)
                flag = 0;
                return
            end
        end
        Index(i) = crtIndex;
    end
    try
        data = csvread(fullname, 1, 0);
    catch
        errordlg('Fail to open the CSV file');
        flag = 0;
        return
    end
    data = data(:, Index);
else
    try
        data = csvread(fullname);
        data = data(:,1:NVAR);
    catch
        errordlg('Fail to open the CSV file');
        flag = 0;
        return
    end
end
flag = 1;

function [SSTime, flag] = WDtime2SStime(WDtime)
%将HH:MM格式的万达时间转为1988-2-10,HH:MM:SS形式的大鼠时间的默认时间差形式，用于标记时间坐标轴
N = length(WDtime);
for i = 1 : N
    [crt_hm] = WDtimeConvert(WDtimeConvert(WDtime(i),1), 2);
    crt_h = crt_hm(1);
    crt_m = crt_hm(2);
    if crt_h < 0 | crt_m < 0 | crt_m >= 60
        errordlg(['Something wrong with the ', num2str(i), 'th inputdtaa'], 'Error')
        SSTime = [];
        flag = 0;
    end
    SSTime(i) = datenum(1988, 2, 10, crt_h, crt_m, 0);
end
flag = 1;

%---------Color Functions----------% (from: draw_color_band.m / brewermap.m)
function outHtml = colText(inText, inColor)
% return a HTML string with colored font
outHtml = ['<html><table border=0 width=200 bgcolor="', ...
      inColor, ...
      '"><TR><TD><font color="', ...
      inColor, ...
      '">', ...
      inText, ...
      '</font></TD></TR></table></html>'];


function [num,typ,rgb] = cbSelect(tok)
% Return the length, type and RGB values of any colorscheme.
%
switch lower(tok) % ColorName
case 'brbg' % BrBG
	rgb = [84,48,5;140,81,10;166,97,26;191,129,45;216,179,101;223,194,125;246,232,195;245,245,245;199,234,229;128,205,193;90,180,172;53,151,143;1,133,113;1,102,94;0,60,48];
	typ = 'Diverging';
case 'piyg' % PiYG
	rgb = [142,1,82;197,27,125;208,28,139;222,119,174;233,163,201;241,182,218;253,224,239;247,247,247;230,245,208;184,225,134;161,215,106;127,188,65;77,172,38;77,146,33;39,100,25];
	typ = 'Diverging';
case 'prgn' % PRGn
	rgb = [64,0,75;118,42,131;123,50,148;153,112,171;175,141,195;194,165,207;231,212,232;247,247,247;217,240,211;166,219,160;127,191,123;90,174,97;0,136,55;27,120,55;0,68,27];
	typ = 'Diverging';
case 'puor' % PuOr
	rgb = [127,59,8;179,88,6;230,97,1;224,130,20;241,163,64;253,184,99;254,224,182;247,247,247;216,218,235;178,171,210;153,142,195;128,115,172;94,60,153;84,39,136;45,0,75];
	typ = 'Diverging';
case 'rdbu' % RdBu
	rgb = [103,0,31;178,24,43;202,0,32;214,96,77;239,138,98;244,165,130;253,219,199;247,247,247;209,229,240;146,197,222;103,169,207;67,147,195;5,113,176;33,102,172;5,48,97];
	typ = 'Diverging';
case 'rdgy' % RdGy
	rgb = [103,0,31;178,24,43;202,0,32;214,96,77;239,138,98;244,165,130;253,219,199;255,255,255;224,224,224;186,186,186;153,153,153;135,135,135;64,64,64;77,77,77;26,26,26];
	typ = 'Diverging';
case 'rdylbu' % RdYlBu
	rgb = [165,0,38;215,48,39;215,25,28;244,109,67;252,141,89;253,174,97;254,224,144;255,255,191;224,243,248;171,217,233;145,191,219;116,173,209;44,123,182;69,117,180;49,54,149];
	typ = 'Diverging';
case 'rdylgn' % RdYlGn
	rgb = [165,0,38;215,48,39;215,25,28;244,109,67;252,141,89;253,174,97;254,224,139;255,255,191;217,239,139;166,217,106;145,207,96;102,189,99;26,150,65;26,152,80;0,104,55];
	typ = 'Diverging';
case 'spectral' % Spectral
	rgb = [158,1,66;213,62,79;215,25,28;244,109,67;252,141,89;253,174,97;254,224,139;255,255,191;230,245,152;171,221,164;153,213,148;102,194,165;43,131,186;50,136,189;94,79,162];
	typ = 'Diverging';
case 'accent' % Accent
	rgb = [127,201,127;190,174,212;253,192,134;255,255,153;56,108,176;240,2,127;191,91,23;102,102,102];
	typ = 'Qualitative';
case 'dark2' % Dark2
	rgb = [27,158,119;217,95,2;117,112,179;231,41,138;102,166,30;230,171,2;166,118,29;102,102,102];
	typ = 'Qualitative';
case 'paired' % Paired
	rgb = [166,206,227;31,120,180;178,223,138;51,160,44;251,154,153;227,26,28;253,191,111;255,127,0;202,178,214;106,61,154;255,255,153;177,89,40];
	typ = 'Qualitative';
case 'pastel1' % Pastel1
	rgb = [251,180,174;179,205,227;204,235,197;222,203,228;254,217,166;255,255,204;229,216,189;253,218,236;242,242,242];
	typ = 'Qualitative';
case 'pastel2' % Pastel2
	rgb = [179,226,205;253,205,172;203,213,232;244,202,228;230,245,201;255,242,174;241,226,204;204,204,204];
	typ = 'Qualitative';
case 'set1' % Set1
	rgb = [228,26,28;55,126,184;77,175,74;152,78,163;255,127,0;255,255,51;166,86,40;247,129,191;153,153,153];
	typ = 'Qualitative';
case 'set2' % Set2
	rgb = [102,194,165;252,141,98;141,160,203;231,138,195;166,216,84;255,217,47;229,196,148;179,179,179];
	typ = 'Qualitative';
case 'set3' % Set3
	rgb = [141,211,199;255,255,179;190,186,218;251,128,114;128,177,211;253,180,98;179,222,105;252,205,229;217,217,217;188,128,189;204,235,197;255,237,111];
	typ = 'Qualitative';
case 'blues' % Blues
	rgb = [247,251,255;239,243,255;222,235,247;198,219,239;189,215,231;158,202,225;107,174,214;66,146,198;49,130,189;33,113,181;8,81,156;8,69,148;8,48,107];
	typ = 'Sequential';
case 'bugn' % BuGn
	rgb = [247,252,253;237,248,251;229,245,249;204,236,230;178,226,226;153,216,201;102,194,164;65,174,118;44,162,95;35,139,69;0,109,44;0,88,36;0,68,27];
	typ = 'Sequential';
case 'bupu' % BuPu
	rgb = [247,252,253;237,248,251;224,236,244;191,211,230;179,205,227;158,188,218;140,150,198;140,107,177;136,86,167;136,65,157;129,15,124;110,1,107;77,0,75];
	typ = 'Sequential';
case 'gnbu' % GnBu
	rgb = [247,252,240;240,249,232;224,243,219;204,235,197;186,228,188;168,221,181;123,204,196;78,179,211;67,162,202;43,140,190;8,104,172;8,88,158;8,64,129];
	typ = 'Sequential';
case 'greens' % Greens
	rgb = [247,252,245;237,248,233;229,245,224;199,233,192;186,228,179;161,217,155;116,196,118;65,171,93;49,163,84;35,139,69;0,109,44;0,90,50;0,68,27];
	typ = 'Sequential';
case 'greys' % Greys
	rgb = [255,255,255;247,247,247;240,240,240;217,217,217;204,204,204;189,189,189;150,150,150;115,115,115;99,99,99;82,82,82;37,37,37;37,37,37;0,0,0];
	typ = 'Sequential';
case 'orrd' % OrRd
	rgb = [255,247,236;254,240,217;254,232,200;253,212,158;253,204,138;253,187,132;252,141,89;239,101,72;227,74,51;215,48,31;179,0,0;153,0,0;127,0,0];
	typ = 'Sequential';
case 'oranges' % Oranges
	rgb = [255,245,235;254,237,222;254,230,206;253,208,162;253,190,133;253,174,107;253,141,60;241,105,19;230,85,13;217,72,1;166,54,3;140,45,4;127,39,4];
	typ = 'Sequential';
case 'pubu' % PuBu
	rgb = [255,247,251;241,238,246;236,231,242;208,209,230;189,201,225;166,189,219;116,169,207;54,144,192;43,140,190;5,112,176;4,90,141;3,78,123;2,56,88];
	typ = 'Sequential';
case 'pubugn' % PuBuGn
	rgb = [255,247,251;246,239,247;236,226,240;208,209,230;189,201,225;166,189,219;103,169,207;54,144,192;28,144,153;2,129,138;1,108,89;1,100,80;1,70,54];
	typ = 'Sequential';
case 'purd' % PuRd
	rgb = [247,244,249;241,238,246;231,225,239;212,185,218;215,181,216;201,148,199;223,101,176;231,41,138;221,28,119;206,18,86;152,0,67;145,0,63;103,0,31];
	typ = 'Sequential';
case 'purples' % Purples
	rgb = [252,251,253;242,240,247;239,237,245;218,218,235;203,201,226;188,189,220;158,154,200;128,125,186;117,107,177;106,81,163;84,39,143;74,20,134;63,0,125];
	typ = 'Sequential';
case 'rdpu' % RdPu
	rgb = [255,247,243;254,235,226;253,224,221;252,197,192;251,180,185;250,159,181;247,104,161;221,52,151;197,27,138;174,1,126;122,1,119;122,1,119;73,0,106];
	typ = 'Sequential';
case 'reds' % Reds
	rgb = [255,245,240;254,229,217;254,224,210;252,187,161;252,174,145;252,146,114;251,106,74;239,59,44;222,45,38;203,24,29;165,15,21;153,0,13;103,0,13];
	typ = 'Sequential';
case 'ylgn' % YlGn
	rgb = [255,255,229;255,255,204;247,252,185;217,240,163;194,230,153;173,221,142;120,198,121;65,171,93;49,163,84;35,132,67;0,104,55;0,90,50;0,69,41];
	typ = 'Sequential';
case 'ylgnbu' % YlGnBu
	rgb = [255,255,217;255,255,204;237,248,177;199,233,180;161,218,180;127,205,187;65,182,196;29,145,192;44,127,184;34,94,168;37,52,148;12,44,132;8,29,88];
	typ = 'Sequential';
case 'ylorbr' % YlOrBr
	rgb = [255,255,229;255,255,212;255,247,188;254,227,145;254,217,142;254,196,79;254,153,41;236,112,20;217,95,14;204,76,2;153,52,4;140,45,4;102,37,6];
	typ = 'Sequential';
case 'ylorrd' % YlOrRd
	rgb = [255,255,204;255,255,178;255,237,160;254,217,118;254,204,92;254,178,76;253,141,60;252,78,42;240,59,32;227,26,28;189,0,38;177,0,38;128,0,38];
	typ = 'Sequential';
otherwise
	error('Colorscheme "%s" is not supported. Check the token tables.',tok)
end
%
% rgb = rgb./255;
%
switch typ
case 'Diverging'
	num = 11;
case 'Qualitative'
	num = size(rgb,1);
case 'Sequential'
	num = 9;
otherwise
	error('The colorscheme type "%s" is not recognized',typ)
end


function idx = cbIndex(N,num,typ,tok,isr)
% Ensure exactly the same colors as in the online ColorBrewer schemes.
%
if strcmp(typ,'Qualitative')
	assert(N<=num,'Colorscheme "%s" maximum colormap length: %d. Requested: %d.',tok,num,N)
	idx = 1:N;
elseif strcmp(typ,'Diverging')
	switch min(N,num)
	case 1 % extrapolated
		idx = 8;
	case 2 % extrapolated
		idx = [4,12];
	case 3
		idx = [5,8,11];
	case 4
		idx = [3,6,10,13];
	case 5
		idx = [3,6,8,10,13];
	case 6
		idx = [2,5,7,9,11,14];
	case 7
		idx = [2,5,7,8,9,11,14];
	case 8
		idx = [2,4,6,7,9,10,12,14];
	case 9
		idx = [2,4,6,7,8,9,10,12,14];
	case 10
		idx = [1,2,4,6,7,9,10,12,14,15];
	case 11
		idx = [1,2,4,6,7,8,9,10,12,14,15];
	end
elseif strcmp(typ,'Sequential')
	switch min(N,num)
	case 1 % extrapolated
		idx = 6;
	case 2 % extrapolated
		idx = [4,8];
	case 3
		idx = [3,6,9];
	case 4
		idx = [2,5,7,10];
	case 5
		idx = [2,5,7,9,11];
	case 6
		idx = [2,4,6,7,9,11];
	case 7
		idx = [2,4,6,7,8,10,12];
	case 8
		idx = [1,3,4,6,7,8,10,12];
	case 9
		idx = [1,3,4,6,7,8,10,11,13];
	end
else
	error('The colorscheme type "%s" is not recognized',typ)
end
%
if isr
	idx = idx(end:-1:1);
end

% 以下来自color_set_scprit_2016314_2016316.m，后来改过，直接在这里改了，那里仅作纪念
function color_class_num_callback(source,callbackdata)
set(source, 'userdata', source.Value)
crt_fig = findall(0, 'type', 'figure', 'name', 'Set Color Map');
color_class_method = findall(crt_fig, 'position', [.29, .85, .13, .1]);
if get(source, 'Value') ~= 5 & get(color_class_method , 'Value') == 3
    set(color_class_method , 'Value', 2)
end
    

function color_class_method_callback(source, callbackdata)
set(source, 'userdata', source.Value)
crt_fig = findall(0, 'type', 'figure', 'name', 'Set Color Map');
color_class_num = findall(crt_fig, 'position',[.13, .85, .06, .1]);
if get(source, 'Value') == 3
    set(color_class_num, 'Value', 5, 'userdata', 5)
end


function set_color_layout(set_color, min_value, max_value)
%set_color：figure句柄
%min/max_value：最后显示string的时候用到最大最小值
color_class_num_text = uicontrol('parent', set_color, 'style', 'text',...
    'String', 'Classes: ', 'unit', 'normalized', 'position', [.05, .85, .07, .1],...
    'backgroundcolor', 'w', 'fontsize', 10);
color_class_num = uicontrol('parent', set_color, 'style', 'popupmenu',...
    'String', mat2cell(num2str([1:9]'),ones(9,1),1), 'unit', 'normalized', 'position',...
    [.13, .85, .06, .1], 'backgroundcolor', 'w', 'fontsize', 10, 'value', 5,...
    'callback', @color_class_num_callback);
color_class_method_text = uicontrol('parent', set_color, 'style', 'text',...
    'String', 'Method:', 'unit', 'normalized', 'position', [.21, .85, .07, .1],...
    'backgroundcolor', 'w', 'fontsize', 10,...
    'callback', @color_class_method_callback);
color_ramp_sel = uicontrol('parent', set_color, 'style', 'pushbutton',...
    'String', 'Color Ramp', 'unit', 'normalized', 'position',...
    [.66, .85, .16, .1], 'fontsize', 10, 'value', 2,...
    'callback', @color_ramp_sel_callback);
color_ramp_reverse = uicontrol('parent', set_color, 'style', 'pushbutton',...
    'String', 'Reverse', 'unit', 'normalized', 'position',...
    [.85, .85, .1, .1], 'fontsize', 10, 'value', 2,...
    'callback', @color_ramp_reverse_callback);
set_color_str2 = uicontrol('parent', set_color, 'style', 'text',...
    'HorizontalAlignment', 'left','string',...
    ['You can click on each color above and then manually set a new ',...
    'color for that class.'],...
    'unit', 'normalized', 'position', [.05 .13 .7 .06], 'fontsize', 10,...
    'backgroundcolor', 'w', 'ButtonDownFcn', @set_font_utility);
set_color_str3 = uicontrol('parent', set_color, 'style', 'text',...
    'HorizontalAlignment', 'left','string',...
    ['You can set the cut-off values of classes manually, the value should ',...
    'be in the range: ', num2str(round(min_value,2)), '~', num2str(round(max_value,2)), '.'],...
    'unit', 'normalized', 'position', [.05 .06 .7 .06], 'fontsize', 10,...
    'backgroundcolor', 'w', 'ButtonDownFcn', @set_font_utility);


function set_color_initializatoin(set_color, class_num, color_ramp_name, value_cut)
%对set_color布局进行初始化
%set_color为fig句柄，class_num为初始化的分类数，color_ramp_name为初始化色条
%value_cut为初始化cuf-off值
crt_handles = guidata(set_color);
%清除可能残留的历史记录
if isfield(crt_handles, 'color_ramp_name')
    crt_handles = rmfield(crt_handles, 'color_ramp_name');
end
if isfield(crt_handles, 'color_ramp_disp');
    crt_handles = rmfield(crt_handles, 'color_ramp_disp')
end
if isfield(crt_handles, 'value_cut_disp')
    crt_handles = rmfield(crt_handles, 'value_cut_disp')
end
text_place_cut = linspace(.03, .91, class_num+1);
for k = 1 : class_num
    color_place_cut = linspace(.05, .95, class_num+1);
end
color_rgb = brewermap(class_num, color_ramp_name);
%生成色带显示
color_ramp_disp = cell(0);
for k = 1 : class_num
    color_ramp_disp{k} = uicontrol('parent', set_color, 'unit', 'normalized',...
        'style', 'pushbutton', 'position', ...
        [color_place_cut(k), .4, color_place_cut(k+1)-color_place_cut(k), .35],...
        'backgroundcolor', color_rgb(k,:), 'string', '', 'callback', @color_ramp_disp_callback,...
        'userdata', color_rgb(k,:));
end
%生成值文本框
for k = 1 : class_num+1
    value_cut_disp{k} = uicontrol('parent', set_color, 'unit', 'normalized',...
        'style', 'edit', 'position', [text_place_cut(k), .27, .06, .12],...
        'backgroundcolor', 'w', 'string', num2str(value_cut(k)), ...
        'callback', @value_cut_disp_callback,...
        'userdata', value_cut(k),'fontsize', 10);
end
crt_handles.color_ramp_disp = color_ramp_disp;
crt_handles.color_ramp_name = color_ramp_name;
crt_handles.value_cut_disp = value_cut_disp;
guidata(set_color, crt_handles);

function color_generate_callback(hObject, eventdata)
main_fig = findall(0, 'type', 'figure', 'tag', 'figure1');
crt_fig = findall(0, 'type', 'figure', 'name', 'Set Color Map');
color_class_num = findall(crt_fig, 'position',[.13, .85, .06, .1]);
color_class_method = findall(crt_fig, 'position', [.29, .85, .13, .1]);
class_num = get(color_class_num, 'value');
class_method = get(color_class_method, 'value');
handles = guidata(main_fig);
crt_handles = guidata(crt_fig);
if isfield(crt_handles, 'color_ramp_name')
    color_ramp_name = crt_handles.color_ramp_name;
else
    color_ramp_name = 'Reds';
end
%清除已有图形
if isfield(crt_handles, 'color_ramp_disp');
    color_ramp_disp_before = crt_handles.color_ramp_disp;
    for k = 1 : length(color_ramp_disp_before)
        delete(color_ramp_disp_before{k})
    end
end
if isfield(crt_handles, 'value_cut_disp')
    value_cut_disp_before = crt_handles.value_cut_disp;
    for k = 1 : length(value_cut_disp_before)
        delete(value_cut_disp_before{k})
    end
end
%关键！为了让这个程序通用，只能判断到底在画什么图
color_generate_userdata = get(hObject, 'userdata');
Y = color_generate_userdata.Y;
max_amount = max(Y);
min_amount = min(Y);
if class_method == 1
    value_cut = linspace(min_amount, max_amount, class_num+1);
elseif class_method == 2
    value_cut = quantile(Y, linspace(0,1,class_num+1));
elseif class_method == 3
    value_cut = [0 .3 .5 .7 .9 Inf];
    color_class_num = 5;        %这种情况只能对应5种分类
end
text_place_cut = linspace(.03, .91, class_num+1);
for k = 1 : class_num
    color_place_cut = linspace(.05, .95, class_num+1);
end
color_rgb = brewermap(class_num, color_ramp_name);
%生成色带显示
color_ramp_disp = cell(0);
for k = 1 : class_num
    color_ramp_disp{k} = uicontrol('parent', crt_fig, 'unit', 'normalized',...
        'style', 'pushbutton', 'position', ...
        [color_place_cut(k), .4, color_place_cut(k+1)-color_place_cut(k), .35],...
        'backgroundcolor', color_rgb(k,:), 'string', '', 'callback', @color_ramp_disp_callback,...
        'userdata', color_rgb(k,:));
end
%生成值文本框
for k = 1 : class_num+1
    value_cut_disp{k} = uicontrol('parent', crt_fig, 'unit', 'normalized',...
        'style', 'edit', 'position', [text_place_cut(k), .27, .06, .12],...
        'backgroundcolor', 'w', 'string', num2str(value_cut(k)), ...
        'callback', @value_cut_disp_callback,...
        'userdata', value_cut(k),'fontsize', 10);
end
crt_handles.color_ramp_disp = color_ramp_disp;
crt_handles.value_cut_disp = value_cut_disp;
guidata(crt_fig, crt_handles);

function color_ramp_disp_callback(hObject, eventdata)
c = uisetcolor(get(hObject, 'userdata'));
set(hObject, 'userdata', c,...
    'backgroundcolor', c);

function value_cut_disp_callback(hObject, eventdata)
value_before = get(hObject, 'userdata');
try
    value_new = str2double(get(hObject, 'string'));
catch
    errordlg('Invalid input.', 'Error')
    set(hObject, 'string', num2str(value_before));
    return
end
main_fig = findall(0, 'type', 'figure', 'tag', 'figure1');
crt_fig = findall(0, 'type', 'figure', 'name', 'Set Color Map');
crt_handles = guidata(crt_fig);
handles = guidata(main_fig);
%关键！为了让这个程序通用，只能判断到底在画什么图（从generate按纽中判断）
color_generate = findall(crt_fig, 'position', [.47, .85, .16, .1]);
color_generate_userdata = get(color_generate, 'userdata');
Y = color_generate_userdata.Y;
max_amount = max(Y);
min_amount = min(Y);
if isnan(value_new) | isempty(value_new) | ~isnumeric(value_new)
    er = errordlg('Value should be a number.', 'Error');
    waitfor(er)
    set(hObject, 'string', num2str(value_before));
    return
end
if value_new <min_amount | value_new > max_amount
    warn = warndlg(['This value is out of ''min~max'' range: ', num2str(min_amount),...
        '~', num2str(max_amount),'.'], 'Warning');
    
end

%看看有没有乱序
set(hObject, 'userdata', value_new);
value_cut_disp = crt_handles.value_cut_disp;
for k = 1 : length(value_cut_disp)
    value(k) = get(value_cut_disp{k}, 'userdata');
end
if ~isequal(value, sort(value))
    value = sort(value);
    for k = 1 : length(value_cut_disp)
        set(value_cut_disp{k}, 'string', num2str(value(k)),...
            'userdata', value(k));
    end
end
crt_handles.value_cut_disp = value_cut_disp;
guidata(crt_fig, crt_handles);


function color_ramp_reverse_callback(hObject, eventdata)
crt_fig = findall(0, 'type', 'figure', 'name', 'Set Color Map');
crt_handles = guidata(crt_fig);
if isfield(crt_handles, 'color_ramp_disp');
    color_ramp_disp = crt_handles.color_ramp_disp;
    for k = 1 : length(color_ramp_disp)
        color_before_reverse(k, :) = get(color_ramp_disp{k}, 'backgroundcolor');
    end
    color_after_reverse = color_before_reverse(end:-1:1, :);
    for k = 1 : length(color_ramp_disp)
        set(color_ramp_disp{k}, 'backgroundcolor', color_after_reverse(k,:),...
            'userdata', color_after_reverse(k,:));      %其实好像也不用设定这个userdata了
    end
    crt_handles.color_ramp_disp = color_ramp_disp;
    guidata(crt_fig, crt_handles);
end


function color_ramp_sel_callback(hObject, eventdata)
color_ramp_sel_fig = figure('name', 'Color Ramp Selection', 'position',...
    [1310 250 545 580], 'NumberTitle', 'off', 'ToolBar', 'None', 'MenuBar', 'none',...
     'Color', 'w', 'Unit', 'normalized');
 vec = {'BrBG';'PiYG';'PRGn';'PuOr';'RdBu';'RdGy';'RdYlBu';'RdYlGn';'Spectral';...
    'Blues';'BuGn';'BuPu';'GnBu';'Greens';'Greys';'OrRd';'Oranges';'PuBu';'PuBuGn';...
    'PuRd';'Purples';'RdPu';'Reds';'YlGn';'YlGnBu';'YlOrBr';'YlOrRd'};
imx = numel(vec);
for i = 1 : imx
	[num,typ,crt_rgb] = cbSelect(vec{i});
    if isequal(typ, 'Qualitative')
        errordlg(['Serr error 2033, current color band name: ', vec{i}],'Error')
        return
    end
	crt_rgb = crt_rgb(cbIndex(num,9,typ,vec{i},false),:); % downsample
    all_rgb(:, :, i) = crt_rgb;
end
celldata = cell(0);
for i = 1 : imx
    crt_color_band = all_rgb(:, :, i);
    for j = 1 : 9
        celldata{i, j} = colText('Red text', ...
            ['rgb(', num2str(crt_color_band(j,1)),...
            ',', num2str(crt_color_band(j,2)), ...
            ',', num2str(crt_color_band(j,3)), ')']);
    end
end
L = size(celldata,1);
celldata = [mat2cell(false(L,1), ones(L,1), 1), celldata];

ut_h = uitable('Parent', color_ramp_sel_fig,...
    'Data', celldata, ...
    'ColumnName', [], ...
    'RowName', [],...
    'Units', 'normalized', ...
    'Position', [0.05 0.05 .9 .9],...
    'CellSelectionCallback', @draw_sel_callback,...
    'SelectionHighlight', 'off',...
    'ColumnWidth', mat2cell([20,50*ones(1,9)], 1, ones(1,10)),...
    'userdata', vec);
%不用OK，即开即画，调好自行关闭即可
% ok_button = uicontrol('Parent', color_ramp_sel_fig,...
%     'style', 'pushbutton', 'units', 'normalized',...
%     'position', [.3 .05 .4 .1], 'string', 'OK',...
%     'callback', @color_ramp_sel_tab_ok);


function draw_sel_callback(hTab , event)
crt_fig = findall(0, 'type', 'figure', 'name', 'Set Color Map');        %这个是当前设置色谱的主界面
crt_handles = guidata(crt_fig);
vec = get(hTab, 'userdata');
if ~isempty(event.Indices)
    data = get(hTab, 'Data');
    L = size(data,1);
    iRow = event.Indices(1);
    %不允许多选
    data(:,1) = mat2cell(false(L,1), ones(L,1), 1);
    data{iRow, 1} = true;
    set(hTab, 'data', data);
    color_ramp_name = vec{iRow};
    crt_handles.color_ramp_name = color_ramp_name;
    guidata(crt_fig, crt_handles);
%     set(hTab, 'userdata', color_ramp_name)
%     color_generate_callback                   %由于还要重画值文本框，影响速度
    %--------------重生成图形：color_generate_callback简化版----------%
    color_class_num = findall(crt_fig, 'position',[.13, .85, .06, .1]);
    class_num = get(color_class_num, 'value');
    new_color_rgb = brewermap(class_num, color_ramp_name);
    if isfield(crt_handles, 'color_ramp_disp');
        color_ramp_disp = crt_handles.color_ramp_disp;
        for k = 1 : length(color_ramp_disp)
            set(color_ramp_disp{k}, 'backgroundcolor', new_color_rgb(k,:),...
                'userdata', new_color_rgb(k,:));      %其实好像也不用设定这个userdata了
        end
        crt_handles.color_ramp_disp = color_ramp_disp;
        guidata(crt_fig, crt_handles);
    end
end


% 前面的都可以通用，但是OK键不一样，要根据画的图不同而设置不同的callback
% 2016-3-16: 尝试建立一个通用的静态OK键回调函数
function color_map_ok_general(Y, use_queue_bar)
if nargin == 1
    use_queue_bar = 0;
end
main_fig = findall(0, 'type', 'figure', 'tag', 'figure1');
crt_fig = findall(0, 'type', 'figure', 'name', 'Set Color Map');
color_ramp_sel_fig = findall(0, 'type', 'figure', 'name', 'Color Ramp Selection');
crt_handles = guidata(crt_fig);
handles = guidata(main_fig);
ax = handles.axes1;
%底图
if ~isfield(handles , 'Z_factor')
    Z_factor = str2double(get(handles.edit_Z_factor, 'String'));
else
    Z_factor = handles.Z_factor
end
xyz = handles.XYZ;
xyz(:,4) = xyz(:,4) * Z_factor;             %竖向拉开
unique_XYZ = unique(xyz(: , 1));
for i = 1 : size(unique_XYZ)
    crtTAZindex = unique_XYZ(i);
    index = find(xyz(:,1) == crtTAZindex);
    hold(ax, 'on')
    base_patch{i} = patch(xyz(index,2) , xyz(index,3) , xyz(index,4) ,...
        [0.8,0.8,0.8], 'Parent', ax);
    alpha(base_patch{i}, .5);
end
if isfield(handles , 'Ent_ON')  & isfield(handles , 'ENTXYZ')
    if handles.Ent_ON == 1
        entxyz = handles.ENTXYZ;
        entxyz = entxyz(:, 2:4);
        entxyz(:,3) = entxyz(:,3) * Z_factor;
        h_ent = plot3(entxyz(: , 1), entxyz(:, 2), entxyz(:, 3), ...
            'kp','MarkerFacecolor', 'k', 'parent',ax);
        handles.h_ent = h_ent;
    end
end
set(main_fig,'color','w')
axis(ax, 'equal')
axis(ax, 'off')
az = handles.az;
el = handles.el;
view(ax, az,el)
%然后是数据
if ~isfield(crt_handles, 'color_ramp_disp')
    errordlg('Something strange happens, see error 5732', 'Error')
    return
else
    color_ramp_disp = crt_handles.color_ramp_disp;
    for k = 1 : length(color_ramp_disp)
        use_color(k, :) = get(color_ramp_disp{k}, 'backgroundcolor');
    end
end
if ~isfield(crt_handles, 'value_cut_disp')
    errordlg('Something strange happens, see error 5733', 'Error')
    return
else
    value_cut_disp = crt_handles.value_cut_disp;
    for k = 1 : length(value_cut_disp)
        use_cutoff_value(k) = get(value_cut_disp{k}, 'userdata');
    end
end
judge = sign(bsxfun(@minus, Y, use_cutoff_value));
all_taz_id = unique(xyz(:,1));
NTAZ = length(all_taz_id);
NCLS = size(use_color, 1);          %类别数
for i = 1 : NTAZ
    crt_taz = all_taz_id(i);
    negative_index = find(judge(i,:) < 0);
    if isempty(negative_index)
        %防止上界设的太低，有小区超过所有的cut-off,找不到<0，就不画这个小区
        if judge(i,end) == 0
            %但也要防一种情况，就是最后一个cut-off value正好是最大值，这样最后一个
            %judge值就是0，没有负。以前把最后一值设为inf，不会出问题
            crt_class = NCLS;       %此时就是最后一种类别（右包含）
        else
            crt_patch{i} = [];
            continue
        end
    else
        %至少找到了一个负数，说明没有出现上界太低的情况
        first_negative_index = negative_index(1);
        crt_class = first_negative_index - 1;
    end
    if crt_class >= 1 & crt_class <= NCLS
        crt_color = use_color(crt_class, :);
        %注意：这种生成的区间形式是：(-inf, x1), [x1, x2), [x2, x3)...[xn, inf)
        %即右不包含，左包含
        crt_xyz = xyz(xyz(:,1)==crt_taz, :);         %注意：第1列还是ID
        crt_patch{i} = patch(crt_xyz(:,2), crt_xyz(:,3), crt_xyz(:,4), crt_color,...
            'Parent', ax, 'userdata', crt_class);
        %userdata中当前颜色分类
    else
        %防止下界设的太高，有小区低于所有的cut-off,第一个就是负，再-1分类索引就是0了，就不画这个小区
        crt_patch{i} = [];
    end
end

% 2016-3-21：新增排队柱子
if use_queue_bar == 1
    queue_bar = handles.queue_bar;
    queue_bar_reference_value = queue_bar.reference_value;
    queue_bar_reference_length = queue_bar.reference_length;
    queue_bar_width = queue_bar.width;
    for k = 1 : NTAZ
        crt_taz = all_taz_id(k);
        crt_xyz = xyz(xyz(:,1)==crt_taz, :);         %注意：第1列还是ID
        crt_rst = polygeom(crt_xyz(:,2) , crt_xyz(:,3));
        crt_centroid = [crt_rst(2) , crt_rst(3), crt_xyz(1,4)];
        if Y(k) > 0
            crt_length = queue_bar_reference_length * (Y(k) / queue_bar_reference_value);
            crt_length = crt_length * Z_factor;
            queue_bar_f{k} = plot3(ax, [crt_centroid(1);crt_centroid(1)], [crt_centroid(2);crt_centroid(2)],...
                [crt_centroid(3);crt_centroid(3)+crt_length], 'b-', 'linewidth', queue_bar_width);
        else
            queue_bar_f{k} = [];
        end
    end 
end

%图例
lgd_w = 260;
lgd_h = (45+8) * NCLS;
lgd_fig = figure('name', 'Legend', 'NumberTitle', 'off', 'ToolBar', 'none',...
    'menubar', 'none', 'position', [800 300 lgd_w lgd_h], ...
    'unit', 'normalized', 'color', 'w', 'visible', 'off');
set(lgd_fig, 'userdata', 'colormap legend')
lgd_height = linspace(.05, .95, NCLS+1);
lgd_sj_value = 0.08 * (lgd_height(2)-lgd_height(1));            %sj: 缩进
for i = 1 : NCLS
    lgd_color{i} = uicontrol('parent', lgd_fig, 'style', 'text',...
        'units', 'normalized', 'string', '', 'position', ...
        [.05, lgd_height(i)+lgd_sj_value, .4, lgd_height(i+1)-lgd_height(i)-2*lgd_sj_value],...
        'backgroundcolor', use_color(i,:));
    lgd_text{i} = uicontrol('parent', lgd_fig, 'style', 'text',...
        'units', 'normalized', 'string', ...
        [num2str(round(use_cutoff_value(i),3)),' - ',num2str(round(use_cutoff_value(i+1),3))],'position',...
        [.48, lgd_height(i)+lgd_sj_value, .47, (lgd_height(i+1)-lgd_height(i)-2*lgd_sj_value)*.8],...
        'backgroundcolor', 'w', 'horizontalAlignment', 'left', 'fontsize',13,...
        'fontweight', 'bold', 'ButtonDownFcn', @set_font_utility);
end
if get(handles.Legend_check, 'value') == 1
    set(lgd_fig, 'visible', 'on')
end
handles.colormap_legend_fig = lgd_fig;
guidata(main_fig, handles);
close(crt_fig);
close(color_ramp_sel_fig)



%------------2016-3-17: 尝试建立一个通用的colormap OK健数据传输函数-------%
%       %只用于静态数据，将要表达的Y传过来，再调用真正画图的color_map_ok_general
%       %因为之前已经写好，只有分时图上试过，后面那个if end就是专门针对它画时间标题的
function color_map_ok_tranferdata_general(hObject, eventdata)
main_fig = findall(0, 'type', 'figure', 'tag', 'figure1');
handles = guidata(main_fig);
ax = handles.axes1;
%利用通过用 color_map_ok_general(Y)函数
color_map_ok_userdata = get(hObject, 'userdata');
Y = color_map_ok_userdata.Y;
%判断是否要画排队的柱子
type_str = color_map_ok_userdata.type;
if ~isempty(regexp(type_str, 'queue')) & isfield(handles, 'queue_bar') & handles.queue_bar.use == 1
    use_queue_bar = 1;
else
    use_queue_bar = 0;
end
color_map_ok_general(Y, use_queue_bar)
if isfield(color_map_ok_userdata, 'target_time')
    target_time = color_map_ok_userdata.target_time;
    target_time_h = floor(target_time / 100);
    target_time_m = target_time -target_time_h*100;
    target_time_h = num2str(target_time_h);
    target_time_m = num2str(target_time_m);
    if length(target_time_h) == 1
        target_time_h = strcat('0', target_time_h);
    end
    if length(target_time_m) == 1
        target_time_m = strcat('0', target_time_m);
    end
    target_time_str = strcat(target_time_h, ':', target_time_m);
    xyz = handles.XYZ;
    if ~isfield(handles , 'Z_factor')
        Z_factor = str2double(get(handles.edit_Z_factor, 'String'));
    else
        Z_factor = handles.Z_factor
    end
    xyz(:,4) = xyz(:,4) * Z_factor;
    max_x = max(xyz(:,2));
    min_x = min(xyz(:,2));
    max_y = max(xyz(:,3));
    min_y = min(xyz(:,3));
    max_z = max(xyz(:,4));
    median_x = (max_x + min_x) / 2;
    median_y = (max_y + min_y) / 2;
    t = title(ax, target_time_str, 'position', ...
        [median_x, median_y, max_z*1.07], 'fontsize', 15,...
         'ButtonDownFcn', @set_font_utility);
end
rotate3d(ax, 'on')


%2016-3-16：尝试建立一个动态的OK键回调函数
function color_map_ok_dynamic_general(data ,time_name, use_queue_bar)
%输入data:NTAZ*NTIME的整理好的原始数据
%time_name：每一列是一个time，它的名称，HHMM数字即可
if nargin == 2
    use_queue_bar = 0;
end
main_fig = findall(0, 'type', 'figure', 'tag', 'figure1');
handles = guidata(main_fig);
main_axes = handles.axes1;
crt_fig = findall(0, 'type', 'figure', 'name', 'Set Color Map');
color_ramp_sel_fig = findall(0, 'type', 'figure', 'name', 'Color Ramp Selection');
crt_handles = guidata(crt_fig);
handles = guidata(main_fig);
NTAZ = handles.NTAZ;
NENT = handles.NENT;
for i = 1 : length(time_name)
    crt_time = time_name(i);
    crt_h = floor(crt_time / 100);
    crt_m = crt_time - 100*crt_h; 
    crt_h = num2str(crt_h);
    crt_m = num2str(crt_m);
    if length(crt_h) == 1
        crt_h = strcat('0', crt_h);
    end
    if length(crt_m) == 1
        crt_m = strcat('0', crt_m);
    end
    time_str{i} = [crt_h, ':', crt_m];
end

%底图
if ~isfield(handles , 'Z_factor')
    Z_factor = str2double(get(handles.edit_Z_factor, 'String'));
else
    Z_factor = handles.Z_factor
end
xyz = handles.XYZ;
xyz(:,4) = xyz(:,4) * Z_factor;             %竖向拉开
%用来设定标题位置的
max_x = max(xyz(:,2));
min_x = min(xyz(:,2));
max_y = max(xyz(:,3));
min_y = min(xyz(:,3));
max_z = max(xyz(:,4));
median_x = (max_x + min_x) / 2;
median_y = (max_y + min_y) / 2;
%隐形图与隐形轴
set(handles.axes1, 'Position', [0.007, 0.02, 0.62, 0.97]);
invisible_fig = figure('visible', 'off','unit', get(main_fig, 'unit'), ...
    'position', get(main_fig, 'position'));
set(invisible_fig,'color','w')
%底图画到这个fig上，同时自动生成轴
unique_XYZ = unique(xyz(: , 1));
for i = 1 : size(unique_XYZ)
    crtTAZindex = unique_XYZ(i);
    index = find(xyz(:,1) == crtTAZindex);
    hold on
    patch(xyz(index,2) , xyz(index,3) , xyz(index,4) , [0.8,0.8,0.8])
end
invisible_ax = findall(invisible_fig, 'type', 'axes');
set(invisible_ax , 'unit', get(gca, 'unit'), 'position', [0.007, 0.02, 0.62, 0.97]);
if isfield(handles , 'Ent_ON')  & isfield(handles , 'ENTXYZ')
    if handles.Ent_ON == 1
        entxyz = handles.ENTXYZ;
        entxyz = entxyz(:, 2:4);
        entxyz(:,3) = entxyz(:,3) * Z_factor;
        h_ent = plot3(entxyz(: , 1), entxyz(:, 2), entxyz(:, 3), 'kp','MarkerFacecolor', 'k');
        handles.h_ent = h_ent;
    end
end
axis off
set(gcf,'color','w')
axis equal
axis off
az = handles.az;
el = handles.el;
alpha(0.5)
view(az, el)

%然后是数据
all_taz_id = unique(xyz(:,1));
NTAZ = length(all_taz_id);

hw = waitbar(0 , 'Preparing');
%-------先是color与cut-off value-----%
if ~isfield(crt_handles, 'color_ramp_disp')
    errordlg('Something strange happens, see error 5732', 'Error')
    return
else
    color_ramp_disp = crt_handles.color_ramp_disp;
    for k = 1 : length(color_ramp_disp)
        use_color(k, :) = get(color_ramp_disp{k}, 'backgroundcolor');
    end
end
if ~isfield(crt_handles, 'value_cut_disp')
    errordlg('Something strange happens, see error 5733', 'Error')
    return
else
    value_cut_disp = crt_handles.value_cut_disp;
    for k = 1 : length(value_cut_disp)
        use_cutoff_value(k) = get(value_cut_disp{k}, 'userdata');
    end
end
NCLS = size(use_color, 1);          %类别数
for i = 1 : length(time_name)
    
%     if time_name(i) == 1730           %查错用
%         a = 1;
%     end
    
    if exist('crt_patch', 'var')
        for bk = 1 : length(crt_patch)
            if ~isempty(crt_patch{bk})
                delete(crt_patch{bk})
            end
        end
    end
    process = i/length(time_name);
    waitbar(process, hw, ['Preparing: ', num2str(round(100*process)), '%']);
    if exist('crt_patch', 'var') & ~isempty(crt_patch)
        for j = 1 : length(crt_patch)
            if ~isempty(crt_patch{j})
                delete(crt_patch{j})
            end
        end
    end
    %当前时刻的各TAZ的数据
    Y = data(:,i);
    judge = sign(bsxfun(@minus, Y, use_cutoff_value));
    for k = 1 : NTAZ
        crt_taz = all_taz_id(k);
        negative_index = find(judge(k,:) < 0);
        if isempty(negative_index)
            %防止上界设的太低，有小区超过所有的cut-off,找不到<0，就不画这个小区
            if judge(k,end) == 0
                %但也要防一种情况，就是最后一个cut-off value正好是最大值，这样最后一个
                %judge值就是0，没有负。以前把最后一值设为inf，不会出问题
                crt_class = NCLS;       %此时就是最后一种类别（右包含）
            else
                crt_patch{k} = [];
                continue
            end
        else
            %至少找到了一个负数，说明没有出现上界太低的情况
            first_negative_index = negative_index(1);
            crt_class = first_negative_index - 1;
        end
        if crt_class >= 1 & crt_class <= NCLS
            crt_color = use_color(crt_class, :);
            %注意：这种生成的区间形式是：(-inf, x1), [x1, x2), [x2, x3)...[xn, inf)
            %即右不包含，左包含
            crt_xyz = xyz(xyz(:,1)==crt_taz, :);         %注意：第1列还是ID
            crt_patch{k} = patch(crt_xyz(:,2), crt_xyz(:,3), crt_xyz(:,4), crt_color,...
                'Parent', invisible_ax, 'userdata', crt_class);
            %userdata中当前颜色分类
        else
            %防止下界设的太高，有小区低于所有的cut-off,第一个就是负，再-1分类索引就是0了，就不画这个小区
            crt_patch{k} = [];
        end
    end
    
    % 2016-3-21：新增排队柱子
    if use_queue_bar == 1
        if exist('queue_bar_f', 'var')
            for bk = 1 : length(queue_bar_f)
                if ~isempty(queue_bar_f{bk})
                    delete(queue_bar_f{bk})
                end
            end
        end
        queue_bar = handles.queue_bar;
        queue_bar_reference_value = queue_bar.reference_value;
        queue_bar_reference_length = queue_bar.reference_length;
        queue_bar_width = queue_bar.width;
        for k = 1 : NTAZ
            crt_taz = all_taz_id(k);
            crt_xyz = xyz(xyz(:,1)==crt_taz, :);         %注意：第1列还是ID
            crt_rst = polygeom(crt_xyz(:,2) , crt_xyz(:,3));
            crt_centroid = [crt_rst(2) , crt_rst(3), crt_xyz(1,4)];
            if Y(k) > 0
                crt_length = queue_bar_reference_length * (Y(k) / queue_bar_reference_value);
                crt_length = crt_length * Z_factor;
                queue_bar_f{k} = plot3(invisible_ax, [crt_centroid(1);crt_centroid(1)], [crt_centroid(2);crt_centroid(2)],...
                    [crt_centroid(3);crt_centroid(3)+crt_length], 'b-', 'linewidth', queue_bar_width);
            else
                queue_bar_f{k} = [];
            end
        end
    end
    
    
    t = title(invisible_ax, ...
        time_str{i}, 'position', [median_x, median_y, max_z*1.07], 'fontsize', 15);
    F(i) = getframe(invisible_ax);
    [im(i).X, temp] = frame2im(F(i));
end
save('ccsim_redraw', 'im')
waitbar(1, hw, 'Finshed');
handles.F = F;
guidata(main_fig, handles);
close(hw)
if isfield(handles, 'dyn_rst_play_speed')
    speed = handles.dyn_rst_play_speed;
else
    speed = 1;
end
nframe = length(time_name);
all_time = nframe / speed;
str1 = ['1. The play speed is ', num2str(speed), ' fps, therefore the total playing duration would be ', num2str(all_time) ,' seconds, ',...
    'you can reset the speed by checking ''Predefined Parameters''-''Dynamic Result Play Speed''.'];
str2 = ['2. Press ''Enter'' to play / pause the viedo.'];
str3 = ['3. Press ''Right / left arrow'' to advance / go back one frame.'];
str4 = ['4. Legend is not perfectly compatiable with the play, so press any key will firstly close the legend.'];
instr = msgbox(strvcat('Instructions: ', str1, str2, str3, str4), 'Instructions');
waitfor(instr)
videofigWC(nframe, @ccsim_redraw, speed, [], [], 'name', 'CCSIM Spatiotemproal Simulation: Dynamic Result Player',...
    'unit', 'normalized', 'position', [.05 .05 .9 .9], 'numberTitle', 'off');
%图例
lgd_w = 260;
lgd_h = (45+8) * NCLS;
lgd_fig = figure('name', 'Legend', 'NumberTitle', 'off', 'ToolBar', 'none',...
    'menubar', 'none', 'position', [800 300 lgd_w lgd_h], ...
    'unit', 'normalized', 'color', 'w', 'visible', 'off',...
    'KeyPressFcn', @lgd_key_press_fuc_callback);
set(lgd_fig, 'userdata', 'colormap legend')
lgd_height = linspace(.05, .95, NCLS+1);
lgd_sj_value = 0.08 * (lgd_height(2)-lgd_height(1));            %sj: 缩进
for i = 1 : NCLS
    lgd_color{i} = uicontrol('parent', lgd_fig, 'style', 'text',...
        'units', 'normalized', 'string', '', 'position', ...
        [.05, lgd_height(i)+lgd_sj_value, .4, lgd_height(i+1)-lgd_height(i)-2*lgd_sj_value],...
        'backgroundcolor', use_color(i,:));
    lgd_text{i} = uicontrol('parent', lgd_fig, 'style', 'text',...
        'units', 'normalized', 'string', ...
        [num2str(round(use_cutoff_value(i),3)),' - ',num2str(round(use_cutoff_value(i+1),3))],'position',...
        [.48, lgd_height(i)+lgd_sj_value, .47, (lgd_height(i+1)-lgd_height(i)-2*lgd_sj_value)*.8],...
        'backgroundcolor', 'w', 'horizontalAlignment', 'left', 'fontsize',13,...
        'fontweight', 'bold', 'ButtonDownFcn', @set_font_utility);
end
if get(handles.Legend_check, 'value') == 1
    set(lgd_fig, 'visible', 'on')
end
handles.colormap_legend_fig = lgd_fig;
guidata(main_fig, handles);
close(crt_fig);
close(color_ramp_sel_fig)

   % % %-------% % %------专用的OK回调------% % %-------% % %
   %------------这个是模拟+静态+总人数的colormap-------%
function color_map_ok_sim_total_amount_no_time(hObject, eventdata)
main_fig = findall(0, 'type', 'figure', 'tag', 'figure1');
crt_fig = findall(0, 'type', 'figure', 'name', 'Set Color Map');
color_ramp_sel_fig = findall(0, 'type', 'figure', 'name', 'Color Ramp Selection');
crt_handles = guidata(crt_fig);
handles = guidata(main_fig);
ax = handles.axes1;
%底图
if ~isfield(handles , 'Z_factor')
    Z_factor = str2double(get(handles.edit_Z_factor, 'String'));
else
    Z_factor = handles.Z_factor
end
xyz = handles.XYZ;
xyz(:,4) = xyz(:,4) * Z_factor;             %竖向拉开
unique_XYZ = unique(xyz(: , 1));
for i = 1 : size(unique_XYZ)
    crtTAZindex = unique_XYZ(i);
    index = find(xyz(:,1) == crtTAZindex);
    hold(ax, 'on')
    base_patch{i} = patch(xyz(index,2) , xyz(index,3) , xyz(index,4) ,...
        [0.8,0.8,0.8], 'Parent', ax);
    alpha(base_patch{i}, .5);
end
if isfield(handles , 'Ent_ON')  & isfield(handles , 'ENTXYZ')
    if handles.Ent_ON == 1
        entxyz = handles.ENTXYZ;
        entxyz = entxyz(:, 2:4);
        entxyz(:,3) = entxyz(:,3) * Z_factor;
        h_ent = plot3(entxyz(: , 1), entxyz(:, 2), entxyz(:, 3), ...
            'kp','MarkerFacecolor', 'k', 'parent',ax);
        handles.h_ent = h_ent;
    end
end
set(main_fig,'color','w')
axis(ax, 'equal')
axis(ax, 'off')
az = handles.az;
el = handles.el;
view(ax, az,el)
%然后是数据
Sim_mean_taz_distrib = handles.Sim_mean_taz_distrib;        %在PLOT大函数已经判断过了，能到OK，肯定有数据
if ~isfield(crt_handles, 'color_ramp_disp')
    errordlg('Something strange happens, see error 5732', 'Error')
    return
else
    color_ramp_disp = crt_handles.color_ramp_disp;
    for k = 1 : length(color_ramp_disp)
        use_color(k, :) = get(color_ramp_disp{k}, 'backgroundcolor');
    end
end
if ~isfield(crt_handles, 'value_cut_disp')
    errordlg('Something strange happens, see error 5733', 'Error')
    return
else
    value_cut_disp = crt_handles.value_cut_disp;
    for k = 1 : length(value_cut_disp)
        use_cutoff_value(k) = get(value_cut_disp{k}, 'userdata');
    end
end
% use_cutoff_value(1) = -inf;
% use_cutoff_value(end) = inf;
judge = sign(bsxfun(@minus, Sim_mean_taz_distrib, use_cutoff_value));
all_taz_id = unique(xyz(:,1));
NTAZ = length(all_taz_id);
NCLS = size(use_color, 1);          %类别数
for i = 1 : NTAZ
    crt_taz = all_taz_id(i);
    negative_index = find(judge(i,:) < 0);
    if isempty(negative_index)
        %防止上界设的太低，有小区超过所有的cut-off,找不到<0，就不画这个小区
        if judge(i,end) == 0
            %但也要防一种情况，就是最后一个cut-off value正好是最大值，这样最后一个
            %judge值就是0，没有负。以前把最后一值设为inf，不会出问题
            crt_class = NCLS;       %此时就是最后一种类别（右包含）
        else
            crt_patch{i} = [];
            continue
        end
    else
        %至少找到了一个负数，说明没有出现上界太低的情况
        first_negative_index = negative_index(1);
        crt_class = first_negative_index - 1;
    end
    if crt_class >= 1 & crt_class <= NCLS
        crt_color = use_color(crt_class, :);
        %注意：这种生成的区间形式是：(-inf, x1), [x1, x2), [x2, x3)...[xn, inf)
        %即右不包含，左包含
        crt_xyz = xyz(xyz(:,1)==crt_taz, :);         %注意：第1列还是ID
        crt_patch{i} = patch(crt_xyz(:,2), crt_xyz(:,3), crt_xyz(:,4), crt_color,...
            'Parent', ax, 'userdata', crt_class);
        %userdata中当前颜色分类
    else
        %防止下界设的太高，有小区低于所有的cut-off,第一个就是负，再-1分类索引就是0了，就不画这个小区
        crt_patch{i} = [];
    end
end

%图例
lgd_w = 260;
lgd_h = (45+8) * NCLS;
lgd_fig = figure('name', 'Legend', 'NumberTitle', 'off', 'ToolBar', 'none',...
    'menubar', 'none', 'position', [800 300 lgd_w lgd_h], ...
    'unit', 'normalized', 'color', 'w', 'visible', 'off');
set(lgd_fig, 'userdata', 'colormap legend')
lgd_height = linspace(.05, .95, NCLS+1);
lgd_sj_value = 0.08 * (lgd_height(2)-lgd_height(1));            %sj: 缩进
for i = 1 : NCLS
    lgd_color{i} = uicontrol('parent', lgd_fig, 'style', 'text',...
        'units', 'normalized', 'string', '', 'position', ...
        [.05, lgd_height(i)+lgd_sj_value, .4, lgd_height(i+1)-lgd_height(i)-2*lgd_sj_value],...
        'backgroundcolor', use_color(i,:));
    lgd_text{i} = uicontrol('parent', lgd_fig, 'style', 'text',...
        'units', 'normalized', 'string', ...
        [num2str(round(use_cutoff_value(i),3)),' - ',num2str(round(use_cutoff_value(i+1),3))],'position',...
        [.48, lgd_height(i)+lgd_sj_value, .47, (lgd_height(i+1)-lgd_height(i)-2*lgd_sj_value)*.8],...
        'backgroundcolor', 'w', 'horizontalAlignment', 'left', 'fontsize',13,...
        'fontweight', 'bold', 'ButtonDownFcn', @set_font_utility);
end
if get(handles.Legend_check, 'value') == 1
    set(lgd_fig, 'visible', 'on')
end
handles.colormap_legend_fig = lgd_fig;
guidata(main_fig, handles);
close(crt_fig);
close(color_ramp_sel_fig)

   %------------这个是模拟+静态+密度的colormap-------%
function color_map_ok_sim_density_no_time(hObject, eventdata)
%利用通过用 color_map_ok_general(Y)函数
main_fig = findall(0, 'type', 'figure', 'tag', 'figure1');
handles = guidata(main_fig);
Sim_mean_taz_distrib = handles.Sim_mean_taz_distrib;        %在PLOT大函数已经判断过了，能到OK，肯定有数据
base_area = handles.base_area;
Y = Sim_mean_taz_distrib ./ base_area;
color_map_ok_general(Y)



   %------------这个是模拟+静态+消费的colormap-------%
function color_map_ok_sim_expenditure_no_time(hObject, eventdata)
%利用通过用 color_map_ok_general(Y)函数
main_fig = findall(0, 'type', 'figure', 'tag', 'figure1');
handles = guidata(main_fig);
Sim_result_money = handles.Sim_result_money;
for k = 1 : length(Sim_result_money)
    Sim_result_money_all(:,k) = Sim_result_money(k).taz(:,4);
end
Sim_result_money_mean = mean(Sim_result_money_all, 2);
Y = Sim_result_money_mean;
color_map_ok_general(Y)


      %------------这个是对比（实际）+静态+消费的colormap-------%
function color_map_ok_comp_expenditure_no_time(hObject, eventdata)
%利用通过用 color_map_ok_general(Y)函数
main_fig = findall(0, 'type', 'figure', 'tag', 'figure1');
handles = guidata(main_fig);
comp_expenditure_distr = handles.comp_expenditure_distr;
Y = comp_expenditure_distr;
color_map_ok_general(Y)


    %------------这个是模拟+动态+密度的colormap-------%
function color_map_ok_sim_density_time(hObject, eventdata)
%利用 color_map_ok_dynamic_general(data ,time_name)函数
main_fig = findall(0, 'type', 'figure', 'tag', 'figure1');
handles = guidata(main_fig);
timely_taz_stat_result = handles.timely_taz_stat_result;
full_data_before = timely_taz_stat_result.mean;                                    %full data是指精确到每一分的完整时间统计数据
if isfield(handles, 'dyn_rst_play_start_time')
    start_time = handles.dyn_rst_play_start_time;
else
    start_time = 900;
end
if isfield(handles, 'dyn_rst_play_end_time')
    end_time = handles.dyn_rst_play_end_time;
else
    end_time = 2300;
end
if isfield(handles, 'dyn_rst_play_step_size')
    step_size = handles.dyn_rst_play_step_size;
else
    step_size = 30;
end
time_intv_stat_before = timely_taz_stat_result.time_stat_intv_origin;
try
    [time_intv_4stat_column_index, full_data, time_intv_stat]  = ...
        set_dynamic_display_time_intv(time_intv_stat_before, full_data_before, ...
        start_time, end_time, step_size);
catch
    return
end
base_area = handles.base_area;
timely_amount = full_data(:, time_intv_4stat_column_index);              %分时人数
timely_density = bsxfun(@rdivide, timely_amount, base_area);
data = timely_density;
time_name = time_intv_stat(time_intv_4stat_column_index);
color_map_ok_dynamic_general(data ,time_name)



%------------这个是模拟+动态+排队人数的colormap-------%
function color_map_ok_sim_queue_volumn_time(hObject, eventdata)
%利用 color_map_ok_dynamic_general(data ,time_name)函数
main_fig = findall(0, 'type', 'figure', 'tag', 'figure1');
handles = guidata(main_fig);
timely_taz_queue_population_result = handles.timely_taz_queue_population_result;
full_data_before = timely_taz_queue_population_result.mean;                                    %full data是指精确到每一分的完整时间统计数据
if isfield(handles, 'dyn_rst_play_start_time')
    start_time = handles.dyn_rst_play_start_time;
else
    start_time = 900;
end
if isfield(handles, 'dyn_rst_play_end_time')
    end_time = handles.dyn_rst_play_end_time;
else
    end_time = 2300;
end
if isfield(handles, 'dyn_rst_play_step_size')
    step_size = handles.dyn_rst_play_step_size;
else
    step_size = 30;
end
time_intv_stat_before = timely_taz_queue_population_result.time_stat_intv_origin;
try
    [time_intv_4stat_column_index, full_data, time_intv_stat]  = ...
        set_dynamic_display_time_intv(time_intv_stat_before, full_data_before, ...
        start_time, end_time, step_size);
catch
    return
end
timely_queue_volumn = full_data(:, time_intv_4stat_column_index);              %分时排队人数
data = timely_queue_volumn;
time_name = time_intv_stat(time_intv_4stat_column_index);
%判断是否要画排队的柱子
if isfield(handles, 'queue_bar') & handles.queue_bar.use == 1
    use_queue_bar = 1;
else
    use_queue_bar = 0;
end
color_map_ok_dynamic_general(data ,time_name, use_queue_bar)


%------------这个是模拟+动态+排队时间的colormap-------%
function color_map_ok_sim_queue_time_time(hObject, eventdata)
%利用 color_map_ok_dynamic_general(data ,time_name)函数
main_fig = findall(0, 'type', 'figure', 'tag', 'figure1');
handles = guidata(main_fig);
timely_taz_queue_time_result = handles.timely_taz_queue_time_result;
full_data_before = timely_taz_queue_time_result.mean;                                    %full data是指精确到每一分的完整时间统计数据
if isfield(handles, 'dyn_rst_play_start_time')
    start_time = handles.dyn_rst_play_start_time;
else
    start_time = 900;
end
if isfield(handles, 'dyn_rst_play_end_time')
    end_time = handles.dyn_rst_play_end_time;
else
    end_time = 2300;
end
if isfield(handles, 'dyn_rst_play_step_size')
    step_size = handles.dyn_rst_play_step_size;
else
    step_size = 30;
end
time_intv_stat_before = timely_taz_queue_time_result.time_stat_intv_origin;
try
    [time_intv_4stat_column_index, full_data, time_intv_stat]  = ...
        set_dynamic_display_time_intv(time_intv_stat_before, full_data_before, ...
        start_time, end_time, step_size);
catch
    return
end
timely_queue_time = full_data(:, time_intv_4stat_column_index);              %分时排队人数
data = timely_queue_time;
time_name = time_intv_stat(time_intv_4stat_column_index);
%判断是否要画排队的柱子
if isfield(handles, 'queue_bar') & handles.queue_bar.use == 1
    use_queue_bar = 1;
else
    use_queue_bar = 0;
end
color_map_ok_dynamic_general(data ,time_name, use_queue_bar)



    %------------这个是对比（实际）+动态+总人数的colormap-------%
function color_map_ok_comp_total_amount_time(hObject, eventdata)
%利用 color_map_ok_dynamic_general(data ,time_name)函数
main_fig = findall(0, 'type', 'figure', 'tag', 'figure1');
handles = guidata(main_fig);
comp_timely_taz_stat_result = handles.comp_timely_taz_stat_result;
full_data_before = comp_timely_taz_stat_result.data;
if isfield(handles, 'dyn_rst_play_start_time')
    start_time = handles.dyn_rst_play_start_time;
else
    start_time = 900;
end
if isfield(handles, 'dyn_rst_play_end_time')
    end_time = handles.dyn_rst_play_end_time;
else
    end_time = 2300;
end
if isfield(handles, 'dyn_rst_play_step_size')
    step_size = handles.dyn_rst_play_step_size;
else
    step_size = 30;
end
time_intv_stat_before = comp_timely_taz_stat_result.time_stat_intv_origin;
try
    [time_intv_4stat_column_index, full_data, time_intv_stat]  = ...
        set_dynamic_display_time_intv(time_intv_stat_before, full_data_before, ...
        start_time, end_time, step_size);
catch
    return
end
% base_area = handles.base_area;
timely_amount = full_data(:, time_intv_4stat_column_index);              %分时人数
% timely_density = bsxfun(@rdivide, timely_amount, base_area);
data = timely_amount;
time_name = time_intv_stat(time_intv_4stat_column_index);
color_map_ok_dynamic_general(data ,time_name)


    %------------这个是对比（实际）+动态+密度的colormap-------%
function color_map_ok_comp_density_time(hObject, eventdata)
%利用 color_map_ok_dynamic_general(data ,time_name)函数
main_fig = findall(0, 'type', 'figure', 'tag', 'figure1');
handles = guidata(main_fig);
comp_timely_taz_stat_result = handles.comp_timely_taz_stat_result;
full_data_before = comp_timely_taz_stat_result.data;
if isfield(handles, 'dyn_rst_play_start_time')
    start_time = handles.dyn_rst_play_start_time;
else
    start_time = 900;
end
if isfield(handles, 'dyn_rst_play_end_time')
    end_time = handles.dyn_rst_play_end_time;
else
    end_time = 2300;
end
if isfield(handles, 'dyn_rst_play_step_size')
    step_size = handles.dyn_rst_play_step_size;
else
    step_size = 30;
end
time_intv_stat_before = comp_timely_taz_stat_result.time_stat_intv_origin;
try
    [time_intv_4stat_column_index, full_data, time_intv_stat]  = ...
        set_dynamic_display_time_intv(time_intv_stat_before, full_data_before, ...
        start_time, end_time, step_size);
catch
    return
end
base_area = handles.base_area;
timely_amount = full_data(:, time_intv_4stat_column_index);              %分时人数
timely_density = bsxfun(@rdivide, timely_amount, base_area);            %分时密度
data = timely_density;
time_name = time_intv_stat(time_intv_4stat_column_index);
color_map_ok_dynamic_general(data ,time_name)

%------------这个是对比（实际）+动态+排队人数的colormap-------%
function color_map_ok_comp_queue_volumn_time(hObject, eventdata)
%利用 color_map_ok_dynamic_general(data ,time_name)函数
main_fig = findall(0, 'type', 'figure', 'tag', 'figure1');
handles = guidata(main_fig);
comp_timely_taz_queue_population_result = handles.comp_timely_taz_queue_population_result;
full_data_before = comp_timely_taz_queue_population_result.data;
if isfield(handles, 'dyn_rst_play_start_time')
    start_time = handles.dyn_rst_play_start_time;
else
    start_time = 900;
end
if isfield(handles, 'dyn_rst_play_end_time')
    end_time = handles.dyn_rst_play_end_time;
else
    end_time = 2300;
end
if isfield(handles, 'dyn_rst_play_step_size')
    step_size = handles.dyn_rst_play_step_size;
else
    step_size = 30;
end
time_intv_stat_before = comp_timely_taz_queue_population_result.time_stat_intv_origin;
try
    [time_intv_4stat_column_index, full_data, time_intv_stat]  = ...
        set_dynamic_display_time_intv(time_intv_stat_before, full_data_before, ...
        start_time, end_time, step_size);
catch
    return
end
timely_queue_volumn = full_data(:, time_intv_4stat_column_index);              %分时排队人数
% timely_density = bsxfun(@rdivide, timely_amount, base_area);
data = timely_queue_volumn;
time_name = time_intv_stat(time_intv_4stat_column_index);
%判断是否要画排队的柱子
if isfield(handles, 'queue_bar') & handles.queue_bar.use == 1
    use_queue_bar = 1;
else
    use_queue_bar = 0;
end
color_map_ok_dynamic_general(data ,time_name, use_queue_bar)


%------------这个是对比（实际）+动态+排队时间的colormap-------%
function color_map_ok_comp_queue_time_time(hObject, eventdata)
%利用 color_map_ok_dynamic_general(data ,time_name)函数
main_fig = findall(0, 'type', 'figure', 'tag', 'figure1');
handles = guidata(main_fig);
comp_timely_taz_queue_time_result = handles.comp_timely_taz_queue_time_result;
full_data_before = comp_timely_taz_queue_time_result.data;
if isfield(handles, 'dyn_rst_play_start_time')
    start_time = handles.dyn_rst_play_start_time;
else
    start_time = 900;
end
if isfield(handles, 'dyn_rst_play_end_time')
    end_time = handles.dyn_rst_play_end_time;
else
    end_time = 2300;
end
if isfield(handles, 'dyn_rst_play_step_size')
    step_size = handles.dyn_rst_play_step_size;
else
    step_size = 30;
end
time_intv_stat_before = comp_timely_taz_queue_time_result.time_stat_intv_origin;
try
    [time_intv_4stat_column_index, full_data, time_intv_stat]  = ...
        set_dynamic_display_time_intv(time_intv_stat_before, full_data_before, ...
        start_time, end_time, step_size);
catch
    return
end
timely_queue_time = full_data(:, time_intv_4stat_column_index);              %分时排队人数
% timely_density = bsxfun(@rdivide, timely_amount, base_area);
data = timely_queue_time;
time_name = time_intv_stat(time_intv_4stat_column_index);
%判断是否要画排队的柱子
if isfield(handles, 'queue_bar') & handles.queue_bar.use == 1
    use_queue_bar = 1;
else
    use_queue_bar = 0;
end
color_map_ok_dynamic_general(data ,time_name, use_queue_bar)


   %------------这个是对比+静态+密度的colormap-------%
function color_map_ok_comp_density_no_time(hObject, eventdata)
%利用通过用 color_map_ok_general(Y)函数
main_fig = findall(0, 'type', 'figure', 'tag', 'figure1');
handles = guidata(main_fig);
Comp_TAZ_distrib = handles.Comp_TAZ_distrib;
base_area = handles.base_area;
Y = Comp_TAZ_distrib ./ base_area;
color_map_ok_general(Y)


        %------------这个是模拟+动态+总人数的colormap-------%
function color_map_ok_sim_total_amount_time(hObject, eventdata)
main_fig = findall(0, 'type', 'figure', 'tag', 'figure1');
handles = guidata(main_fig);
main_axes = handles.axes1;
crt_fig = findall(0, 'type', 'figure', 'name', 'Set Color Map');
color_ramp_sel_fig = findall(0, 'type', 'figure', 'name', 'Color Ramp Selection');
crt_handles = guidata(crt_fig);
handles = guidata(main_fig);
NTAZ = handles.NTAZ;
NENT = handles.NENT;
timely_taz_stat_result = handles.timely_taz_stat_result;
full_data_before = timely_taz_stat_result.mean;                                    %full data是指精确到每一分的完整时间统计数据
if isfield(handles, 'dyn_rst_play_start_time')
    start_time = handles.dyn_rst_play_start_time;
else
    start_time = 900;
end
if isfield(handles, 'dyn_rst_play_end_time')
    end_time = handles.dyn_rst_play_end_time;
else
    end_time = 2300;
end
if isfield(handles, 'dyn_rst_play_step_size')
    step_size = handles.dyn_rst_play_step_size;
else
    step_size = 30;
end
time_intv_stat_before = timely_taz_stat_result.time_stat_intv_origin;
try
    [time_intv_4stat_column_index, full_data, time_intv_stat]  = ...
        set_dynamic_display_time_intv(time_intv_stat_before, full_data_before, ...
        start_time, end_time, step_size);
catch
    return
end
data = full_data(:, time_intv_4stat_column_index);
time_name = time_intv_stat(time_intv_4stat_column_index);
for i = 1 : length(time_name)
    crt_time = time_name(i);
    crt_h = floor(crt_time / 100);
    crt_m = crt_time - 100*crt_h; 
    crt_h = num2str(crt_h);
    crt_m = num2str(crt_m);
    if length(crt_h) == 1
        crt_h = strcat('0', crt_h);
    end
    if length(crt_m) == 1
        crt_m = strcat('0', crt_m);
    end
    time_str{i} = [crt_h, ':', crt_m];
end

%底图
if ~isfield(handles , 'Z_factor')
    Z_factor = str2double(get(handles.edit_Z_factor, 'String'));
else
    Z_factor = handles.Z_factor
end
xyz = handles.XYZ;
xyz(:,4) = xyz(:,4) * Z_factor;             %竖向拉开
%用来设定标题位置的
max_x = max(xyz(:,2));
min_x = min(xyz(:,2));
max_y = max(xyz(:,3));
min_y = min(xyz(:,3));
max_z = max(xyz(:,4));
median_x = (max_x + min_x) / 2;
median_y = (max_y + min_y) / 2;
%隐形图与隐形轴
set(handles.axes1, 'Position', [0.007, 0.02, 0.62, 0.97]);
invisible_fig = figure('visible', 'off','unit', get(main_fig, 'unit'), ...
    'position', get(main_fig, 'position'));
set(invisible_fig,'color','w')
%底图画到这个fig上，同时自动生成轴
unique_XYZ = unique(xyz(: , 1));
for i = 1 : size(unique_XYZ)
    crtTAZindex = unique_XYZ(i);
    index = find(xyz(:,1) == crtTAZindex);
    hold on
    patch(xyz(index,2) , xyz(index,3) , xyz(index,4) , [0.8,0.8,0.8])
end
invisible_ax = findall(invisible_fig, 'type', 'axes');
set(invisible_ax , 'unit', get(gca, 'unit'), 'position', [0.007, 0.02, 0.62, 0.97]);
if isfield(handles , 'Ent_ON')  & isfield(handles , 'ENTXYZ')
    if handles.Ent_ON == 1
        entxyz = handles.ENTXYZ;
        entxyz = entxyz(:, 2:4);
        entxyz(:,3) = entxyz(:,3) * Z_factor;
        h_ent = plot3(entxyz(: , 1), entxyz(:, 2), entxyz(:, 3), 'kp','MarkerFacecolor', 'k');
        handles.h_ent = h_ent;
    end
end
axis off
set(gcf,'color','w')
axis equal
axis off
alpha(0.5)
az = handles.az;
el = handles.el;
view(az, el)

%然后是数据
all_taz_id = unique(xyz(:,1));
NTAZ = length(all_taz_id);

hw = waitbar(0 , 'Preparing');
%-------先是color与cut-off value-----%
if ~isfield(crt_handles, 'color_ramp_disp')
    errordlg('Something strange happens, see error 5732', 'Error')
    return
else
    color_ramp_disp = crt_handles.color_ramp_disp;
    for k = 1 : length(color_ramp_disp)
        use_color(k, :) = get(color_ramp_disp{k}, 'backgroundcolor');
    end
end
if ~isfield(crt_handles, 'value_cut_disp')
    errordlg('Something strange happens, see error 5733', 'Error')
    return
else
    value_cut_disp = crt_handles.value_cut_disp;
    for k = 1 : length(value_cut_disp)
        use_cutoff_value(k) = get(value_cut_disp{k}, 'userdata');
    end
end
NCLS = size(use_color, 1);          %类别数
for i = 1 : length(time_name)
    process = i/length(time_name);
    waitbar(process, hw, ['Preparing: ', num2str(round(100*process)), '%']);
    if exist('crt_patch', 'var') & ~isempty(crt_patch)
        for j = 1 : length(crt_patch)
            if ~isempty(crt_patch{j})
                delete(crt_patch{j})
            end
        end
    end
    %当前时刻的各TAZ消费者人数统计
    Sim_mean_taz_distrib = data(:,i);
    judge = sign(bsxfun(@minus, Sim_mean_taz_distrib, use_cutoff_value));
    for k = 1 : NTAZ
        crt_taz = all_taz_id(k);
        negative_index = find(judge(k,:) < 0);
        if isempty(negative_index)
            %防止上界设的太低，有小区超过所有的cut-off,找不到<0，就不画这个小区
            if judge(k,end) == 0
                %但也要防一种情况，就是最后一个cut-off value正好是最大值，这样最后一个
                %judge值就是0，没有负。以前把最后一值设为inf，不会出问题
                crt_class = NCLS;       %此时就是最后一种类别（右包含）
            else
                crt_patch{k} = [];
                continue
            end
        else
            %至少找到了一个负数，说明没有出现上界太低的情况
            first_negative_index = negative_index(1);
            crt_class = first_negative_index - 1;
        end
        if crt_class >= 1 & crt_class <= NCLS
            crt_color = use_color(crt_class, :);
            %注意：这种生成的区间形式是：(-inf, x1), [x1, x2), [x2, x3)...[xn, inf)
            %即右不包含，左包含
            crt_xyz = xyz(xyz(:,1)==crt_taz, :);         %注意：第1列还是ID
            crt_patch{k} = patch(crt_xyz(:,2), crt_xyz(:,3), crt_xyz(:,4), crt_color,...
                'Parent', invisible_ax, 'userdata', crt_class);
            %userdata中当前颜色分类
        else
            %防止下界设的太高，有小区低于所有的cut-off,第一个就是负，再-1分类索引就是0了，就不画这个小区
            crt_patch{k} = [];
        end
    end
    t = title(invisible_ax, ...
        time_str{i}, 'position', [median_x, median_y, max_z*1.07], 'fontsize', 15);
    F(i) = getframe(invisible_ax);
    [im(i).X, temp] = frame2im(F(i));
end
save('ccsim_redraw', 'im')
waitbar(1, hw, 'Finshed');
handles.F = F;
guidata(hObject, handles);
close(hw)
if isfield(handles, 'dyn_rst_play_speed')
    speed = handles.dyn_rst_play_speed;
else
    speed = 1;
end
nframe = length(time_name);
all_time = nframe / speed;
str1 = ['1. The play speed is ', num2str(speed), ' fps, therefore the total playing duration would be ', num2str(all_time) ,' seconds, ',...
    'you can reset the speed by checking ''Predefined Parameters''-''Dynamic Result Play Speed''.'];
str2 = ['2. Press ''Enter'' to play / pause the viedo.'];
str3 = ['3. Press ''Right / left arrow'' to advance / go back one frame.'];
str4 = ['4. Legend is not perfectly compatiable with the play, so press any key will firstly close the legend.'];
instr = msgbox(strvcat('Instructions: ', str1, str2, str3, str4), 'Instructions');
waitfor(instr)
videofigWC(nframe, @ccsim_redraw, speed, [], [], 'name', 'CCSIM Spatiotemproal Simulation: Dynamic Result Player',...
    'unit', 'normalized', 'position', [.05 .05 .9 .9], 'numberTitle', 'off');
%图例
lgd_w = 260;
lgd_h = (45+8) * NCLS;
lgd_fig = figure('name', 'Legend', 'NumberTitle', 'off', 'ToolBar', 'none',...
    'menubar', 'none', 'position', [800 300 lgd_w lgd_h], ...
    'unit', 'normalized', 'color', 'w', 'visible', 'off',...
    'KeyPressFcn', @lgd_key_press_fuc_callback);
set(lgd_fig, 'userdata', 'colormap legend')
lgd_height = linspace(.05, .95, NCLS+1);
lgd_sj_value = 0.08 * (lgd_height(2)-lgd_height(1));            %sj: 缩进
for i = 1 : NCLS
    lgd_color{i} = uicontrol('parent', lgd_fig, 'style', 'text',...
        'units', 'normalized', 'string', '', 'position', ...
        [.05, lgd_height(i)+lgd_sj_value, .4, lgd_height(i+1)-lgd_height(i)-2*lgd_sj_value],...
        'backgroundcolor', use_color(i,:));
    lgd_text{i} = uicontrol('parent', lgd_fig, 'style', 'text',...
        'units', 'normalized', 'string', ...
        [num2str(round(use_cutoff_value(i),3)),' - ',num2str(round(use_cutoff_value(i+1),3))],'position',...
        [.48, lgd_height(i)+lgd_sj_value, .47, (lgd_height(i+1)-lgd_height(i)-2*lgd_sj_value)*.8],...
        'backgroundcolor', 'w', 'horizontalAlignment', 'left', 'fontsize',13,...
        'fontweight', 'bold', 'ButtonDownFcn', @set_font_utility);
end
if get(handles.Legend_check, 'value') == 1
    set(lgd_fig, 'visible', 'on')
end
handles.colormap_legend_fig = lgd_fig;
guidata(main_fig, handles);
close(crt_fig);
close(color_ramp_sel_fig)
            %以下小函数解决图例与视频不兼容问题：让它消失
function lgd_key_press_fuc_callback(x, y)
lgd_fig = findall(0, 'name', 'Legend');
if ~isempty(lgd_fig)
    close(lgd_fig)
end

        %------------这个是对比+静态+总人数的colormap-------%
function color_map_ok_comp_total_amount_no_time(hObject, eventdata)
main_fig = findall(0, 'type', 'figure', 'tag', 'figure1');
crt_fig = findall(0, 'type', 'figure', 'name', 'Set Color Map');
color_ramp_sel_fig = findall(0, 'type', 'figure', 'name', 'Color Ramp Selection');
crt_handles = guidata(crt_fig);
handles = guidata(main_fig);
ax = handles.axes1;
%底图
if ~isfield(handles , 'Z_factor')
    Z_factor = str2double(get(handles.edit_Z_factor, 'String'));
else
    Z_factor = handles.Z_factor
end
xyz = handles.XYZ;
xyz(:,4) = xyz(:,4) * Z_factor;             %竖向拉开
unique_XYZ = unique(xyz(: , 1));
for i = 1 : size(unique_XYZ)
    crtTAZindex = unique_XYZ(i);
    index = find(xyz(:,1) == crtTAZindex);
    hold(ax, 'on')
    base_patch{i} = patch(xyz(index,2) , xyz(index,3) , xyz(index,4) ,...
        [0.8,0.8,0.8], 'Parent', ax);
    alpha(base_patch{i}, .5);
end
if isfield(handles , 'Ent_ON')  & isfield(handles , 'ENTXYZ')
    if handles.Ent_ON == 1
        entxyz = handles.ENTXYZ;
        entxyz = entxyz(:, 2:4);
        entxyz(:,3) = entxyz(:,3) * Z_factor;
        h_ent = plot3(entxyz(: , 1), entxyz(:, 2), entxyz(:, 3), ...
            'kp','MarkerFacecolor', 'k', 'parent',ax);
        handles.h_ent = h_ent;
    end
end
set(main_fig,'color','w')
axis(ax, 'equal')
axis(ax, 'off')
az = handles.az;
el = handles.el;
view(ax, az,el)
%然后是数据
Comp_TAZ_distrib = handles.Comp_TAZ_distrib;        %在PLOT大函数已经判断过了，能到OK，肯定有数据
if ~isfield(crt_handles, 'color_ramp_disp')
    errordlg('Something strange happens, see error 5732', 'Error')
    return
else
    color_ramp_disp = crt_handles.color_ramp_disp;
    for k = 1 : length(color_ramp_disp)
        use_color(k, :) = get(color_ramp_disp{k}, 'backgroundcolor');
    end
end
if ~isfield(crt_handles, 'value_cut_disp')
    errordlg('Something strange happens, see error 5733', 'Error')
    return
else
    value_cut_disp = crt_handles.value_cut_disp;
    for k = 1 : length(value_cut_disp)
        use_cutoff_value(k) = get(value_cut_disp{k}, 'userdata');
    end
end
judge = sign(bsxfun(@minus, Comp_TAZ_distrib, use_cutoff_value));
all_taz_id = unique(xyz(:,1));
NTAZ = length(all_taz_id);
NCLS = size(use_color, 1);          %类别数
for i = 1 : NTAZ
    crt_taz = all_taz_id(i);
    negative_index = find(judge(i,:) < 0);
    if isempty(negative_index)
        %防止上界设的太低，有小区超过所有的cut-off,找不到<0，就不画这个小区
        if judge(i,end) == 0
            %但也要防一种情况，就是最后一个cut-off value正好是最大值，这样最后一个
            %judge值就是0，没有负。以前把最后一值设为inf，不会出问题
            crt_class = NCLS;       %此时就是最后一种类别（右包含）
        else
            crt_patch{i} = [];
            continue
        end
    else
        %至少找到了一个负数，说明没有出现上界太低的情况
        first_negative_index = negative_index(1);
        crt_class = first_negative_index - 1;
    end
    if crt_class >= 1 & crt_class <= NCLS
        crt_color = use_color(crt_class, :);
        %注意：这种生成的区间形式是：(-inf, x1), [x1, x2), [x2, x3)...[xn, inf)
        %即右不包含，左包含
        crt_xyz = xyz(xyz(:,1)==crt_taz, :);         %注意：第1列还是ID
        crt_patch{i} = patch(crt_xyz(:,2), crt_xyz(:,3), crt_xyz(:,4), crt_color,...
            'Parent', ax, 'userdata', crt_class);
        %userdata中当前颜色分类
    else
        %防止下界设的太高，有小区低于所有的cut-off,第一个就是负，再-1分类索引就是0了，就不画这个小区
        crt_patch{i} = [];
    end
end

%图例
lgd_w = 260;
lgd_h = (45+8) * NCLS;
lgd_fig = figure('name', 'Legend', 'NumberTitle', 'off', 'ToolBar', 'none',...
    'menubar', 'none', 'position', [800 300 lgd_w lgd_h], ...
    'unit', 'normalized', 'color', 'w', 'visible', 'off');
lgd_height = linspace(.05, .95, NCLS+1);
lgd_sj_value = 0.08 * (lgd_height(2)-lgd_height(1));            %sj: 缩进
for i = 1 : NCLS
    lgd_color{i} = uicontrol('parent', lgd_fig, 'style', 'text',...
        'units', 'normalized', 'string', '', 'position', ...
        [.05, lgd_height(i)+lgd_sj_value, .4, lgd_height(i+1)-lgd_height(i)-2*lgd_sj_value],...
        'backgroundcolor', use_color(i,:));
    lgd_text{i} = uicontrol('parent', lgd_fig, 'style', 'text',...
        'units', 'normalized', 'string', ...
        [num2str(round(use_cutoff_value(i),3)),' - ',num2str(round(use_cutoff_value(i+1),3))],'position',...
        [.48, lgd_height(i)+lgd_sj_value, .47, (lgd_height(i+1)-lgd_height(i)-2*lgd_sj_value)*.8],...
        'backgroundcolor', 'w', 'horizontalAlignment', 'left', 'fontsize',13,...
        'fontweight', 'bold', 'ButtonDownFcn', @set_font_utility);
end
if get(handles.Legend_check, 'value') == 1
    set(lgd_fig, 'visible', 'on')
end
handles.colormap_legend_fig = lgd_fig;
guidata(main_fig, handles);
close(crt_fig);
close(color_ramp_sel_fig)

%---------Color Functions----------% (from: draw_color_band.m / brewermap.m)


% --- Executes on button press in load_taz_info.
function load_taz_info_Callback(hObject, eventdata, handles)
% hObject    handle to load_taz_info (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 应该是4行数据： TAZID, X, Y, Z
[fname_taz_csv , pname_taz_csv]=uigetfile('*.csv' , 'Open the TAZ CSV');
if isequal(fname_taz_csv , 0) | isequal(pname_taz_csv, 0)
    return
end
fullname = strcat(pname_taz_csv,fname_taz_csv);
table_data = importdata(fullname);
if isfield(table_data, 'colheaders')
    colheaders = table_data.colheaders;
    tazID = find(ismember(colheaders, 'TAZID'));
    if isempty(tazID)
        tazID = listdlg('PromptString','Select TAZ ID Variable:','SelectionMode','single',...
            'ListString',colheaders);
        if isempty(tazID)
            return
        end
    end
    xcoord = find(ismember(colheaders, 'X'));
    if isempty(xcoord)
        xcoord = listdlg('PromptString','Select X coordinate Variable:','SelectionMode','single',...
            'ListString',colheaders);
        if isempty(xcoord)
            return
        end
    end
    ycoord = find(ismember(colheaders, 'Y'));
    if isempty(ycoord)
        ycoord = listdlg('PromptString','Select Y coordinate Variable:','SelectionMode','single',...
            'ListString',colheaders);
        if isempty(ycoord)
            return
        end
    end
    zcoord = find(ismember(colheaders, 'Z'));
    if isempty(zcoord)
        zcoord = listdlg('PromptString','Select Z coordinate Variable:','SelectionMode','single',...
            'ListString',colheaders);
        if isempty(zcoord)
            return
        end
    end
    try
        taz_csv = csvread(fullname, 1, 0);
    catch
        errordlg('Fail to open the CSV file');
    end
    taz_csv = taz_csv(:, [tazID, xcoord, ycoord, zcoord]);
else
    try
        taz_csv = csvread(fullname);
        taz_csv = taz_csv(:,1:4);
    catch
        errordlg('Fail to open the CSV file');
    end
end

ids = unique(taz_csv(: , 1));
NTAZ = length(ids);
handles.Num_TAZ.String = NTAZ;
handles.NTAZ = NTAZ;
guidata(hObject , handles);

XYZ = taz_csv;

handles.XYZ = XYZ;
guidata(hObject, handles);
msgbox('Finished.')


% --- Executes on button press in load_ent_info.
function load_ent_info_Callback(hObject, eventdata, handles)
% hObject    handle to load_ent_info (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[fname_ent_csv , pname_ent_csv]=uigetfile('*.csv' , 'Open the Entrance/Exit CSV');
if isequal(fname_ent_csv, 0) | isequal(pname_ent_csv, 0)
    return
end
fullname_ent_csv = strcat(pname_ent_csv,fname_ent_csv);
varnames = {'EntranceID', 'X', 'Y', 'Z'};
varstring = {'Entrance ID', 'X coordinate', 'Y coordinate', 'Z coordinate'};
[ent_csv, flag] = open_csv(fullname_ent_csv, 4, varnames, varstring);
if flag == 0
    return
end
% try
%     ent_csv = csvread(fullname_ent_csv);
% catch
%     errordlg('Fail to open the CSV file');
% end
ids = unique(ent_csv(: , 1));
NENT = length(ids);
if size(ent_csv , 2) >= 5
    X_ent_distrib_load_entrance = ent_csv(: , [5]);
    handles.X_ent_distrib_load_entrance = X_ent_distrib_load_entrance;
end
handles.Num_ent.String = NENT;
handles.NENT = NENT;
guidata(hObject , handles);
ENTXYZ = ent_csv;
handles.ENTXYZ = ENTXYZ;
guidata(hObject, handles);
msgbox('Finshied.')




function Num_Ped_Callback(hObject, eventdata, handles)
% hObject    handle to Num_Ped (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
NPED = str2double(get(hObject,'String'));
handles.NPED = NPED;
guidata(hObject , handles);

% Hints: get(hObject,'String') returns contents of Num_Ped as text
%        str2double(get(hObject,'String')) returns contents of Num_Ped as a double


% --- Executes during object creation, after setting all properties.
function Num_Ped_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Num_Ped (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Num_TAZ_Callback(hObject, eventdata, handles)
% hObject    handle to Num_TAZ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
NTAZ =  str2double(get(hObject,'String'));
handles.NTAZ = NTAZ;
guidata(hObject,handles);

% Hints: get(hObject,'String') returns contents of Num_TAZ as text
%        str2double(get(hObject,'String')) returns contents of Num_TAZ as a double


% --- Executes during object creation, after setting all properties.
function Num_TAZ_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Num_TAZ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in load_ind_fam.
function load_ind_fam_Callback(hObject, eventdata, handles)
% hObject    handle to load_ind_fam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[fname_ind_csv , pname_ind_csv]=uigetfile('*.csv' , 'Open the Individual CSV');
if fname_ind_csv == 0
    return
end
fullname = strcat(pname_ind_csv,fname_ind_csv);
table_data = importdata(fullname);
if isfield(table_data, 'colheaders')
    colheaders = table_data.colheaders;
    IndID_index = find(ismember(colheaders, 'IndividualID'));
    if isempty(IndID_index)
        IndID_index = listdlg('PromptString','Select Individual ID Variable:','SelectionMode','single',...
            'ListString',colheaders);
        if isempty(IndID_index)
            return
        end
    end
    EntID_index = find(ismember(colheaders, 'EntranceID'));
    if isempty(EntID_index)
        EntID_index = listdlg('PromptString','Select Entrance ID Variable:','SelectionMode','single',...
            'ListString',colheaders);
        if isempty(EntID_index)
            return
        end
    end
    EntTime_index = find(ismember(colheaders, 'Time'));
    if isempty(EntTime_index)
        EntTime_index = listdlg('PromptString',strvcat('Select Arriving Time Variable', '(Optional):'),'SelectionMode','single',...
            'ListString',colheaders);
    end
    try
        ind_csv = csvread(fullname, 1, 0);
        ind_csv = ind_csv(:, [IndID_index(:), EntID_index(:), EntTime_index(:)]);
    catch
        errordlg('Fail to open the CSV file');
    end
else
    try
        ind_csv = csvread(fullname);
    catch
        errordlg('Fail to open the CSV file');
    end
end
ids = unique(ind_csv(: , 1));
NPED = length(ids);
handles.Num_Ped.String = NPED;
handles.NPED = NPED;
guidata(hObject , handles);
if size(ind_csv, 2) >= 2
    X_ind_ent = unique(ind_csv(:,1:2) , 'rows');
    handles.X_ind_ent = X_ind_ent;
    tab = tabulate(X_ind_ent(: , 2));
    X_ent_distrib_load_ind_derived = tab(: , [3]);
    X_ent_distrib_load_ind_derived = X_ent_distrib_load_ind_derived / 100;
    handles.X_ent_distrib_load_ind_derived = X_ent_distrib_load_ind_derived;
%     handles.X_ent_distrib_load_ind = X_ind_ent(: , 2);
    guidata(hObject , handles);
    if size(ind_csv, 2) >= 3
        X_ind_ent_time = unique(ind_csv(:,[1 3]) , 'rows');
        handles.X_ind_ent_time = X_ind_ent_time;
        guidata(hObject , handles);
    end
else
    errordlg('Invalid data format', 'Error')
    return
end


% --- Executes on selection change in popupmenu4.
function popupmenu4_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu4


% --- Executes during object creation, after setting all properties.
function popupmenu4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu5.
function popupmenu5_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu5 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu5


% --- Executes during object creation, after setting all properties.
function popupmenu5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu6.
function popupmenu6_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu6 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu6


% --- Executes during object creation, after setting all properties.
function popupmenu6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu7.
function popupmenu7_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu7 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu7


% --- Executes during object creation, after setting all properties.
function popupmenu7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_b_past_Callback(hObject, eventdata, handles)
% hObject    handle to edit_b_past (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
b_past = str2double(get(hObject,'String'));
handles.b_past = b_past;
guidata(hObject , handles);

% Hints: get(hObject,'String') returns contents of edit_b_past as text
%        str2double(get(hObject,'String')) returns contents of edit_b_past as a double


% --- Executes during object creation, after setting all properties.
function edit_b_past_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_b_past (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_b_visited_Callback(hObject, eventdata, handles)
% hObject    handle to edit_b_visited (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
b_visited = str2double(get(hObject,'String'));
handles.b_visited = b_visited;
guidata(hObject , handles);

% Hints: get(hObject,'String') returns contents of edit_b_visited as text
%        str2double(get(hObject,'String')) returns contents of edit_b_visited as a double


% --- Executes during object creation, after setting all properties.
function edit_b_visited_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_b_visited (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_b_stdf_Callback(hObject, eventdata, handles)
% hObject    handle to edit_b_stdf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
b_stdf = str2double(get(hObject,'String'));
handles.b_stdf = b_stdf;
guidata(hObject , handles);

% Hints: get(hObject,'String') returns contents of edit_b_stdf as text
%        str2double(get(hObject,'String')) returns contents of edit_b_stdf as a double


% --- Executes during object creation, after setting all properties.
function edit_b_stdf_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_b_stdf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function e_b_Callback(hObject, eventdata, handles)
% hObject    handle to e_b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
b_familarity = str2double(get(hObject,'String'));
handles.b_familarity = b_familarity;
guidata(hObject , handles);

% Hints: get(hObject,'String') returns contents of e_b as text
%        str2double(get(hObject,'String')) returns contents of e_b as a double


% --- Executes during object creation, after setting all properties.
function e_b_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e_b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function e_c_Callback(hObject, eventdata, handles)
% hObject    handle to e_c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
b_dist = str2double(get(hObject,'String'));
handles.b_dist = b_dist;
guidata(hObject , handles);

% Hints: get(hObject,'String') returns contents of e_c as text
%        str2double(get(hObject,'String')) returns contents of e_c as a double


% --- Executes during object creation, after setting all properties.
function e_c_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e_c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function e_a_Callback(hObject, eventdata, handles)
% hObject    handle to e_a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
b_area = str2double(get(hObject,'String'));
handles.b_area = b_area;
guidata(hObject , handles);

% Hints: get(hObject,'String') returns contents of e_a as text
%        str2double(get(hObject,'String')) returns contents of e_a as a double


% --- Executes during object creation, after setting all properties.
function e_a_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e_a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Sim.
function Sim_Callback(hObject, eventdata, handles)
% hObject    handle to Sim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% h_main = handles.figure1;                   %handle of main interface;
adv_mode = handles.adv_mode;
% 简单模式 （以前写的）
if adv_mode == 0
    % --- Firstly Check the Data.
    tic;
    hw = waitbar(0 , 'Prepare and Check Data. Please Wait.','Name', 'Simulation Process');
    if isfield(handles, 'NTAZ')
        NTAZ = handles.NTAZ;
    else
        errordlg('Num. of TAZ is neccessary')
        close(hw)
        return
    end
    if isfield(handles, 'NPED')
        NPED = handles.NPED;
    else
        errordlg('Num. of Consumers is neccessary')
        close(hw)
        return
    end
    if isfield(handles, 'NENT')
        NENT = handles.NENT;
    else
        errordlg('Num. of ENT is neccessary')
        close(hw)
        return
    end
    if isfield(handles, 'b_area')
        b_area = handles.b_area;
    else
        %     b_area = 0;
        b_area = 0.0001;
    end
    if isfield(handles , 'b_familarity')
        b_familarity = handles.b_familarity;
    else
        %     b_familarity = 0;
        b_familarity = 1.4;
    end
    if isfield(handles , 'b_dist')
        b_dist = handles.b_dist;
    else
        %     b_dist = 0;
        b_dist = -0.01;
    end
    if isfield(handles , 'b_stdf')
        b_stdf = handles.b_stdf;
    else
        %     b_stdf = 0;
        b_stdf = -0.4;
    end
    if isfield(handles , 'b_visited')
        b_visited = handles.b_visited;
    else
        %     b_visited = 0;
        b_visited = -1.5;
    end
    if isfield(handles , 'b_past')
        b_past = handles.b_past;
    else
        %     b_past = 0;
        b_past = 0.6;
    end
    
    % CCSSR input %
    B.area = b_area;
    B.familarity = b_familarity;
    B.dist = b_dist;
    B.stdf = b_stdf;
    B.visited = b_visited;
    B.past = b_past;
    % b = [b_area , b_familarity , b_dist , b_stdf , b_visited , b_past]';
    
    if isfield(handles , 'X_area')
        X_area = handles.X_area;
    else
        errordlg('Area data is neccessary')
        close(hw)
        return
    end
    if isfield(handles , 'X_dist')
        X_dist = handles.X_dist;
    else
        errordlg('Horizontal distance matrix among TAZs is neccessary')
        close(hw)
        return
    end
    if isfield(handles , 'X_dist_ent')
        X_dist_ent = handles.X_dist_ent;
    else
        errordlg('Horizontal distance matrix between TAZs and entrances is neccessary')
        close(hw)
        return
    end
    if isfield(handles , 'X_stdf')
        X_stdf = handles.X_stdf;
    else
        errordlg('Vertical distance matrix(in stairs) among TAZs is neccessary')
        close(hw)
        return
    end
    if isfield(handles, 'X_stdf_ent')
        X_stdf_ent = handles.X_stdf_ent;
    else
        errordlg('Vertical distance matrix(in stairs) between TAZs and entrances is neccessary')
        close(hw)
        return
    end
    
    % CCSSR input %
    EV.area = X_area;
    EV.dist = X_dist;
    EV.dist_ent = X_dist_ent;
    EV.stdf = X_stdf;
    EV.stdf_ent = X_stdf_ent;
    EV.NTAZ = NTAZ;
    EV.NENT = NENT;
    
    if isfield(handles , 'X_familarity')
        X_familarity = handles.X_familarity;
        % 先简单处理下：如果是集合熟悉度，那就都一样地用这个，如果是不存在，就都设成0
        % 只有一种可能性：是个体熟悉度，但个体数又不等于模拟人数，这种情况在单次模拟中
        % 再去抽样吧
        if size(X_familarity , 2) == 1
            X_familarity = repmat(X_familarity , 1 , NPED);
        end
    else
        X_familarity = zeros(NTAZ , NPED);
    end
    
    if isfield(handles , 'X_ent_distrib')
        X_ent_distrib = handles.X_ent_distrib;
        %     X_ent_distrib = X_ent_distrib(: , 2);
    else
        errordlg('Sptial distributoin of consumers among entrances is neccessary')
        close(hw)
        return
    end
    
    % CCSSR input  %
    IND.ent_distrib = X_ent_distrib;
    IND.familarity = X_familarity;
    IND.NPED = NPED;
    % --- Firstly Check the Data: Finished.
    waitbar(0 , hw , 'Begin Simulation')
    
    
    % set(handles.Sim , 'BackgroundColor' , [0.831 , 0.816 , 0.784])
    % set(handles.Sim , 'BackgroundColor' , [0.831 , 0.816 , 0.784])
    
    % --- Then Run the Simulatoin.
    
    if isfield(handles, 'b_sim_times')
        b_sim_times = handles.b_sim_times;
    else
        b_sim_times = 10;
    end
    toc_sim_start = toc;
    for i = 1 : b_sim_times
        [ result_ped , result_taz ] = CCSSR_GUI(EV,IND, B);
        result(i).ped = result_ped;
        result(i).taz = result_taz;
        process = i / b_sim_times;
        waitbar(process , hw , ['Simulation Process: ', num2str(i), ' of ', ...
            num2str(b_sim_times), ', ', num2str(round(process*100)) , '%'])
    end
    toc_sim_end = toc;
    % --- Then Run the Simulatoin: Finished.
    waitbar(1 , hw , 'Simulatoin Finished, Prepare Results')
    handles.Sim_result = result;
end

% 高级模式 （2016/03/01 - ）
if adv_mode == 1
    % --- Firstly Check the Data.
    tic;
    hw = waitbar(0 , 'Prepare and Check Data. Please Wait.','Name', 'Simulation Process');
    if isfield(handles, 'adv_var')
        adv_var = handles.adv_var;
    else
        errordlg('Definition of variables is neccessary in advance mode.')
        close(hw)
        return
    end
    if isfield(handles, 'NTAZ')
        NTAZ = handles.NTAZ;
    else
        errordlg('Num. of TAZ is neccessary.')
        close(hw)
        return
    end
    if isfield(handles, 'NPED')
        NPED = handles.NPED;
    else
        errordlg('Num. of Consumers is neccessary.')
        close(hw)
        return
    end
    if isfield(handles, 'NENT')
        NENT = handles.NENT;
    else
        errordlg('Num. of ENT is neccessary.')
        close(hw)
        return
    end
    if isfield(handles, 'beta_adv')
        beta_adv = handles.beta_adv;
    else
        errordlg('User-defined coefficients are neccessary in advance mode.')
        close(hw)
        return
    end
    
    %2016-03-13：这个模式是纯空间模拟，如果有时间系数，要去掉的
    if isfield(handles, 'time_var')
        time_var = handles.time_var;
        beta_adv_time_var_index = [];
        for i  = 1 : length(time_var)
            time_var_name{i} = time_var{i}.name;
        end
        beta_adv_fields = fieldnames(beta_adv);
        beta_adv_time_var_index = find(ismember(beta_adv_fields, time_var_name) == 1);
        warn_time = warndlg(['In the current logit model there are ', num2str(length(beta_adv_time_var_index)), ...
            ' time-related coefficients, since this is a spatial simulation, they are kept out for this simulation, ',...
            'which may cause inaccuracy, you are advised to re-estimate a new logit model without time-related variables ',...
            'and then use this module, or directly use spatiotemporal simulation module.'], 'Dismiss of Time-Related Coefficient');
        waitfor(warn_time);
        to_be_rm_fields = beta_adv_fields(beta_adv_time_var_index);
        beta_adv = rmfield(beta_adv, to_be_rm_fields);
    end
    
    % CCSSR input %
    B = beta_adv;
    
    if ~isfield(handles, 'X_adv')
        errordlg('Some independent varaibles are incomplete.')
        close(hw)
        return
    else                    %将变量分类后，准备检查是否所有的X都已经有数值而不是空（除了动态更新的）
        X_adv = handles.X_adv;
        all_var = fieldnames(X_adv);
        %对变量进行分类：一列的属性，二维的矩阵，特殊的有可能会不一样的变量(familarity)，以及动态变量
        var_col = cell(0);
        var_mat = cell(0);
        var_dyn = cell(0);
        var_fam = cell(0);
        for ii = 1 : length(all_var)
            if isequal(all_var{ii}, 'dist') | isequal(all_var{ii}, 'stdf')
                var_mat{end+1} = all_var{ii};
            elseif isequal(all_var{ii}, 'past') | isequal(all_var{ii}, 'visited')
                var_dyn{end+1} = all_var{ii};
            elseif isequal(all_var{ii}, 'familarity')
                var_fam{end+1} = all_var{ii};
            else
                var_col{end+1} = all_var{ii};
            end
        end
    end
    
    if exist('var_col', 'var') & length(var_col) >= 1
        for ii = 1 : length(var_col)                %不允许有空value，除了动态变量
            if isempty(getfield(X_adv, var_col{ii}))
                crt_col_name = var_col{ii};
                if isequal(crt_col_name, 'familarity')      %换换名字
                    crt_col_name = 'Attractiveness';
                elseif isequal(crt_col_name, 'area')
                    crt_col_name = 'Area';
                elseif isequal(crt_col_name, 'past')
                    crt_col_name = 'Past';
                elseif isequal(crt_col_name, 'visited')
                    crt_col_name = 'Visited';
                end
                errordlg(['Incomplete independent variable input:  ''', crt_col_name, ''''])
                close(hw)
                return
            end
        end
    end
    
    if exist('var_mat', 'var') & length(var_mat) >= 1
        for ii = 1 : length(var_mat)                %对于矩阵变量，要检查是否两个矩阵都有了
            crt_var_mat = var_mat{ii};
            if ~isfield(getfield(X_adv, crt_var_mat), 'taz') | isempty(getfield(getfield(X_adv, crt_var_mat), 'taz')) | ...
                    ~isfield(getfield(X_adv, crt_var_mat), 'ent') | isempty(getfield(getfield(X_adv, crt_var_mat), 'ent'))
                if isequal(crt_var_mat, 'dist')         %改一下名字
                    crt_var_mat = 'Distance';
                elseif isequal(crt_var_mat, 'stdf')
                    crt_var_mat = 'Stair';
                end
                errordlg(['Incomplete independent variable input (matrix):  ''', crt_var_name, ''''])
                close(hw)
                return
            end
        end
    end
    
    %familarity的策略是：如果本身就是二维个体级的，不动，如果本身是一维集合层面的，按所有人相同扩展到二维，
    %如果没有这个变量，那生成一个全是0的，然后再在B中补充一个0系数。
    %最后，再在X_adv中把它去掉（因为这个时候肯定有这个变量了），加到个体IND这个结构体中。
    if exist('var_fam', 'var') & length(var_fam) == 1
        if isempty(getfield(X_adv, var_fam{1}))
            errordlg(['Incomplete independent variable input:  ''Attractiveness'''])
            close(hw)
            return
        else
            X_familarity = getfield(X_adv, var_fam{1});
            if size(X_familarity, 2) == 1
                 X_familarity = repmat(X_familarity , 1 , NPED);
                 X_adv = setfield(X_adv, 'familarity', X_familarity);
            end
        end
    else            %如果没有定义familarity，就加上一个全是0的
        X_familarity = zeros(NTAZ , NPED);
        X_adv = setfield(X_adv, 'familarity', X_familarity);
        B = setfield(B, 'familarity', 0);
    end
            

    % CCSSR input %
    EV.NTAZ = NTAZ;
    EV.NENT = NENT;
    EV.X = rmfield(X_adv, 'familarity');                    %familarity不放到X里了，放到IND里
    
    
    if isfield(handles , 'X_ent_distrib')
        X_ent_distrib = handles.X_ent_distrib;
        %     X_ent_distrib = X_ent_distrib(: , 2);
    else
        errordlg('Sptial distributoin of consumers among entrances is neccessary')
        close(hw)
        return
    end
    
    % CCSSR input  %
    IND.ent_distrib = X_ent_distrib;
    IND.familarity = X_familarity;
    IND.NPED = NPED;
    % --- Firstly Check the Data: Finished.
    waitbar(0 , hw , 'Begin Simulation')
    
    
    % set(handles.Sim , 'BackgroundColor' , [0.831 , 0.816 , 0.784])
    % set(handles.Sim , 'BackgroundColor' , [0.831 , 0.816 , 0.784])
    
    % --- Then Run the Simulatoin.
    
    if isfield(handles, 'b_sim_times')
        b_sim_times = handles.b_sim_times;
    else
        b_sim_times = 10;
    end
    toc_sim_start = toc;
    
    %所有变量名
    %20160313发现：如果输入的是一个高级模式下的时空系数，在不做时空模拟的情况下，会因为系数多而出错，所以要在前面把时间系数去掉
    all_var_name = fieldnames(B);
    for ki = 1 : length(all_var_name)
        %  2016-09-13:不知道是否合适，当时在读入高级模式下的变量时，变量名都被小写了，下面就找不到了，为防止这一情况，也让忽略大小写的通过
        if ~isequal(all_var_name{ki}, 'familarity') & ~isfield(EV.X, all_var_name{ki}) & ~isfield(EV.X, lower(all_var_name{ki}))
            errordlg('Something strange happen.(varaible in B can not be found in X), see error 3012.')
            close(hw)
            return
        end
    end
    if length(all_var_name) ~= length(fieldnames(EV.X)) + 1
        errordlg('Something strange happen.(varaible in B can not be found in X), see error 3013.')
        close(hw)
        return
    end
    
    for i = 1 : b_sim_times
        [ result_ped , result_taz ] = CCSSR_GUI_adv(EV,IND, B, all_var_name);
        result(i).ped = result_ped;
        result(i).taz = result_taz;
        process = i / b_sim_times;
        waitbar(process , hw , ['Simulation Process: ', num2str(i), ' of ', ...
            num2str(b_sim_times), ', ', num2str(round(process*100)) , '%'])
    end
    toc_sim_end = toc;
    % --- Then Run the Simulatoin: Finished.
    waitbar(1 , hw , 'Simulatoin Finished, Prepare Results')
    handles.Sim_result = result;
end


% --- Simulation result analysis
for i = 1 : b_sim_times
    crt_rst = result(i);
    crt_rst_taz = crt_rst.taz;
    crt_rst_taz(end , :) = [];
    crt_rst_taz = crt_rst_taz(: , 2);
    Sim_taz_distrib(: , i) = crt_rst_taz;
    crt_rst_ped = crt_rst.ped;
    %------OD统计-------%
    crt_OD_3d = zeros(NTAZ , NTAZ);
    for j = 1 : NPED
        crt_ped_path = crt_rst_ped{j , 3};
        for k = 1 : length(crt_ped_path)-1
            crt_ped_path_from = crt_ped_path(k);
            crt_ped_path_to = crt_ped_path(k + 1);
            crt_OD_3d(crt_ped_path_from , crt_ped_path_to) = crt_OD_3d(crt_ped_path_from , crt_ped_path_to)+1;
        end
    end
    OD_3d(:,:,i) = crt_OD_3d;
    %------OD统计-------%
    crt_gn = llz_gn(ones(NTAZ , 1) , crt_rst_taz , 0);
    crt_cv = std(crt_rst_taz) / mean(crt_rst_taz);
    crt_rst_ped_actpp = cell2mat(crt_rst_ped(: , 4));
    Sim_actpp(: , i) = crt_rst_ped_actpp;
    Sim_gn(i , 1) = crt_gn;
    Sim_cv(i , 1) = crt_cv;
    Sim_mean_actpp(i , 1) = mean(crt_rst_ped_actpp);
end


Sim_mean_OD = mean(OD_3d , 3);
Sim_mean_taz_distrib = mean(Sim_taz_distrib , 2);
Sim_mean_gn = llz_gn(ones(NTAZ , 1) , Sim_mean_taz_distrib , 0);
Sim_mean_cv = std(Sim_mean_taz_distrib) / mean(Sim_mean_taz_distrib);
handles.Sim_mean_OD = Sim_mean_OD;
handles.Sim_OD_3d = OD_3d;
handles.Sim_gn = Sim_gn;
handles.Sim_cv = Sim_cv;
handles.Sim_mean_actpp = Sim_mean_actpp;
handles.Sim_taz_distrib = Sim_taz_distrib;
handles.Sim_mean_taz_distrib = Sim_mean_taz_distrib;
handles.Sim_mean_gn = Sim_mean_gn;
handles.Sim_mean_cv = Sim_mean_cv;
handles.b_sim_times = b_sim_times;
handles.Sim_actpp = Sim_actpp;

%2016-3-13:可以说，时空模拟与纯空间模拟是两个相冲突的结果，所以如果之前做了时空模拟，现在再做空间模拟，就要把之前的时间的结果删掉
if isfield(handles, 'F')
    handles = rmfield(handles, 'F');
end
if isfield(handles, 'space_time_result_flag')
    handles = rmfield(handles, 'space_time_result_flag');
end
if isfield(handles, 'timely_taz_stat_result')
    handles = rmfield(handles, 'timely_taz_stat_result');
end
guidata(hObject, handles);
waitbar(1 , hw , 'Results Finished')
close(hw)
toc_all_end = toc;
tt_time = toc_all_end;
single_time = (toc_sim_end - toc_sim_start) / b_sim_times;
set(handles.clocker_tt, 'String' , num2str(tt_time))
set(handles.clocker_single, 'String' , num2str(single_time))










function edit27_Callback(hObject, eventdata, handles)
% hObject    handle to edit27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
b_sim_times = str2double(get(hObject,'String'));
handles.b_sim_times = b_sim_times;
guidata(hObject , handles);

% Hints: get(hObject,'String') returns contents of edit27 as text
%        str2double(get(hObject,'String')) returns contents of edit27 as a double


% --- Executes during object creation, after setting all properties.
function edit27_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit29_Callback(hObject, eventdata, handles)
% hObject    handle to edit29 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit29 as text
%        str2double(get(hObject,'String')) returns contents of edit29 as a double


% --- Executes during object creation, after setting all properties.
function edit29_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit29 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit28_Callback(hObject, eventdata, handles)
% hObject    handle to edit28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit28 as text
%        str2double(get(hObject,'String')) returns contents of edit28 as a double


% --- Executes during object creation, after setting all properties.
function edit28_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in plot_execute.
function plot_execute_Callback(hObject, eventdata, handles)
% hObject    handle to plot_execute (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 画图前务必关掉其它一切fig，尤其是legend
close_other_figurs()
if ~isfield(handles, 'NTAZ')
    errordlg('You should firstly set the Num. of TAZs', 'Error')
    return
else
    NTAZ= handles.NTAZ;
end
if ~isfield(handles , 'PlotChoice')
    PlotChoice = 1;
else
    PlotChoice = handles.PlotChoice;
end
if ~isfield(handles , 'Z_factor')
    Z_factor = str2double(get(handles.edit_Z_factor, 'String'));
else
    Z_factor = handles.Z_factor
end
if ~isfield(handles , 'marker_size')
    marker_size = 5;
else
    marker_size = handles.marker_size;
end
if isfield(handles, 'colormap_legend_fig')
    handles = rmfield(handles, 'colormap_legend_fig');          %清空上一次可能剩下的图例
end

cla reset
set(gcf,'color','w')
axis equal
axis off
set(handles.axes1, 'Position', [0.007, 0.02, 0.62, 0.97]);
if ~isfield(handles, 'XYZ')
    errordlg('No TAZ Data', 'TAZ Data');
    return
else
    XYZ = handles.XYZ;
end
xyz = XYZ;              %不用全局变量，用局部变量-----以前把XYZ设成global了，现在就不改了
switch PlotChoice
    
    %-----------------------%
    case 1              %只画底图
        xyz(:,4) = xyz(:,4) * Z_factor;             %竖向拉开
        %画全体
        unique_XYZ = unique(xyz(: , 1));
        for i = 1 : size(unique_XYZ)
            crtTAZindex = unique_XYZ(i);
            index = find(xyz(:,1) == crtTAZindex);
            hold on
            patch(xyz(index,2) , xyz(index,3) , xyz(index,4) , [0.8,0.8,0.8])
        end
        
        if isfield(handles , 'Ent_ON')  & isfield(handles , 'ENTXYZ')
            if handles.Ent_ON == 1
                entxyz = handles.ENTXYZ;
                entxyz = entxyz(:, 2:4);
                entxyz(:,3) = entxyz(:,3) * Z_factor;
                h_ent = plot3(entxyz(: , 1), entxyz(:, 2), entxyz(:, 3), 'kp','MarkerFacecolor', 'k');
                handles.h_ent = h_ent;
            end
        end
        %图形控制
        set(gcf,'color','w')
        axis equal
        axis off
        alpha(0.5)
        az = handles.az;
        el = handles.el;
        view(az, el)
        rotate3d on
        
        %-----------------------%
    case 2
        helpdlg('Please choose a specific map plot item','Plot Item')
        
        %-----------------------%
    case 3                      %底图+空间分布（本次模拟）
        if isfield(handles, 'Sim_mean_taz_distrib')
            Sim_mean_taz_distrib = handles.Sim_mean_taz_distrib;
        else
            errordlg('There is NO valid simulation TAZ distribution.')
            return
        end
        %首先是底图
        xyz(:,4) = xyz(:,4) * Z_factor;             %竖向拉开
        unique_XYZ = unique(xyz(: , 1));
        for i = 1 : size(unique_XYZ)
            crtTAZindex = unique_XYZ(i);
            index = find(xyz(:,1) == crtTAZindex);
            hold on
            patch(xyz(index,2) , xyz(index,3) , xyz(index,4) , [0.8,0.8,0.8])
        end
        if isfield(handles , 'Ent_ON')  & isfield(handles , 'ENTXYZ')
            if handles.Ent_ON == 1
                entxyz = handles.ENTXYZ;
                entxyz = entxyz(:, 2:4);
                entxyz(:,3) = entxyz(:,3) * Z_factor;
                h_ent = plot3(entxyz(: , 1), entxyz(:, 2), entxyz(:, 3), 'kp','MarkerFacecolor', 'k');
                handles.h_ent = h_ent;
            end
        end
        set(gcf,'color','w')
        axis equal
        axis off
        alpha(0.5)
        az = handles.az;
        el = handles.el;
        view(az,el)
        %然后是数据
        h_TAZ_distrib_Sim  = WDplotTAZ_GUI( round(Sim_mean_taz_distrib), xyz, 2, marker_size );
        rotate3d on
        
        
            %-----------------------%
    case 4                      %底图+空间分布（本次模拟）：分时段
        if ~isfield(handles, 'timely_taz_stat_result')
            errordlg('There is NO spatiotemporal simulation result.', 'Error')
            return
        else
            timely_taz_stat_result = handles.timely_taz_stat_result;
        end
        full_data = timely_taz_stat_result.mean;
        time_intv_stat = timely_taz_stat_result.time_stat_intv_origin;
        target_time = inputdlgWC('Input the interested time (Format: HHMM, Range: 0000~2400): ',...
            'Time', 1);
        if isempty(target_time) | (~isempty(target_time) & isempty(target_time{:}))
            return
        end
        try
            target_time = str2double(target_time{:});
        catch
            errordlg('Invalid input.', 'Error')
            return
        end
        target_time_h = floor(target_time / 100);
        target_time_m = target_time -target_time_h*100;
        if target_time_h < 0 | target_time_h > 24
            errordlg('Invalid hour format.', 'Error')
            return
        end
        if target_time_m < 0 | target_time_m > 59
            errordlg('Invalid minute format.', 'Error')
            return
        end
        if WDtimeConvert(target_time, 1) < WDtimeConvert(0000, 1) | ...
                WDtimeConvert(target_time, 1) > WDtimeConvert(2400, 1)
            errordlg('Invalid input: time should be in range 0000~2400', 'Error')
            return
        end
        target_time_index = find(time_intv_stat == target_time);
        if isempty(target_time_index)
            sim_target_time_space_distr = zeros(NTAZ, 1);
        else
            sim_target_time_space_distr = full_data(:, target_time_index);
        end
        if length(sim_target_time_space_distr) ~= NTAZ
            errodlg('The Num. of TAZ is not right.', 'Error')
            return
        end
        %首先是底图
        xyz(:,4) = xyz(:,4) * Z_factor;             %竖向拉开
        unique_XYZ = unique(xyz(: , 1));
        for i = 1 : size(unique_XYZ)
            crtTAZindex = unique_XYZ(i);
            index = find(xyz(:,1) == crtTAZindex);
            hold on
            patch(xyz(index,2) , xyz(index,3) , xyz(index,4) , [0.8,0.8,0.8])
        end
        if isfield(handles , 'Ent_ON')  & isfield(handles , 'ENTXYZ')
            if handles.Ent_ON == 1
                entxyz = handles.ENTXYZ;
                entxyz = entxyz(:, 2:4);
                entxyz(:,3) = entxyz(:,3) * Z_factor;
                h_ent = plot3(entxyz(: , 1), entxyz(:, 2), entxyz(:, 3), 'kp','MarkerFacecolor', 'k');
                handles.h_ent = h_ent;
            end
        end
        set(gcf,'color','w')
        axis equal
        axis off
        alpha(0.5)
        az = handles.az;
        el = handles.el;
        view(az,el)
        %然后是数据
        h_TAZ_distrib_Sim  = WDplotTAZ_GUI( round(sim_target_time_space_distr), xyz, 2, marker_size );
        %加时间标题
        ax = handles.axes1;
        t = add_time_title(ax, target_time, xyz)
        rotate3d on
        
    %-----------------------%
    case 5                     %模拟总人数统计，色图： 2016-3-14
        if isfield(handles, 'Sim_mean_taz_distrib')
            Sim_mean_taz_distrib = handles.Sim_mean_taz_distrib;
        else
            errordlg('There is NO valid simulation TAZ distribution.')
            return
        end
        % % % % 色彩选择 % % % %
        all_figs = findall(0, 'type', 'figure');
        for af_i = 1 : length(all_figs)
            crt_fig_in_all_figs = all_figs(af_i);
            if ~isequal(get(crt_fig_in_all_figs, 'tag') , 'figure1')
                delete(crt_fig_in_all_figs)
            end
        end
%         main_fig = findall(0, 'type', 'figure', 'tag', 'figure1');
        max_value = max(Sim_mean_taz_distrib);
        min_value = min(Sim_mean_taz_distrib);
        Y = Sim_mean_taz_distrib;
        color_generate_userdata = struct();
        color_generate_userdata.name = 'Sim total amount';
        color_generate_userdata.Y = Y;
        set_color = figure('Name' , 'Set Color Map' , 'NumberTitle' , 'off',...
            'Position', [500 400 800 300], 'Color', 'w', 'Unit', 'normalized',...
            'Menubar', 'none');
        color_generate = uicontrol('parent', set_color, 'style', 'pushbutton',...
            'String', 'Generate Classes', 'unit', 'normalized', 'position',...
            [.47, .85, .16, .1], 'fontsize', 10, 'value', 2,...
            'callback', @color_generate_callback,...
            'userdata', color_generate_userdata);     %不得不设userdata，以知道画的什么图
        color_class_method = uicontrol('parent', set_color, 'style', 'popupmenu',...
            'String', {'Equal Interval', 'Quantile'}, 'unit', 'normalized', 'position',...
            [.29, .85, .13, .1], 'backgroundcolor', 'w', 'fontsize', 10, 'value', 2,...
            'callback', @color_class_method_callback);
        %输入set_color句柄和辅助用的最大最小值，自动布局
        set_color_layout(set_color, min_value, max_value);
        % 前面的都可以通用，但是OK键不一样，要根据画的图不同而设置不同的callback
        set_color_all_ok = uicontrol('parent', set_color, 'style', 'pushbutton', ...
            'string', 'OK', 'fontsize', 10, 'unit', 'normalized', 'position',...
            [.8, .05, .15, .15], 'callback', @color_map_ok_sim_total_amount_no_time);
        %初始化
        crt_handles = guidata(set_color);
        %清除可能残留的历史记录
        if isfield(crt_handles, 'color_ramp_name')
            crt_handles = rmfield(crt_handles, 'color_ramp_name');
        end
        if isfield(crt_handles, 'color_ramp_disp');
            crt_handles = rmfield(crt_handles, 'color_ramp_disp')
        end
        if isfield(crt_handles, 'value_cut_disp')
            crt_handles = rmfield(crt_handles, 'value_cut_disp')
        end
        %与上面的max/min_value是一样的，懒得改了
        max_amount = max(Sim_mean_taz_distrib);
        min_amount = min(Sim_mean_taz_distrib);
        %默认class_method = 2 class_num = 5
        class_num = 5;
        color_ramp_name = 'Reds';
        value_cut = quantile(Sim_mean_taz_distrib, linspace(0,1,class_num+1));
        text_place_cut = linspace(.03, .91, class_num+1);
        for k = 1 : class_num
            color_place_cut = linspace(.05, .95, class_num+1);
        end
        color_rgb = brewermap(class_num, color_ramp_name);
        %生成色带显示
        color_ramp_disp = cell(0);
        for k = 1 : class_num
            color_ramp_disp{k} = uicontrol('parent', set_color, 'unit', 'normalized',...
                'style', 'pushbutton', 'position', ...
                [color_place_cut(k), .4, color_place_cut(k+1)-color_place_cut(k), .35],...
                'backgroundcolor', color_rgb(k,:), 'string', '', 'callback', @color_ramp_disp_callback,...
                'userdata', color_rgb(k,:));
        end
        %生成值文本框
        for k = 1 : class_num+1
            value_cut_disp{k} = uicontrol('parent', set_color, 'unit', 'normalized',...
                'style', 'edit', 'position', [text_place_cut(k), .27, .06, .12],...
                'backgroundcolor', 'w', 'string', num2str(value_cut(k)), ...
                'callback', @value_cut_disp_callback,...
                'userdata', value_cut(k),'fontsize', 10);
        end
        crt_handles.color_ramp_disp = color_ramp_disp;
        crt_handles.color_ramp_name = color_ramp_name;
        crt_handles.value_cut_disp = value_cut_disp;
        guidata(set_color, crt_handles);
        
        
                %-----------------------%
    case 6                      %模拟总人数统计，色图：分时段
        if ~isfield(handles, 'timely_taz_stat_result')
            errordlg('There is NO spatiotemporal simulation result.', 'Error')
            return
        else
            timely_taz_stat_result = handles.timely_taz_stat_result;
        end
        full_data = timely_taz_stat_result.mean;
        time_intv_stat = timely_taz_stat_result.time_stat_intv_origin;
        target_time = inputdlgWC('Input the interested time (Format: HHMM, Range: 0000~2400): ',...
            'Time', 1);
        if isempty(target_time) | (~isempty(target_time) & isempty(target_time{:}))
            return
        end
        try
            target_time = str2double(target_time{:});
        catch
            errordlg('Invalid input.', 'Error')
            return
        end
        target_time_h = floor(target_time / 100);
        target_time_m = target_time -target_time_h*100;
        if target_time_h < 0 | target_time_h > 24
            errordlg('Invalid hour format.', 'Error')
            return
        end
        if target_time_m < 0 | target_time_m > 59
            errordlg('Invalid minute format.', 'Error')
            return
        end
        if WDtimeConvert(target_time, 1) < WDtimeConvert(0000, 1) | ...
                WDtimeConvert(target_time, 1) > WDtimeConvert(2400, 1)
            errordlg('Invalid input: time should be in range 0000~2400', 'Error')
            return
        end
        target_time_index = find(time_intv_stat == target_time);
        if isempty(target_time_index)
            sim_target_time_space_distr = zeros(NTAZ, 1);
        else
            sim_target_time_space_distr = full_data(:, target_time_index);
        end
        if length(sim_target_time_space_distr) ~= NTAZ
            errodlg('The Num. of TAZ is not right.', 'Error')
            return
        end
        close_other_figurs()
        max_value = max(sim_target_time_space_distr);
        min_value = min(sim_target_time_space_distr);
        Y = sim_target_time_space_distr;
        color_generate_userdata = struct();
        color_generate_userdata.name = 'Sim total amount at certain time';
        color_generate_userdata.Y = Y;
        set_color = figure('Name' , 'Set Color Map' , 'NumberTitle' , 'off',...
            'Position', [500 400 800 300], 'Color', 'w', 'Unit', 'normalized',...
            'Menubar', 'none');
        color_generate = uicontrol('parent', set_color, 'style', 'pushbutton',...
            'String', 'Generate Classes', 'unit', 'normalized', 'position',...
            [.47, .85, .16, .1], 'fontsize', 10, 'value', 2,...
            'callback', @color_generate_callback,...
            'userdata', color_generate_userdata);     %不得不设userdata，以知道画的什么图
        color_class_method = uicontrol('parent', set_color, 'style', 'popupmenu',...
            'String', {'Equal Interval', 'Quantile'}, ...
            'unit', 'normalized', 'position',[.29, .85, .13, .1],...
             'backgroundcolor', 'w', 'fontsize', 10, 'value', 2,...
             'callback', @color_class_method_callback);
          %输入set_color句柄和辅助用的最大最小值，自动布局
        set_color_layout(set_color, min_value, max_value);
        set_color_all_ok = uicontrol('parent', set_color, 'style', 'pushbutton', ...
            'string', 'OK', 'fontsize', 10, 'unit', 'normalized', 'position',...
            [.8, .05, .15, .15], 'callback', @color_map_ok_tranferdata_general);    %采用通用传输函数
        color_map_ok_userdata.Y = Y;
        color_map_ok_userdata.target_time = target_time;
        color_map_ok_userdata.type = 'Sim total amount at certain time';
        set(set_color_all_ok, 'userdata', color_map_ok_userdata);       %关键：用userdata传递数据
        class_num = 5;
        color_ramp_name = 'Reds';
        value_cut = quantile(Y, linspace(0,1,class_num+1));
        set_color_initializatoin(set_color, class_num, color_ramp_name, value_cut);
        
        
        %-----------------------%
    case 7                     %模拟密度统计，色图： 2016-3-16
        if isfield(handles, 'Sim_mean_taz_distrib')
            Sim_mean_taz_distrib = handles.Sim_mean_taz_distrib;
        else
            errordlg('There is NO valid simulation TAZ distribution.', 'Error')
            return
        end
        if isfield(handles, 'base_area')
            base_area = handles.base_area;
        else
            errordlg('There is NO base area data', 'Error')
            return
        end
        Sim_density = Sim_mean_taz_distrib ./ base_area;
        % % % % 色彩选择 % % % %
        all_figs = findall(0, 'type', 'figure');
        for af_i = 1 : length(all_figs)
            crt_fig_in_all_figs = all_figs(af_i);
            if ~isequal(get(crt_fig_in_all_figs, 'tag') , 'figure1')
                delete(crt_fig_in_all_figs)
            end
        end
%         main_fig = findall(0, 'type', 'figure', 'tag', 'figure1');
        max_value = max(Sim_density);
        min_value = min(Sim_density);
        Y = Sim_density;
        color_generate_userdata = struct();
        color_generate_userdata.name = 'Sim density';
        color_generate_userdata.Y = Y;
        set_color = figure('Name' , 'Set Color Map' , 'NumberTitle' , 'off',...
            'Position', [500 400 800 300], 'Color', 'w', 'Unit', 'normalized',...
            'Menubar', 'none');
        color_generate = uicontrol('parent', set_color, 'style', 'pushbutton',...
            'String', 'Generate Classes', 'unit', 'normalized', 'position',...
            [.47, .85, .16, .1], 'fontsize', 10, 'value', 2,...
            'callback', @color_generate_callback,...
            'userdata', color_generate_userdata);     %不得不设userdata，以知道画的什么图
        color_class_method = uicontrol('parent', set_color, 'style', 'popupmenu',...
            'String', {'Equal Interval', 'Quantile', 'Default Cut-Off'}, ...
            'unit', 'normalized', 'position',[.29, .85, .13, .1],...
             'backgroundcolor', 'w', 'fontsize', 10, 'value', 2,...
             'callback', @color_class_method_callback);
        %输入set_color句柄和辅助用的最大最小值，自动布局
        set_color_layout(set_color, min_value, max_value);
        % 前面的都可以通用，但是OK键不一样，要根据画的图不同而设置不同的callback
        set_color_all_ok = uicontrol('parent', set_color, 'style', 'pushbutton', ...
            'string', 'OK', 'fontsize', 10, 'unit', 'normalized', 'position',...
            [.8, .05, .15, .15], 'callback', @color_map_ok_sim_density_no_time);
        %初始化
        %默认class_method = 3 class_num = 5
        class_num = 5;
        color_ramp_name = '*RdYlGn';
        %         value_cut = [0 .3 .5 .7 .9 Inf];
        value_cut = quantile(Sim_density, linspace(0,1,class_num+1));
        set_color_initializatoin(set_color, class_num, color_ramp_name, value_cut);
        
        
                    %-----------------------%
    case 8                      %模拟密度分布，色图：分时段
        if ~isfield(handles, 'timely_taz_stat_result')
            errordlg('There is NO spatiotemporal simulation result.', 'Error')
            return
        else
            timely_taz_stat_result = handles.timely_taz_stat_result;
        end
        if ~isfield(handles, 'base_area')
            errordlg('There is NO base area data.', 'Error')
            return
        else
            base_area = handles.base_area;
        end
        full_data = timely_taz_stat_result.mean;
        time_intv_stat = timely_taz_stat_result.time_stat_intv_origin;
        [target_time, ok_flag] = input_one_time();
        if ok_flag == 0
            return
        end
        target_time_index = find(time_intv_stat == target_time);
        if isempty(target_time_index)
            sim_target_time_space_distr = zeros(NTAZ, 1);
        else
            sim_target_time_space_distr = full_data(:, target_time_index);
        end
        if length(sim_target_time_space_distr) ~= NTAZ | length(base_area) ~= NTAZ
            errodlg('The Num. of TAZ is not right.', 'Error')
            return
        end
        sim_target_time_density = sim_target_time_space_distr ./ base_area;
        close_other_figurs()
        max_value = max(sim_target_time_density);
        min_value = min(sim_target_time_density);
        Y = sim_target_time_density;
        color_generate_userdata = struct();
        color_generate_userdata.name = 'Sim density at certain time';
        color_generate_userdata.Y = Y;
        set_color = figure('Name' , 'Set Color Map' , 'NumberTitle' , 'off',...
            'Position', [500 400 800 300], 'Color', 'w', 'Unit', 'normalized',...
            'Menubar', 'none');
        color_generate = uicontrol('parent', set_color, 'style', 'pushbutton',...
            'String', 'Generate Classes', 'unit', 'normalized', 'position',...
            [.47, .85, .16, .1], 'fontsize', 10, 'value', 2,...
            'callback', @color_generate_callback,...
            'userdata', color_generate_userdata);     %不得不设userdata，以知道画的什么图
        color_class_method = uicontrol('parent', set_color, 'style', 'popupmenu',...
            'String', {'Equal Interval', 'Quantile', 'Default Cut-Off'}, ...
            'unit', 'normalized', 'position',[.29, .85, .13, .1],...
             'backgroundcolor', 'w', 'fontsize', 10, 'value', 3,...
             'callback', @color_class_method_callback);
          %输入set_color句柄和辅助用的最大最小值，自动布局
        set_color_layout(set_color, min_value, max_value);
        set_color_all_ok = uicontrol('parent', set_color, 'style', 'pushbutton', ...
            'string', 'OK', 'fontsize', 10, 'unit', 'normalized', 'position',...
            [.8, .05, .15, .15], 'callback', @color_map_ok_tranferdata_general);    %采用通用传输函数
        color_map_ok_userdata.Y = Y;
        color_map_ok_userdata.target_time = target_time;
        color_map_ok_userdata.type = 'Sim density at certain time';
        set(set_color_all_ok, 'userdata', color_map_ok_userdata);       %关键：用userdata传递数据
        class_num = 5;
        color_ramp_name = '*RdYlGn';
        value_cut = [0 .3 .5 .7 .9 Inf];
        set_color_initializatoin(set_color, class_num, color_ramp_name, value_cut);
        
        
         %-----------------------%
    case 9                      %模拟排队人数分布，色图：分时段
        if ~isfield(handles, 'timely_taz_queue_population_result')
            errordlg('There is NO queue volumn simulation result.', 'Error')
            return
        else
            timely_taz_queue_population_result = handles.timely_taz_queue_population_result;
        end
        full_data = timely_taz_queue_population_result.mean;
        time_intv_stat = timely_taz_queue_population_result.time_stat_intv_origin;
        [target_time, ok_flag] = input_one_time();
        if ok_flag == 0
            return
        end
        target_time_index = find(time_intv_stat == target_time);
        if isempty(target_time_index)
            sim_target_time_queue_volumn = zeros(NTAZ, 1);
        else
            sim_target_time_queue_volumn = full_data(:, target_time_index);
        end
        if length(sim_target_time_queue_volumn) ~= NTAZ 
            errodlg('The Num. of TAZ is not right.', 'Error')
            return
        end
        close_other_figurs()
        max_value = max(sim_target_time_queue_volumn);
        min_value = min(sim_target_time_queue_volumn);
        Y = sim_target_time_queue_volumn;
        color_generate_userdata = struct();
        color_generate_userdata.name = 'Sim queue volumn at certain time';
        color_generate_userdata.Y = Y;
        set_color = figure('Name' , 'Set Color Map' , 'NumberTitle' , 'off',...
            'Position', [500 400 800 300], 'Color', 'w', 'Unit', 'normalized',...
            'Menubar', 'none');
        color_generate = uicontrol('parent', set_color, 'style', 'pushbutton',...
            'String', 'Generate Classes', 'unit', 'normalized', 'position',...
            [.47, .85, .16, .1], 'fontsize', 10, 'value', 2,...
            'callback', @color_generate_callback,...
            'userdata', color_generate_userdata);     %不得不设userdata，以知道画的什么图
        color_class_method = uicontrol('parent', set_color, 'style', 'popupmenu',...
            'String', {'Equal Interval', 'Quantile'}, ...
            'unit', 'normalized', 'position',[.29, .85, .13, .1],...
             'backgroundcolor', 'w', 'fontsize', 10, 'value', 2,...
             'callback', @color_class_method_callback);
         %输入set_color句柄和辅助用的最大最小值，自动布局
        set_color_layout(set_color, min_value, max_value);
        set_color_all_ok = uicontrol('parent', set_color, 'style', 'pushbutton', ...
            'string', 'OK', 'fontsize', 10, 'unit', 'normalized', 'position',...
            [.8, .05, .15, .15], 'callback', @color_map_ok_tranferdata_general);    %采用通用传输函数
        color_map_ok_userdata.Y = Y;
        color_map_ok_userdata.target_time = target_time;
        color_map_ok_userdata.type = 'Sim queue volumn at certain time';
        set(set_color_all_ok, 'userdata', color_map_ok_userdata);       %关键：用userdata传递数据
        class_num = 5;
        color_ramp_name = '*RdYlGn';
        value_cut = quantile(Y, linspace(0,1,class_num+1));
        set_color_initializatoin(set_color, class_num, color_ramp_name, value_cut);
        
        
        
         %-----------------------%
    case 10                      %模拟排队时间分布，色图：分时段
        if ~isfield(handles, 'timely_taz_queue_time_result')
            errordlg('There is NO queue time simulation result.', 'Error')
            return
        else
            timely_taz_queue_time_result = handles.timely_taz_queue_time_result;
        end
        full_data = timely_taz_queue_time_result.mean;
        time_intv_stat = timely_taz_queue_time_result.time_stat_intv_origin;
        [target_time, ok_flag] = input_one_time();
        if ok_flag == 0
            return
        end
        target_time_index = find(time_intv_stat == target_time);
        if isempty(target_time_index)
            sim_target_time_queue_time = zeros(NTAZ, 1);
        else
            sim_target_time_queue_time = full_data(:, target_time_index);
        end
        if length(sim_target_time_queue_time) ~= NTAZ 
            errodlg('The Num. of TAZ is not right.', 'Error')
            return
        end
        close_other_figurs()
        max_value = max(sim_target_time_queue_time);
        min_value = min(sim_target_time_queue_time);
        Y = sim_target_time_queue_time;
        color_generate_userdata = struct();
        color_generate_userdata.name = 'Sim queue time at certain time';
        color_generate_userdata.Y = Y;
        set_color = figure('Name' , 'Set Color Map' , 'NumberTitle' , 'off',...
            'Position', [500 400 800 300], 'Color', 'w', 'Unit', 'normalized',...
            'Menubar', 'none');
        color_generate = uicontrol('parent', set_color, 'style', 'pushbutton',...
            'String', 'Generate Classes', 'unit', 'normalized', 'position',...
            [.47, .85, .16, .1], 'fontsize', 10, 'value', 2,...
            'callback', @color_generate_callback,...
            'userdata', color_generate_userdata);     %不得不设userdata，以知道画的什么图
        color_class_method = uicontrol('parent', set_color, 'style', 'popupmenu',...
            'String', {'Equal Interval', 'Quantile'}, ...
            'unit', 'normalized', 'position',[.29, .85, .13, .1],...
             'backgroundcolor', 'w', 'fontsize', 10, 'value', 2,...
             'callback', @color_class_method_callback);
         %输入set_color句柄和辅助用的最大最小值，自动布局
        set_color_layout(set_color, min_value, max_value);
        set_color_all_ok = uicontrol('parent', set_color, 'style', 'pushbutton', ...
            'string', 'OK', 'fontsize', 10, 'unit', 'normalized', 'position',...
            [.8, .05, .15, .15], 'callback', @color_map_ok_tranferdata_general);    %采用通用传输函数
        color_map_ok_userdata.Y = Y;
        color_map_ok_userdata.target_time = target_time;
        color_map_ok_userdata.type = 'Sim queue time at certain time';
        set(set_color_all_ok, 'userdata', color_map_ok_userdata);       %关键：用userdata传递数据
        class_num = 5;
        color_ramp_name = '*RdYlGn';
        value_cut = quantile(Y, linspace(0,1,class_num+1));
        set_color_initializatoin(set_color, class_num, color_ramp_name, value_cut);
        
        
        
         %-----------------------%
    case 11                     %底图+OD分布(本次模拟)
        if isfield(handles, 'Sim_mean_OD')
            Sim_mean_OD = handles.Sim_mean_OD;
        else
            errordlg('There is NO valid simulation OD matrix.')
            return
        end
        if isfield(handles, 'od_abs_mode')          %是相对还是绝对模式
            od_abs_mode = handles.od_abs_mode;
        else
            od_abs_mode = 0;                        %如果没动过菜单，即默认为相对模式
        end
        if ~isfield(handles, 'od_t')
            od_t = 1;
        else
            od_t = handles.od_t;
        end
        %首先是底图
        xyz(:,4) = xyz(:,4) * Z_factor;             %竖向拉开
        unique_XYZ = unique(xyz(: , 1));
        for i = 1 : size(unique_XYZ)
            crtTAZindex = unique_XYZ(i);
            index = find(xyz(:,1) == crtTAZindex);
            hold on
            patch(xyz(index,2) , xyz(index,3) , xyz(index,4) , [0.8,0.8,0.8])
        end
        if isfield(handles , 'Ent_ON')  & isfield(handles , 'ENTXYZ')
            if handles.Ent_ON == 1
                entxyz = handles.ENTXYZ;
                entxyz = entxyz(:, 2:4);
                entxyz(:,3) = entxyz(:,3) * Z_factor;
                h_ent = plot3(entxyz(: , 1), entxyz(:, 2), entxyz(:, 3), 'kp','MarkerFacecolor', 'k');
                handles.h_ent = h_ent;
            end
        end
        set(gcf,'color','w')
        axis equal
        axis off
        alpha(0.5)
        az = handles.az;
        el = handles.el;
        view(az,el)
        %然后是数据
        if od_abs_mode == 0             %相对模式
            h_OD_Sim  = WDplotDesLine_GUI( Sim_mean_OD, xyz, od_t, 2 );
        elseif od_abs_mode == 1         %绝对模式
            od_abs_mode_max = handles.od_abs_mode_max;
            od_abs_mode_min = handles.od_abs_mode_min;
            h_OD_Sim  = WDplotDesLine_ABS_GUI( Sim_mean_OD, xyz, od_abs_mode_max , od_abs_mode_min, 2 );
        end
        rotate3d on
        
            %-----------------------%
    case 12                     %模拟总消费额统计，色图： 2016-3-16
        if isfield(handles, 'Sim_result_money')
            Sim_result_money = handles.Sim_result_money;
            for k = 1 : length(Sim_result_money)
                Sim_result_money_all(:,k) = Sim_result_money(k).taz(:,4);
            end
            Sim_result_money_mean = mean(Sim_result_money_all, 2);
        else
            errordlg('There is NO valid simulation expenditure distribution.', 'Error')
            return
        end
        % % % % 色彩选择 % % % %
        all_figs = findall(0, 'type', 'figure');
        for af_i = 1 : length(all_figs)
            crt_fig_in_all_figs = all_figs(af_i);
            if ~isequal(get(crt_fig_in_all_figs, 'tag') , 'figure1')
                delete(crt_fig_in_all_figs)
            end
        end
        max_value = max(Sim_result_money_mean);
        min_value = min(Sim_result_money_mean);
        Y = Sim_result_money_mean;
        color_generate_userdata = struct();
        color_generate_userdata.name = 'Sim expenditure';
        color_generate_userdata.Y = Y;
        set_color = figure('Name' , 'Set Color Map' , 'NumberTitle' , 'off',...
            'Position', [500 400 800 300], 'Color', 'w', 'Unit', 'normalized',...
            'Menubar', 'none');
        color_generate = uicontrol('parent', set_color, 'style', 'pushbutton',...
            'String', 'Generate Classes', 'unit', 'normalized', 'position',...
            [.47, .85, .16, .1], 'fontsize', 10, 'value', 2,...
            'callback', @color_generate_callback,...
            'userdata', color_generate_userdata);     %不得不设userdata，以知道画的什么图
        color_class_method = uicontrol('parent', set_color, 'style', 'popupmenu',...
            'String', {'Equal Interval', 'Quantile'}, ...
            'unit', 'normalized', 'position',[.29, .85, .13, .1],...
             'backgroundcolor', 'w', 'fontsize', 10, 'value', 2,...
             'callback', @color_class_method_callback);
        %输入set_color句柄和辅助用的最大最小值，自动布局
        set_color_layout(set_color, min_value, max_value);
        % 前面的都可以通用，但是OK键不一样，要根据画的图不同而设置不同的callback
        set_color_all_ok = uicontrol('parent', set_color, 'style', 'pushbutton', ...
            'string', 'OK', 'fontsize', 10, 'unit', 'normalized', 'position',...
            [.8, .05, .15, .15], 'callback', @color_map_ok_sim_expenditure_no_time);
        %初始化
        %默认class_method = 3 class_num = 5
        class_num = 5;
        color_ramp_name = 'Reds';
        value_cut = quantile(Sim_result_money_mean, linspace(0,1,class_num+1));
        set_color_initializatoin(set_color, class_num, color_ramp_name, value_cut);
        
        
        %-----------------------%
    case 13                     %底图+空间分布（对比）
        if isfield(handles, 'Comp_ON')
            if handles.Comp_ON == 0
                errordlg('You should firstly check ON the comparison check-box')
                return
            end
        end
        if isfield(handles, 'Comp_TAZ_distrib')
            Comp_TAZ_distrib = handles.Comp_TAZ_distrib;
        else
            errordlg('There is NO valid comparison TAZ distribution.')
            return
        end
        %首先是底图
        xyz(:,4) = xyz(:,4) * Z_factor;             %竖向拉开
        unique_XYZ = unique(xyz(: , 1));
        for i = 1 : size(unique_XYZ)
            crtTAZindex = unique_XYZ(i);
            index = find(xyz(:,1) == crtTAZindex);
            hold on
            patch(xyz(index,2) , xyz(index,3) , xyz(index,4) , [0.8,0.8,0.8])
        end
        if isfield(handles , 'Ent_ON')  & isfield(handles , 'ENTXYZ')
            if handles.Ent_ON == 1
                entxyz = handles.ENTXYZ;
                entxyz = entxyz(:, 2:4);
                entxyz(:,3) = entxyz(:,3) * Z_factor;
                h_ent = plot3(entxyz(: , 1), entxyz(:, 2), entxyz(:, 3), 'kp','MarkerFacecolor', 'k');
                handles.h_ent = h_ent;
            end
        end
        set(gcf,'color','w')
        axis equal
        axis off
        alpha(0.5)
        az = handles.az;
        el = handles.el;
        view(az,el)
        %然后是数据
        h_TAZ_distrib_Comp  = WDplotTAZ_GUI( round(Comp_TAZ_distrib), xyz, 1, marker_size );
        rotate3d on

        
                %-----------------------%
    case 14                      %底图+空间分布（对比/实际）：分时段
        if ~isfield(handles, 'comp_timely_taz_stat_result') & ~isfield(handles, 'space_time_path_rawdata')
            errordlg('There is NO spatiotemporal comparison result.', 'Error')
            return
        elseif ~isfield(handles, 'comp_timely_taz_stat_result') & isfield(handles, 'space_time_path_rawdata')
            errordlg(['There is NO spatiotemporal comparison result, but spatiotemporal ',...
                'path data exists, you can check ''Data'' - ''Input Comparison Data'' -',...
                ' ''Load TAZ Spatiotemporal Distribtuion'' to estimate comparison result'], 'Error')
            return
        else
            comp_timely_taz_stat_result = handles.comp_timely_taz_stat_result;
        end
        full_data = comp_timely_taz_stat_result.data;
        time_intv_stat = comp_timely_taz_stat_result.time_stat_intv_origin;
        [target_time, ok_flag] = input_one_time();
        if ok_flag == 0
            return
        end
        target_time_index = find(time_intv_stat == target_time);
        if isempty(target_time_index)
            comp_target_time_space_distr = zeros(NTAZ, 1);
        else
            comp_target_time_space_distr = full_data(:, target_time_index);
        end
        if length(comp_target_time_space_distr) ~= NTAZ
            errodlg('The Num. of TAZ is not right.', 'Error')
            return
        end
        %首先是底图
        xyz(:,4) = xyz(:,4) * Z_factor;             %竖向拉开
        unique_XYZ = unique(xyz(: , 1));
        for i = 1 : size(unique_XYZ)
            crtTAZindex = unique_XYZ(i);
            index = find(xyz(:,1) == crtTAZindex);
            hold on
            patch(xyz(index,2) , xyz(index,3) , xyz(index,4) , [0.8,0.8,0.8])
        end
        if isfield(handles , 'Ent_ON')  & isfield(handles , 'ENTXYZ')
            if handles.Ent_ON == 1
                entxyz = handles.ENTXYZ;
                entxyz = entxyz(:, 2:4);
                entxyz(:,3) = entxyz(:,3) * Z_factor;
                h_ent = plot3(entxyz(: , 1), entxyz(:, 2), entxyz(:, 3), 'kp','MarkerFacecolor', 'k');
                handles.h_ent = h_ent;
            end
        end
        set(gcf,'color','w')
        axis equal
        axis off
        alpha(0.5)
        az = handles.az;
        el = handles.el;
        view(az,el)
        %然后是数据
        h_TAZ_distrib_Comp  = WDplotTAZ_GUI( round(comp_target_time_space_distr), xyz, 1, marker_size );
        %加时间标题
        ax = handles.axes1;
        t = add_time_title(ax, target_time, xyz)
        rotate3d on
        
        %-----------------------%
    case 15              %对比（实际）总人数统计，色图： 2016-3-16
        if isfield(handles, 'Comp_ON')
            if handles.Comp_ON == 0
                errordlg('You should firstly check ON the comparison check-box')
                return
            end
        end
        if isfield(handles, 'Comp_TAZ_distrib')
            Comp_TAZ_distrib = handles.Comp_TAZ_distrib;
        else
            errordlg('There is NO valid comparison TAZ distribution.')
            return
        end
        % % % % 色彩选择 % % % %
        all_figs = findall(0, 'type', 'figure');
        for af_i = 1 : length(all_figs)
            crt_fig_in_all_figs = all_figs(af_i);
            if ~isequal(get(crt_fig_in_all_figs, 'tag') , 'figure1')
                delete(crt_fig_in_all_figs)
            end
        end
        max_value = max(Comp_TAZ_distrib);
        min_value = min(Comp_TAZ_distrib);
        Y = Comp_TAZ_distrib;
        color_generate_userdata = struct();
        color_generate_userdata.name = 'Comp total amount';
        color_generate_userdata.Y = Y;
        set_color = figure('Name' , 'Set Color Map' , 'NumberTitle' , 'off',...
            'Position', [500 400 800 300], 'Color', 'w', 'Unit', 'normalized',...
            'Menubar', 'none');
        color_generate = uicontrol('parent', set_color, 'style', 'pushbutton',...
            'String', 'Generate Classes', 'unit', 'normalized', 'position',...
            [.47, .85, .16, .1], 'fontsize', 10, 'value', 2,...
            'callback', @color_generate_callback,...
            'userdata', color_generate_userdata);     %不得不设userdata，以知道画的什么图
        color_class_method = uicontrol('parent', set_color, 'style', 'popupmenu',...
            'String', {'Equal Interval', 'Quantile'}, 'unit', 'normalized', 'position',...
            [.29, .85, .13, .1], 'backgroundcolor', 'w', 'fontsize', 10, 'value', 2,...
            'callback', @color_class_method_callback);
        %输入set_color句柄和辅助用的最大最小值，自动布局
        set_color_layout(set_color, min_value, max_value);
        % 前面的都可以通用，但是OK键不一样，要根据画的图不同而设置不同的callback
        set_color_all_ok = uicontrol('parent', set_color, 'style', 'pushbutton', ...
            'string', 'OK', 'fontsize', 10, 'unit', 'normalized', 'position',...
            [.8, .05, .15, .15], 'callback', @color_map_ok_comp_total_amount_no_time);
        %初始化
        crt_handles = guidata(set_color);
        %清除可能残留的历史记录
        if isfield(crt_handles, 'color_ramp_name')
            crt_handles = rmfield(crt_handles, 'color_ramp_name');
        end
        if isfield(crt_handles, 'color_ramp_disp');
            crt_handles = rmfield(crt_handles, 'color_ramp_disp')
        end
        if isfield(crt_handles, 'value_cut_disp')
            crt_handles = rmfield(crt_handles, 'value_cut_disp')
        end
        %与上面的max/min_value是一样的，懒得改了
        max_amount = max(Comp_TAZ_distrib);
        min_amount = min(Comp_TAZ_distrib);
        %默认class_method = 2 class_num = 5
        class_num = 5;
        color_ramp_name = 'Blues';
        value_cut = quantile(Comp_TAZ_distrib, linspace(0,1,class_num+1));
        text_place_cut = linspace(.03, .91, class_num+1);
        for k = 1 : class_num
            color_place_cut = linspace(.05, .95, class_num+1);
        end
        color_rgb = brewermap(class_num, color_ramp_name);
        %生成色带显示
        color_ramp_disp = cell(0);
        for k = 1 : class_num
            color_ramp_disp{k} = uicontrol('parent', set_color, 'unit', 'normalized',...
                'style', 'pushbutton', 'position', ...
                [color_place_cut(k), .4, color_place_cut(k+1)-color_place_cut(k), .35],...
                'backgroundcolor', color_rgb(k,:), 'string', '', 'callback', @color_ramp_disp_callback,...
                'userdata', color_rgb(k,:));
        end
        %生成值文本框
        for k = 1 : class_num+1
            value_cut_disp{k} = uicontrol('parent', set_color, 'unit', 'normalized',...
                'style', 'edit', 'position', [text_place_cut(k), .27, .06, .12],...
                'backgroundcolor', 'w', 'string', num2str(value_cut(k)), ...
                'callback', @value_cut_disp_callback,...
                'userdata', value_cut(k),'fontsize', 10);
        end
        crt_handles.color_ramp_disp = color_ramp_disp;
        crt_handles.value_cut_disp = value_cut_disp;
        crt_handles.color_ramp_name = color_ramp_name;
        guidata(set_color, crt_handles);
        
        
                    %-----------------------%
    case 16                      %实际总人数统计，色图：分时段
        if ~isfield(handles, 'comp_timely_taz_stat_result') & ~isfield(handles, 'space_time_path_rawdata')
            errordlg('There is NO spatiotemporal comparison result.', 'Error')
            return
        elseif ~isfield(handles, 'comp_timely_taz_stat_result') & isfield(handles, 'space_time_path_rawdata')
            errordlg(['There is NO spatiotemporal comparison result, but spatiotemporal ',...
                'path data exists, you can check ''Data'' - ''Input Comparison Data'' -',...
                ' ''Load TAZ Spatiotemporal Distribtuion'' to estimate comparison result'], 'Error')
            return
        else
            comp_timely_taz_stat_result = handles.comp_timely_taz_stat_result;
        end
        full_data = comp_timely_taz_stat_result.data;
        time_intv_stat = comp_timely_taz_stat_result.time_stat_intv_origin;
        [target_time, ok_flag] = input_one_time();
        if ok_flag == 0
            return
        end
        target_time_index = find(time_intv_stat == target_time);
        if isempty(target_time_index)
            comp_target_time_space_distr = zeros(NTAZ, 1);
        else
            comp_target_time_space_distr = full_data(:, target_time_index);
        end
        if length(comp_target_time_space_distr) ~= NTAZ
            errodlg('The Num. of TAZ is not right.', 'Error')
            return
        end
        close_other_figurs()
        max_value = max(comp_target_time_space_distr);
        min_value = min(comp_target_time_space_distr);
        Y = comp_target_time_space_distr;
        color_generate_userdata = struct();
        color_generate_userdata.name = 'Comp total amount at certain time';
        color_generate_userdata.Y = Y;
        set_color = figure('Name' , 'Set Color Map' , 'NumberTitle' , 'off',...
            'Position', [500 400 800 300], 'Color', 'w', 'Unit', 'normalized',...
            'Menubar', 'none');
        color_generate = uicontrol('parent', set_color, 'style', 'pushbutton',...
            'String', 'Generate Classes', 'unit', 'normalized', 'position',...
            [.47, .85, .16, .1], 'fontsize', 10, 'value', 2,...
            'callback', @color_generate_callback,...
            'userdata', color_generate_userdata);     %不得不设userdata，以知道画的什么图
        color_class_method = uicontrol('parent', set_color, 'style', 'popupmenu',...
            'String', {'Equal Interval', 'Quantile'}, ...
            'unit', 'normalized', 'position',[.29, .85, .13, .1],...
             'backgroundcolor', 'w', 'fontsize', 10, 'value', 2,...
             'callback', @color_class_method_callback);
          %输入set_color句柄和辅助用的最大最小值，自动布局
        set_color_layout(set_color, min_value, max_value);
        set_color_all_ok = uicontrol('parent', set_color, 'style', 'pushbutton', ...
            'string', 'OK', 'fontsize', 10, 'unit', 'normalized', 'position',...
            [.8, .05, .15, .15], 'callback', @color_map_ok_tranferdata_general);    %采用通用传输函数
        color_map_ok_userdata.Y = Y;
        color_map_ok_userdata.target_time = target_time;
        color_map_ok_userdata.type = 'Comp total amount at certain time';
        set(set_color_all_ok, 'userdata', color_map_ok_userdata);       %关键：用userdata传递数据
        class_num = 5;
        color_ramp_name = 'Blues';
        value_cut = quantile(Y, linspace(0,1,class_num+1));
        set_color_initializatoin(set_color, class_num, color_ramp_name, value_cut);
        
        
        %-----------------------%
    case 17                     %对比（实际）密度统计，色图： 2016-3-16
        if isfield(handles, 'Comp_ON')
            if handles.Comp_ON == 0
                errordlg('You should firstly check ON the comparison check-box')
                return
            end
        end
        if isfield(handles, 'Comp_TAZ_distrib')
            Comp_TAZ_distrib = handles.Comp_TAZ_distrib;
        else
            errordlg('There is NO valid comparison TAZ distribution.')
            return
        end
        if isfield(handles, 'base_area')
            base_area = handles.base_area;
        else
            errordlg('There is NO base area data', 'Error')
            return
        end
        Comp_density = Comp_TAZ_distrib ./ base_area;
        % % % % 色彩选择 % % % %
        all_figs = findall(0, 'type', 'figure');
        for af_i = 1 : length(all_figs)
            crt_fig_in_all_figs = all_figs(af_i);
            if ~isequal(get(crt_fig_in_all_figs, 'tag') , 'figure1')
                delete(crt_fig_in_all_figs)
            end
        end
        max_value = max(Comp_density);
        min_value = min(Comp_density);
        Y = Comp_density;
        color_generate_userdata = struct();
        color_generate_userdata.name = 'Comp density';
        color_generate_userdata.Y = Y;
        set_color = figure('Name' , 'Set Color Map' , 'NumberTitle' , 'off',...
            'Position', [500 400 800 300], 'Color', 'w', 'Unit', 'normalized',...
            'Menubar', 'none');
        color_generate = uicontrol('parent', set_color, 'style', 'pushbutton',...
            'String', 'Generate Classes', 'unit', 'normalized', 'position',...
            [.47, .85, .16, .1], 'fontsize', 10, 'value', 2,...
            'callback', @color_generate_callback,...
            'userdata', color_generate_userdata);     %不得不设userdata，以知道画的什么图
        color_class_method = uicontrol('parent', set_color, 'style', 'popupmenu',...
            'String', {'Equal Interval', 'Quantile', 'Default Cut-Off'}, ...
            'unit', 'normalized', 'position',[.29, .85, .13, .1],...
             'backgroundcolor', 'w', 'fontsize', 10, 'value', 2,...
             'callback', @color_class_method_callback);
        %输入set_color句柄和辅助用的最大最小值，自动布局
        set_color_layout(set_color, min_value, max_value);
        % 前面的都可以通用，但是OK键不一样，要根据画的图不同而设置不同的callback
        set_color_all_ok = uicontrol('parent', set_color, 'style', 'pushbutton', ...
            'string', 'OK', 'fontsize', 10, 'unit', 'normalized', 'position',...
            [.8, .05, .15, .15], 'callback', @color_map_ok_comp_density_no_time);
        %初始化
        %默认class_method = 3 class_num = 5
        class_num = 5;
        color_ramp_name = '*RdYlGn';
        value_cut = quantile(Comp_density, linspace(0,1,class_num+1));
        set_color_initializatoin(set_color, class_num, color_ramp_name, value_cut);

       
                        %-----------------------%
    case 18                      %实际密度分布，色图：分时段
        if ~isfield(handles, 'comp_timely_taz_stat_result') & ~isfield(handles, 'space_time_path_rawdata')
            errordlg('There is NO spatiotemporal comparison result.', 'Error')
            return
        elseif ~isfield(handles, 'comp_timely_taz_stat_result') & isfield(handles, 'space_time_path_rawdata')
            errordlg(['There is NO spatiotemporal comparison result, but spatiotemporal ',...
                'path data exists, you can check ''Data'' - ''Input Comparison Data'' -',...
                ' ''Load TAZ Spatiotemporal Distribtuion'' to estimate comparison result'], 'Error')
            return
        else
            comp_timely_taz_stat_result = handles.comp_timely_taz_stat_result;
        end
        if ~isfield(handles, 'base_area')
            errordlg('There is NO base area data.', 'Error')
            return
        else
            base_area = handles.base_area;
        end
        full_data = comp_timely_taz_stat_result.data;
        time_intv_stat = comp_timely_taz_stat_result.time_stat_intv_origin;
        [target_time, ok_flag] = input_one_time();
        if ok_flag == 0
            return
        end
        target_time_index = find(time_intv_stat == target_time);
        if isempty(target_time_index)
            comp_target_time_space_distr = zeros(NTAZ, 1);
        else
            comp_target_time_space_distr = full_data(:, target_time_index);
        end
        if length(comp_target_time_space_distr) ~= NTAZ | length(base_area) ~= NTAZ
            errodlg('The Num. of TAZ is not right.', 'Error')
            return
        end
        comp_target_time_denisty_distr = comp_target_time_space_distr ./ base_area;
        close_other_figurs()
        max_value = max(comp_target_time_denisty_distr);
        min_value = min(comp_target_time_denisty_distr);
        Y = comp_target_time_denisty_distr;
        color_generate_userdata = struct();
        color_generate_userdata.name = 'Comp density at certain time';
        color_generate_userdata.Y = Y;
        set_color = figure('Name' , 'Set Color Map' , 'NumberTitle' , 'off',...
            'Position', [500 400 800 300], 'Color', 'w', 'Unit', 'normalized',...
            'Menubar', 'none');
        color_generate = uicontrol('parent', set_color, 'style', 'pushbutton',...
            'String', 'Generate Classes', 'unit', 'normalized', 'position',...
            [.47, .85, .16, .1], 'fontsize', 10, 'value', 2,...
            'callback', @color_generate_callback,...
            'userdata', color_generate_userdata);     %不得不设userdata，以知道画的什么图
        color_class_method = uicontrol('parent', set_color, 'style', 'popupmenu',...
            'String', {'Equal Interval', 'Quantile', 'Default Cut-Off'}, ...
            'unit', 'normalized', 'position',[.29, .85, .13, .1],...
             'backgroundcolor', 'w', 'fontsize', 10, 'value', 3,...
             'callback', @color_class_method_callback);
          %输入set_color句柄和辅助用的最大最小值，自动布局
        set_color_layout(set_color, min_value, max_value);
        set_color_all_ok = uicontrol('parent', set_color, 'style', 'pushbutton', ...
            'string', 'OK', 'fontsize', 10, 'unit', 'normalized', 'position',...
            [.8, .05, .15, .15], 'callback', @color_map_ok_tranferdata_general);    %采用通用传输函数
        color_map_ok_userdata.Y = Y;
        color_map_ok_userdata.target_time = target_time;
        color_map_ok_userdata.type = 'Comp density at certain time';
        set(set_color_all_ok, 'userdata', color_map_ok_userdata);       %关键：用userdata传递数据
        class_num = 5;
        color_ramp_name = '*RdYlGn';
        value_cut = [0 .3 .5 .7 .9 Inf];
        set_color_initializatoin(set_color, class_num, color_ramp_name, value_cut);
         
        
         %-----------------------%
    case 19                      %对比/实际排队人数分布，色图：分时段
        if ~isfield(handles, 'comp_timely_taz_queue_population_result') 
            errordlg('There is NO queue volumn comparison result.', 'Error')
            return
        else
            comp_timely_taz_queue_population_result = handles.comp_timely_taz_queue_population_result;
        end
        full_data = comp_timely_taz_queue_population_result.data;
        time_intv_stat = comp_timely_taz_queue_population_result.time_stat_intv_origin;
        [target_time, ok_flag] = input_one_time();
        if ok_flag == 0
            return
        end
        target_time_index = find(time_intv_stat == target_time);
        if isempty(target_time_index)
            comp_target_time_queue_volumn_distr = zeros(NTAZ, 1);
        else
            comp_target_time_queue_volumn_distr = full_data(:, target_time_index);
        end
        if length(comp_target_time_queue_volumn_distr) ~= NTAZ
            errodlg('The Num. of TAZ is not right.', 'Error')
            return
        end
        close_other_figurs()
        max_value = max(comp_target_time_queue_volumn_distr);
        min_value = min(comp_target_time_queue_volumn_distr);
        Y = comp_target_time_queue_volumn_distr;
        color_generate_userdata = struct();
        color_generate_userdata.name = 'Comp queue volumn at certain time';
        color_generate_userdata.Y = Y;
        set_color = figure('Name' , 'Set Color Map' , 'NumberTitle' , 'off',...
            'Position', [500 400 800 300], 'Color', 'w', 'Unit', 'normalized',...
            'Menubar', 'none');
        color_generate = uicontrol('parent', set_color, 'style', 'pushbutton',...
            'String', 'Generate Classes', 'unit', 'normalized', 'position',...
            [.47, .85, .16, .1], 'fontsize', 10, 'value', 2,...
            'callback', @color_generate_callback,...
            'userdata', color_generate_userdata);     %不得不设userdata，以知道画的什么图
        color_class_method = uicontrol('parent', set_color, 'style', 'popupmenu',...
            'String', {'Equal Interval', 'Quantile'}, ...
            'unit', 'normalized', 'position',[.29, .85, .13, .1],...
             'backgroundcolor', 'w', 'fontsize', 10, 'value', 2,...
             'callback', @color_class_method_callback);
         %输入set_color句柄和辅助用的最大最小值，自动布局
        set_color_layout(set_color, min_value, max_value);
        set_color_all_ok = uicontrol('parent', set_color, 'style', 'pushbutton', ...
            'string', 'OK', 'fontsize', 10, 'unit', 'normalized', 'position',...
            [.8, .05, .15, .15], 'callback', @color_map_ok_tranferdata_general);    %采用通用传输函数
        color_map_ok_userdata.Y = Y;
        color_map_ok_userdata.target_time = target_time;
        color_map_ok_userdata.type = 'Comp queue volumn at certain time';
        set(set_color_all_ok, 'userdata', color_map_ok_userdata);       %关键：用userdata传递数据
        class_num = 5;
        color_ramp_name = '*RdYlGn';
        value_cut = quantile(Y, linspace(0,1,class_num+1));
        set_color_initializatoin(set_color, class_num, color_ramp_name, value_cut);
        
        
        
         %-----------------------%
    case 20                      %对比/实际排队时间分布，色图：分时段
        if ~isfield(handles, 'comp_timely_taz_queue_time_result') 
            errordlg('There is NO queue time comparison result.', 'Error')
            return
        else
            comp_timely_taz_queue_time_result = handles.comp_timely_taz_queue_time_result;
        end
        full_data = comp_timely_taz_queue_time_result.data;
        time_intv_stat = comp_timely_taz_queue_time_result.time_stat_intv_origin;
        [target_time, ok_flag] = input_one_time();
        if ok_flag == 0
            return
        end
        target_time_index = find(time_intv_stat == target_time);
        if isempty(target_time_index)
            comp_target_time_queue_time_distr = zeros(NTAZ, 1);
        else
            comp_target_time_queue_time_distr = full_data(:, target_time_index);
        end
        if length(comp_target_time_queue_time_distr) ~= NTAZ
            errodlg('The Num. of TAZ is not right.', 'Error')
            return
        end
        close_other_figurs()
        max_value = max(comp_target_time_queue_time_distr);
        min_value = min(comp_target_time_queue_time_distr);
        Y = comp_target_time_queue_time_distr;
        color_generate_userdata = struct();
        color_generate_userdata.name = 'Comp queue time at certain time';
        color_generate_userdata.Y = Y;
        set_color = figure('Name' , 'Set Color Map' , 'NumberTitle' , 'off',...
            'Position', [500 400 800 300], 'Color', 'w', 'Unit', 'normalized',...
            'Menubar', 'none');
        color_generate = uicontrol('parent', set_color, 'style', 'pushbutton',...
            'String', 'Generate Classes', 'unit', 'normalized', 'position',...
            [.47, .85, .16, .1], 'fontsize', 10, 'value', 2,...
            'callback', @color_generate_callback,...
            'userdata', color_generate_userdata);     %不得不设userdata，以知道画的什么图
        color_class_method = uicontrol('parent', set_color, 'style', 'popupmenu',...
            'String', {'Equal Interval', 'Quantile'}, ...
            'unit', 'normalized', 'position',[.29, .85, .13, .1],...
             'backgroundcolor', 'w', 'fontsize', 10, 'value', 2,...
             'callback', @color_class_method_callback);
         %输入set_color句柄和辅助用的最大最小值，自动布局
        set_color_layout(set_color, min_value, max_value);
        set_color_all_ok = uicontrol('parent', set_color, 'style', 'pushbutton', ...
            'string', 'OK', 'fontsize', 10, 'unit', 'normalized', 'position',...
            [.8, .05, .15, .15], 'callback', @color_map_ok_tranferdata_general);    %采用通用传输函数
        color_map_ok_userdata.Y = Y;
        color_map_ok_userdata.target_time = target_time;
        color_map_ok_userdata.type = 'Comp queue time at certain time';
        set(set_color_all_ok, 'userdata', color_map_ok_userdata);       %关键：用userdata传递数据
        class_num = 5;
        color_ramp_name = '*RdYlGn';
        value_cut = quantile(Y, linspace(0,1,class_num+1));
        set_color_initializatoin(set_color, class_num, color_ramp_name, value_cut);
        
        
        
        %-----------------------%
    case 21                  %底图+OD（对比）
        if isfield(handles, 'Comp_ON')
            if handles.Comp_ON == 0
                errordlg('You should firstly check ON the comparison check-box')
                return
            end
        end
        if isfield(handles, 'Comp_OD')
            Comp_OD = handles.Comp_OD;
        else
            errordlg('There is NO valid comparison OD matrix.')
            return
        end
        if isfield(handles, 'od_abs_mode')          %是相对还是绝对模式
            od_abs_mode = handles.od_abs_mode;
        else
            od_abs_mode = 0;                        %如果没动过菜单，即默认为相对模式
        end
        
        if ~isfield(handles, 'od_t')
            od_t = 1;
        else
            od_t = handles.od_t;
        end
        %首先是底图
        xyz(:,4) = xyz(:,4) * Z_factor;             %竖向拉开
        unique_XYZ = unique(xyz(: , 1));
        for i = 1 : size(unique_XYZ)
            crtTAZindex = unique_XYZ(i);
            index = find(xyz(:,1) == crtTAZindex);
            hold on
            patch(xyz(index,2) , xyz(index,3) , xyz(index,4) , [0.8,0.8,0.8])
        end
        if isfield(handles , 'Ent_ON')  & isfield(handles , 'ENTXYZ')
            if handles.Ent_ON == 1
                entxyz = handles.ENTXYZ;
                entxyz = entxyz(:, 2:4);
                entxyz(:,3) = entxyz(:,3) * Z_factor;
                h_ent = plot3(entxyz(: , 1), entxyz(:, 2), entxyz(:, 3), 'kp','MarkerFacecolor', 'k');
                handles.h_ent = h_ent;
            end
        end
        set(gcf,'color','w')
        axis equal
        axis off
        alpha(0.5)
        az = handles.az;
        el = handles.el;
        view(az,el)
        %然后是数据
        if od_abs_mode == 0             %相对模式
            h_OD_Comp  = WDplotDesLine_GUI( Comp_OD, xyz, od_t, 1);
        elseif od_abs_mode == 1         %绝对模式
            od_abs_mode_max = handles.od_abs_mode_max;
            od_abs_mode_min = handles.od_abs_mode_min;
            h_OD_Comp  = WDplotDesLine_ABS_GUI( Comp_OD, xyz, od_abs_mode_max , od_abs_mode_min, 1 );
        end
        rotate3d on
        
        
             %-----------------------%
    case 22                     %实际总消费额统计，色图： 2016-3-18
        if isfield(handles, 'comp_expenditure_distr')
            comp_expenditure_distr = handles.comp_expenditure_distr;
        else
            errordlg('There is NO valid comparison expenditure distribution.', 'Error')
            return
        end
        % % % % 色彩选择 % % % %
        all_figs = findall(0, 'type', 'figure');
        for af_i = 1 : length(all_figs)
            crt_fig_in_all_figs = all_figs(af_i);
            if ~isequal(get(crt_fig_in_all_figs, 'tag') , 'figure1')
                delete(crt_fig_in_all_figs)
            end
        end
        max_value = max(comp_expenditure_distr);
        min_value = min(comp_expenditure_distr);
        Y = comp_expenditure_distr;
        color_generate_userdata = struct();
        color_generate_userdata.name = 'Comp expenditure';
        color_generate_userdata.Y = Y;
        set_color = figure('Name' , 'Set Color Map' , 'NumberTitle' , 'off',...
            'Position', [500 400 800 300], 'Color', 'w', 'Unit', 'normalized',...
            'Menubar', 'none');
        color_generate = uicontrol('parent', set_color, 'style', 'pushbutton',...
            'String', 'Generate Classes', 'unit', 'normalized', 'position',...
            [.47, .85, .16, .1], 'fontsize', 10, 'value', 2,...
            'callback', @color_generate_callback,...
            'userdata', color_generate_userdata);     %不得不设userdata，以知道画的什么图
        color_class_method = uicontrol('parent', set_color, 'style', 'popupmenu',...
            'String', {'Equal Interval', 'Quantile'}, ...
            'unit', 'normalized', 'position',[.29, .85, .13, .1],...
             'backgroundcolor', 'w', 'fontsize', 10, 'value', 2,...
             'callback', @color_class_method_callback);
        %输入set_color句柄和辅助用的最大最小值，自动布局
        set_color_layout(set_color, min_value, max_value);
        % 前面的都可以通用，但是OK键不一样，要根据画的图不同而设置不同的callback
        set_color_all_ok = uicontrol('parent', set_color, 'style', 'pushbutton', ...
            'string', 'OK', 'fontsize', 10, 'unit', 'normalized', 'position',...
            [.8, .05, .15, .15], 'callback', @color_map_ok_comp_expenditure_no_time);
        %初始化
        %默认class_method = 2 class_num = 5
        class_num = 5;
        color_ramp_name = 'Blues';
        value_cut = quantile(comp_expenditure_distr, linspace(0,1,class_num+1));
        set_color_initializatoin(set_color, class_num, color_ramp_name, value_cut);    
        
        
      
        
        %-----------------------%
    case 23
        helpdlg('Please choose a specific statistical plot item','Plot Item')
        
        %-----------------------%
    case 24                                  %人数分布洛伦兹曲线
        if isfield(handles, 'Comp_ON')
            Comp_ON = handles.Comp_ON;
        else
            Comp_ON = 1;
        end
        if isfield(handles, 'Legend_ON')
            Legend_ON = handles.Legend_ON;
        else
            Legend_ON = 1;
        end
        set(handles.axes1, 'Position', [0.05, 0.1, 0.55, 0.8]);
        if isfield(handles , 'Sim_mean_taz_distrib')
            Sim_mean_taz_distrib = handles.Sim_mean_taz_distrib;
        end
        if isfield(handles , 'Comp_TAZ_distrib') & Comp_ON == 1
            Comp_TAZ_distrib = handles.Comp_TAZ_distrib;
        end
        if (exist('Sim_mean_taz_distrib' , 'var')) & (~exist('Comp_TAZ_distrib' , 'var'))
            g_s = llz_gn_GUI(Sim_mean_taz_distrib , 1 , 2);
            xlabel('Percentage of TAZs','fontsize',13)
            ylabel('Percentage of Activities','fontsize',13)
            title('Lorenz Curve of Spatial Distribution','fontsize',20)
            legend('Simulation' , 'Absolute Equality', 'Location', 'northwest');
            if Legend_ON == 1
                legend show
            else
                legend hide
            end
            rotate3d off
        elseif (~exist('Sim_mean_taz_distrib' , 'var')) & (exist('Comp_TAZ_distrib' , 'var'))
            g_c = llz_gn_GUI(Comp_TAZ_distrib , 1 , 1);
            xlabel('Percentage of TAZs','fontsize',13)
            ylabel('Percentage of Activities','fontsize',13)
            title('Lorenz Curve of Spatial Distribution','fontsize',20)
            legend('Comparison' , 'Absolute Equality', 'Location', 'northwest');
            if Legend_ON == 1
                legend show
            else
                legend hide
            end
            rotate3d off
        elseif (exist('Sim_mean_taz_distrib' , 'var')) & (exist('Comp_TAZ_distrib' , 'var'))
            g_s = llz_gn_GUI(Sim_mean_taz_distrib , 1 , 2);
            g_c = llz_gn_GUI(Comp_TAZ_distrib , 2 , 1);
            xlabel('Percentage of TAZs','fontsize',13)
            ylabel('Percentage of Activities','fontsize',13)
            title('Lorenz Curve of Spatial Distribution','fontsize',20)
            legend('Simulation' , 'Absolute Equality', 'Comparison' , 'Location', 'northwest');
            if Legend_ON == 1
                legend show
            else
                legend hide
            end
            rotate3d off
        elseif (~exist('Sim_mean_taz_distrib' , 'var')) & (~exist('Comp_TAZ_distrib' , 'var'))
            errordlg('There is NEITHER valid simulation NOR comparison TAZ distribution data, or comparison check-box may not be checked on.', 'Plot Error')
            return
        end
        
        
        %-----------------------%
    case 25                                  %消费分布洛伦兹曲线
        if isfield(handles, 'Comp_ON')
            Comp_ON = handles.Comp_ON;
        else
            Comp_ON = 1;
        end
        if isfield(handles, 'Legend_ON')
            Legend_ON = handles.Legend_ON;
        else
            Legend_ON = 1;
        end
        set(handles.axes1, 'Position', [0.05, 0.1, 0.55, 0.8]);
        if isfield(handles , 'Sim_result_money')
            Sim_result_money = handles.Sim_result_money;
            for k = 1 : length(Sim_result_money)
                Sim_result_money_all(:,k) = Sim_result_money(k).taz(:,4);
            end
            Sim_mean_result_money = mean(Sim_result_money_all, 2);
        end
        if isfield(handles , 'comp_expenditure_distr') & Comp_ON == 1
            Comp_expenditure_distr = handles.comp_expenditure_distr;
        end
        if (exist('Sim_mean_result_money' , 'var')) & (~exist('Comp_expenditure_distr' , 'var'))
            g_s = llz_gn_GUI(Sim_mean_result_money , 1 , 2);
            xlabel('Percentage of TAZs','fontsize',13)
            ylabel('Percentage of Expenditure','fontsize',13)
            title('Lorenz Curve of Expenditure Distribution','fontsize',20)
            legend('Simulation' , 'Absolute Equality', 'Location', 'northwest');
            if Legend_ON == 1
                legend show
            else
                legend hide
            end
            rotate3d off
        elseif (~exist('Sim_mean_result_money' , 'var')) & (exist('Comp_expenditure_distr' , 'var'))
            g_c = llz_gn_GUI(Comp_expenditure_distr , 1 , 1);
            xlabel('Percentage of TAZs','fontsize',13)
            ylabel('Percentage of Expenditure','fontsize',13)
            title('Lorenz Curve of Expenditure Distribution','fontsize',20)
            legend('Comparison' , 'Absolute Equality', 'Location', 'northwest');
            if Legend_ON == 1
                legend show
            else
                legend hide
            end
            rotate3d off
        elseif (exist('Sim_mean_result_money' , 'var')) & (exist('Comp_expenditure_distr' , 'var'))
            g_s = llz_gn_GUI(Sim_mean_result_money , 1 , 2);
            g_c = llz_gn_GUI(Comp_expenditure_distr , 2 , 1);
            xlabel('Percentage of TAZs','fontsize',13)
            ylabel('Percentage of Expenditure','fontsize',13)
            title('Lorenz Curve of Expenditure Distribution','fontsize',20)
            legend('Simulation' , 'Absolute Equality', 'Comparison' , 'Location', 'northwest');
            if Legend_ON == 1
                legend show
            else
                legend hide
            end
            rotate3d off
        elseif (~exist('Sim_mean_result_money' , 'var')) & (~exist('Comp_expenditure_distr' , 'var'))
            errordlg('There is NEITHER valid simulation NOR comparison expenditure distribution data, or comparison check-box may not be checked on.', 'Plot Error')
            return
        end
        
        
         %-----------------------%
    case 26                      %特定TAZ的各种时变统计指标
        if ~isfield(handles, 'NTAZ')
            errordlg('You must firstly set the Num. of TAZs.' ,'Error')
            return
        else
            NTAZ = handles.NTAZ;
        end
        set(handles.axes1, 'Position', [0.05, 0.1, 0.55, 0.8]);
        ax= handles.axes1;
        if isfield(handles, 'Comp_ON')
            Comp_ON = handles.Comp_ON;
        else
            Comp_ON = 1;
        end
        if isfield(handles, 'dyn_rst_play_start_time')
            start_time = handles.dyn_rst_play_start_time;
        else
            start_time = 900;
        end
        if isfield(handles, 'dyn_rst_play_end_time')
            end_time = handles.dyn_rst_play_end_time;
        else
            end_time = 2300;
        end
        % %-----------------------以下：时间坐标轴------------------------%
        xtick_hours = 0:1:24;
        xtick_years = 1988 * ones(1 , size(xtick_hours,2));
        xtick_months = 2 * ones(1 , size(xtick_hours,2));
        xtick_days = 10 * ones(1 , size(xtick_hours,2));
        xtick_minutes = zeros(1,size(xtick_hours,2));
        xtick_seconds = zeros(1,size(xtick_hours,2));
        xtick_data = datenum(xtick_years,xtick_months,xtick_days,xtick_hours,xtick_minutes,xtick_seconds);
        for i=1:length(xtick_data)
            xtick_data_label{i} = datestr(xtick_data(i),'HH:MM');
        end
        % %-----------------------以上：时间坐标轴------------------------%
        sim_item_availabe = {};
        comp_item_availabe = {};
        if isfield(handles, 'timely_taz_stat_result')
            sim_item_availabe{end+1,1} = 'Total Amount of Individuals';
        end
        if isfield(handles, 'timely_taz_stat_result') & isfield(handles, 'base_area')
            sim_item_availabe{end+1,1} = 'Density';
        end
        if isfield(handles, 'timely_taz_queue_population_result')
            sim_item_availabe{end+1,1} = 'Queue Volume';
        end
        if isfield(handles, 'timely_taz_queue_time_result')
            sim_item_availabe{end+1,1} = 'Queue Time';
        end
        if isfield(handles, 'timely_taz_stat_result') & isfield(handles, 'timely_taz_queue_population_result')
            sim_item_availabe{end+1,1} = 'Total Amount of Individuals + Queue Volume';
        end
        
        
        if isfield(handles, 'comp_timely_taz_stat_result')
            comp_item_availabe{end+1,1} = 'Total Amount of Individuals';
        end
        if isfield(handles, 'comp_timely_taz_stat_result') & isfield(handles, 'base_area')
            comp_item_availabe{end+1,1} = 'Density';
        end
        if isfield(handles, 'comp_timely_taz_queue_population_result')
            comp_item_availabe{end+1,1} = 'Queue Volumn';
        end
        if isfield(handles, 'comp_timely_taz_queue_time_result')
            comp_item_availabe{end+1,1} = 'Queue Time';
        end
        if isfield(handles, 'comp_timely_taz_stat_result') & isfield(handles, 'comp_timely_taz_queue_population_result')
            comp_item_availabe{end+1,1} = 'Total Amount of Individuals + Queue Volumn';
        end
        
        if isempty(sim_item_availabe)
            errordlg('You have NO spatiotemporal result for plot.', 'Error')
            return
        end
        %既然至少有一个可画的，那就开画吧
        targetTAZ = inputdlgWC(['Please input the interested TAZ ID (1~', num2str(NTAZ), ')'],...
            'TAZ ID', 1);
        if isempty(targetTAZ)
            return
        end
        try targetTAZ = str2num(targetTAZ{:});
        catch errordlg('Invalid input.', 'Error'); return
        end
        if isnan(targetTAZ) | isempty(targetTAZ)
            errordlg('Invalid input.', 'Error')
            return
        end
        if targetTAZ <=0 | targetTAZ > NTAZ
            errordlg('The input ID is out of range.', 'Error')
            return
        end
        
        [sel,ok] = listdlg('PromptString','Select a plot item:',...
            'SelectionMode','single',...
            'ListString',sim_item_availabe);
        if ok == 0
            return
        end
        
        if strcmp(sim_item_availabe{sel}, 'Total Amount of Individuals')
            title_str = 'Total Amount of Individuals';
            ylabel_str = 'Total Amount of Individuals';
            timely_taz_stat_result = handles.timely_taz_stat_result;
            timely_taz_stat_mean = timely_taz_stat_result.mean;
            time_stat_intv_origin = timely_taz_stat_result.time_stat_intv_origin;
            crt_sim_data  = timely_taz_stat_mean(targetTAZ, :);
            crt_sim_time_name = time_stat_intv_origin;
            if start_time < time_stat_intv_origin(1)
                add_before_data = zeros(1, WDtimeConvert(time_stat_intv_origin(1),1) - WDtimeConvert(start_time, 1));
                add_before_time_name = WDtimeConvert( WDtimeConvert(start_time,1) : WDtimeConvert(time_stat_intv_origin(1),1)-1  , 3);
                crt_sim_data = [add_before_data, crt_sim_data];
                crt_sim_time_name = [add_before_time_name, crt_sim_time_name];
            end
            if end_time > time_stat_intv_origin(end)
                add_after_data = zeros(1, WDtimeConvert(end_time, 1) - WDtimeConvert(time_stat_intv_origin(end),1));
                add_after_time_name = WDtimeConvert(WDtimeConvert(time_stat_intv_origin(end),1)+1 : WDtimeConvert(end_time), 3);
                crt_sim_data = [crt_sim_data, add_after_data];
                crt_sim_time_name = [crt_sim_time_name, add_after_time_name];
            end
            start_time_index = find(crt_sim_time_name == start_time);
            end_time_index = find(crt_sim_time_name == end_time);
            crt_sim_data = crt_sim_data(start_time_index: end_time_index );
            crt_sim_time_name = crt_sim_time_name(start_time_index: end_time_index);
            legend_str = {'Simulation: Total Num. of Individuals'};
            if ~isequal(length(crt_sim_data), length(crt_sim_time_name))
                errordlg('Something strange happens, see error 6597', 'Error')
                return
            end
            [x_date, flag] = WDtime2SStime(crt_sim_time_name);
            if flag == 0
                return
            end
            line_h{1} = plot(ax, x_date, crt_sim_data, 'r-', 'linewidth', 2);
            hold on
            
            if Comp_ON == 1 & ismember('Total Amount of Individuals', comp_item_availabe)
                comp_timely_taz_stat_result = handles.comp_timely_taz_stat_result;
                comp_timely_taz_stat_mean = comp_timely_taz_stat_result.data;
                comp_time_stat_intv_origin = comp_timely_taz_stat_result.time_stat_intv_origin;
                crt_comp_data  = comp_timely_taz_stat_mean(targetTAZ, :);
                crt_comp_time_name = comp_time_stat_intv_origin;
                if start_time < comp_time_stat_intv_origin(1)
                    add_before_data = zeros(1, WDtimeConvert(comp_time_stat_intv_origin(1),1) - WDtimeConvert(start_time, 1));
                    add_before_time_name = WDtimeConvert( WDtimeConvert(start_time,1) : WDtimeConvert(comp_time_stat_intv_origin(1),1)-1  , 3);
                    crt_comp_data = [add_before_data, crt_comp_data];
                    crt_comp_time_name = [add_before_time_name, crt_comp_time_name];
                end
                if end_time > comp_time_stat_intv_origin(end)
                    add_after_data = zeros(1, WDtimeConvert(end_time, 1) - WDtimeConvert(comp_time_stat_intv_origin(end),1));
                    add_after_time_name = WDtimeConvert(WDtimeConvert(comp_time_stat_intv_origin(end),1)+1 : WDtimeConvert(end_time,1), 3);
                    crt_comp_data = [crt_comp_data, add_after_data];
                    crt_comp_time_name = [crt_comp_time_name, add_after_time_name];
                end
                start_time_index = find(crt_comp_time_name == start_time);
                end_time_index = find(crt_comp_time_name == end_time);
                crt_comp_data = crt_comp_data(start_time_index: end_time_index );
                crt_comp_time_name = crt_comp_time_name(start_time_index: end_time_index);
                legend_str{end+1} = 'Comparison: Total Num. of Individuals';
                if ~isequal(length(crt_sim_data), length(crt_comp_data)) | ~isequal(crt_sim_time_name, crt_comp_time_name) 
                    errordlg('Something strange happens, see error 6597', 'Error')
                    return
                end
                line_h{2} = plot(ax, x_date, crt_comp_data, 'b-', 'linewidth', 2);
            end
            hold off
        elseif strcmp(sim_item_availabe{sel}, 'Density')
            title_str = 'Density';
            ylabel_str = 'Density';
            timely_taz_stat_result = handles.timely_taz_stat_result;
            timely_taz_stat_mean = timely_taz_stat_result.mean;
            base_area = handles.base_area;
            base_area = base_area(targetTAZ);
            time_stat_intv_origin = timely_taz_stat_result.time_stat_intv_origin;
            crt_sim_data  = timely_taz_stat_mean(targetTAZ, :) / base_area;
            crt_sim_time_name = time_stat_intv_origin;
            if start_time < time_stat_intv_origin(1)
                add_before_data = zeros(1, WDtimeConvert(time_stat_intv_origin(1),1) - WDtimeConvert(start_time, 1));
                add_before_time_name = WDtimeConvert( WDtimeConvert(start_time,1) : WDtimeConvert(time_stat_intv_origin(1),1)-1  , 3);
                crt_sim_data = [add_before_data, crt_sim_data];
                crt_sim_time_name = [add_before_time_name, crt_sim_time_name];
            end
            if end_time > time_stat_intv_origin(end)
                add_after_data = zeros(1, WDtimeConvert(end_time, 1) - WDtimeConvert(time_stat_intv_origin(end),1));
                add_after_time_name = WDtimeConvert(WDtimeConvert(time_stat_intv_origin(end),1)+1 : WDtimeConvert(end_time), 3);
                crt_sim_data = [crt_sim_data, add_after_data];
                crt_sim_time_name = [crt_sim_time_name, add_after_time_name];
            end
            start_time_index = find(crt_sim_time_name == start_time);
            end_time_index = find(crt_sim_time_name == end_time);
            crt_sim_data = crt_sim_data(start_time_index: end_time_index );
            crt_sim_time_name = crt_sim_time_name(start_time_index: end_time_index);
            legend_str = {'Simulation: Density'};
            if ~isequal(length(crt_sim_data), length(crt_sim_time_name))
                errordlg('Something strange happens, see error 6597', 'Error')
                return
            end
            [x_date, flag] = WDtime2SStime(crt_sim_time_name);
            if flag == 0
                return
            end
            line_h{1} = plot(ax, x_date, crt_sim_data, 'r-', 'linewidth', 2);
            hold on
            
            if Comp_ON == 1 & ismember('Density', comp_item_availabe)
                comp_timely_taz_stat_result = handles.comp_timely_taz_stat_result;
                comp_timely_taz_stat_mean = comp_timely_taz_stat_result.data;
                comp_time_stat_intv_origin = comp_timely_taz_stat_result.time_stat_intv_origin;
                crt_comp_data  = comp_timely_taz_stat_mean(targetTAZ, :) / base_area;
                crt_comp_time_name = comp_time_stat_intv_origin;
                if start_time < comp_time_stat_intv_origin(1)
                    add_before_data = zeros(1, WDtimeConvert(comp_time_stat_intv_origin(1),1) - WDtimeConvert(start_time, 1));
                    add_before_time_name = WDtimeConvert( WDtimeConvert(start_time,1) : WDtimeConvert(comp_time_stat_intv_origin(1),1)-1  , 3);
                    crt_comp_data = [add_before_data, crt_comp_data];
                    crt_comp_time_name = [add_before_time_name, crt_comp_time_name];
                end
                if end_time > comp_time_stat_intv_origin(end)
                    add_after_data = zeros(1, WDtimeConvert(end_time, 1) - WDtimeConvert(comp_time_stat_intv_origin(end),1));
                    add_after_time_name = WDtimeConvert(WDtimeConvert(comp_time_stat_intv_origin(end),1)+1 : WDtimeConvert(end_time), 3);
                    crt_comp_data = [crt_comp_data, add_after_data];
                    crt_comp_time_name = [crt_comp_time_name, add_after_time_name];
                end
                start_time_index = find(crt_comp_time_name == start_time);
                end_time_index = find(crt_comp_time_name == end_time);
                crt_comp_data = crt_comp_data(start_time_index: end_time_index );
                crt_comp_time_name = crt_comp_time_name(start_time_index: end_time_index);
                legend_str{end+1} = 'Comparison: Density';
                if ~isequal(length(crt_sim_data), length(crt_comp_data)) | ~isequal(crt_sim_time_name, crt_comp_time_name) 
                    errordlg('Something strange happens, see error 6597', 'Error')
                    return
                end
                line_h{2} = plot(ax, x_date, crt_comp_data, 'b-', 'linewidth', 2);
            end
            hold off
        elseif strcmp(sim_item_availabe{sel}, 'Queue Volume')
            title_str = 'Queue Volumn';
            ylabel_str = 'Queue Volumn';
            timely_taz_queue_population_result = handles.timely_taz_queue_population_result;
            timely_taz_queue_population_mean = timely_taz_queue_population_result.mean;
            time_stat_intv_origin = timely_taz_queue_population_result.time_stat_intv_origin;
            crt_sim_data  = timely_taz_queue_population_mean(targetTAZ, :);
            crt_sim_time_name = time_stat_intv_origin;
            if start_time < time_stat_intv_origin(1)
                add_before_data = zeros(1, WDtimeConvert(time_stat_intv_origin(1),1) - WDtimeConvert(start_time, 1));
                add_before_time_name = WDtimeConvert( WDtimeConvert(start_time,1) : WDtimeConvert(time_stat_intv_origin(1),1)-1  , 3);
                crt_sim_data = [add_before_data, crt_sim_data];
                crt_sim_time_name = [add_before_time_name, crt_sim_time_name];
            end
            if end_time > time_stat_intv_origin(end)
                add_after_data = zeros(1, WDtimeConvert(end_time, 1) - WDtimeConvert(time_stat_intv_origin(end),1));
                add_after_time_name = WDtimeConvert(WDtimeConvert(time_stat_intv_origin(end),1)+1 : WDtimeConvert(end_time), 3);
                crt_sim_data = [crt_sim_data, add_after_data];
                crt_sim_time_name = [crt_sim_time_name, add_after_time_name];
            end
            start_time_index = find(crt_sim_time_name == start_time);
            end_time_index = find(crt_sim_time_name == end_time);
            crt_sim_data = crt_sim_data(start_time_index: end_time_index );
            crt_sim_time_name = crt_sim_time_name(start_time_index: end_time_index);
            legend_str = {'Simulation: Queue Volumn'};
            if ~isequal(length(crt_sim_data), length(crt_sim_time_name))
                errordlg('Something strange happens, see error 6597', 'Error')
                return
            end
            [x_date, flag] = WDtime2SStime(crt_sim_time_name);
            if flag == 0
                return
            end
            line_h{1} = plot(ax, x_date, crt_sim_data, 'r-', 'linewidth', 2);
            hold on
            
            if Comp_ON == 1 & ismember('Queue Volumn', comp_item_availabe)
                comp_timely_taz_queue_population_result = handles.comp_timely_taz_queue_population_result;
                comp_timely_taz_queue_population_mean = comp_timely_taz_queue_population_result.data;
                comp_time_stat_intv_origin = comp_timely_taz_queue_population_result.time_stat_intv_origin;
                crt_comp_data  = comp_timely_taz_queue_population_mean(targetTAZ, :);
                crt_comp_time_name = comp_time_stat_intv_origin;
                if start_time < comp_time_stat_intv_origin(1)
                    add_before_data = zeros(1, WDtimeConvert(comp_time_stat_intv_origin(1),1) - WDtimeConvert(start_time, 1));
                    add_before_time_name = WDtimeConvert( WDtimeConvert(start_time,1) : WDtimeConvert(comp_time_stat_intv_origin(1),1)-1  , 3);
                    crt_comp_data = [add_before_data, crt_comp_data];
                    crt_comp_time_name = [add_before_time_name, crt_comp_time_name];
                end
                if end_time > comp_time_stat_intv_origin(end)
                    add_after_data = zeros(1, WDtimeConvert(end_time, 1) - WDtimeConvert(comp_time_stat_intv_origin(end),1));
                    add_after_time_name = WDtimeConvert(WDtimeConvert(comp_time_stat_intv_origin(end),1)+1 : WDtimeConvert(end_time), 3);
                    crt_comp_data = [crt_comp_data, add_after_data];
                    crt_comp_time_name = [crt_comp_time_name, add_after_time_name];
                end
                start_time_index = find(crt_comp_time_name == start_time);
                end_time_index = find(crt_comp_time_name == end_time);
                crt_comp_data = crt_comp_data(start_time_index: end_time_index );
                crt_comp_time_name = crt_comp_time_name(start_time_index: end_time_index);
                legend_str{end+1} = 'Comparison: Queue Volumn';
                if ~isequal(length(crt_sim_data), length(crt_comp_data)) | ~isequal(crt_sim_time_name, crt_comp_time_name) 
                    errordlg('Something strange happens, see error 6597', 'Error')
                    return
                end
                line_h{2} = plot(ax, x_date, crt_comp_data, 'b-', 'linewidth', 2);
            end
            hold off
        elseif strcmp(sim_item_availabe{sel}, 'Queue Time')
            title_str = 'Queue Time';
            ylabel_str = 'Queue Time';
            timely_taz_queue_time_result = handles.timely_taz_queue_time_result;
            timely_taz_queue_time_mean = timely_taz_queue_time_result.mean;
            time_stat_intv_origin = timely_taz_queue_time_result.time_stat_intv_origin;
            crt_sim_data  = timely_taz_queue_time_mean(targetTAZ, :);
            crt_sim_time_name = time_stat_intv_origin;
            if start_time < time_stat_intv_origin(1)
                add_before_data = zeros(1, WDtimeConvert(time_stat_intv_origin(1),1) - WDtimeConvert(start_time, 1));
                add_before_time_name = WDtimeConvert( WDtimeConvert(start_time,1) : WDtimeConvert(time_stat_intv_origin(1),1)-1  , 3);
                crt_sim_data = [add_before_data, crt_sim_data];
                crt_sim_time_name = [add_before_time_name, crt_sim_time_name];
            end
            if end_time > time_stat_intv_origin(end)
                add_after_data = zeros(1, WDtimeConvert(end_time, 1) - WDtimeConvert(time_stat_intv_origin(end),1));
                add_after_time_name = WDtimeConvert(WDtimeConvert(time_stat_intv_origin(end),1)+1 : WDtimeConvert(end_time), 3);
                crt_sim_data = [crt_sim_data, add_after_data];
                crt_sim_time_name = [crt_sim_time_name, add_after_time_name];
            end
            start_time_index = find(crt_sim_time_name == start_time);
            end_time_index = find(crt_sim_time_name == end_time);
            crt_sim_data = crt_sim_data(start_time_index: end_time_index );
            crt_sim_time_name = crt_sim_time_name(start_time_index: end_time_index);
            legend_str = {'Simulation: Queue Time'};
            if ~isequal(length(crt_sim_data), length(crt_sim_time_name))
                errordlg('Something strange happens, see error 6597', 'Error')
                return
            end
            [x_date, flag] = WDtime2SStime(crt_sim_time_name);
            if flag == 0
                return
            end
            line_h{1} = plot(ax, x_date, crt_sim_data, 'r-', 'linewidth', 2);
            hold on
            
            if Comp_ON == 1 & ismember('Queue Time', comp_item_availabe)
                comp_timely_taz_queue_time_result = handles.comp_timely_taz_queue_time_result;
                comp_timely_taz_queue_time_mean = comp_timely_taz_queue_time_result.data;
                comp_time_stat_intv_origin = comp_timely_taz_queue_time_result.time_stat_intv_origin;
                crt_comp_data  = comp_timely_taz_queue_time_mean(targetTAZ, :);
                crt_comp_time_name = comp_time_stat_intv_origin;
                if start_time < comp_time_stat_intv_origin(1)
                    add_before_data = zeros(1, WDtimeConvert(comp_time_stat_intv_origin(1),1) - WDtimeConvert(start_time, 1));
                    add_before_time_name = WDtimeConvert( WDtimeConvert(start_time,1) : WDtimeConvert(comp_time_stat_intv_origin(1),1)-1  , 3);
                    crt_comp_data = [add_before_data, crt_comp_data];
                    crt_comp_time_name = [add_before_time_name, crt_comp_time_name];
                end
                if end_time > comp_time_stat_intv_origin(end)
                    add_after_data = zeros(1, WDtimeConvert(end_time, 1) - WDtimeConvert(comp_time_stat_intv_origin(end),1));
                    add_after_time_name = WDtimeConvert(WDtimeConvert(comp_time_stat_intv_origin(end),1)+1 : WDtimeConvert(end_time), 3);
                    crt_comp_data = [crt_comp_data, add_after_data];
                    crt_comp_time_name = [crt_comp_time_name, add_after_time_name];
                end
                start_time_index = find(crt_comp_time_name == start_time);
                end_time_index = find(crt_comp_time_name == end_time);
                crt_comp_data = crt_comp_data(start_time_index: end_time_index );
                crt_comp_time_name = crt_comp_time_name(start_time_index: end_time_index);
                legend_str{end+1} = 'Comparison: Queue Time';
                if ~isequal(length(crt_sim_data), length(crt_comp_data)) | ~isequal(crt_sim_time_name, crt_comp_time_name) 
                    errordlg('Something strange happens, see error 6597', 'Error')
                    return
                end
                line_h{2} = plot(ax, x_date, crt_comp_data, 'b-', 'linewidth', 2);
            end
            hold off
        elseif strcmp(sim_item_availabe{sel}, 'Total Amount of Individuals + Queue Volume')
            title_str = 'Total Amount of Individuals & Queue Volumn';
            ylabel_str = 'Volumn';
            %先画模拟总人数
            timely_taz_stat_result = handles.timely_taz_stat_result;
            timely_taz_stat_mean = timely_taz_stat_result.mean;
            time_stat_intv_origin = timely_taz_stat_result.time_stat_intv_origin;
            crt_sim_data  = timely_taz_stat_mean(targetTAZ, :);
            crt_sim_time_name = time_stat_intv_origin;
            if start_time < time_stat_intv_origin(1)
                add_before_data = zeros(1, WDtimeConvert(time_stat_intv_origin(1),1) - WDtimeConvert(start_time, 1));
                add_before_time_name = WDtimeConvert( WDtimeConvert(start_time,1) : WDtimeConvert(time_stat_intv_origin(1),1)-1  , 3);
                crt_sim_data = [add_before_data, crt_sim_data];
                crt_sim_time_name = [add_before_time_name, crt_sim_time_name];
            end
            if end_time > time_stat_intv_origin(end)
                add_after_data = zeros(1, WDtimeConvert(end_time, 1) - WDtimeConvert(time_stat_intv_origin(end),1));
                add_after_time_name = WDtimeConvert(WDtimeConvert(time_stat_intv_origin(end),1)+1 : WDtimeConvert(end_time), 3);
                crt_sim_data = [crt_sim_data, add_after_data];
                crt_sim_time_name = [crt_sim_time_name, add_after_time_name];
            end
            start_time_index = find(crt_sim_time_name == start_time);
            end_time_index = find(crt_sim_time_name == end_time);
            crt_sim_data = crt_sim_data(start_time_index: end_time_index );
            crt_sim_time_name = crt_sim_time_name(start_time_index: end_time_index);
            legend_str = {'Simulation: Total Num. of Individuals'};
            if ~isequal(length(crt_sim_data), length(crt_sim_time_name))
                errordlg('Something strange happens, see error 6597', 'Error')
                return
            end
            [x_date, flag] = WDtime2SStime(crt_sim_time_name);
            if flag == 0
                return
            end
            line_h{1} = plot(ax, x_date, crt_sim_data, 'r-', 'linewidth', 2);
            hold on
            %再画模拟总排队人数
            timely_taz_queue_population_result = handles.timely_taz_queue_population_result;
            timely_taz_queue_population_mean = timely_taz_queue_population_result.mean;
            time_stat_intv_origin = timely_taz_queue_population_result.time_stat_intv_origin;
            crt_sim_data2  = timely_taz_queue_population_mean(targetTAZ, :);
            crt_sim_time_name2 = time_stat_intv_origin;
            if start_time < time_stat_intv_origin(1)
                add_before_data = zeros(1, WDtimeConvert(time_stat_intv_origin(1),1) - WDtimeConvert(start_time, 1));
                add_before_time_name = WDtimeConvert( WDtimeConvert(start_time,1) : WDtimeConvert(time_stat_intv_origin(1),1)-1  , 3);
                crt_sim_data2 = [add_before_data, crt_sim_data2];
                crt_sim_time_name2 = [add_before_time_name, crt_sim_time_name2];
            end
            if end_time > time_stat_intv_origin(end)
                add_after_data = zeros(1, WDtimeConvert(end_time, 1) - WDtimeConvert(time_stat_intv_origin(end),1));
                add_after_time_name = WDtimeConvert(WDtimeConvert(time_stat_intv_origin(end),1)+1 : WDtimeConvert(end_time), 3);
                crt_sim_data2 = [crt_sim_data2, add_after_data];
                crt_sim_time_name2 = [crt_sim_time_name2, add_after_time_name];
            end
            start_time_index = find(crt_sim_time_name2 == start_time);
            end_time_index = find(crt_sim_time_name2 == end_time);
            crt_sim_data2 = crt_sim_data2(start_time_index: end_time_index );
            crt_sim_time_name2 = crt_sim_time_name2(start_time_index: end_time_index);
            legend_str{end+1} = 'Simulation: Queue Volumn';
            if ~isequal(length(crt_sim_data), length(crt_sim_time_name), length(crt_sim_data2), length(crt_sim_time_name2)) | ...
                ~isequal(crt_sim_time_name, crt_sim_time_name2)
                errordlg('Something strange happens, see error 6597', 'Error')
                return
            end
            line_h{2} = plot(ax, x_date, crt_sim_data2, 'r--', 'linewidth', 2);
            
            
            if Comp_ON == 1 & ismember('Total Amount of Individuals', comp_item_availabe)
                comp_timely_taz_stat_result = handles.comp_timely_taz_stat_result;
                comp_timely_taz_stat_mean = comp_timely_taz_stat_result.data;
                comp_time_stat_intv_origin = comp_timely_taz_stat_result.time_stat_intv_origin;
                crt_comp_data  = comp_timely_taz_stat_mean(targetTAZ, :);
                crt_comp_time_name = comp_time_stat_intv_origin;
                if start_time < comp_time_stat_intv_origin(1)
                    add_before_data = zeros(1, WDtimeConvert(comp_time_stat_intv_origin(1),1) - WDtimeConvert(start_time, 1));
                    add_before_time_name = WDtimeConvert( WDtimeConvert(start_time,1) : WDtimeConvert(comp_time_stat_intv_origin(1),1)-1  , 3);
                    crt_comp_data = [add_before_data, crt_comp_data];
                    crt_comp_time_name = [add_before_time_name, crt_comp_time_name];
                end
                if end_time > comp_time_stat_intv_origin(end)
                    add_after_data = zeros(1, WDtimeConvert(end_time, 1) - WDtimeConvert(comp_time_stat_intv_origin(end),1));
                    add_after_time_name = WDtimeConvert(WDtimeConvert(comp_time_stat_intv_origin(end),1)+1 : WDtimeConvert(end_time,1), 3);
                    crt_comp_data = [crt_comp_data, add_after_data];
                    crt_comp_time_name = [crt_comp_time_name, add_after_time_name];
                end
                start_time_index = find(crt_comp_time_name == start_time);
                end_time_index = find(crt_comp_time_name == end_time);
                crt_comp_data = crt_comp_data(start_time_index: end_time_index );
                crt_comp_time_name = crt_comp_time_name(start_time_index: end_time_index);
                legend_str{end+1} = 'Comparison: Total Num. of Individuals';
                if ~isequal(length(crt_sim_data), length(crt_comp_data)) | ~isequal(crt_sim_time_name, crt_comp_time_name) 
                    errordlg('Something strange happens, see error 6597', 'Error')
                    return
                end
                line_h{end+1} = plot(ax, x_date, crt_comp_data, 'b-', 'linewidth', 2);
            end
            if Comp_ON == 1 & ismember('Queue Volumn', comp_item_availabe)
                comp_timely_taz_queue_population_result = handles.comp_timely_taz_queue_population_result;
                comp_timely_taz_queue_population_mean = comp_timely_taz_queue_population_result.data;
                comp_time_stat_intv_origin = comp_timely_taz_queue_population_result.time_stat_intv_origin;
                crt_comp_data2  = comp_timely_taz_queue_population_mean(targetTAZ, :);
                crt_comp_time_name2 = comp_time_stat_intv_origin;
                if start_time < comp_time_stat_intv_origin(1)
                    add_before_data = zeros(1, WDtimeConvert(comp_time_stat_intv_origin(1),1) - WDtimeConvert(start_time, 1));
                    add_before_time_name = WDtimeConvert( WDtimeConvert(start_time,1) : WDtimeConvert(comp_time_stat_intv_origin(1),1)-1  , 3);
                    crt_comp_data2 = [add_before_data, crt_comp_data2];
                    crt_comp_time_name2 = [add_before_time_name, crt_comp_time_name2];
                end
                if end_time > comp_time_stat_intv_origin(end)
                    add_after_data = zeros(1, WDtimeConvert(end_time, 1) - WDtimeConvert(comp_time_stat_intv_origin(end),1));
                    add_after_time_name = WDtimeConvert(WDtimeConvert(comp_time_stat_intv_origin(end),1)+1 : WDtimeConvert(end_time), 3);
                    crt_comp_data2 = [crt_comp_data2, add_after_data];
                    crt_comp_time_name2 = [crt_comp_time_name2, add_after_time_name];
                end
                start_time_index = find(crt_comp_time_name2 == start_time);
                end_time_index = find(crt_comp_time_name2 == end_time);
                crt_comp_data2 = crt_comp_data2(start_time_index: end_time_index );
                crt_comp_time_name2 = crt_comp_time_name2(start_time_index: end_time_index);
                legend_str{end+1} = 'Comparison: Queue Volumn';
                if ~isequal(length(crt_sim_data2), length(crt_comp_data2)) | ~isequal(crt_sim_time_name, crt_comp_time_name2) 
                    errordlg('Something strange happens, see error 6597', 'Error')
                    return
                end
                line_h{end+1} = plot(ax, x_date, crt_comp_data2, 'b--', 'linewidth', 2);
            end
            hold off
        end
        
        legend(legend_str)
        set(ax , 'xtick' , xtick_data)
        set(ax , 'xticklabel' , xtick_data_label)
        set(ax , 'fontsize' , 10)
        title(['Time-Variation of ', title_str, ': TAZ ', num2str(targetTAZ)] , 'fontname','Comic Sans MS','fontsize',18,'fontweight','bold')
        xlabel('Time','fontsize',15,'fontname','Comic Sans MS')
        ylabel(ylabel_str , 'fontsize',15,'fontname','Comic Sans MS')
        set(ax,'fontname','Comic Sans MS')
        xlim(ax, [datenum(1988,2,10, floor(start_time/100), start_time-floor(start_time/100)*100 ,0) , ...
        datenum(1988,2,10, floor(end_time/100), end_time-floor(end_time/100)*100 ,0)])   
        if isfield(handles, 'Legend_ON')
            Legend_ON = handles.Legend_ON;
        else
            Legend_ON = 1;
        end
        if Legend_ON == 1
            legend show
        else
            legend hide
        end
        rotate3d off
        
        %-----------------------%
    case 27                      %平均活动强度
        if isfield(handles, 'Comp_ON')
            Comp_ON = handles.Comp_ON;
        else
            Comp_ON = 1;
        end
        if isfield(handles, 'Legend_ON')
            Legend_ON = handles.Legend_ON;
        else
            Legend_ON = 1;
        end
        set(handles.axes1, 'Position', [0.05, 0.1, 0.55, 0.8]);
        if isfield(handles , 'Sim_mean_actpp')
            Sim_mean_actpp = handles.Sim_mean_actpp;
        else
            errordlg('There is NO valid simulatoin data')
            return
        end
        if isfield(handles , 'Comp_mean_actpp') & Comp_ON == 1
            Comp_mean_actpp = handles.Comp_mean_actpp;
        end
        
        Sim_mean_actpp_withTime = cumsum(Sim_mean_actpp) ./ [1 : length(Sim_mean_actpp)]';
        plot([1 : length(Sim_mean_actpp)]' , Sim_mean_actpp_withTime, 'r' ,'linewidth' , 2)
        hold on
        plot([1 : length(Sim_mean_actpp)]' , Sim_mean_actpp, 'r' ,'linewidth' , 1)
        xlim([1 , length(Sim_mean_actpp)])
        ylim([0 , max(Sim_mean_actpp) * 1.2])
        if exist('Comp_mean_actpp' , 'var')
            plot([1 : length(Sim_mean_actpp)]' , Comp_mean_actpp * ones(length(Sim_mean_actpp) , 1), 'b' ,'linewidth' , 2)
            ylim([0 , max(max(Sim_mean_actpp), Comp_mean_actpp) * 1.2])
        end
        
        if ~exist('Comp_mean_actpp' , 'var')
            legend('Simulation Mean' , 'Simulatoin Single',  'Location', 'northeast');
        elseif exist('Comp_mean_actpp' , 'var')
            legend('Simulation Mean' , 'Simulatoin Single', 'Comparison Constant', 'Location', 'northeast');
        end
        if Legend_ON == 1
            legend show
        else
            legend hide
        end
        xlabel('Simulation Time','fontsize',13)
        ylabel('Value','fontsize',13)
        title('Mean Num. Activities per Individual ','fontsize',20)
        rotate3d off
        
        %-----------------------%
    case 28                  %某个特定小区
        if isfield(handles, 'Comp_ON')
            Comp_ON = handles.Comp_ON;
        else
            Comp_ON = 1;
        end
        if isfield(handles, 'Legend_ON')
            Legend_ON = handles.Legend_ON;
        else
            Legend_ON = 1;
        end
        set(handles.axes1, 'Position', [0.05, 0.1, 0.55, 0.8]);
        if isfield(handles , 'Sim_taz_distrib')
            Sim_taz_distrib = handles.Sim_taz_distrib;
            NTAZ = handles.NTAZ;
        else
            errordlg('There is NO valid simulatoin data')
            return
        end
        if isfield(handles , 'Comp_TAZ_distrib') & Comp_ON == 1
            Comp_TAZ_distrib = handles.Comp_TAZ_distrib;
        end
        
        max_of_all = max(max(Sim_taz_distrib)) * 1.05;
        tazID = inputdlgWC('Enter the id of TAZ you want to check' , 'TAZ ID');
        if isempty(tazID)
            return
        else
            try
                tazID = str2num(cell2mat(tazID));
            catch
                errordlg('Invalid input.', 'Error')
                return
            end
            if ~isnumeric(tazID)| isnan(tazID) | isempty(tazID)
                errordlg('Invalid input.', 'Error')
                return
            end
        end
        if tazID < 1 | tazID > NTAZ
            errordlg('Invalid TAZ id', 'TAZ ID Error')
            return
        end
        crt_Sim_distrib = Sim_taz_distrib(tazID , :);
        crt_Sim_distrib = crt_Sim_distrib';
        sim_time = length(crt_Sim_distrib);
        crt_Sim_mean_distrib_withTime = cumsum(crt_Sim_distrib) ./ [1 : sim_time]';
        plot([1 : sim_time]' , crt_Sim_mean_distrib_withTime, 'r' ,'linewidth' , 2)
        hold on
        plot([1 : sim_time]' , crt_Sim_distrib, 'r' ,'linewidth' , 1)
        xlim([1 , sim_time])
        ylim([0 , max_of_all])
        if exist('Comp_TAZ_distrib' , 'var')
            max_of_all = max(max_of_all , max(Comp_TAZ_distrib) * 1.05);
            plot([1 : sim_time]' , Comp_TAZ_distrib(tazID) * ones(sim_time , 1), 'b' ,'linewidth' , 2)
            ylim([0 , max_of_all])
        end
        
        if ~exist('Comp_TAZ_distrib' , 'var')
            legend('Simulation Mean' , 'Simulatoin Single',  'Location', 'northeast');
        elseif exist('Comp_TAZ_distrib' , 'var')
            legend('Simulation Mean' , 'Simulatoin Single', 'Comparison Constant', 'Location', 'northeast');
        end
        if Legend_ON == 1
            legend show
        else
            legend hide
        end
        xlabel('Simulation Time','fontsize',13)
        ylabel('Value','fontsize',13)
        title(['Num. Activities in TAZ ', num2str(tazID)],'fontsize',20)
        rotate3d off
        
        %-----------------------%
    case 29             %对比折线
        if isfield(handles, 'Comp_ON') & handles.Comp_ON == 0
            errordlg('Comparison check-box is not checked on')
            return
        end
        if isfield(handles, 'Legend_ON')
            Legend_ON = handles.Legend_ON;
        else
            Legend_ON = 1;
        end
        set(handles.axes1, 'Position', [0.05, 0.1, 0.55, 0.8]);
        if isfield(handles , 'Sim_mean_taz_distrib')
            Sim_mean_taz_distrib = handles.Sim_mean_taz_distrib;
            NTAZ = handles.NTAZ;
        else
            errordlg('There is NO valid simulatoin data')
            return
        end
        if isfield(handles , 'Comp_TAZ_distrib')
            Comp_TAZ_distrib = handles.Comp_TAZ_distrib;
        else
            errordlg('There is NO valid comparison data')
            return
        end
        
        max_of_all = max(max(Sim_mean_taz_distrib)) * 1.05;
        max_of_all = max(max_of_all , max(Comp_TAZ_distrib) * 1.05);
        plot([1 : NTAZ]' , Sim_mean_taz_distrib, 'r-o' ,'linewidth' , 1)
        hold on
        plot([1 : NTAZ]' , Comp_TAZ_distrib, 'b-x' ,'linewidth' , 1)
        xlim([1 , NTAZ])
        ylim([0 , max_of_all])
        set(gca, 'xtick', 1:NTAZ)
        legend('Simulation' , 'Comparison',  'Location', 'northeast');
        if Legend_ON == 1
            legend show
        else
            legend hide
        end
        xlabel('TAZ ID','fontsize',13)
        ylabel('Num. Activities','fontsize',13)
        title('Comparison of Num. Activities in All TAZs ','fontsize',20)
        rotate3d off
        
        %-----------------------%
    case 30                     %散点图
        if isfield(handles, 'Comp_ON') & handles.Comp_ON == 0
            errordlg('Comparison check-box is not checked on')
            return
        end
        if isfield(handles, 'Legend_ON')
            Legend_ON = handles.Legend_ON;
        else
            Legend_ON = 1;
        end
        set(handles.axes1, 'Position', [0.05, 0.1, 0.55, 0.8]);
        if isfield(handles , 'Sim_mean_taz_distrib')
            Sim_mean_taz_distrib = handles.Sim_mean_taz_distrib;
            NTAZ = handles.NTAZ;
        else
            errordlg('There is NO valid simulatoin data')
            return
        end
        if isfield(handles , 'Comp_TAZ_distrib')
            Comp_TAZ_distrib = handles.Comp_TAZ_distrib;
        else
            errordlg('There is NO valid comparison data')
            return
        end
        max_of_all = max(max(Sim_mean_taz_distrib)) * 1.05;
        max_of_all = max(max_of_all , max(Comp_TAZ_distrib) * 1.05);
        plot(Sim_mean_taz_distrib , Comp_TAZ_distrib, 'bo' )
        xl = get(gca , 'xlim');
        yl = get(gca , 'ylim');
        xmin = min(xl(1) , yl(1));
        xmax = max(xl(2) , yl(2));
        set(gca , 'xlim' , [xmin , xmax]);
        set(gca , 'ylim' , [xmin , xmax]);
        xlabel('Num. Activities: Simulation','fontsize',13)
        ylabel('Num. Activities: Comparison','fontsize',13)
        title('Scatter Plot: Simulation vs. Comparison ','fontsize',20)
        rotate3d off
        [cc, p] = corrcoef(Sim_mean_taz_distrib , Comp_TAZ_distrib);
        cc = cc(2);
        p = p(2);
        str = strvcat(['Pearson R: ', num2str(cc)] , ['p-value: ', num2str(p)]);
        %         annotation('textbox', [xmax*0.8, xmax*0.2, xmax*0.15, xmax*0.15] , 'String', str)
        text(.75*xmax , .1*xmax, str, 'edgecolor', 'k', 'fontsize', 13)
        
        
end
        


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in plot_type_choice_popmenu.
function plot_type_choice_popmenu_Callback(hObject, eventdata, handles)
% hObject    handle to plot_type_choice_popmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
PlotChoice = get(hObject , 'Value');
handles.PlotChoice = PlotChoice;
guidata(hObject , handles)
if PlotChoice == 2
    helpdlg('Please choose a specific map plot item','Plot Item')
end
if PlotChoice == 19
    helpdlg('Please choose a specific statistical plot item','Plot Item')
end
% if ~isfield(handles , 'Comp_OD') & PlotChoice == 10
%     errordlg('There is NO comparing OD matrix available', 'Compare Data Error')
% end
% if ~isfield(handles , 'Comp_TAZ_distrib') & (PlotChoice == 7 | PlotChoice == 8 | ...
%         PlotChoice == 9 | PlotChoice == 15 | PlotChoice == 16)
%     errordlg('There is NO comparing TAZ distribution data available' , 'Compare Data Error')
% end
if ~isfield(handles , 'Comp_TAZ_distrib') & (PlotChoice == 24 | PlotChoice == 25)
    errordlg('There is NO comparing TAZ distribution data available' , 'Compare Data Error')
end
    
% Hints: contents = cellstr(get(hObject,'String')) returns plot_type_choice_popmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from plot_type_choice_popmenu


% --- Executes during object creation, after setting all properties.
function plot_type_choice_popmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to plot_type_choice_popmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Comp.
function Comp_Callback(hObject, eventdata, handles)
% hObject    handle to Comp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Comp_ON = get(hObject,'Value');
handles.Comp_ON = Comp_ON;
guidata(hObject , handles)

% Hint: get(hObject,'Value') returns toggle state of Comp


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: place code in OpeningFcn to populate axes1


% --- Executes on mouse press over axes background.
function axes1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in AreaInput.
function AreaInput_Callback(hObject, eventdata, handles)
% hObject    handle to AreaInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if strcmp(get(hObject, 'string'), '等待输入')
    set(hObject, 'string', '输入完成');
elseif  strcmp(get(hObject, 'string'), '输入完成')
    set(hObject, 'string', '等待输入');
end

% % 关于advance mode的补充
% adv_mode = handles.adv_mode;
% if adv_mode == 1 & isfield(handles, 'X_adv') & ~isempty(handles.X_adv.area) & ~isnan(handles.X_adv.area(1))
%     X_area = handles.X_adv.area;
%     handles.X_area = X_area;            %为了本段check data使用，用完即删
% end
% if ~isfield(handles , 'NTAZ')
%      errordlg('Please firstly input Num of TAZs' , 'NTAZ Error')
%      return
% end
% NTAZ = handles.NTAZ;
% choice1 = questdlg('Do you want to input area data or just check area data?' , 'Area Data'...
%     , 'Input Data' , 'Check Data' , 'Input Data');
% if isequal(choice1, 'Input Data')
%     choice2 = questdlg('Please choose the way of inputting area data' , 'Area Data Input',...
%         'Load CSV File'  ,'Directly Type or Copy / Paste' , 'Automatic Calculatoin', 'Load CSV File');
%     switch choice2
%         case 'Directly Type or Copy / Paste'
%             str = ['Please enter space(/comma)-separated areas in the order: from TAZ_1 to TAZ_' , num2str(NTAZ)];
%             same_pasted_value = inputdlgWC({str, 'OR please enter the same area for All TAZS'} , 'Area Data Input', [1 80 ; 1 45]);
%             if isempty(same_pasted_value)
%                 return
%             end
%             pasted_value = same_pasted_value{1};
%             same_value = same_pasted_value{2};
%             if length(pasted_value) ~= 0
%                 try
%                     pasted_value = str2num(pasted_value);
%                 catch
%                     errordlg('Invalid Input', 'Input Error')
%                     return
%                 end
%                 if length(pasted_value) == NTAZ
%                     X_area = pasted_value';
%                     handles.X_area = X_area;
%                     guidata(hObject,handles);
%                 else
%                     errordlg('Input Num of area data NOT equal Num of TAZ' , 'Area Input Error')
%                     return
%                 end
%             elseif length(same_value) ~= 0
%                 try
%                     same_value = str2num(same_value);
%                 catch
%                     errordlg('Invalid Input', 'Input Error')
%                     return
%                 end  
%                 X_area = same_value * ones(NTAZ, 1);
%                 handles.X_area = X_area;
%                 guidata(hObject,handles);
%             end
%         case 'Load CSV File'
%             [fname_area_csv , pname_area_csv] = uigetfile('*.csv' , 'Open the Area Data CSV');
%             if isequal(fname_area_csv, 0) | isequal(pname_area_csv, 0)
%                 return
%             end
%             fullname_area_csv = strcat(pname_area_csv,fname_area_csv);
%             varnames = {'TAZID', 'Area'};
%             varstring = {'TAZ ID', 'Area'};
%             [area_csv, flag] = open_csv(fullname_area_csv, 2, varnames, varstring);
%             if flag == 0
%                 return
%             end
% %             try
% %                 area_csv = csvread(fullname_area_csv);
% %             catch
% %                 errordlg('Fail to open the csv file', 'Open Error')
% %                 return
% %             end
%             [nrow_area , ncol_area] = size(area_csv);
%             if nrow_area == NTAZ
%                 if ncol_area == 1
%                     handles.X_area = area_csv;
%                     guidata(hObject,handles);
%                 elseif ncol_area == 2
%                     area_csv = sortrows(area_csv , 1);
%                     X_area = area_csv(: , 2);
%                     handles.X_area = X_area;
%                     guidata(hObject,handles);
%                 else
%                     errordlg('The input csv file should contain no more than 2 columns of data', 'Input Error')
%                     return
%                 end
%             else
%                 errordlg('Input Num of area data NOT equal Num of TAZ' , 'Area Input Error')
%                 return
%             end
%         case 'Automatic Calculatoin'
%             clear X_area
%             if ~isfield(handles , 'XYZ')
%                 errordlg('NO TAZ inputting' , 'Area Input Error')
%                 return
%             else
%                 xyz = handles.XYZ;
%                 ids = unique(xyz(:,1));
%                 for kk = 1 : length(ids);
%                     crt = xyz(xyz(:,1) == ids(kk) , 2:3);
%                     crt_rst = polygeom(crt(:,1) , crt(:,2));
%                     X_area(kk , 1) = crt_rst(1);
%                 end
%                 if length(X_area) == NTAZ;
%                     handles.X_area = X_area;
%                     guidata(hObject,handles);
%                 else
%                     errordlg('Input Num of area data NOT equal Num of TAZ' , 'Area Input Error')
%                     return
%                 end
%             end
%     end
% 
% elseif isequal(choice1 , 'Check Data')
%     if ~isfield(handles , 'X_area')
%         warndlg('There is NO valid area input' ,'Area Data Input')
%         return
%     else
%         X_area = handles.X_area;
%         taz_area = [[1:NTAZ]' , X_area];
%         show = strvcat('TAZ    AREA' , num2str(taz_area));
%         msgbox(show)
%     end
%     
% end
% if isfield(handles , 'X_area')
%     fin_str = 'Finished';
%     handles.AreaInput.String = fin_str;
% end
% if adv_mode == 1 
%     try 
%         X_adv = handles.X_adv;
%         X_adv.area = X_area;
%         handles.X_adv = X_adv;
%         if isfield(handles, 'X_area')
%             handles = rmfield(handles, 'X_area');   %避免与一般模式混掉
%         end
%         guidata(hObject, handles);
%     catch
%         errordlg('Error 1000, check the program', 'Error')
%     end
% end
        
    


% --- Executes on button press in DistInput.
function DistInput_Callback(hObject, eventdata, handles)
% hObject    handle to DistInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 关于advance mode的补充
adv_mode = handles.adv_mode;
if adv_mode == 1 & isfield(handles, 'X_adv') & ~isempty(handles.X_adv.dist)
    if isfield(handles.X_adv.dist, 'taz')
        X_dist = handles.X_adv.dist.taz;
        handles.X_dist = X_dist;            %为了本段check data使用，用完即删
    end
    if isfield(handles.X_adv.dist, 'ent')
        X_dist_ent = handles.X_adv.dist.ent;
        handles.X_dist_ent = X_dist_ent;            %为了本段check data使用，用完即删
    end
end
if ~isfield(handles , 'NTAZ')
     errordlg('Please Firstly Input Num of TAZs' , 'NTAZ Error')
     return
end
if ~isfield(handles , 'NENT')
     errordlg('Please Firstly Input Num of Entrances' , 'NENT Error')
     return
end
NENT = handles.NENT;
NTAZ = handles.NTAZ;
choice1 = questdlg('Do you want to input horizontal distance data or just check the data?' , 'Horizontal Distance Data'...
    , 'Input Data' , 'Check Data' , 'Input Data');
if isequal(choice1, 'Input Data')
    choice2 = questdlg('Please choose the way of inputting horizontal distance data' , 'Horizontal Distance Data Input',...
        'Load CSV File' , 'Automatic Calculatoin', 'Load CSV File');
    switch choice2
        case 'Load CSV File'
            choice3 = questdlg('Which kind is your input matrix:' , 'Horizontal Distance Data Input',...
                'TAZ - TAZ Matrix' , 'TAZ - Entrance Matrix' ,...
                'TAZ/Entrance - TAZ/Entrance Matrix' , 'TAZ - TAZ Matrix');
            [fname_dist_csv , pname_dist_csv] = uigetfile('*.csv' , 'Open the distance data CSV');
            if isequal(fname_dist_csv, 0) | isequal(pname_dist_csv, 0)
                return
            end
            fullname_dist_csv = strcat(pname_dist_csv,fname_dist_csv);
            try
                dist_csv = csvread(fullname_dist_csv);
            catch
                errordlg('Fail to open the csv file', 'Open Error')
            end
            [dist_nrow , dist_ncol] = size(dist_csv);
            switch choice3
                case 'TAZ - TAZ Matrix'
                    if dist_nrow == NTAZ & dist_ncol == NTAZ
                        X_dist = dist_csv;
                        handles.X_dist = X_dist;
                        guidata(hObject , handles);
                    else
                        errordlg(['Dimenshion of inputting matrix should be ', num2str(NTAZ),'*',num2str(NTAZ)] , 'Distance Input Error')
                        return
                    end
                case  'TAZ - Entrance Matrix'
                    if dist_nrow == NTAZ & dist_ncol == NENT
                        X_dist_ent = dist_csv;
                        handles.X_dist_ent = X_dist_ent;
                        guidata(hObject , handles);
                    else
                        errordlg(['Dimenshion of inputting matrix should be ', num2str(NTAZ),'*',num2str(NENT)] , 'Distance Input Error')
                        return
                    end
                case 'TAZ/Entrance - TAZ/Entrance Matrix'
                    if dist_nrow == NTAZ+NENT & dist_ncol == NTAZ+NENT
                        X_dist_all = dist_csv;
                        X_dist = X_dist_all(NENT+1:end , NENT+1:end);
                        X_dist_ent = X_dist_all(NENT+1:end , 1:NENT);
                        handles.X_dist = X_dist;
                        handles.X_dist_ent = X_dist_ent;
                        guidata(hObject , handles);
                    else
                        errordlg(['Dimenshion of inputting matrix should be ', num2str(NTAZ+NENT),'*',num2str(NENT+NTAZ)] , 'Distance Input Error')
                        return
                    end
            end
                    
        case 'Automatic Calculatoin'
            if ~isfield(handles , 'XYZ') 
                errordlg('NO TAZ inputting' , 'Area Input Error')
                return
            end
            if ~isfield(handles , 'ENTXYZ')
                errordlg('NO Entrance inputting, it is inevitable only for automatic calculation' , 'Area Input Error')
                return
            end
            xyz = handles.XYZ;
            entxyz = handles.ENTXYZ;
            entpoints = sortrows(entxyz , 1);
            entpoints = entpoints(: , 2:3);
            ids = unique(xyz(:,1));
            X_dist = zeros(NTAZ , NTAZ);
            X_dist_ent = zeros(NTAZ , NENT);
            for kk = 1 : length(ids);
                crt = xyz(xyz(:,1) == ids(kk) , 2:3);
                crt_rst = polygeom(crt(:,1) , crt(:,2));
                centroids(kk , :) = [crt_rst(2) , crt_rst(3)];
            end
            for kk = 1 : NTAZ
                for kk2 = kk : NTAZ
                    X_dist(kk , kk2) = norm(centroids(kk,:) - centroids(kk2,:));
                    X_dist(kk2 , kk) = norm(centroids(kk,:) - centroids(kk2,:));
                end
            end
            for kk = 1 : NTAZ
                for kk2 = 1 : NENT
                    X_dist_ent(kk , kk2) = norm(centroids(kk,:) - entpoints(kk2,:));
                end
            end
            handles.X_dist = X_dist;
            handles.X_dist_ent = X_dist_ent;
            guidata(hObject , handles);
    end

elseif choice1 == 'Check Data'
    choice4 = questdlg('Which horizontal distance matrix do you want to check?' , 'Horizontal Distance Data'...
        , 'TAZ - TAZ Matrix' , 'TAZ - Entrance Matrix' , 'TAZ - TAZ Matrix');
    switch choice4
        case 'TAZ - TAZ Matrix'
            if ~isfield(handles , 'X_dist')
                warndlg('There is NO valid TAZ - TAZ horizontal distance input' ,'Horizontal Distance Data Input')
            else
                X_dist = handles.X_dist;
%                 show = strvcat('Firt 3 Columns of TAZ - TAZ Matrix: ' , num2str(X_dist(:,1:3)));
                  show = strvcat('TAZ - TAZ Matrix: ' , num2str(round(X_dist)));
%                 show = num2str(X_dist);
                h1 = figure;
               data = uicontrol('style','text','units','normalized','string',show,...
                    'horizontalalignment','center','position',[.1 .1 .88 .88]);
                button = uicontrol('style','pushbutton','units','normalized','string','OK','position',[.4 .02 .2 .08],'Callback',@matrixshow_Callback);
                
            end
        case 'TAZ - Entrance Matrix'
            if ~isfield(handles , 'X_dist_ent')
                warndlg('There is NO valid TAZ - Entrance horizontal distance input' ,'Horizontal Distance Data Input')
            else
                X_dist_ent = handles.X_dist_ent;
%                 show = strvcat('Firt 3 Columns of TAZ - Entrance Matrix: ', num2str(X_dist_ent(: , 1:3)));
                 show = strvcat('TAZ - Entrance Matrix: ' , num2str(round(X_dist_ent)));
%                 set(h , 'position' , [100 100 800 800])
                 h1 = figure;
               data = uicontrol('style','text','units','normalized','string',show,...
                    'horizontalalignment','center','position',[.1 .1 .88 .88]);
                button = uicontrol('style','pushbutton','units','normalized','string','OK','position',[.4 .02 .2 .08],'Callback',@matrixshow_Callback);
            end
    end
            
end
if isfield(handles , 'X_dist') & isfield(handles , 'X_dist_ent')
    fin_str = 'Finished';
    handles.DistInput.String = fin_str;
elseif isfield(handles , 'X_dist') & ~isfield(handles , 'X_dist_ent')
    fin_str = 'Need TAZ-Entrance Matrix';
    handles.DistInput.String = fin_str;
elseif ~isfield(handles , 'X_dist') & isfield(handles , 'X_dist_ent')
    fin_str = 'Need TAZ-TAZ Matrix';
    handles.Distnput.String = fin_str;
end

if adv_mode == 1 
    try 
        X_adv = handles.X_adv;
        if isfield(handles, 'X_dist')
            X_adv.dist.taz = handles.X_dist;
        end
        if isfield(handles, 'X_dist_ent')
            X_adv.dist.ent = handles.X_dist_ent;
        end
        handles.X_adv = X_adv;
        if isfield(handles, 'X_dist')
            handles = rmfield(handles, 'X_dist');   %避免与一般模式混掉
        end
        if isfield(handles, 'X_dist_ent')
            handles = rmfield(handles, 'X_dist_ent');
        end
        guidata(hObject, handles);
    catch
        errordlg('Error 1002, check the program', 'Error')
    end
end

function matrixshow_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
display('OK');
close(gcf);

% --- Executes during object creation, after setting all properties.
function load_taz_info_CreateFcn(hObject, eventdata, handles)
% hObject    handle to load_taz_info (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% str = ['Load TAZ CSV File：' , '[ID, X, Y, Z]'];
% set(handles.load_taz_info.string , str );



function Num_ent_Callback(hObject, eventdata, handles)
% hObject    handle to Num_ent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Num_ent as text
%        str2double(get(hObject,'String')) returns contents of Num_ent as a double
NENT =  str2double(get(hObject,'String'));
handles.NENT = NENT;
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function Num_ent_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Num_ent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in StdfInput.
function StdfInput_Callback(hObject, eventdata, handles)
% hObject    handle to StdfInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 关于advance mode的补充
adv_mode = handles.adv_mode;
if adv_mode == 1 & isfield(handles, 'X_adv') & ~isempty(handles.X_adv.stdf)
    if isfield(handles.X_adv.stdf, 'taz')
        X_stdf = handles.X_adv.stdf.taz;
        handles.X_stdf = X_stdf;            %为了本段check data使用，用完即删
    end
    if isfield(handles.X_adv.stdf, 'ent')
        X_stdf_ent = handles.X_adv.stdf.ent;
        handles.X_stdf_ent = X_stdf_ent;            %为了本段check data使用，用完即删
    end
end
if ~isfield(handles , 'NTAZ')
     errordlg('Please Firstly Input Num of TAZs' , 'NTAZ Error')
     return
end
if ~isfield(handles , 'NENT')
     errordlg('Please Firstly Input Num of Entrances' , 'NENT Error')
     return
end
NENT = handles.NENT;
NTAZ = handles.NTAZ;
choice1 = questdlg('Do you want to input vertical distance data or just check the data?' , 'Vertical Distance Data'...
    , 'Input Data' , 'Check Data' , 'Input Data');
if isequal(choice1 , 'Input Data')
    choice2 = questdlg('Please choose the way of inputting horizontal distance data' , 'Vertical Distance Data',...
        'Load CSV File' , 'Load CSV File');
    switch choice2
        case 'Load CSV File'
            choice3 = questdlg('Which kind is your input matrix:' ,  'Vertical Distance Data',...
                'TAZ - TAZ Matrix' , 'TAZ - Entrance Matrix' ,...
                'TAZ/Entrance - TAZ/Entrance Matrix' , 'TAZ - TAZ Matrix');
            [fname_stdf_csv , pname_stdf_csv] = uigetfile('*.csv' , 'Open the stair(difference) data CSV');
            if isequal(fname_stdf_csv, 0) | isequal(pname_stdf_csv, 0)
                return
            end
            fullname_stdf_csv = strcat(pname_stdf_csv,fname_stdf_csv);
            try
                stdf_csv = csvread(fullname_stdf_csv);
            catch
                errordlg('Fail to open the csv file', 'Open Error')
                return
            end
            [stdf_nrow , stdf_ncol] = size(stdf_csv);
            switch choice3
                case 'TAZ - TAZ Matrix'
                    if stdf_nrow == NTAZ & stdf_ncol == NTAZ
                        X_stdf = stdf_csv;
                        handles.X_stdf = X_stdf;
                        guidata(hObject , handles);
                    else
                        errordlg(['Dimenshion of inputting matrix should be ', num2str(NTAZ),'*',num2str(NTAZ)] , 'Distance Input Error')
                        return
                    end
                case  'TAZ - Entrance Matrix'
                    if stdf_nrow == NTAZ & stdf_ncol == NENT
                        X_stdf_ent = stdf_csv;
                        handles.X_stdf_ent = X_stdf_ent;
                        guidata(hObject , handles);
                    else
                        errordlg(['Dimenshion of inputting matrix should be ', num2str(NTAZ),'*',num2str(NENT)] , 'Distance Input Error')
                        return
                    end
                case 'TAZ/Entrance - TAZ/Entrance Matrix'
                    if stdf_nrow == NTAZ+NENT & stdf_ncol == NTAZ+NENT
                        X_stdf_all = stdf_csv;
                        X_stdf = X_stdf_all(NENT+1:end , NENT+1:end);
                        X_stdf_ent = X_stdf_all(NENT+1:end , 1:NENT);
                        handles.X_stdf = X_stdf;
                        handles.X_stdf_ent = X_stdf_ent;
                        guidata(hObject , handles);
                    else
                        errordlg(['Dimenshion of inputting matrix should be ', num2str(NTAZ+NENT),'*',num2str(NENT+NTAZ)] , 'Distance Input Error')
                        return
                    end
            end
    end

elseif isequal(choice1 , 'Check Data')
    choice4 = questdlg('Which vertical distance matrix do you want to check?' ,  'Vertical Distance Data'...
        , 'TAZ - TAZ Matrix' , 'TAZ - Entrance Matrix' , 'TAZ - TAZ Matrix');
    switch choice4
        case 'TAZ - TAZ Matrix'
            if ~isfield(handles , 'X_stdf')
                warndlg('There is NO valid TAZ - TAZ vertical distance input' , 'Vertical Distance Data')
                return
            else
                X_stdf = handles.X_stdf;
%                 show = strvcat('Firt 3 Columns of TAZ - TAZ Matrix: ' , num2str(X_dist(:,1:3)));
                  show = strvcat('TAZ - TAZ Matrix: ' , num2str(round(X_stdf)));
%                 show = num2str(X_dist);
                h1 = figure;
               data = uicontrol('style','text','units','normalized','string',show,...
                    'horizontalalignment','center','position',[.1 .1 .88 .88]);
                button = uicontrol('style','pushbutton','units','normalized','string','OK','position',[.4 .02 .2 .08],'Callback',@matrixshow_Callback);
                
            end
        case 'TAZ - Entrance Matrix'
            if ~isfield(handles , 'X_stdf_ent')
                warndlg('There is NO valid TAZ - Entrance vertical distance input' , 'Vertical Distance Data')
            else
                X_stdf_ent = handles.X_stdf_ent;
%                 show = strvcat('Firt 3 Columns of TAZ - Entrance Matrix: ', num2str(X_dist_ent(: , 1:3)));
                 show = strvcat('TAZ - Entrance Matrix: ' , num2str(round(X_stdf_ent)));
%                 set(h , 'position' , [100 100 800 800])
                 h1 = figure;
               data = uicontrol('style','text','units','normalized','string',show,...
                    'horizontalalignment','center','position',[.1 .1 .88 .88]);
                button = uicontrol('style','pushbutton','units','normalized','string','OK','position',[.4 .02 .2 .08],'Callback',@matrixshow_Callback);
            end
    end
else
    return
            
end
if isfield(handles , 'X_stdf') & isfield(handles , 'X_stdf_ent')
    fin_str = 'Finished';
    handles.StdfInput.String = fin_str;
elseif isfield(handles , 'X_stdf') & ~isfield(handles , 'X_stdf_ent')
    fin_str = 'Need TAZ-Entrance Matrix';
    handles.StdfInput.String = fin_str;
elseif ~isfield(handles , 'X_stdf') & isfield(handles , 'X_stdf_ent')
    fin_str = 'Need TAZ-TAZ Matrix';
    handles.Stdfnput.String = fin_str;
end

if adv_mode == 1 
    try 
        X_adv = handles.X_adv;
        if isfield(handles, 'X_stdf')
            X_adv.stdf.taz = handles.X_stdf;
        end
        if isfield(handles, 'X_stdf_ent')
            X_adv.stdf.ent = handles.X_stdf_ent;
        end
        handles.X_adv = X_adv;
        if isfield(handles, 'X_stdf')
            handles = rmfield(handles, 'X_stdf');   %避免与一般模式混掉
        end
        if isfield(handles, 'X_stdf_ent')
            handles = rmfield(handles, 'X_stdf_ent');
        end
        guidata(hObject, handles);
    catch
        errordlg('Error 1003, check the program', 'Error')
    end
end


% --- Executes on button press in FamInput.
function FamInput_Callback(hObject, eventdata, handles)
% hObject    handle to FamInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 考虑advance模式
adv_mode = handles.adv_mode;
if adv_mode == 1 & isfield(handles, 'X_adv') & ~isempty(handles.X_adv.familarity) & ~isnan(handles.X_adv.familarity(1))
    X_familarity = handles.X_adv.familarity;
    handles.X_familarity = X_familarity;        %为了本段的check data使用，段末删掉
end
if ~isfield(handles , 'NTAZ')
     errordlg('Please firstly input Num of TAZs' , 'NTAZ Error')
     return
end
NTAZ = handles.NTAZ;
choice1 = questdlg('Do you want to input familarity data or just check area data?' , 'Familarity Data'...
    , 'Input Aggregate Data' , 'Input Individual-Level Data', 'Check Data' , 'Input Aggregate Data');
if strcmp(choice1, 'Input Aggregate Data') == 1
    choice2 = questdlg('Please choose the way of inputting  data' , 'Familarity Data Input',...
        'Load CSV File'  ,'Directly Type or Copy / Paste' , 'Automatic Calculatoin from Individual-Level Data', 'Load CSV File');
    switch choice2
        case 'Directly Type or Copy / Paste'
            str = ['Please enter space(/comma)-separated areas in the order: from TAZ_1 to TAZ_' , num2str(NTAZ)];
            same_pasted_value = inputdlgWC({str, 'OR please enter the same familarity for All TAZS'} , 'Familarity Data Input', [1 80 ; 1 45]);
            if isempty(same_pasted_value)
                return
            end
            pasted_value = same_pasted_value{1};
            same_value = same_pasted_value{2};
            if length(pasted_value) ~= 0
                try
                    pasted_value = str2num(pasted_value);
                catch
                    errordlg('Invalid input', 'Error')
                    return
                end
                if length(pasted_value) == NTAZ
                    X_familarity = pasted_value';
                    handles.X_familarity = X_familarity;
                    guidata(hObject,handles);
                else
                    errordlg('Input Num of familarity data NOT equal Num of TAZ' , 'Familarity Input Error')
                    return
                end
            elseif length(same_value) ~= 0
                try
                    same_value = str2num(same_value);
                catch
                    errordlg('Invalid input', 'Error')
                    return
                end
                X_familarity = same_value * ones(NTAZ, 1);
                handles.X_familarity = X_familarity;
                guidata(hObject,handles);
            end
        case 'Load CSV File'
            [fname_familarity_csv , pname_familarity_csv] = uigetfile('*.csv' , 'Open the Familarity Data CSV');
            if isequal(fname_familarity_csv , 0) | isequal(pname_familarity_csv, 0)
                return
            end
            fullname_familarity_csv = strcat(pname_familarity_csv,fname_familarity_csv);
            %两列：TAZID, FAILARITY
            varnames = {'TAZID', 'Attractiveness'};
            varstring = {'TAZ ID', 'Attractiveness'};
            [familarity_csv, flag] = open_csv(fullname_familarity_csv, 2, varnames, varstring);
            if flag == 0
                return
            end
%             try
%                 familarity_csv = csvread(fullname_familarity_csv);
%             catch
%                 errordlg('Fail to open the csv file', 'Open Error')
%                 return
%             end
            [nrow_familarity , ncol_familarity] = size(familarity_csv);
            if nrow_familarity == NTAZ
                if ncol_familarity == 1
                    handles.X_familarity = X_familarity;
                    guidata(hObject,handles);
                elseif ncol_familarity == 2
                    familarity_csv = sortrows(familarity_csv , 1);
                    X_familarity = familarity_csv(: , 2);
                    handles.X_familarity = X_familarity;
                    guidata(hObject,handles);
                else
                    errordlg('The input csv file should contain no more than 2 columns of data', 'Input Error')
                    return
                end
            else
                errordlg('Input Num of familarity data NOT equal Num of TAZ' , 'Input Error')
                return
            end
        case 'Automatic Calculatoin from Individual-Level Data'
            clear X_familarity
            if ~isfield(handles, 'X_familarity')
                errordlg('NO prior familarity inputting' , 'Familarity Input Error')
                return
            else
                X_familarity = handles.X_familarity;
                X_familarity = mean(X_familarity , 2);
                if length(X_familarity) == NTAZ;
                    handles.X_familarity = X_familarity;
                    guidata(hObject,handles);
                else
                    errordlg('Input Num of familarity data NOT equal Num of TAZ' , 'Area Input Error')
                    return
                end
            end
    end
elseif strcmp(choice1 , 'Input Individual-Level Data') ==1
    [fname_familarity_ind_csv , pname_familarity_ind_csv] = uigetfile('*.csv' , 'Open the Individual-Level Familarity Data CSV');
    if isequal(fname_familarity_ind_csv, 0) | isequal(pname_familarity_ind_csv, 0)
        return
    end
    fullname_familarity_ind_csv = strcat(pname_familarity_ind_csv,fname_familarity_ind_csv);
    %3列，个体编号，小区编号，是否熟悉
    varnames = {'IndividualID', 'TAZID', 'Attractiveness'};
    varstring = {'Individual ID', 'TAZ ID', 'Attractiveness'};
    [familarity_ind_csv, flag] = open_csv(fullname_familarity_ind_csv, 3, varnames, varstring);
    if flag == 0
        return
    end
%     try
%         familarity_ind_csv = csvread(fullname_familarity_ind_csv);
%     catch
%         errordlg('Fail to open the csv data', 'Open Error')
%         return
%     end
    [nrow_familarity_ind , ncol_familarity_ind] = size(familarity_ind_csv);
    if ncol_familarity_ind == 3 & mod(nrow_familarity_ind , NTAZ) == 0
        X_familarity_ind = familarity_ind_csv(: , 3);
        X_familarity_ind = reshape(X_familarity_ind , NTAZ , nrow_familarity_ind/NTAZ);
        handles.X_familarity_ind = X_familarity_ind;
        handles.X_familarity = X_familarity_ind;
        guidata(hObject,handles);
    elseif ncol_familarity_ind ~= 3
        errordlg('Individual-level data should have 3 columns' , 'Input Error')
        return
    elseif mod(nrow_familarity_ind , NTAZ) ~= 0
        errordlg(['Num. of rows of individual-level data should be N * ' ,num2str(NTAZ)], 'Input Error')
        return
    end

elseif strcmp(choice1 , 'Check Data')==1
    if ~isfield(handles , 'X_familarity')
        warndlg('There is NO valid familarity input' ,'Familarity Data Input')
        return
    else
        X_familarity = handles.X_familarity;
        if size(X_familarity , 2) ~= 1
            judge = ['This is a individual-level familarity matrix with ', num2str(size(X_familarity , 2)),' samples. The fisrt ', num2str(min(size(X_familarity,2),100)),'samples are as follows.'];
            taz_familarity = X_familarity(: , 1:min(size(X_familarity,2),100));
            show = strvcat(judge ,'TAZ - Sample Respondents' ,num2str(taz_familarity));
            h1 = figure;
            data = uicontrol('style','text','units','normalized','string',show,...
                'horizontalalignment','center','position',[.1 .1 .88 .88]);
            button = uicontrol('style','pushbutton','units','normalized','string','OK','position',[.4 .02 .2 .08],'Callback',@matrixshow_Callback);
        else
            judge = ['This is an aggregate familarity vector '];
            taz_familarity = [[1:NTAZ]' , X_familarity];
            show = strvcat(judge , 'TAZ    FAMILARITY' , num2str(taz_familarity));
            msgbox(show)
        end
    end
    
end
if isfield(handles , 'X_familarity')
%     X_area = handles.X_area;
%     fin_str = ['OK, Data Size: ' , num2str(length(X_area))];
    X_familarity = handles.X_familarity;
    if size(X_familarity , 2) > 1
        fin_str = 'Finished: individual-level';
    else
        fin_str = 'Finished: aggregate';
    end
    handles.FamInput.String = fin_str;
end
if adv_mode == 1 
    try 
        X_adv = handles.X_adv;
        X_adv.familarity = X_familarity;
        handles.X_adv = X_adv;
        if isfield(handles, 'X_familarity')
            handles = rmfield(handles, 'X_familarity');   %避免与一般模式混掉
        end
        guidata(hObject, handles);
    catch
        errordlg('Error 1001, check the program', 'Error')
    end
end


% --------------------------------------------------------------------
function confi_Callback(hObject, eventdata, handles)
% hObject    handle to confi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function beh_coeff_Callback(hObject, eventdata, handles)
% hObject    handle to beh_coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)





% --------------------------------------------------------------------
function with_fam_Callback(hObject, eventdata, handles)
% hObject    handle to with_fam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
b_area = 0.0001;
handles.b_area = b_area;
b_dist = -0.01;
handles.b_dist = b_dist;
b_stdf = -0.4;
handles.b_stdf = b_stdf;
b_visited = -1.5;
handles.b_visited = b_visited;
b_familarity = 1.4;
handles.b_familarity = b_familarity;
b_past = 0.6;
handles.b_past = b_past;
set(handles.e_a , 'String' , num2str(b_area));
set(handles.e_c , 'String' , num2str(b_dist));
set(handles.edit_b_stdf , 'String' , num2str(b_stdf));
set(handles.e_b , 'String' , num2str(b_familarity));
set(handles.edit_b_visited , 'String' , num2str(b_visited));
set(handles.edit_b_past , 'String' , num2str(b_past));
guidata(hObject , handles)



% --------------------------------------------------------------------
function without_fam_Callback(hObject, eventdata, handles)
% hObject    handle to without_fam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
b_area = 0.0002;
handles.b_area = b_area;
b_dist = -0.01;
handles.b_dist = b_dist;
b_stdf = -0.4;
handles.b_stdf = b_stdf;
b_visited = -1.1;
handles.b_visited = b_visited;
b_past = 0.5;
handles.b_past = b_past;
set(handles.e_a , 'String' , num2str(b_area));
set(handles.e_c , 'String' , num2str(b_dist));
set(handles.edit_b_stdf , 'String' , num2str(b_stdf));
set(handles.edit_b_visited , 'String' , num2str(b_visited));
set(handles.edit_b_past , 'String' , num2str(b_past));
b_familarity = 0;
handles.b_familarity = b_familarity;
set(handles.e_b , 'String' , num2str(b_familarity));
guidata(hObject , handles)


% --------------------------------------------------------------------
function Untitled_2_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_3_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
notebook('C:\Program Files\MATLAB\MATLAB Production Server\R2015a\bin\WD_MonteCarlo\2015-10\gui\CCSIM_HELP.doc')


% --- Executes on selection change in choose_distrib.
function choose_distrib_Callback(hObject, eventdata, handles)
% hObject    handle to choose_distrib (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isfield(handles , 'NENT')
     errordlg('Please firstly input Num of Entrances' , 'NENT Error')
     return
end
NENT = handles.NENT;
choice_rst = get(hObject , 'value');
switch choice_rst
    case 3
        if ~isfield(handles , 'X_ent_distrib_load_ind_derived')
            errordlg('There is NO derived entrance distribution data.', 'Entrance Distribution Eroor');
            return
        else
            handles.X_ent_distrib = handles.X_ent_distrib_load_ind_derived;
            guidata(hObject , handles);
        end
         judge = 'This is aggregate entrance distribution';
            ent_distrib = [[1:NENT]' , handles.X_ent_distrib];
            show = strvcat(judge , 'Entrance    Ratio' , num2str(ent_distrib));
            msgbox(show)
    case 1
        if ~isfield(handles , 'X_ent_distrib_load_entrance')
            errordlg('There is NO aggregate entrance distribution data in Entrance-CSV file', 'Entrance Distribution Eroor');
            return
        else
            X_ent_distrib = handles.X_ent_distrib_load_entrance;
            handles.X_ent_distrib = X_ent_distrib;
            guidata(hObject , handles);
            
        end
        judge = 'This is aggregate entrance distribution';
            ent_distrib = [[1:NENT]' , X_ent_distrib];
            show = strvcat(judge , 'Entrance    Ratio' , num2str(ent_distrib));
            msgbox(show)
    case 4
        if ~isfield(handles , 'X_ind_ent')
            errordlg('There is NO individual-specific entrance distribution data in Individual-Information-CSV file', 'Entrance Distribution Eroor');
            return
        else
            X_ent_distrib = handles.X_ind_ent;
            handles.X_ent_distrib = X_ent_distrib;
            guidata(hObject , handles);
        end
        judge = strvcat('This is individual level entrance distribution' , 'Here is the derived aggregate entrance distribution');
           derived = handles.X_ent_distrib_load_ind_derived;
           ent_distrib = [[1:NENT]' , derived];
            show = strvcat(judge , 'Entrance    Ratio' , num2str(ent_distrib));
            msgbox(show)
    case 2
        str = ['Please enter space(/comma)-separated distribution ratios in the order: from Entrance_1 to Entrance_' , num2str(NENT)];
        pasted_value = inputdlgWC([str, '; OR please enter ONLY ONE abitrary number for EVEN distribution among ALL entrances'] , 'Area Data Input', [1 80 ]);
        if isempty(pasted_value) == 1
            return
        end
        pasted_value = str2num(pasted_value{:});
        if length(pasted_value) == NENT
            X_ent_distrib = pasted_value';
            X_ent_distrib = X_ent_distrib / sum(X_ent_distrib);
            handles.X_ent_distrib = X_ent_distrib;
            guidata(hObject,handles);
        elseif length(pasted_value) == 1
            X_ent_distrib = ones(NENT , 1) * (1 / NENT);
            handles.X_ent_distrib = X_ent_distrib;
            guidata(hObject,handles);
        else
            errordlg('Input Num of area data NEITHER equal equal Num of TAZ NOR equal 1' , 'Entrance Distribution Input Error')
        end
        judge = 'This is aggregate entrance distribution';
            ent_distrib = [[1:NENT]' , X_ent_distrib];
            show = strvcat(judge , 'Entrance    Ratio' , num2str(ent_distrib));
            msgbox(show)
    case 5
        if ~isfield(handles , 'X_ent_distrib')
        warndlg('There is NO valid entrance distribution input' ,'Entrance Distribution Data Input')
    else
        X_ent_distrib = handles.X_ent_distrib;
        if length(X_ent_distrib) == NENT
            judge = 'This is aggregate entrance distribution';
            ent_distrib = [[1:NENT]' , X_ent_distrib];
            show = strvcat(judge , 'Entrance    Ratio' , num2str(ent_distrib));
            msgbox(show)
        else
           judge = strvcat('This is individual level entrance distribution' , 'Here is the derived aggregate entrance distribution');
           derived = handles.X_ent_distrib_load_ind_derived;
           ent_distrib = [[1:NENT]' , derived];
            show = strvcat(judge , 'Entrance    Ratio' , num2str(ent_distrib));
            msgbox(show)
        end
    end
end
                

        

% Hints: contents = cellstr(get(hObject,'String')) returns choose_distrib contents as cell array
%        contents{get(hObject,'Value')} returns selected item from choose_distrib


% --- Executes during object creation, after setting all properties.
function choose_distrib_CreateFcn(hObject, eventdata, handles)
% hObject    handle to choose_distrib (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton16.
function pushbutton16_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function save_confi_Callback(hObject, eventdata, handles)
% hObject    handle to save_confi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
adv_mode = handles.adv_mode;
if adv_mode == 1
    errordlg(['Save excel configuration files does NOT work for advance mode, ',...
        'please switch to save standard configuration file.'], 'Error')
    return
end
[fname_save_xlsx , pname_save_xlsx] = uiputfile('*.xlsx' , 'Save the Configuration XLS');
if isequal(fname_save_xlsx, 0) | isequal(pname_save_xlsx, 0)
    return
end
tic;
fullnameS = strcat(pname_save_xlsx , fname_save_xlsx);
if exist(fullnameS,'file')
    delete(fullnameS)
end

if isfield(handles , 'XYZ')
    flag_TAZ = 1;
    xlswrite(fullnameS , handles.XYZ , 'TAZ');
else
    flag_TAZ = 0;
end
if isfield(handles , 'ENTXYZ')
    flag_ENT = 1;
    xlswrite(fullnameS , handles.ENTXYZ, 'Entrance');
else
    flag_ENT = 0;
end
if isfield(handles , 'NTAZ')
    NTAZ = handles.NTAZ;
else
    NTAZ = 0;
end
if isfield(handles , 'NENT')
    NENT = handles.NENT;
else
    NENT = 0;
end
if isfield(handles , 'NPED')
    NPED = handles.NPED;
else
    NPED = 0;
end
if isfield(handles , 'X_area')
    X_area = handles.X_area;
    xlswrite(fullnameS , X_area , 'Area');
    flag_area = 1;
else
    flag_area = 0;
end
if isfield(handles , 'X_dist')
    X_dist = handles.X_dist;
    xlswrite(fullnameS, X_dist , 'H-Distance');
    flag_dist = 1;
else
    flag_dist = 0;
end
if isfield(handles , 'X_dist_ent')
    X_dist_ent = handles.X_dist_ent;
    xlswrite(fullnameS, X_dist_ent , 'H-Distance Entrance');
    flag_dist_ent = 1;
else
    flag_dist_ent = 0;
end
if isfield(handles , 'X_stdf')
    X_stdf = handles.X_stdf;
    xlswrite(fullnameS, X_stdf , 'V-Distance');
    flag_stdf = 1;
else
    flag_stdf = 0;
end
if isfield(handles , 'X_stdf_ent')
    X_stdf_ent = handles.X_stdf_ent;
    xlswrite(fullnameS , X_stdf_ent , 'V-Distance Entrance');
    flag_stdf_ent = 1;
else
    flag_stdf_ent = 0;
end
if isfield(handles, 'X_familarity')
    X_familarity = handles.X_familarity;
    xlswrite(fullnameS , X_familarity , 'Familarity');
    flag_familarity = 1;
    if size(X_familarity , 2) > 1
        TYPE_FAM = 2;
    else
        TYPE_FAM = 1;
    end
else
    TYPE_FAM = 0;
    flag_familarity = 0;
end
if isfield(handles , 'X_ent_distrib')
    X_ent_distrib = handles.X_ent_distrib;
    xlswrite(fullnameS , X_ent_distrib , 'Entrance Distribution');
    flag_ent_distrib = 1;
    if max(X_ent_distrib) < 1
        TYPE_ENT_DIST = 1;
    elseif max(X_ent_distrib) > 1
        TYPE_ENT_DIST = 2;
    else
        if length(X_ent_distrib) == 1
            TYPE_ENT_DIST = 1;
        else
            TYPE_ENT_DIST = 2;
        end
    end
else
    flag_ent_distrib = 0;
    TYPE_ENT_DIST = 0;
end
general = [NTAZ , NENT, NPED, TYPE_FAM , TYPE_ENT_DIST];
general2 = mat2cell(general , 1 , [1 1 1 1 1]);
general3 = {'Num. of TAZ:' , 'Num. of Entrance:' , 'Num. of Consumers:','Type of Familarity:' , 'Type of Entrance Distribution:'};
general_print = [general3 ; general2]';
xlswrite(fullnameS , general_print , 1)

flag = [flag_TAZ , flag_ENT , flag_area , flag_dist , flag_dist_ent , flag_stdf , flag_stdf_ent , flag_familarity , flag_ent_distrib];
flag2 = mat2cell(flag , 1 , ones(1 , length(flag)));
flag3 = {'flag_TAZ' , 'flag_ENT' , 'flag_area' , 'flag_dist' , 'flag_dist_ent' , 'flag_stdf' , 'flag_stdf_ent' , 'flag_familarity' , 'flag_ent_distrib'};
flag_print = [flag3 ; flag2]';
xlswrite(fullnameS, flag_print , 1 , 'A8')
if isfield(handles , 'b_area')
    b_area = handles.b_area;
else
    b_area = 0;
end
if isfield(handles , 'b_familarity')
    b_familarity = handles.b_familarity;
else
    b_familarity = 0;
end
if isfield(handles , 'b_dist')
    b_dist = handles.b_dist;
else
    b_dist = 0;
end
if isfield(handles , 'b_stdf')
    b_stdf = handles.b_stdf;
else
    b_stdf = 0;
end
if isfield(handles , 'b_visited')
    b_visited = handles.b_visited;
else
    b_visited = 0;
end
if isfield(handles , 'b_past')
    b_past = handles.b_past;
else
    b_past = 0;
end
b = [b_area , b_dist , b_stdf , b_familarity , b_visited , b_past]'
xlswrite(fullnameS , b , 'Beta');

have = [];
need = [];
if flag_TAZ == 1 
    have = strcat(have , '  TAZ XYZ; ');
else
    need = strcat(need , '  TAZ XYZ; ');
end
if flag_ENT ==1 
    have = strcat(have , '  Entrace XYZ; ');
else
    need = strcat(need , '  Entrance XYZ; ');
end    
if flag_area == 1
    have = strcat(have , '  Area; ');
else
    need = strcat(need , '  Area; ');
end
if flag_dist == 1
    have = strcat(have , '  H-Distance; ');
else
    need = strcat(need , '  H-Distance; ');
end
if flag_dist_ent == 1
    have = strcat(have , '  H-Distance for Entrances; ');
else
    need = strcat(need , '  H-Distance for Entrances; ');
end
if flag_stdf == 1
    have = strcat(have , '  V-Distance; ');
else
    need = strcat(need , '  V-Distance; ');
end
if flag_stdf_ent == 1
    have = strcat(have , '  V-Distance for Entrances; ');
else
    need = strcat(need , '  V-Distance for Entrances; ');
end
if flag_familarity == 1
    have = strcat(have , '  Familarities ');
else
    need = strcat(need , '  [Familarities]; ');
end
if flag_ent_distrib == 1
    have = strcat(have , '  Entrance Distribution; ');
else
    need = strcat(need , '  Entrance Distribution; ');
end
if length(need)~=0
    message = strvcat('You have already finished the following information:' , have , '' , 'You may still need  the following information:' , need);
else
    message = strvcat('You have already finished the following information:' , have , '' , 'ALL FINISHED!!!');
end
clo = toc;
msgbox({message; ' '; ['Elapsed time(s):', num2str(clo)]} , 'Configuration File: Successfully Saved')

            


    




% --------------------------------------------------------------------
function open_confi_Callback(hObject, eventdata, handles)
% hObject    handle to open_confi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
adv_mode = handles.adv_mode;
if adv_mode == 1
    errordlg(['Save excel configuration files does NOT work for advance mode, ',...
        'please switch to save standard configuration file.'], 'Error')
    return
end
temp1 = handles.active_handles;     %上一次保存/打开新文件/完全新开文件时的数据
temp2 = rmfield(handles, {'blank_handles', 'active_handles'});      %当前的数据
if ~isequaln(temp1, temp2)
    save_quest = questdlg('Do you want to save the current data to a standard configuration file?', 'Save',...
        'Yes', 'No', 'Yes');
    if strcmp(save_quest, 'Yes')
        save_standard_config_Callback(hObject, eventdata, handles)
    elseif isempty(save_quest)
        return
    end
end

[fname , pname] = uigetfile('*.xlsx' , 'Open the Configuration XLSX');
if isequal(fname, 0) | isequal(pname, 0)
    return
end
tic;
fullnameO = strcat(pname , fname);
try
    general = xlsread(fullnameO , 1 , 'b1:b5');
catch
    errordlg('Failed to load the file', 'Error')
    return
end
%--------%读入新数据前清空老数据%--------%
blank_handles = handles.blank_handles;
handles = blank_handles;
handles.active_handles = blank_handles;
handles.blank_handles = blank_handles;          %复原到blank状态
guidata(hObject, handles)
cla reset
set(gcf,'color','w')
axis equal
axis off
set(handles.Num_TAZ, 'string', '')
set(handles.Num_ent, 'string', '')
set(handles.Num_Ped, 'string', '')
set(handles.AreaInput, 'string', 'Waiting for Input', 'Enable', 'on')
set(handles.FamInput, 'string', 'Waiting for Input', 'Enable', 'on')
set(handles.DistInput, 'string', 'Waiting for Input', 'Enable', 'on')
set(handles.StdfInput, 'string', 'Waiting for Input', 'Enable', 'on')
set(handles.e_a, 'string', '0.0001', 'style', 'edit')
set(handles.e_b, 'string', '1.4', 'style', 'edit')
set(handles.e_c, 'string', '-0.01', 'style', 'edit')
set(handles.edit_b_stdf, 'string', '-0.4', 'style', 'edit')
set(handles.edit_b_visited, 'string', '-1.5', 'style', 'edit')
set(handles.edit_b_past, 'string', '0.6', 'style', 'edit')
set(handles.edit_Comp_actpp, 'string', '')
handles.b_sim_times = 10;
handles.od_t = 1;
handles.od_abs_mode = 0;
handles.az = -37;
handles.el = 19;
handles.queue_on = 0;
handles.queue_bar.use = 1;
handles.queue_bar.reference_value = 30;
handles.queue_bar.reference_length = 5;
handles.queue_bar.width = 10;
set(handles.change_od_mode, 'checked', 'off')
file_name = 'Unnamed';
main_fig = findall(0 , 'type', 'figure', 'tag', 'figure1');
set(main_fig, 'name', ['鼓浪屿游客行为模拟器'])
set(handles.adv_def_var, 'enable', 'off')
set(handles.queue_on_check, 'enable', 'off');
set(handles.input_user_def_vars, 'enable', 'off');
set(handles.def_time_var, 'enable', 'off');
set(handles.def_dyn_var, 'enable', 'off');
set(handles.beta_panel, 'title', 'Behaivoral Coefficients')
set(handles.xs_panel, 'title', 'Explanatory Variables')
set(handles.use_predefine_with_fam, 'Enable', 'on');
set(handles.use_predefine_without_fam, 'Enable', 'on');
set(handles.use_user_define_coef, 'Enable', 'on');
set(handles.excel_confi_file, 'Enable', 'on');
set(handles.save_confi, 'Enable', 'on');
set(handles.open_confi, 'Enable', 'on');
%--------%读入新数据前清空老数据%--------%
NTAZ = general(1);
if NTAZ > 0
    handles.NTAZ = NTAZ;
    set(handles.Num_TAZ , 'String' , num2str(NTAZ));
end
NENT = general(2);
if NENT > 0
    handles.NENT = NENT;
    set(handles.Num_ent , 'String' ,num2str(NENT));
end
NPED = general(3);
if NPED > 0
    handles.NPED = NPED;
    set(handles.Num_Ped , 'String' , num2str(NPED));
end
TYPE_FAM = general(4);
TYPE_ENT_DIST = general(5);

try
    flags = xlsread(fullnameO , 1 , 'b8:b16');
catch
    errordlg('Fail to read some data of the file', 'Error')
    return
end
flag_TAZ = flags(1);
flag_ENT = flags(2);
flag_area = flags(3);
flag_dist = flags(4);
flag_dist_ent = flags(5);
flag_stdf = flags(6);
flag_stdf_ent = flags(7);
flag_familarity = flags(8);
flag_ent_distrib = flags(9);

have = [];
need = [];
if flag_TAZ == 1 
    have = strcat(have , '  TAZ XYZ; ');
else
    need = strcat(need , '  TAZ XYZ; ');
end
if flag_ENT ==1 
    have = strcat(have , '  Entrace XYZs; ');
else
    need = strcat(need , '  Entrance XYZ; ');
end    
if flag_area == 1
    have = strcat(have , '  Area; ');
else
    need = strcat(need , '  Area; ');
end
if flag_dist == 1
    have = strcat(have , '  H-Distance; ');
else
    need = strcat(need , '  H-Distance; ');
end
if flag_dist_ent == 1
    have = strcat(have , '  H-Distance for Entrances; ');
else
    need = strcat(need , '  H-Distance for Entrances; ');
end
if flag_stdf == 1
    have = strcat(have , '  V-Distance; ');
else
    need = strcat(need , '  V-Distance; ');
end
if flag_stdf_ent == 1
    have = strcat(have , '  V-Distance for Entrances; ');
else
    need = strcat(need , '  V-Distance for Entrances; ');
end
if flag_familarity == 1
    have = strcat(have , '  Familarities ');
else
    need = strcat(need , '  [Familarities]; ');
end
if flag_ent_distrib == 1
    have = strcat(have , '  Entrance Distribution; ');
else
    need = strcat(need , '  Entrance Distribution; ');
end
if length(need)~=0
    message = strvcat('You have already finished the following information:' , have , '' , 'You may still need  the following information:' , need);
else
    message = strvcat('You have already finished the following information:' , have , '' , 'ALL FINISHED!!!');
end



if flag_TAZ == 1
    XYZ = xlsread(fullnameO, 'TAZ');
    handles.XYZ = XYZ;
end
if flag_ENT == 1
    ENTXYZ = xlsread(fullnameO , 'Entrance');
    handles.ENTXYZ = ENTXYZ;
end
if flag_area == 1
    X_area = xlsread(fullnameO , 'Area');
    handles.X_area = X_area;
    set(handles.AreaInput , 'String' , 'Finished');
end
if flag_dist == 1
    X_dist = xlsread(fullnameO , 'H-Distance');
    handles.X_dist = X_dist;
end
if flag_dist_ent == 1
    X_dist_ent = xlsread(fullnameO , 'H-Distance Entrance');
    handles.X_dist_ent = X_dist_ent;
end
if flag_dist == 1 &  flag_dist_ent == 1
    set(handles.DistInput , 'String' , 'Finished');
elseif flag_dist == 1 &  flag_dist_ent == 0
    set(handles.DistInput , 'String' , 'Need TAZ-Entrance Matrix');
elseif flag_dist == 0 &  flag_dist_ent == 1
    set(handles.DistInput , 'String' , 'Need TAZ-TAZ Matrix');
end
if flag_stdf == 1
    X_stdf = xlsread(fullnameO , 'V-Distance');
    handles.X_stdf = X_stdf;
end
if flag_stdf_ent == 1
    X_stdf_ent = xlsread(fullnameO , 'V-Distance Entrance');
    handles.X_stdf_ent = X_stdf_ent;
end
if flag_stdf == 1 &  flag_stdf_ent == 1
    set(handles.StdfInput , 'String' , 'Finished');
elseif flag_stdf == 1 &  flag_stdf_ent == 0
    set(handles.StdfInput , 'String' , 'Need TAZ-Entrance Matrix');
elseif flag_stdf == 0 &  flag_stdf_ent == 1
    set(handles.StdfInput , 'String' , 'Need TAZ-TAZ Matrix');
end
if flag_familarity == 1
    X_familarity = xlsread(fullnameO , 'Familarity');
    handles.X_familarity = X_familarity;
    if TYPE_FAM == 1
        set(handles.FamInput , 'String' , 'Finished: aggregate')
    else
        set(handles.FamInput , 'String' , 'Finished: individual-level')
    end
end
if flag_ent_distrib == 1
    X_ent_distrib = xlsread(fullnameO , 'Entrance Distribution');
    handles.X_ent_distrib = X_ent_distrib;
    if TYPE_ENT_DIST == 2
        tab = tabulate(X_ent_distrib(:,2));
        X_ent_distrib_load_ind_derived = tab(: , [3]);
        X_ent_distrib_load_ind_derived = X_ent_distrib_load_ind_derived / 100;
        handles.X_ent_distrib_load_ind_derived = X_ent_distrib_load_ind_derived;
    end
    
end

beta = xlsread(fullnameO  , 'Beta');
b_area = beta(1);
handles.b_area = b_area;
set(handles.e_a , 'String' , num2str(b_area));
b_dist = beta(2);
handles.b_dist = b_dist;
set(handles.e_c , 'String' , num2str(b_dist));
b_stdf = beta(3);
handles.b_stdf = b_stdf;
set(handles.edit_b_stdf , 'String' , num2str(b_stdf));
b_familarity = beta(4);
handles.b_familarity = b_familarity;
set(handles.e_b , 'String' , num2str(b_familarity));
b_visited = beta(5);
handles.b_visited = b_visited;
set(handles.edit_b_visited , 'String' , num2str(b_visited));
b_past = beta(6);
handles.b_past = b_past;
set(handles.edit_b_past , 'String' , num2str(b_past));
guidata(hObject , handles);
clo = toc;
file_name = 'Unnamed';
main_fig = findall(0 , 'type', 'figure', 'tag', 'figure1');
set(main_fig, 'name', ['鼓浪屿游客行为模拟器 '])
msgbox({message; ' ' ; ['Elapsed time(s): ', num2str(clo)]} , 'Configuration File: Successfully Open')




    


% --------------------------------------------------------------------
function Untitled_4_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function sta_Callback(hObject, eventdata, handles)
% hObject    handle to sta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tic;
if ~isfield(handles, 'Sim_result')
    errordlg('There is no simulation result right now')
    return
end
[fname_xlsx , pname_xlsx] = uiputfile('SimResult_Statistics.xlsx' , 'Save the Statistics XLSX');
if isequal(fname_xlsx, 0) | isequal(pname_xlsx, 0)
    return
end
fullnameS = strcat(pname_xlsx , fname_xlsx);
if exist(fullnameS,'file')
    delete(fullnameS)
end
b_sim_times = handles.b_sim_times;
Sim_gn = handles.Sim_gn;
Sim_cv = handles.Sim_cv;
Sim_mean_actpp = handles.Sim_mean_actpp;
Sim_sta = [[1:b_sim_times]' , Sim_mean_actpp , Sim_gn , Sim_cv];
Sim_mean_actpp_mean = mean(Sim_mean_actpp);
Sim_mean_gn = handles.Sim_mean_gn;
Sim_mean_cv = handles.Sim_mean_cv;

%2016-3-18：消费模拟
if isfield(handles, 'Sim_result_money')
    TAZMoneyResult = handles.Sim_result_money;
    for k = 1 : b_sim_times
        crt_TAZMoneyResult = TAZMoneyResult(k).taz(:,4);
        TAZMoneyResult_single(:,k) = crt_TAZMoneyResult;
        NTAZ = length(crt_TAZMoneyResult);
        money_gn(k,1) = llz_gn(ones(NTAZ , 1) , crt_TAZMoneyResult , 0);
        money_cv(k,1) = std(crt_TAZMoneyResult) / mean(crt_TAZMoneyResult);
    end
    TAZMoneyResult_mean = mean(TAZMoneyResult_single, 2);
    money_mean_gn = llz_gn(ones(NTAZ , 1) , TAZMoneyResult_mean , 0);
    money_mean_cv = std(TAZMoneyResult_mean) / mean(TAZMoneyResult_mean);
    Sim_sta = [Sim_sta, money_gn, money_cv];
    xlswrite(fullnameS , {'Sim. Index' , 'Average Num. of Activities', ...
        'Gini of Individual Distribution' , 'CV of Individual Distribution',...
        'Gini of Expenditure Distribution', 'CV of Expenditure Distribution'} , ...
        'Result of Every Simulatoin' , 'A1')
    xlswrite(fullnameS ,Sim_sta, 'Result of Every Simulatoin' , 'A2')
else
    xlswrite(fullnameS , {'Sim. Index' , 'Average Num. of Activities', ...
        'Gini of Individual Distribution' , 'CV of Individual Distribution'} , 'Result of Every Simulatoin' , 'A1')
    xlswrite(fullnameS ,Sim_sta, 'Result of Every Simulatoin' , 'A2')
end

xlswrite(fullnameS , {'Simulated Average Num. of Activities per Individual (Mean Level Across All Simulations):'} , 'Mean Result of All Simulations' , 'A1')
xlswrite(fullnameS , Sim_mean_actpp_mean , 'Mean Result of All Simulations' , 'A2')
xlswrite(fullnameS , {'Simulated Mean Individual Spatial Distribution Gini Coefficient (Mean Level Across All Simulations):'} , 'Mean Result of All Simulations' , 'A5')
xlswrite(fullnameS , Sim_mean_gn , 'Mean Result of All Simulations' , 'A6')
xlswrite(fullnameS , {'Simulated Mean Coefficient of Variationn of Individual Spatial Distribution (Mean Level Across All Simulations):'} , 'Mean Result of All Simulations' , 'A9')
xlswrite(fullnameS , Sim_mean_cv , 'Mean Result of All Simulations' , 'A10')
if isfield(handles, 'Sim_result_money')
    xlswrite(fullnameS , {'Simulated Mean Expenditure Spatial Distribution Gini Coefficient (Mean Level Across All Simulations):'} , 'Mean Result of All Simulations' , 'A13')
    xlswrite(fullnameS , money_mean_gn , 'Mean Result of All Simulations' , 'A14')
    xlswrite(fullnameS , {'Simulated Mean Coefficient of Variationn of Individual Spatial Distribution (Mean Level Across All Simulations):'} , 'Mean Result of All Simulations' , 'A17')
    xlswrite(fullnameS , money_mean_cv , 'Mean Result of All Simulations' , 'A18')
end
clo = toc;
msgbox({[fname_xlsx, ' saved successfully'];['Elapsed time(s): ',num2str(clo)]})



% --------------------------------------------------------------------
function TAZ_distrib_Callback(hObject, eventdata, handles)
% hObject    handle to TAZ_distrib (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tic;
if ~isfield(handles, 'Sim_result')
    errordlg('There is no simulation result right now')
    return
end
[fname_xlsx , pname_xlsx] = uiputfile('SimResult_Individual_Distribution.xlsx' , 'Save the Individual Distribution XLSX');
if isequal(fname_xlsx, 0) | isequal(pname_xlsx, 0)
    return
end
fullnameS = strcat(pname_xlsx , fname_xlsx);
Sim_taz_distrib = handles.Sim_taz_distrib;
if exist(fullnameS,'file')
    delete(fullnameS)
end
b_sim_times = handles.b_sim_times;
Sim_taz_distrib = handles.Sim_taz_distrib;
Sim_mean_taz_distrib = mean(Sim_taz_distrib , 2);
NTAZ = length(Sim_mean_taz_distrib);
Sim_mean_taz_distrib = [[1:NTAZ]' , Sim_mean_taz_distrib];
Sim_taz_distrib = [[1:NTAZ]' , Sim_taz_distrib];
for i = 1 : b_sim_times
    sim_index{1 , i} = ['Sim' , num2str(i)];
end

xlswrite(fullnameS , {'TAZ. Index'} , 'Result of Every Simulatoin' , 'A1')
xlswrite(fullnameS , sim_index , 'Result of Every Simulatoin' , 'B1')
xlswrite(fullnameS ,Sim_taz_distrib, 'Result of Every Simulatoin' , 'A2')

xlswrite(fullnameS , {'TAZ. Index' , 'Simulated Mean Distribution'} , 'Mean Result of All Simulations' , 'A1')
xlswrite(fullnameS , Sim_mean_taz_distrib , 'Mean Result of All Simulations' , 'A2')
clo = toc;
msgbox({[fname_xlsx, ' saved successfully'];['Elapsed time(s): ',num2str(clo)]})



% --------------------------------------------------------------------
function Num_Act_Callback(hObject, eventdata, handles)
% hObject    handle to Num_Act (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tic;
if ~isfield(handles, 'Sim_result')
    errordlg('There is no simulation result right now')
    return
end
[fname_xlsx , pname_xlsx] = uiputfile('SimResult_Num_Activities.xlsx' , 'Save the Num Activities XLSX');
if isequal(fname_xlsx, 0) | isequal(pname_xlsx, 0)
    return
end
fullnameS = strcat(pname_xlsx , fname_xlsx);
if exist(fullnameS,'file')
    delete(fullnameS)
end
b_sim_times = handles.b_sim_times;
Sim_actpp = handles.Sim_actpp;
NPED = size(Sim_actpp , 1);
Sim_actpp = [[1:NPED]' , Sim_actpp];
for i = 1 : b_sim_times
    sim_index{1 , i} = ['Sim' , num2str(i)];
end

xlswrite(fullnameS , {'Consumer. Index'} , 'Result of Every Simulatoin' , 'A1')
xlswrite(fullnameS , sim_index , 'Result of Every Simulatoin' , 'B1')
xlswrite(fullnameS ,Sim_actpp, 'Result of Every Simulatoin' , 'A2')
clo = toc;
msgbox({[fname_xlsx, ' saved successfully'];['Elapsed time(s): ',num2str(clo)]})


% --------------------------------------------------------------------
function raw_data_Callback(hObject, eventdata, handles)
% hObject    handle to raw_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tic;
if ~isfield(handles, 'Sim_result')
    errordlg('There is no simulation result right now')
    return
end
[fname_xlsx , pname_xlsx] = uiputfile('SimResult_Raw_Path.xlsx' , 'Save the Num Activities XLSX');
if isequal(fname_xlsx, 0) | isequal(pname_xlsx, 0)
    return
end
fullnameS = strcat(pname_xlsx , fname_xlsx);
if exist(fullnameS,'file')
    delete(fullnameS)
end
b_sim_times = handles.b_sim_times;
Sim_result = handles.Sim_result;
NPED = handles.NPED;
for i = 1 : NPED
%     ped_index{i , 1} = ['Consumer' , num2str(i)];
    ped_index{i , 1} = [ num2str(i)];
end
for i = 1 : b_sim_times
    clear route_matrix
    xlswrite(fullnameS ,{'Consumer. Index' , 'Route'}, ['Result of Sim', num2str(i)] , 'A1')
    xlswrite(fullnameS ,ped_index, ['Result of Sim', num2str(i)] , 'A2')
    crt = Sim_result(i).ped;
    crt_allRoute = crt(: , 3);
    max_actpp_plus1 = max(cell2mat(crt(: , 4))) + 1;
    for j = 1 : NPED
        crt_crtRoute = crt_allRoute{j};
        route_matrix(j , :) = [crt_crtRoute , nan(1 , max_actpp_plus1-length(crt_crtRoute))];
    end
    xlswrite(fullnameS ,route_matrix, ['Result of Sim', num2str(i)] , 'B2')
end
clo = toc;
msgbox({[fname_xlsx, ' saved successfully'];['Elapsed time(s): ',num2str(clo)]})
    


% --- Executes on selection change in popupmenu10.
function popupmenu10_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu10 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu10
choice = get(hObject , 'value');
switch choice
    case 1
        az = handles.az;
        el = handles.el;
        view(az,el)
    case 2
        view(2)
    case 3
        vp_xyz = inputdlgWC({'X Coordinate','Y Coordinate' , 'Z Coordinate'},...
            'Set X-Y-Z Coordinates of View Point');
        if isempty(vp_xyz)
            return
        end
        try
            vpx = str2num(vp_xyz{1});
            vpy = str2num(vp_xyz{2});
            vpz = str2num(vp_xyz{3});
        catch
            errordlg('Invalid input.', 'Error')
            return
        end
        if isempty(vpx) | isempty(vpy) | isempty(vpz)
            return
        end
        if vpx==0 & vpy==0 & vpz==0
            errordlg('X-Y-Z could not be all 0.', 'Error')
            return
        end
        view([vpx , vpy , vpz])        
end


% --- Executes during object creation, after setting all properties.
function popupmenu10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes during object creation, after setting all properties.
function text41_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text41 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --------------------------------------------------------------------
function OD_Callback(hObject, eventdata, handles)
% hObject    handle to OD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tic;
if ~isfield(handles, 'Sim_result')
    errordlg('There is no simulation result right now')
    return
end
[fname_xlsx , pname_xlsx] = uiputfile('SimResult_OD_Matrix.xlsx' , 'Save the OD Matrix XLSX');
if isequal(fname_xlsx, 0) | isequal(pname_xlsx, 0)
    return
end
fullnameS = strcat(pname_xlsx , fname_xlsx);
if exist(fullnameS,'file')
    delete(fullnameS)
end
b_sim_times = handles.b_sim_times;
Sim_OD_3d = handles.Sim_OD_3d;
Sim_mean_OD = handles.Sim_mean_OD;
NPED = handles.NPED;

for i = 1 : b_sim_times
    crt_OD = Sim_OD_3d(: , : , i);
    xlswrite(fullnameS ,{['OD Matrix of Simulation ', num2str(i) , '. This is a ', num2str(size(crt_OD ,1)),' * ', num2str(size(crt_OD ,2)),' Matrix']}, ['Result of Sim', num2str(i)] , 'A1')
    xlswrite(fullnameS ,crt_OD, ['Result of Sim', num2str(i)] , 'A2')
end

xlswrite(fullnameS ,{['Mean OD Matrix of All Simulations' , '. This is a ', num2str(size(Sim_mean_OD ,1)),' * ', num2str(size(Sim_mean_OD ,2)),' Matrix']}, ['Mean Result of All Simulations'] , 'A1')
xlswrite(fullnameS ,Sim_mean_OD, ['Mean Result of All Simulations'] , 'A2')
clo = toc;
msgbox({[fname_xlsx, ' saved successfully'];['Elapsed time(s): ',num2str(clo)]})



function clocker_tt_Callback(hObject, eventdata, handles)
% hObject    handle to clocker_tt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of clocker_tt as text
%        str2double(get(hObject,'String')) returns contents of clocker_tt as a double


% --- Executes during object creation, after setting all properties.
function clocker_tt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to clocker_tt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function clocker_single_Callback(hObject, eventdata, handles)
% hObject    handle to clocker_single (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of clocker_single as text
%        str2double(get(hObject,'String')) returns contents of clocker_single as a double


% --- Executes during object creation, after setting all properties.
function clocker_single_CreateFcn(hObject, eventdata, handles)
% hObject    handle to clocker_single (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_Z_factor_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Z_factor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
    Z_factor = str2num(get(hObject , 'String'));
catch
    errordlg('Invalid input','Error')
    return
end
if isempty(Z_factor)
    errordlg('Invalid input','Error')
    return
end
handles.Z_factor = Z_factor;
guidata(hObject , handles);

% Hints: get(hObject,'String') returns contents of edit_Z_factor as text
%        str2double(get(hObject,'String')) returns contents of edit_Z_factor as a double


% --- Executes during object creation, after setting all properties.
function edit_Z_factor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Z_factor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function OD_Plot_T_Callback(hObject, eventdata, handles)
% hObject    handle to OD_Plot_T (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
od_t_str = {'In OD Map Plot, all OD-values are normalized to numbers between 0 and 10, and only those above the threshold would appear. The defaut threshold is 1, you can input a new threshold and keep it work through simulation.'}
new_od_t = inputdlgWC(od_t_str , 'OD Plot Threshold');
if ~isempty(new_od_t)
    try
        new_od_t = str2num(new_od_t{:});
    catch
        errordlg('Invalid Input', 'Input Error')
        return
    end
else
    return
end
if isempty(new_od_t)
    errordlg('Invalid Input', 'Input Error')
    return
end
if new_od_t < 0 | new_od_t > 10 
    errordlg('Threshold must be 0~10', 'Input Error')
    return
end
handles.od_t = new_od_t;
guidata(hObject , handles)


% --------------------------------------------------------------------
function change_od_mode_Callback(hObject, eventdata, handles)
% hObject    handle to change_od_mode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if strcmp(get(hObject,'Checked'),'on')
    set(hObject,'Checked','off');
else 
    set(hObject,'Checked','on');
end
if strcmp(get(hObject , 'Checked'), 'on')               %如果当前选中，进入绝对模式
    helpstr = {'Notice:';'1. By default a relative mode is used when plotting OD plot. Now it is going to use a ABSOLUTE mode, in which original OD-values will be used, instead of normalized values';...
        '2. You should set a fixed maximum possible OD-value, which will be plotted in a maximum width, OD-values above this value will not appear.';...
        '3. You should also set a fixed minimum OD-value, which is similar with threshold in relative mode, OD-values below this value will not appear.';...
        '4. WARNING: these maximum and minimum values should be set carefully, since if not, a lot of (maybe all) desire lines would be invisible for too small width'};
    hh = helpdlg(helpstr , 'Change to Absolute Mode');
    waitfor(hh);
    od_abs_mode = inputdlgWC({'Please input a fixed maximum possible OD-value', 'Please input a fixed minimum OD-value'} , 'Change to Absolute Mode');
    if isempty(od_abs_mode)
        errordlg('You must input valid values to swtich to absolute mode', 'Error')
        handles.od_abs_mode = 0;
        guidata(hObject , handles)
        set(hObject,'Checked','off');
        return
    end
    try
        od_abs_mode_max = str2num(od_abs_mode{1});
        od_abs_mode_min = str2num(od_abs_mode{2});
    catch
        errordlg('Invalid input, you must input valid values to swtich to absolute mode', 'Error')
        handles.od_abs_mode = 0;
        guidata(hObject , handles)
        set(hObject,'Checked','off');
        return
    end
    if isempty(od_abs_mode_max) | (~isempty(od_abs_mode_max) & od_abs_mode_max < 0)
        errordlg('You must input valid maximum value to swtich to absolute mode', 'Error')
        valid = 0;
    end
    if isempty(od_abs_mode_min) | (~isempty(od_abs_mode_min) & od_abs_mode_min < 0)
        errordlg('You must input valid minimum value to swtich to absolute mode', 'Error')
        valid = 0;
    end
    if ~isempty(od_abs_mode_max) & ~isempty(od_abs_mode_min) & od_abs_mode_max < od_abs_mode_min
        errordlg('Minimum value should not be bigger than maximum value', 'Error')
        valid = 0;
    end
    if exist('valid', 'var') & valid == 0
        handles.od_abs_mode = 0;
        guidata(hObject , handles)
        set(hObject,'Checked','off');
        return
    end
    od_abs_mode = 1;
    handles.od_abs_mode_max = od_abs_mode_max;
    handles.od_abs_mode_min = od_abs_mode_min;
else
    od_abs_mode = 0;
end
handles.od_abs_mode = od_abs_mode;
guidata(hObject , handles)


% --- Executes on button press in edit_Comp_taz_distrib.
function edit_Comp_taz_distrib_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Comp_taz_distrib (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isfield(handles, 'NTAZ')
    NTAZ = handles.NTAZ;
else
    errordlg('Num. TAZ is neccessary', 'Comparison Data Error')
    return
end
[fname , pname]=uigetfile('*.xlsx' , 'Open the Comparison TAZ Distribution CSV');
if isequal(fname, 0) | isequal(pname, 0)
    return
end
fullname = strcat(pname, fname);
Comp = xlsread(fullname , 1);
if length(Comp) == 0
    Comp = xlsread(fullname , 'Mean Result of All Simulations');
end
Comp_TAZ_distrib = Comp(: , 2);
Comp_cv = std(Comp_TAZ_distrib) / mean(Comp_TAZ_distrib);
Comp_gn = llz_gn(ones(NTAZ , 1) , Comp_TAZ_distrib , 0);
handles.Comp_TAZ_distrib = Comp_TAZ_distrib;
handles.Comp_cv = Comp_cv;
handles.Comp_gn = Comp_gn;
if length(get(handles.edit_Comp_actpp, 'String')) ==0 & isfield(handles, 'NPED')
    NPED = handles.NPED;
    Comp_mean_actpp = sum(Comp_TAZ_distrib) / NPED;
    handles.Comp_mean_actpp = Comp_mean_actpp;
    set(handles.edit_Comp_actpp, 'String', num2str(Comp_mean_actpp))
end
guidata(hObject , handles)
msgbox('Load Comparison TAZ distribution data successfully')



% --- Executes on button press in edit_Comp_od.
function edit_Comp_od_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Comp_od (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isfield(handles, 'NTAZ')
    NTAZ = handles.NTAZ;
else
    errordlg('Num. TAZ is neccessary', 'Comparison Data Error')
    return
end
[fname , pname]=uigetfile('*.xlsx' , 'Open the Comparison OD Matrix CSV');
if isequal(fname, 0) | isequal(pname, 0)
    return
end
fullname = strcat(pname, fname);
Comp = xlsread(fullname , 1);
if length(Comp) == 0
    Comp = xlsread(fullname , 'Mean Result of All Simulations');
end
Comp_OD = Comp;
handles.Comp_OD = Comp_OD;
if length(get(handles.edit_Comp_actpp, 'String')) ==0 & isfield(handles, 'NPED')
    NPED = handles.NPED;
    Comp_mean_actpp = sum(sum(Comp_OD)) / NPED + 1;                 %+1是因为入口那一步
    handles.Comp_mean_actpp = Comp_mean_actpp;
    set(handles.edit_Comp_actpp, 'String', num2str(Comp_mean_actpp))
end
guidata(hObject , handles)
msgbox('Load Comparison OD data successfully')



function edit_Comp_actpp_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Comp_actpp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
    Comp_mean_actpp = str2num(get(hObject,'String'));
catch
    errordlg('Invalid Input', 'Input Error')
    return
end
if isempty(Comp_mean_actpp)
    errordlg('Invalid Input', 'Input Error')
    return
end
handles.Comp_mean_actpp = Comp_mean_actpp;
guidata(hObject , handles)

% Hints: get(hObject,'String') returns contents of edit_Comp_actpp as text
%        str2double(get(hObject,'String')) returns contents of edit_Comp_actpp as a double


% --- Executes during object creation, after setting all properties.
function edit_Comp_actpp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Comp_actpp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton21.
function pushbutton21_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isfield(handles, 'Comp_mean_actpp')
    str_actpp = ['Mean number of activities per consumer: ', num2str(handles.Comp_mean_actpp)];
else
    str_actpp = ['Mean number of activities per consumer: N/A', ];
end
if isfield(handles , 'Comp_TAZ_distrib')
    Comp_TAZ_distrib = handles.Comp_TAZ_distrib;
    Comp_gn = handles.Comp_gn;
    Comp_cv = handles.Comp_cv;
    str_TAZ = strvcat('TAZ distribution data summary: ' , ['    Mean: ', num2str(mean(Comp_TAZ_distrib))], ...
        ['    Max: ',  num2str(max(Comp_TAZ_distrib))] ,['    Min: ',  num2str(min(Comp_TAZ_distrib))],...
        ['    CV: ', num2str(Comp_cv)], ['    Gini: ', num2str(Comp_gn)]);
else
    str_TAZ = 'TAZ distribution data: N/A'
end
if isfield(handles , 'Comp_OD')
    Comp_OD = handles.Comp_OD;
    str_OD = strvcat('OD matrix data summary: ' , ['    Mean: ', num2str(mean(mean(Comp_OD)))], ...
        ['    Max: ',  num2str(max(max(Comp_OD)))] ,['    Min: ',  num2str(min(min(Comp_OD)))]);
else
    str_OD = 'OD matrix data: N/A';
end
msgbox({'Summary of Comparison Data'; ' ' ; ' ' ; str_actpp ; ' ' ; str_TAZ; ' ' ; str_OD} , 'Summary')
 

% --- Executes on button press in pushbutton22.
function pushbutton22_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isfield(handles, 'Sim_result')
    errordlg('There is NO valid simulatoin result','Summary')
    return
end
if isfield(handles, 'Sim_mean_actpp')
    str_actpp = ['Mean number of activities per consumer: ', num2str(mean(handles.Sim_mean_actpp))];
else
    str_actpp = ['Mean number of activities per consumer: N/A', ];
end
if isfield(handles , 'Sim_mean_taz_distrib')
    Sim_mean_taz_distrib = handles.Sim_mean_taz_distrib;
    Sim_mean_gn = handles.Sim_mean_gn;
    Sim_mean_cv = handles.Sim_mean_cv;
    str_TAZ = strvcat('TAZ distribution data summary: ' , ['    Mean: ', num2str(mean(Sim_mean_taz_distrib))], ...
        ['    Max: ',  num2str(max(Sim_mean_taz_distrib))] ,['    Min: ',  num2str(min(Sim_mean_taz_distrib))],...
        ['    CV: ', num2str(Sim_mean_cv)], ['    Gini: ', num2str(Sim_mean_gn)]);
else
    str_TAZ = 'TAZ distribution data: N/A';
end
if isfield(handles , 'Sim_mean_OD')
    Sim_mean_OD = handles.Sim_mean_OD;
    str_OD = strvcat('OD matrix data summary: ' , ['    Mean: ', num2str(mean(mean(Sim_mean_OD)))], ...
        ['    Max: ',  num2str(max(max(Sim_mean_OD)))] ,['    Min: ',  num2str(min(min(Sim_mean_OD)))]);
else
    str_OD = 'OD matrix data: N/A'
end
msgbox({'Summary of Current Simulation Data'; ' ' ; ' ' ; str_actpp ; ' ' ; str_TAZ; ' ' ; str_OD} , 'Summary')


% --- Executes on button press in Legend_check.
function Legend_check_Callback(hObject, eventdata, handles)
% hObject    handle to Legend_check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Legend_ON = get(hObject,'Value');
handles.Legend_ON = Legend_ON;
%关于colormap
colormap_legend_fig = findall(0, 'type', 'figure', ...
   'userdata', 'colormap legend' );
if ~isempty(colormap_legend_fig)
    if Legend_ON == 1
        set(colormap_legend_fig, 'visible', 'on')
    else
        set(colormap_legend_fig, 'visible', 'off')
    end
    return              %下面的show/high什么的很危险，会出很长一条legend
end
if Legend_ON == 0
    legend hide
else
    legend show
end

guidata(hObject , handles)

% Hint: get(hObject,'Value') returns toggle state of Legend_check


% --------------------------------------------------------------------
function save_plot_Callback(hObject, eventdata, handles)
% hObject    handle to save_plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[fname , pname] = uiputfile('*.png' , 'Save Plot');
if isequal(fname, 0) | isequal(pname, 0)
    return
end
tic;
fullname = strcat(pname , fname);
if exist(fullname,'file')
    delete(fullname)
end
export_fig(gca, fullname)
clo = toc;
msgbox({[fname, ' saved successfully'];['Elapsed time(s): ',num2str(clo)]})


% --- Executes during object creation, after setting all properties.
function uipanel1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uipanel1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in Entrance_ON_check.
function Entrance_ON_check_Callback(hObject, eventdata, handles)
% hObject    handle to Entrance_ON_check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Ent_ON = get(hObject,'Value');
handles.Ent_ON = Ent_ON;

if ~isfield(handles , 'Z_factor')
    Z_factor = str2double(get(handles.edit_Z_factor, 'String'));
else
    Z_factor = handles.Z_factor
end
if isfield(handles , 'ENTXYZ') & Ent_ON == 1
    entxyz = handles.ENTXYZ;
    entxyz = entxyz(:, 2:4);
    entxyz(:,3) = entxyz(:,3) * Z_factor;
    h_ent = plot3(entxyz(: , 1), entxyz(:, 2), entxyz(:, 3), 'kp','MarkerFacecolor', 'k');
    handles.h_ent = h_ent;
elseif Ent_ON == 0 & isfield(handles , 'h_ent')
    h_ent = handles.h_ent;
    delete(h_ent);
end
guidata(hObject , handles)
    
% Hint: get(hObject,'Value') returns toggle state of Entrance_ON_check


% --------------------------------------------------------------------
function edit_markersize_Callback(hObject, eventdata, handles)
% hObject    handle to edit_markersize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
MS_str = {'This value control the marker size in TAZ distribution plots. The defaut size is 5, you can input a new value and keep it work through simulation.'};
new_marker_size = inputdlgWC(MS_str , 'Marker Size');
if ~isempty(new_marker_size)
    try
        new_marker_size = str2double(new_marker_size{:});
    catch
        errordlg('Invalid Input', 'Input Error')
        return
    end
else
    return
end
if new_marker_size <= 0
    errordlg('Makersize must be positive', 'Input Error')
    return
end
handles.marker_size = new_marker_size;
guidata(hObject , handles)


% --------------------------------------------------------------------
function long_form_Callback(hObject, eventdata, handles)
% hObject    handle to long_form (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function import_path_Callback(hObject, eventdata, handles)
% hObject    handle to import_path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 
% [fname , pname]=uigetfile('*.csv' , 'Open the Path CSV');
% if isequal(fname, 0) | isequal(pname, 0)
%     return
% end
% fullname = strcat(pname,fname);
% try 
%     path_rawdata = csvread(fullname);
% catch
%     try 
%         path_rawdata = csvread(fullname, 1, 0);
%         NPath = size(path_rawdata, 1);
%     catch
%         msgbox('Unable to open the Path CSV')
%         return
%     end
% end
% handles.path_rawdata = path_rawdata;
% guidata(hObject, handles);
% msgbox(['Successfully import ', num2str(NPath) ' path(s)']);
% NINV = size(path_rawdata ,1);
% rhs_exist_flag = '';
% rhs_process_flag = 1;            %是否基本的自变量都有了，以便能进一步处理数据
% if ~isfield(handles, 'X_area')
%     rhs_exist_flag = strcat(rhs_exist_flag , 'No area data; ');
%     rhs_process_flag = 0
% else
%     X_area = handles.X_area;
% end
% if ~isfield(handles, 'X_dist')
%     rhs_exist_flag = strcat(rhs_exist_flag , 'No horizental distance (TAZ-TAZ) data; ');
%     rhs_process_flag = 0
% else
%     X_dist = handles.X_dist;
% end
% if ~isfield(handles, 'X_dist_ent')
%     rhs_exist_flag = strcat(rhs_exist_flag , 'No horizental distance (TAZ-Entrance) data; ');
%     rhs_process_flag = 0
% else
%     X_dist_ent = handles.X_dist_ent;
% end
% if ~isfield(handles, 'X_stdf')
%     rhs_exist_flag = strcat(rhs_exist_flag , 'No vertical distance (TAZ-TAZ) data; ');
%     rhs_process_flag = 0
% else
%     X_stdf = handles.X_stdf;
% end
% if ~isfield(handles, 'X_stdf_ent')
%     rhs_exist_flag = strcat(rhs_exist_flag , 'No vertical distance (TAZ-Entrance) data; ');
%     rhs_process_flag = 0
% else
%     X_stdf_ent = handles.X_stdf_ent;
% end
% if ~isfield(handles, 'X_familarity')
%     rhs_exist_flag = strcat(rhs_exist_flag, 'No attractiveness data, but this is optional');
% else
%     X_familarity = handles.X_familarity;
% end
% NIND = size(path_rawdata , 1);
% if rhs_process_flag == 1 & ~isfield(handles, 'NTAZ')
%     NTAZ = str2num(cell2mat(inputdlg('Please input the Num. of TAZs in this data', 'NTAZ')));
% elseif rhs_process_flag == 1 & isfield(handles, 'NTAZ')
%     NTAZ = handles.NTAZ;
% end
% NALT = NTAZ + 1;
% if rhs_process_flag == 1 
%     t = 1;                          %总的选择情景
%     for i = 1 : NIND
%         crtdata = path_rawdata(i, :);
%         crtdata = crtdata(crtdata > 0);
%         crt_visited = zeros(NTAZ, 1);
%         crt_past = 0;
%         % 入口
%         crt_from = crtdata(2);
%         crt_to = crtdata(3);
%         logit_long_form(((t-1)*NALT) + (1:NALT), 1) = crtdata(1);
%         logit_long_form(((t-1)*NALT) + (1:NALT), 2) = crt_from;
%         crtchoice = zeros(NALT, 1);
%         crtchoice(crt_to) = 1;
%         logit_long_form(((t-1)*NALT) + (1:NALT), 3) = 1:NALT;
%         logit_long_form(((t-1)*NALT) + (1:NALT), 4) = crtchoice;
%         logit_long_form(((t-1)*NALT) + (1:NALT), 5) = [X_area ; 0];
%         logit_long_form(((t-1)*NALT) + (1:NALT), 6) = [X_dist_ent(:, crt_from) ; 0];
%         logit_long_form(((t-1)*NALT) + (1:NALT), 7) = [X_stdf_ent(:, crt_from) ; 0];
%         logit_long_form(((t-1)*NALT) + (1:NALT), 8) = [crt_visited; 0];
%         logit_long_form(((t-1)*NALT) + (1:NALT), 9) = [zeros(NTAZ, 1) ; crt_past];
%         crt_visited(crt_to) = crt_visited(crt_to) + 1;
%         crt_past = crt_past + 1;
%         t = t + 1;
%         % 回游
%         j = 3;
%         while j < length(crtdata)
%             crt_from = crtdata(j);
%             crt_to = crtdata(j+1);
%             crtchoice = zeros(NALT, 1);
%             crtchoice(crt_to) = 1;
%             logit_long_form(((t-1)*NALT) + (1:NALT), 1) = crtdata(1);
%             logit_long_form(((t-1)*NALT) + (1:NALT), 2) = crt_from;
%             logit_long_form(((t-1)*NALT) + (1:NALT), 3) = 1:NALT;
%             logit_long_form(((t-1)*NALT) + (1:NALT), 4) = crtchoice;
%             logit_long_form(((t-1)*NALT) + (1:NALT), 5) = [X_area ; 0];
%             logit_long_form(((t-1)*NALT) + (1:NALT), 6) = [X_dist(:, crt_from) ; 0];
%             logit_long_form(((t-1)*NALT) + (1:NALT), 7) = [X_stdf(:, crt_from) ; 0];
%             logit_long_form(((t-1)*NALT) + (1:NALT), 8) = [crt_visited; 0];
%             logit_long_form(((t-1)*NALT) + (1:NALT), 9) = [zeros(NTAZ, 1) ; crt_past];
%             crt_visited(crt_to) = crt_visited(crt_to) + 1;
%             crt_past = crt_past + 1;
%             t = t + 1;
%             j = j + 1;
%         end
%         %回家
%         crt_from = crtdata(end);
%         crtchoice = [zeros(NTAZ, 1); 1];
%         logit_long_form(((t-1)*NALT) + (1:NALT), 1) = crtdata(1);
%         logit_long_form(((t-1)*NALT) + (1:NALT), 2) = crt_from;
%         logit_long_form(((t-1)*NALT) + (1:NALT), 3) = 1:NALT;
%         logit_long_form(((t-1)*NALT) + (1:NALT), 4) = crtchoice;
%         logit_long_form(((t-1)*NALT) + (1:NALT), 5) = [X_area ; 0];
%         logit_long_form(((t-1)*NALT) + (1:NALT), 6) = [X_dist(:, crt_from) ; 0];
%         logit_long_form(((t-1)*NALT) + (1:NALT), 7) = [X_stdf(:, crt_from) ; 0];
%         logit_long_form(((t-1)*NALT) + (1:NALT), 8) = [crt_visited; 0];
%         logit_long_form(((t-1)*NALT) + (1:NALT), 9) = [zeros(NTAZ, 1) ; crt_past];
%         t = t + 1;
%     end
% end
% 
% if exist('logit_long_form' , 'var') & ~exist('X_familarity', 'var')
%     NCS = size(logit_long_form, 1) / NALT;
%     group = reshape(repmat(1:NCS, NALT, 1), NCS*NALT, 1);
%     logit_long_form = [logit_long_form(:,1), group, logit_long_form(:,2:end)];
%     long_form_var_index = [6:10];
%     long_form_choice_index = 5;
%     long_form_var_names = {'Individual', 'Group', 'From', 'To', 'Choice', 'Area', ...
%         'Distance', 'Stair', 'Visited', 'Past'};
% elseif exist('logit_long_form' , 'var') & exist('X_familarity', 'var') & size(X_familarity, 2) > 0 & size(X_familarity, 2) ~= NINV
%     NCS = size(logit_long_form, 1) / NALT;
%     group = reshape(repmat(1:NCS, NALT, 1), NCS*NALT, 1);
%     logit_long_form = [logit_long_form(:,1), group, logit_long_form(:,2:end)];
%     long_form_var_index = [6:10];
%     long_form_choice_index = 5;
%     long_form_var_names = {'Individual', 'Group', 'From', 'To', 'Choice', 'Area', ...
%         'Distance', 'Stair', 'Visited', 'Past'};
%     warndlg({'Current Attractiveness is individual level, but the Num. of indivdual does NOT equal with the Num. of paths.';...
%         'So it is not used in the model, if you want to use it, make sure that Num. of individual = Num. of paths, or use attractiveness in aggregate level.'}, 'Attractiveness Not Used');
% elseif exist('logit_long_form' , 'var') & exist('X_familarity', 'var') & size(X_familarity, 2) == 0
%     NCS = size(logit_long_form, 1) / NALT;
%     group = reshape(repmat(1:NCS, NALT, 1), NCS*NALT, 1);
%     familarity = repmat(X_familarity, NCS, 1);
%     logit_long_form = [logit_long_form(:,1), group, logit_long_form(:,2:5), familarity, logit_long_form(:,6:end)];
%     long_form_var_index = [6:11];
%     long_form_choice_index = 5;
%     long_form_var_names = {'Individual', 'Group', 'From', 'To', 'Choice', 'Area', ...
%         'Attractiveness' , 'Distance', 'Stair', 'Visited', 'Past'};
% elseif exist('logit_long_form' , 'var') & exist('X_familarity', 'var') & size(X_familarity, 2) == NINV
%     NCS = size(logit_long_form, 1) / NALT;
%     group = reshape(repmat(1:NCS, NALT, 1), NCS*NALT, 1);
%     familarity = [];
%     for tt = 1 : NCS
%         crt_IND = logit_long_form((tt-1)*NALT+1, 1);
%         crt_familarity = [X_familarity(:, crt_IND); 0];
%         familarity = [familarity; crt_familarity];
%     end
%     logit_long_form = [logit_long_form(:,1), group, logit_long_form(:,2:5), familarity, logit_long_form(:,6:end)];
%     long_form_var_index = [6:11];
%     long_form_choice_index = 5;
%     long_form_var_names = {'Individual', 'Group', 'From', 'To', 'Choice', 'Area', ...
%         'Attractiveness' , 'Distance', 'Stair', 'Visited', 'Past'};
% end


% --------------------------------------------------------------------
function logit_est_Callback(hObject, eventdata, handles)
% hObject    handle to logit_est (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isfield(handles, 'path_rawdata')
    errordlg('There are NO path data, please import it first.' ,'No Path Data')
    return
else
    path_rawdata = handles.path_rawdata;
end

if ~isfield(handles, 'NTAZ')
    errordlg('There is NO Num. of TAZ data', 'No NTAZ')
    return
else
    NTAZ = handles.NTAZ;
end

%以下：判断一下能否运用时间变量，以为下面的做准备， 2016-3-8
use_time_var = 0;
if handles.adv_mode == 1
    if isfield(handles, 'time_var')
        time_var = handles.time_var;
        if isfield(handles, 'space_time_path_rawdata')
            use_time_var = 1;
            space_time_path_rawdata = handles.space_time_path_rawdata;
        else
            warnstr = ['You have specify time variables, but there is no spatiotemporal path data, ',...
                'so time variables are not included in the model'];
            warn_h = warndlg(warnstr, 'Time Variables');
            waitfor(warn_h)
        end
    end
end
%以上：判断一下能否运用时间变量，以为下面的做准备， 2016-3-8

if handles.adv_mode == 0                    %2016.1.28，考虑普通模式
    NINV = size(path_rawdata ,1);
    rhs_exist_flag = '';
    rhs_process_flag = 1;            %是否基本的自变量都有了，以便能进一步处理数据
    if ~isfield(handles, 'X_area')
        rhs_exist_flag = strcat(rhs_exist_flag , 'No area data; ');
        rhs_process_flag = 0;
    else
        X_area = handles.X_area;
    end
    if ~isfield(handles, 'X_dist')
        rhs_exist_flag = strcat(rhs_exist_flag , 'No horizental distance (TAZ-TAZ) data; ');
        rhs_process_flag = 0;
    else
        X_dist = handles.X_dist;
    end
    if ~isfield(handles, 'X_dist_ent')
        rhs_exist_flag = strcat(rhs_exist_flag , 'No horizental distance (TAZ-Entrance) data; ');
        rhs_process_flag = 0;
    else
        X_dist_ent = handles.X_dist_ent;
    end
    if ~isfield(handles, 'X_stdf')
        rhs_exist_flag = strcat(rhs_exist_flag , 'No vertical distance (TAZ-TAZ) data; ');
        rhs_process_flag = 0;
    else
        X_stdf = handles.X_stdf;
    end
    if ~isfield(handles, 'X_stdf_ent')
        rhs_exist_flag = strcat(rhs_exist_flag , 'No vertical distance (TAZ-Entrance) data; ');
        rhs_process_flag = 0;
    else
        X_stdf_ent = handles.X_stdf_ent;
    end
    if ~isfield(handles, 'X_familarity')
        %     rhs_exist_flag = strcat(rhs_exist_flag, 'No attractiveness data, but this is optional');
    else
        X_familarity = handles.X_familarity;
    end
    NIND = size(path_rawdata , 1);
    if rhs_process_flag == 1 & ~isfield(handles, 'NTAZ')
        NTAZ = str2num(cell2mat(inputdlgWC('Please input the Num. of TAZs in this data', 'NTAZ')));
    elseif rhs_process_flag == 1 & isfield(handles, 'NTAZ')
        NTAZ = handles.NTAZ;
    end
    NALT = NTAZ + 1;
    if rhs_process_flag == 1
        t = 1;                          %总的选择情景
        for i = 1 : NIND
            crtdata = path_rawdata(i, :);
            crtdata = crtdata(crtdata > 0);
            crt_visited = zeros(NTAZ, 1);
            crt_past = 0;
            % 入口
            crt_from = crtdata(2);
            crt_to = crtdata(3);
            logit_long_form(((t-1)*NALT) + (1:NALT), 1) = crtdata(1);
            logit_long_form(((t-1)*NALT) + (1:NALT), 2) = crt_from;
            crtchoice = zeros(NALT, 1);
            crtchoice(crt_to) = 1;
            logit_long_form(((t-1)*NALT) + (1:NALT), 3) = 1:NALT;
            logit_long_form(((t-1)*NALT) + (1:NALT), 4) = crtchoice;
            logit_long_form(((t-1)*NALT) + (1:NALT), 5) = [X_area ; 0];
            logit_long_form(((t-1)*NALT) + (1:NALT), 6) = [X_dist_ent(:, crt_from) ; 0];
            logit_long_form(((t-1)*NALT) + (1:NALT), 7) = [X_stdf_ent(:, crt_from) ; 0];
            logit_long_form(((t-1)*NALT) + (1:NALT), 8) = [crt_visited; 0];
            logit_long_form(((t-1)*NALT) + (1:NALT), 9) = [zeros(NTAZ, 1) ; crt_past];
            crt_visited(crt_to) = crt_visited(crt_to) + 1;
            crt_past = crt_past + 1;
            t = t + 1;
            % 回游
            j = 3;
            while j < length(crtdata)
                crt_from = crtdata(j);
                crt_to = crtdata(j+1);
                crtchoice = zeros(NALT, 1);
                crtchoice(crt_to) = 1;
                logit_long_form(((t-1)*NALT) + (1:NALT), 1) = crtdata(1);
                logit_long_form(((t-1)*NALT) + (1:NALT), 2) = crt_from;
                logit_long_form(((t-1)*NALT) + (1:NALT), 3) = 1:NALT;
                logit_long_form(((t-1)*NALT) + (1:NALT), 4) = crtchoice;
                logit_long_form(((t-1)*NALT) + (1:NALT), 5) = [X_area ; 0];
                logit_long_form(((t-1)*NALT) + (1:NALT), 6) = [X_dist(:, crt_from) ; 0];
                logit_long_form(((t-1)*NALT) + (1:NALT), 7) = [X_stdf(:, crt_from) ; 0];
                logit_long_form(((t-1)*NALT) + (1:NALT), 8) = [crt_visited; 0];
                logit_long_form(((t-1)*NALT) + (1:NALT), 9) = [zeros(NTAZ, 1) ; crt_past];
                crt_visited(crt_to) = crt_visited(crt_to) + 1;
                crt_past = crt_past + 1;
                t = t + 1;
                j = j + 1;
            end
            %回家
            crt_from = crtdata(end);
            crtchoice = [zeros(NTAZ, 1); 1];
            logit_long_form(((t-1)*NALT) + (1:NALT), 1) = crtdata(1);
            logit_long_form(((t-1)*NALT) + (1:NALT), 2) = crt_from;
            logit_long_form(((t-1)*NALT) + (1:NALT), 3) = 1:NALT;
            logit_long_form(((t-1)*NALT) + (1:NALT), 4) = crtchoice;
            logit_long_form(((t-1)*NALT) + (1:NALT), 5) = [X_area ; 0];
            logit_long_form(((t-1)*NALT) + (1:NALT), 6) = [X_dist(:, crt_from) ; 0];
            logit_long_form(((t-1)*NALT) + (1:NALT), 7) = [X_stdf(:, crt_from) ; 0];
            logit_long_form(((t-1)*NALT) + (1:NALT), 8) = [crt_visited; 0];
            logit_long_form(((t-1)*NALT) + (1:NALT), 9) = [zeros(NTAZ, 1) ; crt_past];
            t = t + 1;
        end
    end
    
    if exist('logit_long_form' , 'var') & ~exist('X_familarity', 'var')
        NCS = size(logit_long_form, 1) / NALT;
        group = reshape(repmat(1:NCS, NALT, 1), NCS*NALT, 1);
        nalt = NALT * ones(length(group), 1);
        logit_long_form = [logit_long_form(:,1), group, nalt, logit_long_form(:,2:end)];
        long_form_var_index = [7:11];
        long_form_choice_index = 6;
        long_form_var_names = {'individual', 'group', 'NALT',  'from', 'to', 'choice', 'area', ...
            'distance', 'stair', 'visited', 'past'};
    elseif exist('logit_long_form' , 'var') & exist('X_familarity', 'var') & size(X_familarity, 2) > 1  & size(X_familarity, 2) ~= NINV
        NCS = size(logit_long_form, 1) / NALT;
        group = reshape(repmat(1:NCS, NALT, 1), NCS*NALT, 1);
        nalt = NALT * ones(length(group), 1);
        logit_long_form = [logit_long_form(:,1), group, nalt, logit_long_form(:,2:end)];
        long_form_var_index = [7:11];
        long_form_choice_index = 6;
        long_form_var_names = {'individual', 'group', 'NALT', 'from', 'to', 'choice', 'area', ...
            'distance', 'stair', 'visited', 'past'};
        warndlg({'Current Attractiveness is individual level, but the Num. of indivdual does NOT equal with the Num. of paths.';...
            'So it is not used in the model, if you want to use it, make sure that Num. of individual = Num. of paths, or use attractiveness in aggregate level.'}, 'Attractiveness Not Used');
    elseif exist('logit_long_form' , 'var') & exist('X_familarity', 'var') & size(X_familarity, 2) == 1
        NCS = size(logit_long_form, 1) / NALT;
        group = reshape(repmat(1:NCS, NALT, 1), NCS*NALT, 1);
        nalt = NALT * ones(length(group), 1);
        familarity = repmat(X_familarity, NCS, 1);
        logit_long_form = [logit_long_form(:,1), group, nalt, logit_long_form(:,2:5), familarity, logit_long_form(:,6:end)];
        long_form_var_index = [7:12];
        long_form_choice_index = 6;
        long_form_var_names = {'individual', 'group', 'NALT', 'from', 'to', 'choice', 'area', ...
            'attractiveness' , 'distance', 'stair', 'visited', 'past'};
    elseif exist('logit_long_form' , 'var') & exist('X_familarity', 'var') & size(X_familarity, 2) == NINV
        NCS = size(logit_long_form, 1) / NALT;
        group = reshape(repmat(1:NCS, NALT, 1), NCS*NALT, 1);
        nalt = NALT * ones(length(group), 1);
        familarity = [];
        for tt = 1 : NCS
            crt_IND = logit_long_form((tt-1)*NALT+1, 1);
            crt_familarity = [X_familarity(:, crt_IND); 0];
            familarity = [familarity; crt_familarity];
        end
        logit_long_form = [logit_long_form(:,1), group, nalt, logit_long_form(:,2:5), familarity, logit_long_form(:,6:end)];
        long_form_var_index = [7:12];
        long_form_choice_index = 6;
        long_form_var_names = {'individual', 'group', 'NALT', 'from', 'to', 'choice', 'area', ...
            'attractiveness' , 'distance', 'stair', 'visited', 'past'};
    end
    
    
elseif handles.adv_mode == 1     % 2016.1.28，高级模式  (+ 2016.3.8,不使用时间数据)
    NINV = size(path_rawdata ,1);
    if ~isfield(handles, 'X_adv')
        errordlg('Can NOT find the variables in advance mode', 'Error')
        return
    else
        X_adv = handles.X_adv;
    end
    
    all_var = fieldnames(X_adv);
        %对变量进行分类：一列的属性，二维的矩阵，特殊的有可能会不一样的变量，以及动态变量
    var_col = cell(0);
    var_mat = cell(0);
    var_dyn = cell(0);
    var_var = cell(0);
    for ii = 1 : length(all_var)
        if isequal(all_var{ii}, 'dist') | isequal(all_var{ii}, 'stdf')
            var_mat{end+1} = all_var{ii};
        elseif isequal(all_var{ii}, 'past') | isequal(all_var{ii}, 'visited')
            var_dyn{end+1} = all_var{ii};
        elseif isequal(all_var{ii}, 'familarity')
            var_var{end+1} = all_var{ii};
        else
            var_col{end+1} = all_var{ii};
        end
    end
    for ii = 1 : length(var_col)                %不允许有空value，除了动态变量
        if isempty(getfield(X_adv, var_col{ii}))
            errordlg('There exist variables with NO value, you must complete all input', 'Error')
            return
        end
    end
    for ii = 1 : length(var_mat)                %对于矩阵变量，要检查是否两个矩阵都有了
        crt_var_mat = var_mat{ii};
        if ~isfield(getfield(X_adv, crt_var_mat), 'taz') | isempty(getfield(getfield(X_adv, crt_var_mat), 'taz')) | ...
                ~isfield(getfield(X_adv, crt_var_mat), 'ent') | isempty(getfield(getfield(X_adv, crt_var_mat), 'ent')) 
            errordlg('There exist variables with NO value, you must complete all input', 'Error')
            return
        end
    end
    
        % 正式开始输数据
    NIND = size(path_rawdata , 1);
    NALT = NTAZ + 1;
    t = 1;                          %总的选择情景
    for i = 1 : NIND
        col_end = 0;                         %列尾置0
        crtdata = path_rawdata(i, :);
        crtdata = crtdata(crtdata > 0);
        crt_visited = zeros(NTAZ, 1);
        crt_past = 0;
        
        % 入口
        crt_from = crtdata(2);
        crt_to = crtdata(3);
        logit_long_form(((t-1)*NALT) + (1:NALT), col_end+1) = crtdata(1);           %第1列，受访者编号
        col_end = col_end + 1;
        logit_long_form(((t-1)*NALT) + (1:NALT), col_end+1) = t;                    %第2列，选择场景
        col_end = col_end + 1;
        logit_long_form(((t-1)*NALT) + (1:NALT), col_end+1) = NALT;                 %第3列，选择场景
        col_end = col_end + 1;
        logit_long_form(((t-1)*NALT) + (1:NALT), col_end+1) = crt_from;             %第4列，起点编号
        col_end = col_end + 1;
        crtchoice = zeros(NALT, 1);
        crtchoice(crt_to) = 1;
        logit_long_form(((t-1)*NALT) + (1:NALT), col_end+1) = 1:NALT;               %第5列，to编号
        col_end = col_end + 1;
        logit_long_form(((t-1)*NALT) + (1:NALT), col_end+1) = crtchoice;            %第6列，选择结果
        col_end = col_end + 1;
            %下面是
        for kk = 1 : length(var_col)
            crt_X_var_col = getfield(X_adv, var_col{kk});
            logit_long_form(((t-1)*NALT) + (1:NALT), col_end+1) = [crt_X_var_col; 0];
            col_end = col_end + 1;
        end
        if sum(ismember(var_mat, 'dist')) > 0
            X_dist_all = getfield(X_adv, 'dist');
            X_dist_ent = X_dist_all.ent;
            logit_long_form(((t-1)*NALT) + (1:NALT), col_end+1) = [X_dist_ent(:, crt_from) ; 0];
            col_end = col_end + 1;
        end
        if sum(ismember(var_mat, 'stdf')) > 0
            X_stdf_all = getfield(X_adv, 'stdf');
            X_stdf_ent = X_stdf_all.ent;
            logit_long_form(((t-1)*NALT) + (1:NALT), col_end+1) = [X_stdf_ent(:, crt_from) ; 0];
            col_end = col_end + 1;
        end
        if sum(ismember(var_var, 'familarity')) > 0
            X_familarity = getfield(X_adv, 'familarity');
            if size(X_familarity, 2) > 1 & size(X_familarity, 2) ~= NINV
                warndlg({'Current Attractiveness is individual level, but the Num. of indivdual does NOT equal with the Num. of paths.';...
                    'So it is not used in the model, if you want to use it, make sure that Num. of individual = Num. of paths, or use attractiveness in aggregate level.'}, 'Attractiveness Not Used');
            elseif size(X_familarity, 2) == 1
                logit_long_form(((t-1)*NALT) + (1:NALT), col_end+1) = [X_familarity ; 0];
                col_end = col_end + 1;
            elseif size(X_familarity, 2) == NINV
                logit_long_form(((t-1)*NALT) + (1:NALT), col_end+1) = [X_familarity(:, crtdata(1)) ; 0];
                col_end = col_end + 1;
            end
        end
        if sum(ismember(var_dyn, 'visited')) > 0
            logit_long_form(((t-1)*NALT) + (1:NALT), col_end+1) = [crt_visited; 0];
            col_end = col_end + 1;
        end
        if sum(ismember(var_dyn, 'past')) > 0
            logit_long_form(((t-1)*NALT) + (1:NALT), col_end+1) = [zeros(NTAZ, 1) ; crt_past];
            col_end = col_end + 1;
        end
        crt_visited(crt_to) = crt_visited(crt_to) + 1;
        crt_past = crt_past + 1;
        t = t + 1;
        
        
        % 回游
        j = 3;                              %path_rawdata中从第列开始正式进入TAZ路径，到行尾跳出循环
        while j < length(crtdata)
            col_end = 0;                    %每一次循环，都将列末置0
            crt_from = crtdata(j);
            crt_to = crtdata(j+1);
            crtchoice = zeros(NALT, 1);
            crtchoice(crt_to) = 1;
            logit_long_form(((t-1)*NALT) + (1:NALT), col_end+1) = crtdata(1);
            col_end = col_end + 1;
            logit_long_form(((t-1)*NALT) + (1:NALT), col_end+1) = t;                    %第2列，选择场景
            col_end = col_end + 1;
            logit_long_form(((t-1)*NALT) + (1:NALT), col_end+1) = NALT;                 %第3列，选择场景
            col_end = col_end + 1;
            logit_long_form(((t-1)*NALT) + (1:NALT), col_end+1) = crt_from;
            col_end = col_end + 1;
            logit_long_form(((t-1)*NALT) + (1:NALT), col_end+1) = 1:NALT;
            col_end = col_end + 1;
            logit_long_form(((t-1)*NALT) + (1:NALT), col_end+1) = crtchoice;
            col_end = col_end + 1;
            for kk = 1 : length(var_col)
                crt_X_var_col = getfield(X_adv, var_col{kk});
                logit_long_form(((t-1)*NALT) + (1:NALT), col_end+1) = [crt_X_var_col; 0];
                col_end = col_end + 1;
            end
            if sum(ismember(var_mat, 'dist')) > 0
                X_dist_all = getfield(X_adv, 'dist');
                X_dist = X_dist_all.taz;
                logit_long_form(((t-1)*NALT) + (1:NALT), col_end+1) = [X_dist(:, crt_from) ; 0];
                col_end = col_end + 1;
            end
            if sum(ismember(var_mat, 'stdf')) > 0
                X_stdf_all = getfield(X_adv, 'stdf');
                X_stdf = X_stdf_all.taz;
                logit_long_form(((t-1)*NALT) + (1:NALT), col_end+1) = [X_stdf(:, crt_from) ; 0];
                col_end = col_end + 1;
            end
            if sum(ismember(var_var, 'familarity')) > 0
                X_familarity = getfield(X_adv, 'familarity');
                if size(X_familarity, 2) > 1 & size(X_familarity, 2) ~= NINV
                    warndlg({'Current Attractiveness is individual level, but the Num. of indivdual does NOT equal with the Num. of paths.';...
                        'So it is not used in the model, if you want to use it, make sure that Num. of individual = Num. of paths, or use attractiveness in aggregate level.'}, 'Attractiveness Not Used');
                elseif size(X_familarity, 2) == 1
                    logit_long_form(((t-1)*NALT) + (1:NALT), col_end+1) = [X_familarity ; 0];
                    col_end = col_end + 1;
                elseif size(X_familarity, 2) == NINV
                    logit_long_form(((t-1)*NALT) + (1:NALT), col_end+1) = [X_familarity(:, crtdata(1)) ; 0];
                    col_end = col_end + 1;
                end
            end
            if sum(ismember(var_dyn, 'visited')) > 0
                logit_long_form(((t-1)*NALT) + (1:NALT), col_end+1) = [crt_visited; 0];
                col_end = col_end + 1;
            end
            if sum(ismember(var_dyn, 'past')) > 0
                logit_long_form(((t-1)*NALT) + (1:NALT), col_end+1) = [zeros(NTAZ, 1) ; crt_past];
                col_end = col_end + 1;
            end
            crt_visited(crt_to) = crt_visited(crt_to) + 1;
            crt_past = crt_past + 1;
            t = t + 1;
            j = j + 1;
        end
        %回家
        col_end = 0;                %列末置0
        crt_from = crtdata(end);
        crtchoice = [zeros(NTAZ, 1); 1];
        logit_long_form(((t-1)*NALT) + (1:NALT), col_end+1) = crtdata(1);
        col_end = col_end + 1;
        logit_long_form(((t-1)*NALT) + (1:NALT), col_end+1) = t;                    %第2列，选择场景
        col_end = col_end + 1;
        logit_long_form(((t-1)*NALT) + (1:NALT), col_end+1) = NALT;                 %第3列，选择场景
        col_end = col_end + 1;
        logit_long_form(((t-1)*NALT) + (1:NALT), col_end+1) = crt_from;
        col_end = col_end + 1;
        logit_long_form(((t-1)*NALT) + (1:NALT), col_end+1) = 1:NALT;
        col_end = col_end + 1;
        logit_long_form(((t-1)*NALT) + (1:NALT), col_end+1) = crtchoice;
        col_end = col_end + 1;
        for kk = 1 : length(var_col)
            crt_X_var_col = getfield(X_adv, var_col{kk});
            logit_long_form(((t-1)*NALT) + (1:NALT), col_end+1) = [crt_X_var_col; 0];
            col_end = col_end + 1;
        end
        if sum(ismember(var_mat, 'dist')) > 0
            X_dist_all = getfield(X_adv, 'dist');
            X_dist = X_dist_all.taz;
            logit_long_form(((t-1)*NALT) + (1:NALT), col_end+1) = [X_dist(:, crt_from) ; 0];
            col_end = col_end + 1;
        end
        if sum(ismember(var_mat, 'stdf')) > 0
            X_stdf_all = getfield(X_adv, 'stdf');
            X_stdf = X_stdf_all.taz;
            logit_long_form(((t-1)*NALT) + (1:NALT), col_end+1) = [X_stdf(:, crt_from) ; 0];
            col_end = col_end + 1;
        end
        if sum(ismember(var_var, 'familarity')) > 0
            X_familarity = getfield(X_adv, 'familarity');
            if size(X_familarity, 2) > 1 & size(X_familarity, 2) ~= NINV
                warndlg({'Current Attractiveness is individual level, but the Num. of indivdual does NOT equal with the Num. of paths.';...
                    'So it is not used in the model, if you want to use it, make sure that Num. of individual = Num. of paths, or use attractiveness in aggregate level.'}, 'Attractiveness Not Used');
            elseif size(X_familarity, 2) == 1
                logit_long_form(((t-1)*NALT) + (1:NALT), col_end+1) = [X_familarity ; 0];
                col_end = col_end + 1;
            elseif size(X_familarity, 2) == NINV
                logit_long_form(((t-1)*NALT) + (1:NALT), col_end+1) = [X_familarity(:, crtdata(1)) ; 0];
                col_end = col_end + 1;
            end
        end
        if sum(ismember(var_dyn, 'visited')) > 0
            logit_long_form(((t-1)*NALT) + (1:NALT), col_end+1) = [crt_visited; 0];
            col_end = col_end + 1;
        end
        if sum(ismember(var_dyn, 'past')) > 0
            logit_long_form(((t-1)*NALT) + (1:NALT), col_end+1) = [zeros(NTAZ, 1) ; crt_past];
            col_end = col_end + 1;
        end
        t = t + 1;
    end

    long_form_var_index = [7 : size(logit_long_form, 2)];
    long_form_choice_index = 6;
    long_form_var_names = {'individual', 'group', 'NALT',  'from', 'to', 'choice'};
    long_form_var_names = [long_form_var_names, var_col];
    if sum(ismember(var_mat, 'dist')) > 0
        long_form_var_names = [long_form_var_names , 'dist'];
    end
    if sum(ismember(var_mat, 'stdf')) > 0
        long_form_var_names = [long_form_var_names , 'stdf'];
    end
    if sum(ismember(var_var, 'familarity')) > 0
        long_form_var_names = [long_form_var_names , 'familarity'];
    end
    if sum(ismember(var_dyn, 'visited')) > 0
        long_form_var_names = [long_form_var_names , 'visited'];
    end
    if sum(ismember(var_dyn, 'past')) > 0
        long_form_var_names = [long_form_var_names , 'past'];
    end
    %校验一下变量个数
    if length(long_form_var_index) ~= length(long_form_var_names)-6
        errordlg('Some thing strange happen, see error 1210', 'Error')
        return
    end
    
end

%以下：2016.3.8：时间数据，策略：为避免与以前程序的干扰，生成一个新的只有时间变量的文件，到最后再进行合并
if use_time_var == 1
    cs = 1;                                 %choice situation (只用于时间数据生成)
    for ti = 1 : NIND
        crtdata = path_rawdata(ti, :);       %便于与之前生成的主题数据相对照
        crtPed = crtdata(1);
        if space_time_path_rawdata{crtPed} == crtPed
            crtIndex = crtPed;
        else
            crtIndex = find(cell2mat(space_time_path_rawdata(:,1)) == crtPed);
        end
        time_judge(((cs-1)*NALT) + (1:NALT), 1) = crtPed;         %第一列为个体编号，用来校核的
        time_judge(((cs-1)*NALT) + (1:NALT), 2) = cs;             %第一列为选择情景，用来校核的
        crt_space_time_path_Ent = space_time_path_rawdata{crtIndex, 2};
        crt_space_time_path_TAZ = space_time_path_rawdata{crtIndex, 3};
        %------------------------------%
        %以下：时间判断——入口 ：2016-3-8
        for tj = 1 : length(time_var)
            crt_EntTime = crt_space_time_path_Ent(2);
            time_judge(((cs-1)*NALT) + (1:NALT), 3) = crt_EntTime;             %第三列为当前做决定的时间
            crt_time_var_name = time_var{tj}.name;
            crt_time_var_start = time_var{tj}.start_time;
            crt_time_var_end = time_var{tj}.end_time;
            if ~isempty(crt_time_var_start)
                if WDtimeConvert(crt_EntTime, 1) >= WDtimeConvert(crt_time_var_start, 1)
                    after_start = 1;
                else
                    after_start = 0;
                end
            else    %时间段开始时间为空，说明上界无控制，只要不晚于结束时间即可
                after_start = 1;
            end
            if ~isempty(crt_time_var_end)
                if WDtimeConvert(crt_EntTime, 1) <= WDtimeConvert(crt_time_var_end, 1)
                    before_end = 1;
                else
                    before_end = 0;
                end
            else        %时间段结束时间为空，说明下界无控制，只要不早于开始时间即可
                before_end = 1;
            end
            
            if after_start == 1 & before_end == 1       %在目标时间段内
                time_judge(((cs-1)*NALT) + (1:NALT), tj+3) = 1;
            else
                time_judge(((cs-1)*NALT) + (1:NALT), tj+3) = 0;
            end
        end
        cs = cs + 1;
        %以上：时间判断——入口 ：2016-3-8
        %------------------------------%
        %以下：时间判断——回游：2016-3-8
        crt_NTAZ = size(crt_space_time_path_TAZ, 1);
        for tntaz = 1 : crt_NTAZ                        %个体路径中第几个TAZ
%             if cs == 155
%                 ttttt = 0;                            % 查错用的
%             end
            %先校核一下，两种路径对应的TAZ是否一致以防出现奇怪的错误，注意：cs-1是说明当前所在地是上一轮的选择结果
            if crt_space_time_path_TAZ(tntaz, 1) ~= logit_long_form(logit_long_form(:,2)==cs-1 & logit_long_form(:,6)==1, 5)
                errordlg('Something strange happend, see error 3992','Error')
                return
            end
            time_judge(((cs-1)*NALT) + (1:NALT), 1) = crtPed;         %第一列为个体编号，用来校核的
            time_judge(((cs-1)*NALT) + (1:NALT), 2) = cs;             %第一列为选择情景，用来校核的
            crt_taz_arrive_time = crt_space_time_path_TAZ(tntaz, 2);
            crt_taz_stay = crt_space_time_path_TAZ(tntaz, 3);
            crt_taz_leave_time = WDtimeConvert(crt_taz_arrive_time, 1) + crt_taz_stay;          %注：此时间已经是分钟差了
            time_judge(((cs-1)*NALT) + (1:NALT), 3) = WDtimeConvert(crt_taz_leave_time, 3);     %第三列为当前做决定的时间
            for tj = 1 : length(time_var)
                crt_time_var_name = time_var{tj}.name;
                crt_time_var_start = time_var{tj}.start_time;
                crt_time_var_end = time_var{tj}.end_time;
                if ~isempty(crt_time_var_start)
                    if crt_taz_leave_time >= WDtimeConvert(crt_time_var_start, 1)
                        after_start = 1;
                    else
                        after_start = 0;
                    end
                else    %时间段开始时间为空，说明上界无控制，只要不晚于结束时间即可
                    after_start = 1;
                end
                if ~isempty(crt_time_var_end)
                    if crt_taz_leave_time <= WDtimeConvert(crt_time_var_end, 1)
                        before_end = 1;
                    else
                        before_end = 0;
                    end
                else        %时间段结束时间为空，说明下界无控制，只要不早于开始时间即可
                    before_end = 1;
                end
                
                if after_start == 1 & before_end == 1       %在目标时间段内
                    time_judge(((cs-1)*NALT) + (1:NALT), tj+3) = 1;
                else
                    time_judge(((cs-1)*NALT) + (1:NALT), tj+3) = 0;
                end
            end
            cs = cs + 1;
        end
        %以上：时间判断——回游：2016-3-8
        %------------------------------%
        %以下：时间判断——回家：2016-3-8
        % 因为之前的回游阶段不需要考虑选择回家的问题，已经一并处理了
        %以上：时间判断——回家：2016-3-8
    end
    
    %与主数据校验
    if ~isequal(logit_long_form(:, 1:2), time_judge(:,1:2))
        errordlg('Strange things happend, time dummy do not consist with main data, see error 6098', 'Error')
        return
    end
    logit_long_form_time_dummy = time_judge(:, 3:end);                  %只含当前时间与时间断送判断的dummy
    logit_long_form_time_interaction = time_judge(:, 4:end);            %只含时间与别的变量的交互
    logit_long_form_time_dummy_var_name{1} = 'CurrentTime';             %dummy数据表变量名，第一个是当前时间（消费者ID，场景编号后面就不要了）
    for tj = 1 : length(time_var)
         crt_time_var_name = time_var{tj}.name;
         crt_time_var_origin = time_var{tj}.origin;
         crt_time_var_interaction_var_name = time_var{tj}.interaction_var_name;
         if crt_time_var_origin == 1
             %来自已定义的变量名，对于基本模式的变量名需要转一下
             if isequal( crt_time_var_interaction_var_name, 'Area')
                  crt_time_var_interaction_var_name = 'area';
             elseif isequal( crt_time_var_interaction_var_name, 'Attractiveness')
                  crt_time_var_interaction_var_name = 'familarity';
             elseif isequal( crt_time_var_interaction_var_name, 'Distance')
                  crt_time_var_interaction_var_name = 'dist';
             elseif isequal( crt_time_var_interaction_var_name, 'Stair(Difference)')
                  crt_time_var_interaction_var_name = 'stdf';
             elseif isequal( crt_time_var_interaction_var_name, 'Visited')
                  crt_time_var_interaction_var_name = 'visited';
             elseif isequal( crt_time_var_interaction_var_name, 'Past')
                  crt_time_var_interaction_var_name = 'past';
             end
             already_existed_var_position_index = find(ismember(long_form_var_names,  crt_time_var_interaction_var_name) == 1);
             if isempty(already_existed_var_position_index) | length(already_existed_var_position_index) ~= 1
                 errordlg(['Something strange happend, can not find 1 variable matching time intercation, No. ',...
                     num2str(i), ' see error 3907.'],'Error')
                 return
             end
             crt_interacted_X = logit_long_form(:,already_existed_var_position_index);
         else
             crt_time_var_X_created_interaction_var = time_var{tj}.X_created_interaction_var;
             if length(crt_time_var_X_created_interaction_var) == NTAZ      %前面已经允许输入NTAZ或NTAZ+1个值。
                crt_time_var_X_created_interaction_var = [crt_time_var_X_created_interaction_var ; 0]; %加0是因为[NTAZ, 回家]
             end
             if length(crt_time_var_X_created_interaction_var) ~= NALT
                 errordlg(['Definition of time variable ', crt_time_var_name , 'is invalid: Num. of values do not equal with Num. of TAZs ',...
                     'you have to delete it and then define it again using proper data.'], 'Error')
                 return
             end
             maximum_cs = max(time_judge(:,2));
             crt_interacted_X = repmat(crt_time_var_X_created_interaction_var, maximum_cs, 1);
         end
         logit_long_form_time_interaction(:, tj) = logit_long_form_time_interaction(:, tj) .* crt_interacted_X;
         logit_long_form_time_dummy_var_name{tj+1} = strcat(crt_time_var_name, '_dummy');
         logit_long_form_time_interaction_var_name{tj} = crt_time_var_name;
    end  
    %-----------------------------%
    %调整数据，把新数据加上，准备估计
    logit_long_form = [logit_long_form, logit_long_form_time_interaction];
    long_form_var_index = [7 : size(logit_long_form, 2)];       %加上时间数据后更新
    long_form_var_names = [long_form_var_names, logit_long_form_time_interaction_var_name]; %加上时间后变量名称更新
end



%以上： 时间数据，策略：为避免与以前程序的干扰，生成一个新的只有时间变量的文件，到最后再进行合并

% Logit Model 估计
adv_mode = handles.adv_mode;
if  adv_mode == 0 & ~isequal(rhs_exist_flag , '')
    errordlg({'Though there is path data, logit model estimation is failed.'; ...
        'The reason is some of the following features are missing:  '; ...
        '    Area, Distance(TAZ-TAZ or TAZ-Entrance), Stair(TAZ-TAZ or TAZ-Entrance)'});
    return
elseif adv_mode == 1 & ~exist('logit_long_form', 'var')                   %2016/1/29，高级模式
    errordlg({'Though there is path data, logit model estimation is failed.'; ...
        'The reason is the programm failed to generate long-form logit data.'});
    return
end

[fname , pname]=uiputfile('Logit_Estimation.txt' , 'Save the Logit Model Estimation Results');
if isequal(fname, 0) | isequal(pname, 0)
    return
end
fullname = strcat(pname,fname);   
if exist(fullname)
    delete(fullname)
end

NAMES = long_form_var_names(7:end);
    % 为了显示方便，转换一下NAMES
for in = 1 : length(NAMES)
    if isequal(NAMES{in}, 'dist')
        NAMES{in} = 'distance';
    elseif isequal(NAMES{in}, 'stdf')
        NAMES{in} = 'stair';
    elseif isequal(NAMES{in}, 'familarity')
        NAMES{in} = 'attractiveness';
    end
end
choice = logit_long_form(: , long_form_choice_index);
choice = reshape(choice, NALT, length(choice) / NALT);
choice = choice';
for i = 1 : size(choice , 1)
    Y(i , 1) = find(choice(i,:) == 1);
end
rhs = logit_long_form(:, long_form_var_index);
NCS = max(logit_long_form(:, 2));
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
options=optimset('Disp','Iter','LargeScale','on','MaxFunEvals',2000000,'MaxIter',MAXITERS,'TolX',PARAMTOL,'Tolfun',LLTOL,'GradObj','on','DerivativeCheck','off','FinDiffType','central');
% startval = .05*rand((J-1)*size(X,2)+size(Z,2),1);
startval = zeros(size(Z, 2) , 1);
% bEst = fminunc('mlogitBaseAltRestrict',startval,options,[],Y,X,Z);
[paramhat,fval,exitflag,output,grad,hessian] = fminunc('clogit_wc1',startval,options,[],Y,[],Z);
hessian = full(hessian);
ihess=inv(hessian);
stderr=sqrt(diag(ihess));
t_stat = paramhat ./ stderr;
p_value = 2 * (1 - normcdf(abs(t_stat)));
diary(fullname)
disp(char(datetime))
disp(' ')
if adv_mode == 1
    disp('ADVANCE MODE ');
    disp(' ')
end
disp(['Estimation Finished']);
dispflag = 1;
if dispflag == 1
    disp(' ');
    disp(['Estimation took ' num2str(toc) ' seconds.']);
    disp(' ');
    if exitflag == 1
        disp('Convergence achieved.');
    elseif exitflag == 2
        disp('Convergence achieved by criterion based on change in parameters.');
        if size(PARAMTOL,1)>0
            disp(['Parameters changed less than PARAMTOL= ' num2str(PARAMTOL)]);
        else
            disp('Parameters changed less than PARAMTOL=0.000001, set by default.');
        end
%         disp('You might want to check whether this is actually convergence.');
%         disp('The gradient vector is');
%         grad
    elseif exitflag == 3
        disp('Convergence achieved by criterion based on change in log-likelihood value.');
        if size(PARAMTOL,1)>0
            disp(['Log-likelihood value changed less than LLTOL= ' num2str(LLTOL)]);
        else
            disp('Log-likelihood changed less than LLTOL=0.000001, set by default.');
        end
%         disp('You might want to check whether this is actually convergence.');
%         disp('The gradient vector is');
%         grad
    else
        disp('Convergence not achieved.');
        disp('The current value of the parameters and hessian');
        disp('can be accesses as variables paramhat and hessian.');
        disp('Results are not printed because no convergence.');
        return
    end
    
    null_ll = log(1/NALT) * NCS;
    mr2 = 1 - (-fval)/null_ll;
       disp(' ');
    disp(['Value of the log-likelihood function of null model: ' num2str(null_ll)]);
    disp(['Value of the log-likelihood function at convergence: ' num2str(-fval)]);
    disp(['Value of the McFadden R-squre: ' num2str(mr2)]);
    
    
    %Calculate standard errors of parameters
%     disp('Taking inverse of hessian for standard errors.');
%     disp(['The value of grad*inv(hessian)*grad is: ' num2str(grad'*ihess*grad)]);
%     
    disp(' ');
    disp('ESTIMATION RESULTS');
    disp(' ')
    disp('                   -------------------------------------------- ');
    disp('                      Coef         SE      t-stat      p-value');
    for r=1:size(NAMES,2);
        fprintf('%-15s %12.6f %10.4f %10.4f %10.4f\n', NAMES{1,r}, [paramhat(r,1) stderr(r,1) t_stat(r,1), p_value(r,1) ]);
    end
    disp(' ');
    
    disp(' ');
    disp('END OF ESTIMATION RESULTS')
    disp(' ');
    disp(' ');
    % disp('You can access the estimated parameters as variable paramhat,');
    % disp('the gradient of the negative of the log-likelihood function as variable grad,');
    % disp('the hessian of the negative of the log-likelihood function as variable hessian,');
    % disp('and the inverse of the hessian as variable ihess.');
%     disp('The hessian is calculated by the BFGS updating procedure.');
    if adv_mode == 0
        disp('Coefficients above have been automatically set as user-defined default coefficients.');
        disp('If you want to use them in simulatoin, check the menu and select ''Use the User-Defined Default Coefficients'' .');
        disp('If you want to use another user-defined model, you have to re-estimate a new model, or check the menu and select ')
        disp('''Define the Default Logit Model Coefficients'' to load a new model.')
    elseif adv_mode == 1
        disp('Note: you are using advance mode, so all predefined coefficients are not available.')
        disp('Coefficients above have been automatically set as user-defined default coefficients, you can directly use this model.')
        disp('If you want to use another user-defined model, you have to re-estimate a new model, or check the menu and select ')
        disp('''Define the Default Logit Model Coefficients'' to load a new model.')
    end
end
disp(' ');
disp(' ');
%输出简单的解释
disp(' ');
disp(' ');
disp('--------------------------------------------------------------- ');
disp(' ');
disp('Simple Explanation & Descreptive Statistic');
disp(' ');

chosen_TAZ = logit_long_form(logit_long_form(:,6)==1 & logit_long_form(:,5)~=NALT, 7:end);
not_chosen_TAZ = logit_long_form(logit_long_form(:,6)==0 & logit_long_form(:,5)~=NALT, 7:end);
chosen_home = logit_long_form(logit_long_form(:,6)==1 & logit_long_form(:,5)==NALT, 7:end);
not_chosen_home = logit_long_form(logit_long_form(:,6)==0 & logit_long_form(:,5)==NALT, 7:end);

if exist('logit_long_form_time_interaction_var_name', 'var')
    TT = logit_long_form_time_interaction_var_name;         %TT是临时创建用来判断是否时间变量的，如果压根没有，那一个空cell中肯定查不到
else
    TT = cell(0);
end

for r=1:size(NAMES,2);
    crtname = [NAMES{1,r}, ' :'];
    crt_par = paramhat(r,1);
    crt_p =  p_value(r,1);
    if crt_p > 0.05
        fprintf('%-15s insignificant effect, the value of ''%s'' do not have enough association with the probability of being chosen, when controlling other variables..\n', crtname, NAMES{1,r});
    elseif crt_p <= 0.05 & ~isequal(NAMES{1,r}, 'past') & sum(ismember(TT, NAMES{1,r})) == 0
        if crt_par > 0
            fprintf('%-15s significantly positive effect, TAZs with higher value of ''%s'' are more likely to be chosen, when controlling other variables.\n', crtname, NAMES{1,r});
        elseif crt_par < 0
            fprintf('%-15s significantly negative effect, TAZs with lower value of ''%s'' are more likely to be chosen, when controlling other variables.\n', crtname, NAMES{1,r});
        end
    elseif crt_p <= 0.05 & isequal(NAMES{1,r}, 'past')
        if crt_par > 0
            fprintf('%-15s significantly positive effect, the higher value of ''%s'', the higher probability to go home, when controlling other variables.\n', crtname, NAMES{1,r});
        elseif crt_par < 0
            fprintf('%-15s significantly negative effect, the higher value of ''%s'', the lower probability to go home, when controlling other variables.\n', crtname, NAMES{1,r});
        end
    elseif crt_p <= 0.05 & ~isequal(NAMES{1,r}, 'past') & sum(ismember(TT, NAMES{1,r})) == 1
        %这个就是时间变量了
        which_time_var = find(ismember(logit_long_form_time_interaction_var_name, NAMES{1,r}) == 1);
        crt_start_time = time_var{which_time_var}.start_time;
        crt_end_time = time_var{which_time_var}.end_time;
        crt_time_var_interaction_var_name = time_var{which_time_var}.interaction_var_name;
        crt_origin = time_var{which_time_var}.origin;
        if crt_origin == 1
             %来自已定义的变量名，对于基本模式的变量名需要转一下
             if isequal( crt_time_var_interaction_var_name, 'Area')
                  crt_time_var_interaction_var_name = 'area';
             elseif isequal( crt_time_var_interaction_var_name, 'Attractiveness')
                  crt_time_var_interaction_var_name = 'familarity';
             elseif isequal( crt_time_var_interaction_var_name, 'Distance')
                  crt_time_var_interaction_var_name = 'dist';
             elseif isequal( crt_time_var_interaction_var_name, 'Stair(Difference)')
                  crt_time_var_interaction_var_name = 'stdf';
             elseif isequal( crt_time_var_interaction_var_name, 'Visited')
                  crt_time_var_interaction_var_name = 'visited';
             elseif isequal( crt_time_var_interaction_var_name, 'Past')
                  crt_time_var_interaction_var_name = 'past';
             end
        end
        if ~isempty(crt_start_time)
            crt_start_time_h = floor(crt_start_time / 100);
            crt_start_time_m = crt_start_time - 100*crt_start_time_h;
            crt_start_time_h = num2str(crt_start_time_h);
            crt_start_time_m = num2str(crt_start_time_m);
            if length(crt_start_time_h) == 1
                crt_start_time_h = ['0', crt_start_time_h];
            end
            if length(crt_start_time_m) == 1
                crt_start_time_m = ['0', crt_start_time_m];
            end
            crt_start_time_str = [crt_start_time_h, ':', crt_start_time_m];
        else
            crt_start_time_str = '';
        end
        if ~isempty(crt_end_time)
            crt_end_time_h = floor(crt_end_time / 100);
            crt_end_time_m = crt_end_time - 100*crt_end_time_h;
            crt_end_time_h = num2str(crt_end_time_h);
            crt_end_time_m = num2str(crt_end_time_m);
            if length(crt_end_time_h) == 1
                crt_end_time_h = ['0', crt_end_time_h];
            end
            if length(crt_end_time_m) == 1
                crt_end_time_m = ['0', crt_end_time_m];
            end
            crt_end_time_str = [crt_end_time_h, ':', crt_end_time_m];
        else
            crt_end_time_str = '';
        end
        if crt_par > 0
            if isequal(time_var{which_time_var}.interaction_var_name, 'Past')
                fprintf('%-15s significantly time-specific positive effect, during [%5s ~ %5s], the higher value of ''Past'', the higher probability to go home, when controlling other variables.\n', ...
                    crtname, crt_start_time_str, crt_end_time_str);
            elseif time_var{which_time_var}.origin == 2 & isequal(time_var{which_time_var}.X_created_interaction_var, [zeros(NTAZ, 1);1])
                fprintf('%-15s significantly time-specific positive effect, during [%5s ~ %5s], people are more willingly to go home, when controlling other variables.\n', ...
                    crtname, crt_start_time_str, crt_end_time_str);
            else
                fprintf('%-15s significantly time-specific positive effect, during [%5s ~ %5s], TAZs with higher value of ''%s'' are more likely to be chosen, when controlling other variables.\n', ...
                    crtname, crt_start_time_str, crt_end_time_str, crt_time_var_interaction_var_name);
            end
        else
            if isequal(time_var{which_time_var}.interaction_var_name, 'Past')
                fprintf('%-15s significantly time-specific positive effect, during [%5s ~ %5s], the higher value of ''Past'', the lower probability to go home, when controlling other variables.\n', ...
                    crtname, crt_start_time_str, crt_end_time_str);
            elseif time_var{which_time_var}.origin == 2 & isequal(time_var{which_time_var}.X_created_interaction_var, [zeros(NTAZ, 1);1])
                fprintf('%-15s significantly time-specific positive effect, during [%5s ~ %5s], people are less willingly to go home, when controlling other variables.\n', ...
                    crtname, crt_start_time_str, crt_end_time_str);
            else
                fprintf('%-15s significantly time-specific positive effect, during [%5s ~ %5s], TAZs with lower value of ''%s'' are more likely to be chosen, when controlling other variables.\n', ...
                    crtname, crt_start_time_str, crt_end_time_str, crt_time_var_interaction_var_name);
            end
        end  
    end
    
    if ~isequal(NAMES{1,r}, 'past') & sum(ismember(TT, NAMES{1,r})) == 0
        fprintf('                   (mean value of chosen TAZs: %8.2f; mean value of unchosen TAZs: %8.2f) \n', mean(chosen_TAZ(:,r)), mean(not_chosen_TAZ(:,r)));
    elseif isequal(NAMES{1,r}, 'past')
        fprintf('                   (mean value when choose to go home: %8.2f; mean value when not choose to go home: %8.2f) \n', mean(chosen_home(:,r)), mean(not_chosen_home(:,r)));
    elseif ~isequal(NAMES{1,r}, 'past') & sum(ismember(TT, NAMES{1,r})) == 1
        which_time_var = find(ismember(logit_long_form_time_interaction_var_name, NAMES{1,r}) == 1);
        crt_start_time = time_var{which_time_var}.start_time;
        crt_end_time = time_var{which_time_var}.end_time;
        crt_time_var_interaction_var_name = time_var{which_time_var}.interaction_var_name;
        crt_origin = time_var{which_time_var}.origin;
        if crt_origin == 1
             %来自已定义的变量名，对于基本模式的变量名需要转一下
             if isequal( crt_time_var_interaction_var_name, 'Area')
                  crt_time_var_interaction_var_name = 'area';
             elseif isequal( crt_time_var_interaction_var_name, 'Attractiveness')
                  crt_time_var_interaction_var_name = 'familarity';
             elseif isequal( crt_time_var_interaction_var_name, 'Distance')
                  crt_time_var_interaction_var_name = 'dist';
             elseif isequal( crt_time_var_interaction_var_name, 'Stair(Difference)')
                  crt_time_var_interaction_var_name = 'stdf';
             elseif isequal( crt_time_var_interaction_var_name, 'Visited')
                  crt_time_var_interaction_var_name = 'visited';
             elseif isequal( crt_time_var_interaction_var_name, 'Past')
                  crt_time_var_interaction_var_name = 'past';
             end
        end
        if ~isempty(crt_start_time)
            crt_start_time_h = floor(crt_start_time / 100);
            crt_start_time_m = crt_start_time - 100*crt_start_time_h;
            crt_start_time_h = num2str(crt_start_time_h);
            crt_start_time_m = num2str(crt_start_time_m);
            if length(crt_start_time_h) == 1
                crt_start_time_h = ['0', crt_start_time_h];
            end
            if length(crt_start_time_m) == 1
                crt_start_time_m = ['0', crt_start_time_m];
            end
            crt_start_time_str = [crt_start_time_h, ':', crt_start_time_m];
        else
            crt_start_time_str = '';
        end
        if ~isempty(crt_end_time)
            crt_end_time_h = floor(crt_end_time / 100);
            crt_end_time_m = crt_end_time - 100*crt_end_time_h;
            crt_end_time_h = num2str(crt_end_time_h);
            crt_end_time_m = num2str(crt_end_time_m);
            if length(crt_end_time_h) == 1
                crt_end_time_h = ['0', crt_end_time_h];
            end
            if length(crt_end_time_m) == 1
                crt_end_time_m = ['0', crt_end_time_m];
            end
            crt_end_time_str = [crt_end_time_h, ':', crt_end_time_m];
        else
            crt_end_time_str = '';
        end
        %时间变量！
        temp = find(ismember(logit_long_form_time_dummy_var_name, strcat(NAMES{1,r}, '_dummy')) == 1);
        all_in_time = logit_long_form(logit_long_form_time_dummy(:,temp) == 1 , :);             %先把属于这个时间段的数据和排除在这个时间段以外的数据分开
        all_out_time = logit_long_form(logit_long_form_time_dummy(:,temp) == 0 , :);
        if isequal(time_var{which_time_var}.interaction_var_name, 'Past')
            before_interact_origin_index = find(ismember(NAMES, 'past'));       %这个是未与时间dummy交互前的正常变量
            in_time_chosen_home = all_in_time(all_in_time(:,6)==1 & all_in_time(:,5)== NALT, 7:end);
            in_time_not_chosen_home = all_in_time(all_in_time(:,6)==0 & all_in_time(:,5)== NALT, 7:end);
            out_time_chosen_home = all_out_time(all_out_time(:,6)==1 & all_out_time(:,5)== NALT, 7:end);
            out_time_not_chosen_home = all_out_time(all_out_time(:,6)==0 & all_out_time(:,5)== NALT, 7:end);
            fprintf('                   (during [%5s ~ %5s], mean value of ''past'' when choose to go home: %8.2f; mean value when not choose to go home: %8.2f \n',...
                crt_start_time_str, crt_end_time_str, mean(in_time_chosen_home(:,before_interact_origin_index)), mean(in_time_not_chosen_home(:,before_interact_origin_index)));
            fprintf('                    out of [%5s ~ %5s], mean value of ''past'' when choose to go home: %8.2f; mean value when not choose to go home: %8.2f )\n',...
                crt_start_time_str, crt_end_time_str, mean(out_time_chosen_home(:,before_interact_origin_index)), mean(out_time_not_chosen_home(:,before_interact_origin_index)));
   
        elseif time_var{which_time_var}.origin == 2 & isequal(time_var{which_time_var}.X_created_interaction_var, [zeros(NTAZ, 1);1])
            %这是一个关于回家的虚拟变量
            in_time_chosen_home = all_in_time(all_in_time(:,6)==1 & all_in_time(:,5)== NALT, 7:end);
            in_time_not_chosen_home = all_in_time(all_in_time(:,6)==0 & all_in_time(:,5)== NALT, 7:end);
            out_time_chosen_home = all_out_time(all_out_time(:,6)==1 & all_out_time(:,5)== NALT, 7:end);
            out_time_not_chosen_home = all_out_time(all_out_time(:,6)==0 & all_out_time(:,5)== NALT, 7:end);
            in_time_go_home_prct = size(in_time_chosen_home,  1) / (size(in_time_chosen_home,  1) + size(in_time_not_chosen_home,  1));
            out_time_go_home_prct = size(out_time_chosen_home,  1) / (size(out_time_chosen_home,  1) + size(out_time_not_chosen_home,  1));
            fprintf('                   (during [%5s ~ %5s], %8.2f%% of people choose to go home\n', ...
                crt_start_time_str, 100*crt_end_time_str, 100*in_time_go_home_prct);
            fprintf('                    out of [%5s ~ %5s], %8.2f%% of people choose to go home\n', ...
                crt_start_time_str, 100*crt_end_time_str, 100*out_time_go_home_prct);
        else
            %这是一般的TAZ变量
            %因为有可能用的是临时定义的交互变量，即原来的Logit_long_form里没有，所以需要重新生成all_in_time与all_out_time，索性就不生成那么多了
            if crt_origin == 1
                before_interact_origin_index = find(ismember(NAMES, crt_time_var_interaction_var_name) == 1);
                X_before_interact_origin = logit_long_form(:, before_interact_origin_index+6);
            else
                 X_before_interact_origin = repmat([time_var{which_time_var}.X_created_interaction_var; 0], max(logit_long_form(:,2)), 1);
                 %既然是一般的TAZ变量，应该是45个，最后加个0代表go home
                 if length(X_before_interact_origin) ~= size(logit_long_form, 1)
                     errordlg('Something strange happen, see error 9124')
                     return
                 end
            end
            %此时的X_before_interact_origin只有一列：交互前的正常X变量，为了下面利用选择信息，还要处理,加上logit_long_form里第5列的to与第6列的choice信息，变成第1、2列，这样原始X就成了第3列）
             X_before_interact_origin = [logit_long_form(:,5:6), X_before_interact_origin];
            all_in_time = X_before_interact_origin(logit_long_form_time_dummy(:,temp) == 1, :);
            all_out_time = X_before_interact_origin(logit_long_form_time_dummy(:,temp) == 0, :);
            in_time_chosen_TAZ = all_in_time(all_in_time(:,2)==1 & all_in_time(:,1)~=NALT, :);
            in_time_not_chosen_TAZ = all_in_time(all_in_time(:,2)==0 & all_in_time(:,1)~=NALT, :);
            out_time_chosen_TAZ = all_out_time(all_out_time(:,2)==1 & all_out_time(:,1)~=NALT, :);
            out_time_not_chosen_TAZ = all_out_time(all_out_time(:,2)==0 & all_out_time(:,1)~=NALT, :);
            fprintf('                   (during [%5s ~ %5s], mean value of ''%s'' of chosen TAZs: %8.2f; mean value of ''%s'' of unchosen TAZs: %8.2f \n',...
                crt_start_time_str, crt_end_time_str, crt_time_var_interaction_var_name, ...
                mean(in_time_chosen_TAZ(:,3)),  crt_time_var_interaction_var_name, mean(in_time_not_chosen_TAZ(:,3)));
            fprintf('                    out of [%5s ~ %5s], mean value of ''%s'' of chosen TAZs: %8.2f; mean value of ''%s'' of unchosen TAZs: %8.2f) \n',...
                crt_start_time_str, crt_end_time_str, crt_time_var_interaction_var_name,...
                mean(out_time_chosen_TAZ(:, 3)), crt_time_var_interaction_var_name, mean(out_time_not_chosen_TAZ(:, 3)));
        end
    end
    disp('    ');
end




diary off
fid = fopen(fullname);
i = 1;
newstr = fgetl(fid);
str{i,1} = newstr;
while feof(fid) == 0 & ~isequal(newstr, 'END OF ESTIMATION RESULTS')
    i = i + 1;
    newstr = fgetl(fid);
    str{i,1} = newstr;
end
fclose(fid);
msgbox(str, 'Logit Model Estimation');
if adv_mode == 0
    if length(paramhat) == 6
        handles.b_area_user = paramhat(1);
        handles.b_familarity_user = paramhat(2);
        handles.b_dist_user = paramhat(3);
        handles.b_stdf_user = paramhat(4);
        handles.b_visited_user = paramhat(5);
        handles.b_past_user = paramhat(6);
    elseif length(paramhat) == 5
        handles.b_area_user = paramhat(1);
        handles.b_familarity_user = 0;
        handles.b_dist_user = paramhat(2);
        handles.b_stdf_user = paramhat(3);
        handles.b_visited_user = paramhat(4);
        handles.b_past_user = paramhat(5);
    end
elseif adv_mode == 1
    % 把NAMES转回来
    for in = 1 : length(NAMES)
        if isequal(NAMES{in}, 'distance')
            NAMES{in} = 'dist';
        elseif isequal(NAMES{in}, 'stair')
            NAMES{in} = 'stdf';
        elseif isequal(NAMES{in}, 'attractiveness')
            NAMES{in} = 'familarity';
        end
    end
    beta_adv = struct;
    for in = 1 : length(NAMES)
        beta_adv = setfield(beta_adv, NAMES{in}, paramhat(in));
    end
    handles.beta_adv = beta_adv;
end
guidata(hObject, handles);
clc




% --------------------------------------------------------------------
function logit_long_form_export_Callback(hObject, eventdata, handles)
% hObject    handle to logit_long_form_export (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isfield(handles, 'path_rawdata')
    errordlg('There are NO path data, please import it first.' ,'No Path Data')
    return
else
    path_rawdata = handles.path_rawdata;
end

if ~isfield(handles, 'NTAZ')
    errordlg('There is NO Num. of TAZ data', 'No NTAZ')
    return
else
    NTAZ = handles.NTAZ;
end

%以下：判断一下能否运用时间变量，以为下面的做准备， 2016-3-8
use_time_var = 0;
if handles.adv_mode == 1
    if isfield(handles, 'time_var')
        time_var = handles.time_var;
        if isfield(handles, 'space_time_path_rawdata')
            use_time_var = 1;
            space_time_path_rawdata = handles.space_time_path_rawdata;
        else
            warnstr = ['You have specify time variables, but there is no spatiotemporal path data, ',...
                'so time variables are not included in the model'];
            warn_h = warndlg(warnstr, 'Time Variables');
            waitfor(warn_h)
        end
    end
end
%以上：判断一下能否运用时间变量，以为下面的做准备， 2016-3-8

if handles.adv_mode == 0                    %2016.2.1，考虑普通模式
    NINV = size(path_rawdata ,1);
    rhs_exist_flag = '';
    rhs_process_flag = 1;            %是否基本的自变量都有了，以便能进一步处理数据
    if ~isfield(handles, 'X_area')
        rhs_exist_flag = strcat(rhs_exist_flag , 'No area data; ');
        rhs_process_flag = 0
    else
        X_area = handles.X_area;
    end
    if ~isfield(handles, 'X_dist')
        rhs_exist_flag = strcat(rhs_exist_flag , 'No horizental distance (TAZ-TAZ) data; ');
        rhs_process_flag = 0
    else
        X_dist = handles.X_dist;
    end
    if ~isfield(handles, 'X_dist_ent')
        rhs_exist_flag = strcat(rhs_exist_flag , 'No horizental distance (TAZ-Entrance) data; ');
        rhs_process_flag = 0
    else
        X_dist_ent = handles.X_dist_ent;
    end
    if ~isfield(handles, 'X_stdf')
        rhs_exist_flag = strcat(rhs_exist_flag , 'No vertical distance (TAZ-TAZ) data; ');
        rhs_process_flag = 0
    else
        X_stdf = handles.X_stdf;
    end
    if ~isfield(handles, 'X_stdf_ent')
        rhs_exist_flag = strcat(rhs_exist_flag , 'No vertical distance (TAZ-Entrance) data; ');
        rhs_process_flag = 0
    else
        X_stdf_ent = handles.X_stdf_ent;
    end
    if ~isfield(handles, 'X_familarity')
        %     rhs_exist_flag = strcat(rhs_exist_flag, 'No attractiveness data, but this is optional');
    else
        X_familarity = handles.X_familarity;
    end
    NIND = size(path_rawdata , 1);
    if rhs_process_flag == 1 & ~isfield(handles, 'NTAZ')
        NTAZ = str2num(cell2mat(inputdlgWC('Please input the Num. of TAZs in this data', 'NTAZ')));
    elseif rhs_process_flag == 1 & isfield(handles, 'NTAZ')
        NTAZ = handles.NTAZ;
    end
    NALT = NTAZ + 1;
    if rhs_process_flag == 1
        t = 1;                          %总的选择情景
        for i = 1 : NIND
            crtdata = path_rawdata(i, :);
            crtdata = crtdata(crtdata > 0);
            crt_visited = zeros(NTAZ, 1);
            crt_past = 0;
            % 入口
            crt_from = crtdata(2);
            crt_to = crtdata(3);
            logit_long_form(((t-1)*NALT) + (1:NALT), 1) = crtdata(1);
            logit_long_form(((t-1)*NALT) + (1:NALT), 2) = crt_from;
            crtchoice = zeros(NALT, 1);
            crtchoice(crt_to) = 1;
            logit_long_form(((t-1)*NALT) + (1:NALT), 3) = 1:NALT;
            logit_long_form(((t-1)*NALT) + (1:NALT), 4) = crtchoice;
            logit_long_form(((t-1)*NALT) + (1:NALT), 5) = [X_area ; 0];
            logit_long_form(((t-1)*NALT) + (1:NALT), 6) = [X_dist_ent(:, crt_from) ; 0];
            logit_long_form(((t-1)*NALT) + (1:NALT), 7) = [X_stdf_ent(:, crt_from) ; 0];
            logit_long_form(((t-1)*NALT) + (1:NALT), 8) = [crt_visited; 0];
            logit_long_form(((t-1)*NALT) + (1:NALT), 9) = [zeros(NTAZ, 1) ; crt_past];
            crt_visited(crt_to) = crt_visited(crt_to) + 1;
            crt_past = crt_past + 1;
            t = t + 1;
            % 回游
            j = 3;
            while j < length(crtdata)
                crt_from = crtdata(j);
                crt_to = crtdata(j+1);
                crtchoice = zeros(NALT, 1);
                crtchoice(crt_to) = 1;
                logit_long_form(((t-1)*NALT) + (1:NALT), 1) = crtdata(1);
                logit_long_form(((t-1)*NALT) + (1:NALT), 2) = crt_from;
                logit_long_form(((t-1)*NALT) + (1:NALT), 3) = 1:NALT;
                logit_long_form(((t-1)*NALT) + (1:NALT), 4) = crtchoice;
                logit_long_form(((t-1)*NALT) + (1:NALT), 5) = [X_area ; 0];
                logit_long_form(((t-1)*NALT) + (1:NALT), 6) = [X_dist(:, crt_from) ; 0];
                logit_long_form(((t-1)*NALT) + (1:NALT), 7) = [X_stdf(:, crt_from) ; 0];
                logit_long_form(((t-1)*NALT) + (1:NALT), 8) = [crt_visited; 0];
                logit_long_form(((t-1)*NALT) + (1:NALT), 9) = [zeros(NTAZ, 1) ; crt_past];
                crt_visited(crt_to) = crt_visited(crt_to) + 1;
                crt_past = crt_past + 1;
                t = t + 1;
                j = j + 1;
            end
            %回家
            crt_from = crtdata(end);
            crtchoice = [zeros(NTAZ, 1); 1];
            logit_long_form(((t-1)*NALT) + (1:NALT), 1) = crtdata(1);
            logit_long_form(((t-1)*NALT) + (1:NALT), 2) = crt_from;
            logit_long_form(((t-1)*NALT) + (1:NALT), 3) = 1:NALT;
            logit_long_form(((t-1)*NALT) + (1:NALT), 4) = crtchoice;
            logit_long_form(((t-1)*NALT) + (1:NALT), 5) = [X_area ; 0];
            logit_long_form(((t-1)*NALT) + (1:NALT), 6) = [X_dist(:, crt_from) ; 0];
            logit_long_form(((t-1)*NALT) + (1:NALT), 7) = [X_stdf(:, crt_from) ; 0];
            logit_long_form(((t-1)*NALT) + (1:NALT), 8) = [crt_visited; 0];
            logit_long_form(((t-1)*NALT) + (1:NALT), 9) = [zeros(NTAZ, 1) ; crt_past];
            t = t + 1;
        end
    end
    
    if exist('logit_long_form' , 'var') & ~exist('X_familarity', 'var')
        NCS = size(logit_long_form, 1) / NALT;
        group = reshape(repmat(1:NCS, NALT, 1), NCS*NALT, 1);
        nalt = NALT * ones(length(group), 1);
        logit_long_form = [logit_long_form(:,1), group, nalt, logit_long_form(:,2:end)];
        long_form_var_index = [7:11];
        long_form_choice_index = 6;
        long_form_var_names = {'individual', 'group', 'NALT',  'from', 'to', 'choice', 'area', ...
            'distance', 'stair', 'visited', 'past'};
    elseif exist('logit_long_form' , 'var') & exist('X_familarity', 'var') & size(X_familarity, 2) > 1 & size(X_familarity, 2) ~= NINV
        NCS = size(logit_long_form, 1) / NALT;
        group = reshape(repmat(1:NCS, NALT, 1), NCS*NALT, 1);
        nalt = NALT * ones(length(group), 1);
        logit_long_form = [logit_long_form(:,1), group, nalt, logit_long_form(:,2:end)];
        long_form_var_index = [7:11];
        long_form_choice_index = 6;
        long_form_var_names = {'individual', 'group', 'NALT', 'from', 'to', 'choice', 'area', ...
            'distance', 'stair', 'visited', 'past'};
        warndlg({'Current Attractiveness is individual level, but the Num. of indivdual does NOT equal with the Num. of paths.';...
            'So it is not used in the model, if you want to use it, make sure that Num. of individual = Num. of paths, or use attractiveness in aggregate level.'}, 'Attractiveness Not Used');
    elseif exist('logit_long_form' , 'var') & exist('X_familarity', 'var') & size(X_familarity, 2) == 1
        NCS = size(logit_long_form, 1) / NALT;
        group = reshape(repmat(1:NCS, NALT, 1), NCS*NALT, 1);
        nalt = NALT * ones(length(group), 1);
        familarity = repmat(X_familarity, NCS, 1);
        logit_long_form = [logit_long_form(:,1), group, nalt, logit_long_form(:,2:5), familarity, logit_long_form(:,6:end)];
        long_form_var_index = [7:12];
        long_form_choice_index = 6;
        long_form_var_names = {'individual', 'group', 'NALT', 'from', 'to', 'choice', 'area', ...
            'attractiveness' , 'distance', 'stair', 'visited', 'past'};
    elseif exist('logit_long_form' , 'var') & exist('X_familarity', 'var') & size(X_familarity, 2) == NINV
        NCS = size(logit_long_form, 1) / NALT;
        group = reshape(repmat(1:NCS, NALT, 1), NCS*NALT, 1);
        nalt = NALT * ones(length(group), 1);
        familarity = [];
        for tt = 1 : NCS
            crt_IND = logit_long_form((tt-1)*NALT+1, 1);
            crt_familarity = [X_familarity(:, crt_IND); 0];
            familarity = [familarity; crt_familarity];
        end
        logit_long_form = [logit_long_form(:,1), group, nalt, logit_long_form(:,2:5), familarity, logit_long_form(:,6:end)];
        long_form_var_index = [7:12];
        long_form_choice_index = 6;
        long_form_var_names = {'individual', 'group', 'NALT', 'from', 'to', 'choice', 'area', ...
            'attractiveness' , 'distance', 'stair', 'visited', 'past'};
    end
elseif    handles.adv_mode == 1    % 2016.2.1，高级模式
    NINV = size(path_rawdata ,1);
    if ~isfield(handles, 'X_adv')
        errordlg('Can NOT find the variables in advance mode', 'Error')
        return
    else
        X_adv = handles.X_adv;
    end
    all_var = fieldnames(X_adv);
        %对变量进行分类：一列的属性，二维的矩阵，特殊的有可能会不一样的变量，以及动态变量
    var_col = cell(0);
    var_mat = cell(0);
    var_dyn = cell(0);
    var_var = cell(0);
    for ii = 1 : length(all_var)
        if isequal(all_var{ii}, 'dist') | isequal(all_var{ii}, 'stdf')
            var_mat{end+1} = all_var{ii};
        elseif isequal(all_var{ii}, 'past') | isequal(all_var{ii}, 'visited')
            var_dyn{end+1} = all_var{ii};
        elseif isequal(all_var{ii}, 'familarity')
            var_var{end+1} = all_var{ii};
        else
            var_col{end+1} = all_var{ii};
        end
    end
    for ii = 1 : length(var_col)                %不允许有空value，除了动态变量
        if isempty(getfield(X_adv, var_col{ii}))
            errordlg('There exist variables with NO value, you must complete all input', 'Error')
            return
        end
    end
    for ii = 1 : length(var_mat)                %对于矩阵变量，要检查是否两个矩阵都有了
        crt_var_mat = var_mat{ii};
        if ~isfield(getfield(X_adv, crt_var_mat), 'taz') | isempty(getfield(getfield(X_adv, crt_var_mat), 'taz')) | ...
                ~isfield(getfield(X_adv, crt_var_mat), 'ent') | isempty(getfield(getfield(X_adv, crt_var_mat), 'ent')) 
            errordlg('There exist variables with NO value, you must complete all input', 'Error')
            return
        end
    end
    
        % 正式开始输数据
    NIND = size(path_rawdata , 1);
    NALT = NTAZ + 1;
    t = 1;                          %总的选择情景
    for i = 1 : NIND
        col_end = 0;                         %列尾置0
        crtdata = path_rawdata(i, :);
        crtdata = crtdata(crtdata > 0);
        crt_visited = zeros(NTAZ, 1);
        crt_past = 0;
        % 入口
        crt_from = crtdata(2);
        crt_to = crtdata(3);
        logit_long_form(((t-1)*NALT) + (1:NALT), col_end+1) = crtdata(1);           %第1列，受访者编号
        col_end = col_end + 1;
        logit_long_form(((t-1)*NALT) + (1:NALT), col_end+1) = t;                    %第2列，选择场景
        col_end = col_end + 1;
        logit_long_form(((t-1)*NALT) + (1:NALT), col_end+1) = NALT;                 %第3列，选择场景
        col_end = col_end + 1;
        logit_long_form(((t-1)*NALT) + (1:NALT), col_end+1) = crt_from;             %第4列，起点编号
        col_end = col_end + 1;
        crtchoice = zeros(NALT, 1);
        crtchoice(crt_to) = 1;
        logit_long_form(((t-1)*NALT) + (1:NALT), col_end+1) = 1:NALT;               %第5列，to编号
        col_end = col_end + 1;
        logit_long_form(((t-1)*NALT) + (1:NALT), col_end+1) = crtchoice;            %第6列，选择结果
        col_end = col_end + 1;
            %下面是
        for kk = 1 : length(var_col)
            crt_X_var_col = getfield(X_adv, var_col{kk});
            logit_long_form(((t-1)*NALT) + (1:NALT), col_end+1) = [crt_X_var_col; 0];
            col_end = col_end + 1;
        end
        if sum(ismember(var_mat, 'dist')) > 0
            X_dist_all = getfield(X_adv, 'dist');
            X_dist_ent = X_dist_all.ent;
            logit_long_form(((t-1)*NALT) + (1:NALT), col_end+1) = [X_dist_ent(:, crt_from) ; 0];
            col_end = col_end + 1;
        end
        if sum(ismember(var_mat, 'stdf')) > 0
            X_stdf_all = getfield(X_adv, 'stdf');
            X_stdf_ent = X_stdf_all.ent;
            logit_long_form(((t-1)*NALT) + (1:NALT), col_end+1) = [X_stdf_ent(:, crt_from) ; 0];
            col_end = col_end + 1;
        end
        if sum(ismember(var_var, 'familarity')) > 0
            X_familarity = getfield(X_adv, 'familarity');
            if size(X_familarity, 2) > 1 & size(X_familarity, 2) ~= NINV
                warndlg({'Current Attractiveness is individual level, but the Num. of indivdual does NOT equal with the Num. of paths.';...
                    'So it is not used in the model, if you want to use it, make sure that Num. of individual = Num. of paths, or use attractiveness in aggregate level.'}, 'Attractiveness Not Used');
            elseif size(X_familarity, 2) == 1
                logit_long_form(((t-1)*NALT) + (1:NALT), col_end+1) = [X_familarity ; 0];
                col_end = col_end + 1;
            elseif size(X_familarity, 2) == NINV
                logit_long_form(((t-1)*NALT) + (1:NALT), col_end+1) = [X_familarity(:, crtdata(1)) ; 0];
                col_end = col_end + 1;
            end
        end
        if sum(ismember(var_dyn, 'visited')) > 0
            logit_long_form(((t-1)*NALT) + (1:NALT), col_end+1) = [crt_visited; 0];
            col_end = col_end + 1;
        end
        if sum(ismember(var_dyn, 'past')) > 0
            logit_long_form(((t-1)*NALT) + (1:NALT), col_end+1) = [zeros(NTAZ, 1) ; crt_past];
            col_end = col_end + 1;
        end
        crt_visited(crt_to) = crt_visited(crt_to) + 1;
        crt_past = crt_past + 1;
        t = t + 1;
        % 回游
        j = 3;
        while j < length(crtdata)
            col_end = 0;                    %每一次循环，都将列末置0
            crt_from = crtdata(j);
            crt_to = crtdata(j+1);
            crtchoice = zeros(NALT, 1);
            crtchoice(crt_to) = 1;
            logit_long_form(((t-1)*NALT) + (1:NALT), col_end+1) = crtdata(1);
            col_end = col_end + 1;
            logit_long_form(((t-1)*NALT) + (1:NALT), col_end+1) = t;                    %第2列，选择场景
            col_end = col_end + 1;
            logit_long_form(((t-1)*NALT) + (1:NALT), col_end+1) = NALT;                 %第3列，选择场景
            col_end = col_end + 1;
            logit_long_form(((t-1)*NALT) + (1:NALT), col_end+1) = crt_from;
            col_end = col_end + 1;
            logit_long_form(((t-1)*NALT) + (1:NALT), col_end+1) = 1:NALT;
            col_end = col_end + 1;
            logit_long_form(((t-1)*NALT) + (1:NALT), col_end+1) = crtchoice;
            col_end = col_end + 1;
            for kk = 1 : length(var_col)
                crt_X_var_col = getfield(X_adv, var_col{kk});
                logit_long_form(((t-1)*NALT) + (1:NALT), col_end+1) = [crt_X_var_col; 0];
                col_end = col_end + 1;
            end
            if sum(ismember(var_mat, 'dist')) > 0
                X_dist_all = getfield(X_adv, 'dist');
                X_dist = X_dist_all.taz;
                logit_long_form(((t-1)*NALT) + (1:NALT), col_end+1) = [X_dist(:, crt_from) ; 0];
                col_end = col_end + 1;
            end
            if sum(ismember(var_mat, 'stdf')) > 0
                X_stdf_all = getfield(X_adv, 'stdf');
                X_stdf = X_stdf_all.taz;
                logit_long_form(((t-1)*NALT) + (1:NALT), col_end+1) = [X_stdf(:, crt_from) ; 0];
                col_end = col_end + 1;
            end
            if sum(ismember(var_var, 'familarity')) > 0
                X_familarity = getfield(X_adv, 'familarity');
                if size(X_familarity, 2) > 1 & size(X_familarity, 2) ~= NINV
                    warndlg({'Current Attractiveness is individual level, but the Num. of indivdual does NOT equal with the Num. of paths.';...
                        'So it is not used in the model, if you want to use it, make sure that Num. of individual = Num. of paths, or use attractiveness in aggregate level.'}, 'Attractiveness Not Used');
                elseif size(X_familarity, 2) == 1
                    logit_long_form(((t-1)*NALT) + (1:NALT), col_end+1) = [X_familarity ; 0];
                    col_end = col_end + 1;
                elseif size(X_familarity, 2) == NINV
                    logit_long_form(((t-1)*NALT) + (1:NALT), col_end+1) = [X_familarity(:, crtdata(1)) ; 0];
                    col_end = col_end + 1;
                end
            end
            if sum(ismember(var_dyn, 'visited')) > 0
                logit_long_form(((t-1)*NALT) + (1:NALT), col_end+1) = [crt_visited; 0];
                col_end = col_end + 1;
            end
            if sum(ismember(var_dyn, 'past')) > 0
                logit_long_form(((t-1)*NALT) + (1:NALT), col_end+1) = [zeros(NTAZ, 1) ; crt_past];
                col_end = col_end + 1;
            end
            crt_visited(crt_to) = crt_visited(crt_to) + 1;
            crt_past = crt_past + 1;
            t = t + 1;
            j = j + 1;
        end
        %回家
        col_end = 0;                %列末置0
        crt_from = crtdata(end);
        crtchoice = [zeros(NTAZ, 1); 1];
        logit_long_form(((t-1)*NALT) + (1:NALT), col_end+1) = crtdata(1);
        col_end = col_end + 1;
        logit_long_form(((t-1)*NALT) + (1:NALT), col_end+1) = t;                    %第2列，选择场景
        col_end = col_end + 1;
        logit_long_form(((t-1)*NALT) + (1:NALT), col_end+1) = NALT;                 %第3列，选择场景
        col_end = col_end + 1;
        logit_long_form(((t-1)*NALT) + (1:NALT), col_end+1) = crt_from;
        col_end = col_end + 1;
        logit_long_form(((t-1)*NALT) + (1:NALT), col_end+1) = 1:NALT;
        col_end = col_end + 1;
        logit_long_form(((t-1)*NALT) + (1:NALT), col_end+1) = crtchoice;
        col_end = col_end + 1;
        for kk = 1 : length(var_col)
            crt_X_var_col = getfield(X_adv, var_col{kk});
            logit_long_form(((t-1)*NALT) + (1:NALT), col_end+1) = [crt_X_var_col; 0];
            col_end = col_end + 1;
        end
        if sum(ismember(var_mat, 'dist')) > 0
            X_dist_all = getfield(X_adv, 'dist');
            X_dist = X_dist_all.taz;
            logit_long_form(((t-1)*NALT) + (1:NALT), col_end+1) = [X_dist(:, crt_from) ; 0];
            col_end = col_end + 1;
        end
        if sum(ismember(var_mat, 'stdf')) > 0
            X_stdf_all = getfield(X_adv, 'stdf');
            X_stdf = X_stdf_all.taz;
            logit_long_form(((t-1)*NALT) + (1:NALT), col_end+1) = [X_stdf(:, crt_from) ; 0];
            col_end = col_end + 1;
        end
        if sum(ismember(var_var, 'familarity')) > 0
            X_familarity = getfield(X_adv, 'familarity');
            if size(X_familarity, 2) > 1 & size(X_familarity, 2) ~= NINV
                warndlg({'Current Attractiveness is individual level, but the Num. of indivdual does NOT equal with the Num. of paths.';...
                    'So it is not used in the model, if you want to use it, make sure that Num. of individual = Num. of paths, or use attractiveness in aggregate level.'}, 'Attractiveness Not Used');
            elseif size(X_familarity, 2) == 1
                logit_long_form(((t-1)*NALT) + (1:NALT), col_end+1) = [X_familarity ; 0];
                col_end = col_end + 1;
            elseif size(X_familarity, 2) == NINV
                logit_long_form(((t-1)*NALT) + (1:NALT), col_end+1) = [X_familarity(:, crtdata(1)) ; 0];
                col_end = col_end + 1;
            end
        end
        if sum(ismember(var_dyn, 'visited')) > 0
            logit_long_form(((t-1)*NALT) + (1:NALT), col_end+1) = [crt_visited; 0];
            col_end = col_end + 1;
        end
        if sum(ismember(var_dyn, 'past')) > 0
            logit_long_form(((t-1)*NALT) + (1:NALT), col_end+1) = [zeros(NTAZ, 1) ; crt_past];
            col_end = col_end + 1;
        end
        t = t + 1;
    end

    long_form_var_index = [7 : size(logit_long_form, 2)];
    long_form_choice_index = 6;
    long_form_var_names = {'individual', 'group', 'NALT',  'from', 'to', 'choice'};
    long_form_var_names = [long_form_var_names, var_col];
    if sum(ismember(var_mat, 'dist')) > 0
        long_form_var_names = [long_form_var_names , 'distance'];
    end
    if sum(ismember(var_mat, 'stdf')) > 0
        long_form_var_names = [long_form_var_names , 'stair'];
    end
    if sum(ismember(var_var, 'familarity')) > 0
        long_form_var_names = [long_form_var_names , 'attractiveness'];
    end
    if sum(ismember(var_dyn, 'visited')) > 0
        long_form_var_names = [long_form_var_names , 'visited'];
    end
    if sum(ismember(var_dyn, 'past')) > 0
        long_form_var_names = [long_form_var_names , 'past'];
    end
    %校验一下变量个数
    if length(long_form_var_index) ~= length(long_form_var_names)-6
        errordlg('Some thing strange happen, see error 1211', 'Error')
        return
    end
end

%以下：2016.3.8：时间数据，策略：为避免与以前程序的干扰，生成一个新的只有时间变量的文件，到最后再进行合并
if use_time_var == 1
    cs = 1;                                 %choice situation (只用于时间数据生成)
    for ti = 1 : NIND
        crtdata = path_rawdata(ti, :);       %便于与之前生成的主题数据相对照
        crtPed = crtdata(1);
        if space_time_path_rawdata{crtPed} == crtPed
            crtIndex = crtPed;
        else
            crtIndex = find(cell2mat(space_time_path_rawdata(:,1)) == crtPed);
        end
        time_judge(((cs-1)*NALT) + (1:NALT), 1) = crtPed;         %第一列为个体编号，用来校核的
        time_judge(((cs-1)*NALT) + (1:NALT), 2) = cs;             %第一列为选择情景，用来校核的
        crt_space_time_path_Ent = space_time_path_rawdata{crtIndex, 2};
        crt_space_time_path_TAZ = space_time_path_rawdata{crtIndex, 3};
        %------------------------------%
        %以下：时间判断——入口 ：2016-3-8
        for tj = 1 : length(time_var)
            crt_EntTime = crt_space_time_path_Ent(2);
            time_judge(((cs-1)*NALT) + (1:NALT), 3) = crt_EntTime;             %第三列为当前做决定的时间
            crt_time_var_name = time_var{tj}.name;
            crt_time_var_start = time_var{tj}.start_time;
            crt_time_var_end = time_var{tj}.end_time;
            if ~isempty(crt_time_var_start)
                if WDtimeConvert(crt_EntTime, 1) >= WDtimeConvert(crt_time_var_start, 1)
                    after_start = 1;
                else
                    after_start = 0;
                end
            else    %时间段开始时间为空，说明上界无控制，只要不晚于结束时间即可
                after_start = 1;
            end
            if ~isempty(crt_time_var_end)
                if WDtimeConvert(crt_EntTime, 1) <= WDtimeConvert(crt_time_var_end, 1)
                    before_end = 1;
                else
                    before_end = 0;
                end
            else        %时间段结束时间为空，说明下界无控制，只要不早于开始时间即可
                before_end = 1;
            end
            
            if after_start == 1 & before_end == 1       %在目标时间段内
                time_judge(((cs-1)*NALT) + (1:NALT), tj+3) = 1;
            else
                time_judge(((cs-1)*NALT) + (1:NALT), tj+3) = 0;
            end
        end
        cs = cs + 1;
        %以上：时间判断——入口 ：2016-3-8
        %------------------------------%
        %以下：时间判断——回游：2016-3-8
        crt_NTAZ = size(crt_space_time_path_TAZ, 1);
        for tntaz = 1 : crt_NTAZ                        %个体路径中第几个TAZ
            %先校核一下，两种路径对应的TAZ是否一致以防出现奇怪的错误，注意：cs-1是说明当前所在地是上一轮的选择结果
            if crt_space_time_path_TAZ(tntaz, 1) ~= logit_long_form(logit_long_form(:,2)==cs-1 & logit_long_form(:,6)==1, 5)
                errordlg('Something strange happend, see error 3992','Error')
                return
            end
            time_judge(((cs-1)*NALT) + (1:NALT), 1) = crtPed;         %第一列为个体编号，用来校核的
            time_judge(((cs-1)*NALT) + (1:NALT), 2) = cs;             %第一列为选择情景，用来校核的
            crt_taz_arrive_time = crt_space_time_path_TAZ(tntaz, 2);
            crt_taz_stay = crt_space_time_path_TAZ(tntaz, 3);
            crt_taz_leave_time = WDtimeConvert(crt_taz_arrive_time, 1) + crt_taz_stay;          %注：此时间已经是分钟差了
            time_judge(((cs-1)*NALT) + (1:NALT), 3) = WDtimeConvert(crt_taz_leave_time, 3);     %第三列为当前做决定的时间
            for tj = 1 : length(time_var)
                crt_time_var_name = time_var{tj}.name;
                crt_time_var_start = time_var{tj}.start_time;
                crt_time_var_end = time_var{tj}.end_time;
                if ~isempty(crt_time_var_start)
                    if crt_taz_leave_time >= WDtimeConvert(crt_time_var_start, 1)
                        after_start = 1;
                    else
                        after_start = 0;
                    end
                else    %时间段开始时间为空，说明上界无控制，只要不晚于结束时间即可
                    after_start = 1;
                end
                if ~isempty(crt_time_var_end)
                    if crt_taz_leave_time <= WDtimeConvert(crt_time_var_end, 1)
                        before_end = 1;
                    else
                        before_end = 0;
                    end
                else        %时间段结束时间为空，说明下界无控制，只要不早于开始时间即可
                    before_end = 1;
                end
                
                if after_start == 1 & before_end == 1       %在目标时间段内
                    time_judge(((cs-1)*NALT) + (1:NALT), tj+3) = 1;
                else
                    time_judge(((cs-1)*NALT) + (1:NALT), tj+3) = 0;
                end
            end
            cs = cs + 1;
        end
        %以上：时间判断——回游：2016-3-8
        %------------------------------%
        %以下：时间判断——回家：2016-3-8
        % 因为之前的回游阶段不需要考虑选择回家的问题，已经一并处理了
        %以上：时间判断——回家：2016-3-8
    end
    
    %与主数据校验
    if ~isequal(logit_long_form(:, 1:2), time_judge(:,1:2))
        errordlg('Strange things happend, time dummy do not consist with main data, see error 6098', 'Error')
        return
    end
    logit_long_form_time_dummy = time_judge(:, 3:end);                  %只含当前时间与时间断送判断的dummy
    logit_long_form_time_interaction = time_judge(:, 4:end);            %只含时间与别的变量的交互
    logit_long_form_time_dummy_var_name{1} = 'CurrentTime';             %dummy数据表变量名，第一个是当前时间（消费者ID，场景编号后面就不要了）
    for tj = 1 : length(time_var)
         crt_time_var_name = time_var{tj}.name;
         crt_time_var_origin = time_var{tj}.origin;
         crt_time_var_interaction_var_name = time_var{tj}.interaction_var_name;
         if crt_time_var_origin == 1
             %来自已定义的变量名，对于基本模式的变量名需要转一下
             if isequal( crt_time_var_interaction_var_name, 'Area')
                  crt_time_var_interaction_var_name = 'area';
             elseif isequal( crt_time_var_interaction_var_name, 'Attractiveness')
                  crt_time_var_interaction_var_name = 'familarity';
             elseif isequal( crt_time_var_interaction_var_name, 'Distance')
                  crt_time_var_interaction_var_name = 'dist';
             elseif isequal( crt_time_var_interaction_var_name, 'Stair(Difference)')
                  crt_time_var_interaction_var_name = 'stdf';
             elseif isequal( crt_time_var_interaction_var_name, 'Visited')
                  crt_time_var_interaction_var_name = 'visited';
             elseif isequal( crt_time_var_interaction_var_name, 'Past')
                  crt_time_var_interaction_var_name = 'past';
             end
             already_existed_var_position_index = find(ismember(long_form_var_names,  crt_time_var_interaction_var_name) == 1);
             if isempty(already_existed_var_position_index) | length(already_existed_var_position_index) ~= 1
                 errordlg(['Something strange happend, can not find 1 variable matching time intercation, No. ',...
                     num2str(i), ' see error 3907.'],'Error')
                 return
             end
             crt_interacted_X = logit_long_form(:,already_existed_var_position_index);
         else
             crt_time_var_X_created_interaction_var = time_var{tj}.X_created_interaction_var;
             if length(crt_time_var_X_created_interaction_var) == NTAZ      %前面已经允许输入NTAZ或NTAZ+1个值。
                crt_time_var_X_created_interaction_var = [crt_time_var_X_created_interaction_var ; 0]; %加0是因为[NTAZ, 回家]
             end
             if length(crt_time_var_X_created_interaction_var) ~= NALT
                 errordlg(['Definition of time variable ', crt_time_var_name , 'is invalid: Num. of values do not equal with Num. of TAZs ',...
                     'you have to delete it and then define it again using proper data.'], 'Error')
                 return
             end
             maximum_cs = max(time_judge(:,2));
             crt_interacted_X = repmat(crt_time_var_X_created_interaction_var, maximum_cs, 1);
         end
         logit_long_form_time_interaction(:, tj) = logit_long_form_time_interaction(:, tj) .* crt_interacted_X;
         logit_long_form_time_dummy_var_name{tj+1} = strcat(crt_time_var_name, '_dummy');
         logit_long_form_time_interaction_var_name{tj} = crt_time_var_name;
    end  
    %-----------------------------%
    %调整数据，把新数据加上，准备估计
    logit_long_form = [logit_long_form, logit_long_form_time_interaction];
    long_form_var_index = [7 : size(logit_long_form, 2)];       %加上时间数据后更新
    long_form_var_names = [long_form_var_names, logit_long_form_time_interaction_var_name]; %加上时间后变量名称更新
    
    %直接估计Logit模型不需要这一部，但生成Logit长表数据加上这一步：把当前时间与时间dummy变量导出
    logit_long_form = [logit_long_form, logit_long_form_time_dummy];
    %不更新long_form_var_index，因为dummy不作为估计模型的变量
    long_form_var_names = [long_form_var_names, logit_long_form_time_dummy_var_name]; %加上时间dummy后变量名称更新
    
end

%以上： 时间数据，策略：为避免与以前程序的干扰，生成一个新的只有时间变量的文件，到最后再进行合并


handles.logit_long_form = logit_long_form;
handles.long_form_var_index = long_form_var_index;
handles.long_form_choice_index = long_form_choice_index;
handles.long_form_var_names = long_form_var_names;
guidata(hObject, handles);
if handles.adv_mode == 0                        %简单模式
    if (~isfield(handles, 'logit_long_form') | ~isequal(rhs_exist_flag , ''))
        errordlg({'Though there is path data, the long form logit data is not generated.'; ...
            'The reason is some of the following features are missing:  '; ...
            '    Area, Distance(TAZ-TAZ or TAZ-Entrance), Stair(TAZ-TAZ or TAZ-Entrance)'});
        return
    else
        [fname , pname]=uiputfile('Logit_Data.xlsx' , 'Save the Long-form Logit File for Stata / Nlogit');
        if isequal(fname, 0) | isequal(pname, 0)
            return
        end
        fullname = strcat(pname,fname);
        if exist(fullname, 'file')
            delete(fullname);
        end
        tic
        if length(long_form_var_names) == 12
            stata_clogit = 'clogit choice area attractiveness distance stair visited past, group(group)';
        elseif length(long_form_var_names) == 11
            stata_clogit = 'clogit choice area distance stair visited past, group(group)';
        end
        instr_stata = strvcat('BASIC INSTRUCTIONS FOR STATA', ...
            '1. Export a CSV version of Logit Data Sheet;',...
            '2. Import the data in Logit Data (CSV version) to Stata, with the first line preserved as the variable names;',...
            '3. Copy the following statement to the command line window of Stata:', ...
            stata_clogit ,...
            '4. Press Enter to run, and then the result comes out.' );
        for kk = 1 : size(instr_stata , 1)
            if kk ~= 5
                xlswrite(fullname, {instr_stata(kk,:)}, 1, ['A',num2str(kk)]);
            else
                xlswrite(fullname, {instr_stata(kk,:)}, 1, ['B',num2str(kk)]);
            end
        end
        
        if length(long_form_var_names) == 12
            nlogit = 'Nlogit ;lhs = Choice, NALT ;rhs = Area, Attracti, Distance, Stair, Visited, Past ;Maxit = 1000 ;Alg = bfgs$';
        elseif length(long_form_var_names) == 11
            nlogit = 'Nlogit ;lhs = Choice, NALT ;rhs = Area, Distance, Stair, Visited, Past ;Maxit = 1000 ;Alg = bfgs$';
        end
        instr_nlogit = strvcat('BASIC INSTRUCTIONS FOR NLOGIT', ...
            '1. Export a CSV version of Logit Data Sheet;',...
            '2. Check the project setting, set the number of rows to be big enough;',...
            '3. Import the data in Logit Data (CSV version) to a NLOGIT project;',...
            '4. Copy the following statement to the a command document (.lim) of NLOGIT:', ...
            nlogit ,...
            '5. Select that pasted statement, click the Go button, and then the result comes out.' );
        for kk = 1 : size(instr_nlogit , 1)
            if kk ~= 6
                xlswrite(fullname, {instr_nlogit(kk,:)}, 1, ['A',num2str(kk+9)]);
            else
                xlswrite(fullname, {instr_nlogit(kk,:)}, 1, ['B',num2str(kk+9)]);
            end
        end
        xlswrite(fullname, long_form_var_names, 'Logit Data');
        xlswrite(fullname, logit_long_form, 'Logit Data', 'A2');
        
        ti = toc;
        msgbox({['Successfully export long-form logit data: ', fname]; ['It took ', num2str(ti), ' seconds']} ,'Export Finished')
    end
elseif handles.adv_mode == 1                    %高级模式
    if ~isfield(handles, 'logit_long_form')
        errordlg({'Though there is path data, the long form logit data is not generated.'});
        return
    else
        [fname , pname]=uiputfile('Logit_Data.xlsx' , 'Save the Long-form Logit File for Stata / Nlogit');
        if isequal(fname, 0) | isequal(pname, 0)
            return
        end
        fullname = strcat(pname,fname);
        if exist(fullname, 'file')
            delete(fullname);
        end
        tic
        NAMES = long_form_var_names(7:end);
        if use_time_var == 1
            %如果采用了时间变量，要把当前时间与时间dummy扔掉
            NAMES(end-length(logit_long_form_time_dummy_var_name)+1 : end) = [];
        end
        % 为了显示方便，转换一下NAMES
        for in = 1 : length(NAMES)
            if isequal(NAMES{in}, 'dist')
                NAMES{in} = 'distance';
            elseif isequal(NAMES{in}, 'stdf')
                NAMES{in} = 'stair';
            elseif isequal(NAMES{in}, 'familarity')
                NAMES{in} = 'attractiveness';
            end
        end
        stata_clogit = 'clogit choice';
        for jj = 1 : length(NAMES)
            crt_var_name = lower(NAMES{jj});            %统一使用小写，stata保险
            stata_clogit = [stata_clogit, ' ', crt_var_name];
        end
        stata_clogit = [stata_clogit, ', group(group)'];
        instr_stata = strvcat('BASIC INSTRUCTIONS FOR STATA', ...
            '1. Export a CSV version of Logit Data Sheet;',...
            '2. Import the data in Logit Data (CSV version) to Stata, with the first line preserved as the variable names;',...
            '3. Copy the following statement to the command line window of Stata:', ...
            stata_clogit ,...
            '4. Press Enter to run, and then the result comes out.' );
        if use_time_var == 1
            instr_stata = strvcat(instr_stata, ...
                ['5. There exist ', num2str(length(logit_long_form_time_dummy_var_name)-1), ' time-related variables, they are ',...
                'included into the model as interaction-term variables, and their corresponding dummy variables are provided in the end columns.']);
        end
        for kk = 1 : size(instr_stata , 1)
            if kk ~= 5
                xlswrite(fullname, {instr_stata(kk,:)}, 1, ['A',num2str(kk)]);
            else
                xlswrite(fullname, {instr_stata(kk,:)}, 1, ['B',num2str(kk)]);
            end
        end

        nlogit = 'Nlogit ;lhs = Choice, NALT ;rhs =';
        for jj = 1 : length(NAMES)-1
            crt_var_name = NAMES{jj};
            if length(crt_var_name) > 8
                crt_var_name = crt_var_name(1:8);
            end
            nlogit = [nlogit, ' ', crt_var_name, ','];
        end
        last_var_name = NAMES{end};
        nlogit = [nlogit, ' ', last_var_name];
        nlogit = [nlogit, ' ;Maxit = 1000 ;Alg = bfgs$'];
        instr_nlogit = strvcat('BASIC INSTRUCTIONS FOR NLOGIT', ...
            '1. Export a CSV version of Logit Data Sheet;',...
            '2. Check the project setting, set the number of rows to be big enough;',...
            '3. Import the data in Logit Data (CSV version) to a NLOGIT project;',...
            '4. Copy the following statement to the a command document (.lim) of NLOGIT:', ...
            nlogit ,...
            '5. Select that pasted statement, click the Go button, and then the result comes out.' );
        if use_time_var == 1
            instr_nlogit = strvcat(instr_nlogit, ...
                ['6. There exist ', num2str(length(logit_long_form_time_dummy_var_name)-1), ' time-related variables, they are ',...
                'included into the model as interaction-term variables, and their corresponding dummy variables are provided in the end columns.']);
        end
        
        for kk = 1 : size(instr_nlogit , 1)
            if kk ~= 6
                xlswrite(fullname, {instr_nlogit(kk,:)}, 1, ['A',num2str(kk+9)]);
            else
                xlswrite(fullname, {instr_nlogit(kk,:)}, 1, ['B',num2str(kk+9)]);
            end
        end
        xlswrite(fullname, lower(long_form_var_names), 'Logit Data');
        xlswrite(fullname, logit_long_form, 'Logit Data', 'A2');
        
        ti = toc;
        msgbox({['Successfully export long-form logit data: ', fname]; ['It took ', num2str(ti), ' seconds']} ,'Export Finished')
    end
end


% --------------------------------------------------------------------
function Untitled_9_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 2016-3-14：以前是在这里面统一导入/输入以及检查，现在把检查和小修改放到别的另一个程序里了（choice1的选择变化），这里还可以用做高级模式
% choice1 = questdlg('Do you want to set your user-defined default logit model coefficients or just check them?' , 'User-Defined Default Logit Model Coefficients'...
% , 'Set User-Defined Default Coefficients' , 'Check User-Defined Default Coefficients' , 'Set User-Defined Default Coefficients');
% if isequal(choice1, 'Set User-Defined Default Coefficients')
adv_mode = handles.adv_mode;
if adv_mode == 1
    choice2 = questdlg('How do you want to set your user-defined default logit model coefficients?' , 'User-Defined Default Logit Model Coefficients'...
        , 'Import Coefficients' , 'Directly Input Coefficients'  , 'Import Coefficients');
else
    choice2 = questdlg('How do you want to set your user-defined default logit model coefficients?' , 'User-Defined Default Logit Model Coefficients'...
       ,'Import Coefficients'  , 'Directly Input Coefficients' ,  'Set Current Coefficients as Default' , 'Import Coefficients');
end
if isequal(choice2 , 'Import Coefficients')
    [fname , pname]=uigetfile('Logit_Estimation.txt' , 'Open the Logit Cofficients TXT');
    if isequal(fname, 0) | isequal(pname, 0)
        return
    end
    fullname = strcat(pname,fname);
    if adv_mode == 0                            %一般模式
        b_familarity_user = 0;
        over = 0;
        fid = fopen(fullname);
        while feof(fid) == 0 
            str = fgetl(fid);
            if over == 1
                continue
            end
            if strcmp(str, 'END OF ESTIMATION RESULTS')
                over = 1;
                continue
            end
            if length(regexp(str, '^area.*')) ~= 0
                area_token = regexp(str, '^area\s*(\S*)\s*' ,'tokens');
                b_area_user = str2double(area_token{:}{:});
            end
            if length(regexp(str, '^attractiveness.*')) ~= 0
                familarity_token = regexp(str, '^attractiveness\s*(\S*)\s*' ,'tokens');
                b_familarity_user = str2double(familarity_token{:}{:});
            end
            if length(regexp(str, '^distance.*')) ~= 0
                dist_token = regexp(str, '^distance\s*(\S*)\s*' ,'tokens');
                b_dist_user = str2double(dist_token{:}{:});
            end
            if length(regexp(str, '^stair.*')) ~= 0
                stdf_token = regexp(str, '^stair\s*(\S*)\s*' ,'tokens');
                b_stdf_user = str2double(stdf_token{:}{:});
            end
            if length(regexp(str, '^visited.*')) ~= 0
                visited_token = regexp(str, '^visited\s*(\S*)\s*' ,'tokens');
                b_visited_user = str2double(visited_token{:}{:});
            end
            if length(regexp(str, '^past.*')) ~= 0
                past_token = regexp(str, '^past\s*(\S*)\s*' ,'tokens');
                b_past_user = str2double(past_token{:}{:});
            end
        end
        fclose(fid);
        handles.b_area_user = b_area_user;
        handles.b_familarity_user =  b_familarity_user;
        handles.b_dist_user = b_dist_user;
        handles.b_stdf_user = b_stdf_user;
        handles.b_visited_user = b_visited_user;
        handles.b_past_user = b_past_user;
        guidata(hObject, handles);
    elseif adv_mode == 1                                                %高级模式
        if ~isfield(handles, 'adv_var')
            errordlg('You should firstly define variables so that the proper variable names can be recognized.', 'Error')
            return
        end
        adv_var = handles.adv_var;
        names_adv_var = adv_var;                    %蠢了，本来以为是结构体，所以用了fieldnames，才发现是cell，多此一步了
        if isfield(handles, 'time_var')
            time_var = handles.time_var;
            for k = 1 : length(time_var)
                names_adv_var{end+1} = time_var{k}.name;
            end
        end
        fid = fopen(fullname);
        right_line = 0;                     %用来是否到了正确的行
        beta = struct;                      %初始化
        while feof(fid) == 0
            str = fgetl(fid);
            if right_line == 0
                if length(regexp(str, '^\s+Coef\s+SE\s+t-stat\s+p-value')) == 0 
                    %从这一行的下一行正式进入系数
                    continue
                elseif length(regexp(str, '^\s+Coef\s+SE\s+t-stat\s+p-value')) ~= 0
                    right_line = 1;
                    continue
                end
            elseif right_line == 1                      %这一段进入正式部分
                if length(regexp(str, '^END OF ESTIMATION RESULTS')) ~= 0 
                    %从这一行往下结束模型
                    break
                end
                if length(regexp(str, '^[a-zA-Z]\S*\s*\S*\s*\S*\s')) == 0
                    %正式部分找不到正确的格式，基本是因为扫到了空行
                    continue
                else
                    crt_var = regexp(str, '^([a-zA-Z]\S*)\s*\S*\s*\S*\s', 'tokens');
                    crt_var = crt_var{:}{:};
                    crt_var_para = regexp(str, '^[a-zA-Z]\S*\s*(\S*)\s*\S*\s', 'tokens');
                    try
                        crt_var_para =  str2double(crt_var_para{:}{:});
                    catch
                        warnd = warndlg(['Failed to get the coefficient of variable: ', crt_var,...
                            ', it is set to be zero, you can check and modify it by ',...
                            'checking ''Logit Model'' -- ''Check / Modify Default Coefficients''.'], 'Error');
                        waitfor(warnd)
                        crt_var_para = 0;
                    end
                    if isempty(crt_var_para) | isnan(crt_var_para)
                        warnd = warndlg(['Failed to get the coefficient of variable: ', crt_var,...
                            ', it is set to be zero, you can check and modify it by ',...
                            'checking ''Logit Model'' -- ''Check / Modify Default Coefficients''.'], 'Warning');
                        waitfor(warnd)
                        crt_var_para = 0;
                    end
                    beta = setfield(beta, crt_var, crt_var_para);
                end
            end
        end
        fclose(fid);
        names_beta = fieldnames(beta);
        if length(names_adv_var) ~= length(names_beta)
            errordlg('Num. of coefficients do not equal Num. of defined variables.' ,'Error')
            return
        end
        [xor_names, i_adv_var, i_beta] = setxor(names_adv_var, names_beta);
        xor_adv_var = names_adv_var(i_adv_var);
        xor_beta = names_beta(i_beta);
        for kk = 1 : length(xor_adv_var)
            if isequal(xor_adv_var{kk}, 'Attractiveness')
                xor_adv_var{kk} = 'attractiveness';
            end
            if isequal(xor_adv_var{kk}, 'Distance')
                xor_adv_var{kk} = 'distance';
            end
            if isequal(xor_adv_var{kk}, 'Stair(Difference)')
                xor_adv_var{kk} = 'stair';
            end
            if isequal(xor_adv_var{kk}, 'Visited')
                xor_adv_var{kk} = 'visited';
            end
            if isequal(xor_adv_var{kk}, 'Past')
                xor_adv_var{kk} = 'past';
            end
            if isequal(xor_adv_var{kk}, 'Area')
                xor_adv_var{kk} = 'area';
            end
        end
        if ~isequal(xor_adv_var, xor_beta)
            [xor_xor_names, i_xor_adv_var, i_xor_beta] = setxor(xor__adv_var, xor__beta);
            errordlg(['Variable names in logit model can not completely match variable names ',...
                'defined in advance mode: ''',i_xor_beta{1}, ''' can not be found.'], 'Error')
            return
        end
        %特殊处理： 在adv_var中，是Attractiveness，在logit model
        %txt里一般是attractiveness，但在过程中，基本都是familarity,类似的，在adv_var中，是Distance,
        %在logit model txt里一般是distance,在过程中，一般是dist
        if isfield(beta, 'attractiveness')
            beta.familarity = beta.attractiveness;
            beta = rmfield(beta, 'attractiveness');
        end
        if isfield(beta, 'distance')
            beta.dist = beta.distance;
            beta = rmfield(beta, 'distance');
        end
        if isfield(beta, 'stair')
            beta.stdf = beta.stair;
            beta = rmfield(beta, 'stair');
        end
        handles.beta_adv = beta;
        guidata(hObject, handles);
    end
elseif isequal(choice2, 'Set Current Coefficients as Default')
    %这种情况下，必然是一般模式，因为高级模式不会选到这个选项
    b_area_user = str2double(get(handles.e_a, 'String'));
    b_familarity_user = str2double(get(handles.e_b, 'String'));
    b_dist_user = str2double(get(handles.e_c, 'String'));
    b_stdf_user = str2double(get(handles.edit_b_stdf, 'String'));
    b_visited_user = str2double(get(handles.edit_b_visited, 'String'));
    b_past_user = str2double(get(handles.edit_b_past, 'String'));
    
    if isnan(b_area_user) | isnan(b_dist_user) | isnan(b_dist_user) | isnan(b_stdf_user) | isnan(b_visited_user) | isnan(b_past_user)
        errordlg('Current coefficients are not complete, please check and finish them', 'User-Defined Default Coefficients');
        return
    end
    
    if isnan(b_familarity_user) == 1
        b_familarity_user = 0;
    end
    
    handles.b_area_user = b_area_user;
    handles.b_familarity_user =  b_familarity_user;
    handles.b_dist_user = b_dist_user;
    handles.b_stdf_user = b_stdf_user;
    handles.b_visited_user = b_visited_user;
    handles.b_past_user = b_past_user;
    guidata(hObject, handles);
    
elseif isequal(choice2, 'Directly Input Coefficients')
    if adv_mode == 0
        prompt = {'Enter area coefficient:','Enter attractiveness coefficient(optional):',...
            'Enter distance coefficient:' , 'Enter stair coefficient',...
            'Enter visited coefficient:', 'Enter past coefficient'};
        dlg_title = 'Input User-Defined Default Coefficients';
        num_lines = 1;
        def = {'' , '' , '' , '' , '' , ''};
        answer = inputdlgWC(prompt,dlg_title,num_lines,def);
        if isempty(answer)
            return
        end
        try
            b_area_user = str2double(answer{1});
        catch
            errordlg('Invalid area coefficient input', 'Error')
            return
        end
        try
            b_familarity_user = str2double(answer{2});
        catch
            errordlg('Invalid attractiveness coefficient input', 'Error')
            return
        end
        try
            b_dist_user = str2double(answer{3});
        catch
            errordlg('Invalid distance coefficient input', 'Error')
            return
        end
        try
            b_stdf_user = str2double(answer{4});
        catch
            errordlg('Invalid stair coefficient input', 'Error')
            return
        end
        try
            b_visited_user = str2double(answer{5});
        catch
            errordlg('Invalid visited coefficient input', 'Error')
            return
        end
        try
            b_past_user = str2double(answer{6});
        catch
            errordlg('Invalid past coefficient input', 'Error')
            return
        end

        if isnan(b_familarity_user) | isempty(b_familarity_user)
            b_familarity_user = 0;
        end
        if isnan(b_area_user) | isempty(b_area_user)
            warn = warndlg(['There is no valid area coefficient input, it is set to zero, ',...
                'you can check and modify it by checking ''Logit Model'' -- ''Check / Modify Default Coefficients'''], 'Warning');
            waitfor(warn)
            b_area_user = 0;
        end
        if isnan(b_dist_user) | isempty(b_dist_user)
            warn = warndlg(['There is no valid distance coefficient input, it is set to zero, ',...
                'you can check and modify it by checking ''Logit Model'' -- ''Check / Modify Default Coefficients'''], 'Warning');
            waitfor(warn)
            b_dist_user = 0;
        end
         if isnan(b_stdf_user) | isempty(b_stdf_user)
            warn = warndlg(['There is no valid stair coefficient input, it is set to zero, ',...
                'you can check and modify it by checking ''Logit Model'' -- ''Check / Modify Default Coefficients'''], 'Warning');
            waitfor(warn)
            b_stdf_user = 0;
         end
         if isnan(b_visited_user) | isempty(b_visited_user)
            warn = warndlg(['There is no valid visited coefficient input, it is set to zero, ',...
                'you can check and modify it by checking ''Logit Model'' -- ''Check / Modify Default Coefficients'''], 'Warning');
            waitfor(warn)
            b_visited_user = 0;
         end
         if isnan(b_past_user) | isempty(b_past_user)
            warn = warndlg(['There is no valid past coefficient input, it is set to zero, ',...
                'you can check and modify it by checking ''Logit Model'' -- ''Check / Modify Default Coefficients'''], 'Warning');
            waitfor(warn)
            b_past_user = 0;
        end
        handles.b_area_user = b_area_user;
        handles.b_familarity_user =  b_familarity_user;
        handles.b_dist_user = b_dist_user;
        handles.b_stdf_user = b_stdf_user;
        handles.b_visited_user = b_visited_user;
        handles.b_past_user = b_past_user;
        guidata(hObject, handles);
    elseif adv_mode == 1
        if ~isfield(handles, 'adv_var')
            errordlg('You should firstly define variables so that the proper variable names can be recognized.', 'Error')
            return
        end
        adv_var = handles.adv_var;
        names_adv_var = adv_var;                                     %蠢了，本来以为是结构体，所以用了fieldnames，才发现是cell，多此一步了
        if isfield(handles, 'time_var')
            time_var = handles.time_var;
            for k = 1 : length(time_var)
                names_adv_var{end+1} = time_var{k}.name;
            end
        end
        prompt = cell(0);
        for kk = 1 : length(names_adv_var)
            prompt{end+1} = ['Enter ', names_adv_var{kk}, ' coefficient:'];
        end
        dlg_title = 'Input User-Defined Default Coefficients';
        num_lines = 1;
        answer = inputdlgWC(prompt,dlg_title,num_lines);
        if isempty(answer)
            return
        end
        beta = struct;
        for kk = 1 : length(answer)
            crt_var = names_adv_var{kk};
            try
                crt_var_para = str2double(answer{kk});
            catch
                warn = warndlg(['Invalid input for variable: ', crt_var, ', it is set ',...
                    'to be zero, you can check and modify it by checking ', ...
                    '''Logit Model'' -- ''Check / Modify Default Coefficients'''], 'Warning');
                waitfor(warn)
                crt_var_para = 0;
            end
            if isempty(crt_var_para) | isnan(crt_var_para)
                warn = warndlg(['Invalid input for variable: ', crt_var, ', it is set ',...
                    'to be zero, you can check and modify it by checking ', ...
                    '''Logit Model'' -- ''Check / Modify Default Coefficients'''], 'Warning');
                waitfor(warn)
                crt_var_para = 0;
            end
            if isequal(crt_var, 'Area')
                crt_var = 'area';
            elseif isequal(crt_var, 'Distance')
                crt_var = 'dist';
            elseif isequal(crt_var, 'Stair(Difference)')
                crt_var = 'stdf';
            elseif isequal(crt_var, 'Visited')
                crt_var = 'visited';
            elseif isequal(crt_var, 'Past')
                crt_var = 'past';
            elseif isequal(crt_var, 'Attractiveness')
                crt_var = 'familarity';
            end
            beta = setfield(beta, crt_var, crt_var_para);
        end
        handles.beta_adv = beta;
        guidata(hObject, handles);
    end
end
msgbox('Finished.')
% %检查的事，留给另一个module吧
% checkstr = {'Following coefficents are succeessfully set to be default';...
%     'You can use them by checking the menu and selecting ''Use the User-Defined Default Coefficients'' ';...
%     '   ';...
%     '   ';...
%     ['area:                  ', num2str(b_area_user)] ; ...
%     ['attractiveness:     ', num2str(b_familarity_user)] ; ...
%     ['distance:             ', num2str(b_dist_user)] ; ...
%     ['stair:                  ', num2str(b_stdf_user)] ; ...
%     ['visited:               ', num2str(b_visited_user)] ; ...
%     ['past:                  ', num2str(b_past_user)]};
% msgbox(checkstr, 'User-Defined Default Coefficients');

% elseif isequal(choice1, 'Check User-Defined Default Coefficients')
%     if ~isfield(handles, 'b_area_user')
%         errordlg('There are NO user-defined default coefficients right now.', 'No Coefficients');
%         return
%     end
%     b_area_user = handles.b_area_user;
%     b_familarity_user = handles.b_familarity_user;
%     b_dist_user = handles.b_dist_user;
%     b_stdf_user = handles.b_stdf_user;
%     b_visited_user = handles.b_visited_user;
%     b_past_user = handles.b_past_user;
%     checkstr = {'Following coefficents are succeessfully set to be default';...
%         'You can use them by checking the menu and selecting ''Use the User-Defined Default Coefficients'' ';...
%         '   ';...
%         '   ';...
%         ['area:                  ', num2str(b_area_user)] ; ...
%         ['attractiveness:     ', num2str(b_familarity_user)] ; ...
%         ['distance:             ', num2str(b_dist_user)] ; ...
%         ['stair:                  ', num2str(b_stdf_user)] ; ...
%         ['visited:               ', num2str(b_visited_user)] ; ...
%         ['past:                  ', num2str(b_past_user)]};
%     msgbox(checkstr, 'User-Defined Default Coefficients');
% end

    

% --------------------------------------------------------------------
function use_user_define_coef_Callback(hObject, eventdata, handles)
% hObject    handle to use_user_define_coef (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
adv_mode = handles.adv_mode;
% 简单模式
if adv_mode == 0
    if ~isfield(handles, 'b_area_user')
        errordlg('There are NO user-defined default coefficients right now.', 'No Coefficients');
        return
    end
    b_area_user = handles.b_area_user;
    b_familarity_user = handles.b_familarity_user;
    b_dist_user = handles.b_dist_user;
    b_stdf_user = handles.b_stdf_user;
    b_visited_user = handles.b_visited_user;
    b_past_user = handles.b_past_user;
    
    handles.b_area = b_area_user;
    handles.b_familarity = b_familarity_user;
    handles.b_dist = b_dist_user;
    handles.b_stdf = b_stdf_user;
    handles.b_visited = b_visited_user;
    handles.b_past = b_past_user;
    
    set(handles.e_a, 'String', b_area_user);
    set(handles.e_b, 'String', b_familarity_user);
    set(handles.e_c, 'String', b_dist_user);
    set(handles.edit_b_stdf, 'String', b_stdf_user);
    set(handles.edit_b_visited, 'String', b_visited_user);
    set(handles.edit_b_past, 'String', b_past_user);
end



% --------------------------------------------------------------------
function use_predefine_with_fam_Callback(hObject, eventdata, handles)
% hObject    handle to use_predefine_with_fam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
b_area = 0.0001;
handles.b_area = b_area;
b_dist = -0.01;
handles.b_dist = b_dist;
b_stdf = -0.4;
handles.b_stdf = b_stdf;
b_visited = -1.5;
handles.b_visited = b_visited;
b_familarity = 1.4;
handles.b_familarity = b_familarity;
b_past = 0.6;
handles.b_past = b_past;
set(handles.e_a , 'String' , num2str(b_area));
set(handles.e_c , 'String' , num2str(b_dist));
set(handles.edit_b_stdf , 'String' , num2str(b_stdf));
set(handles.e_b , 'String' , num2str(b_familarity));
set(handles.edit_b_visited , 'String' , num2str(b_visited));
set(handles.edit_b_past , 'String' , num2str(b_past));
guidata(hObject , handles)


% --------------------------------------------------------------------
function use_predefine_without_fam_Callback(hObject, eventdata, handles)
% hObject    handle to use_predefine_without_fam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
b_area = 0.0002;
handles.b_area = b_area;
b_dist = -0.01;
handles.b_dist = b_dist;
b_stdf = -0.4;
handles.b_stdf = b_stdf;
b_visited = -1.1;
handles.b_visited = b_visited;
b_past = 0.5;
handles.b_past = b_past;
set(handles.e_a , 'String' , num2str(b_area));
set(handles.e_c , 'String' , num2str(b_dist));
set(handles.edit_b_stdf , 'String' , num2str(b_stdf));
set(handles.edit_b_visited , 'String' , num2str(b_visited));
set(handles.edit_b_past , 'String' , num2str(b_past));
b_familarity = 0;
handles.b_familarity = b_familarity;
set(handles.e_b , 'String' , num2str(b_familarity));
guidata(hObject , handles)


% --------------------------------------------------------------------
function Untitled_14_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --------------------------------------------------------------------
function Untitled_15_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Adj_TAZ_ID_Callback(hObject, eventdata, handles)
% hObject    handle to Adj_TAZ_ID (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% global XYZ_GL Z_factor_GL
if ~isfield(handles, 'XYZ')
    errordlg('There is NO valid TAZ input' , 'No TAZ Data')
    return
end
XYZ = handles.XYZ;
% XYZ_GL = XYZ;
if exist('check_fig', 'var') | exist('check_fig', 'class')
    close(check_fig);
end
% 关闭除主fig之外的所有fig
all_figs = findall(0, 'type', 'figure');
for af_i = 1 : length(all_figs)
    crt_fig_in_all_figs = all_figs(af_i);
    if ~isequal(get(crt_fig_in_all_figs, 'tag') , 'figure1')
        delete(crt_fig_in_all_figs)
    end
end

check_fig = figure('Name' , 'Check / Modify the TAZ ID' , 'NumberTitle' , 'off',...
    'Position', [250 100 1400 850], 'Color', 'w', 'Unit', 'normalized');
if ~isfield(handles , 'Z_factor')
    Z_factor = str2double(get(handles.edit_Z_factor, 'String'));
else
    Z_factor = handles.Z_factor
end
% Z_factor_GL = Z_factor;
figure(check_fig)
axis equal
axis off
xyz = XYZ;
xyz(:,4) = xyz(:,4) * Z_factor;             %竖向拉开
%画全体
unique_XYZ = unique(xyz(: , 1));
for i = 1 : size(unique_XYZ)
    crtTAZindex = unique_XYZ(i);
    index = find(xyz(:,1) == crtTAZindex);
    hold on
    patch(xyz(index,2) , xyz(index,3) , xyz(index,4) , [0.8,0.8,0.8])
end
% if isfield(handles , 'Ent_ON')  & isfield(handles , 'ENTXYZ')
%     if handles.Ent_ON == 1
%         entxyz = handles.ENTXYZ;
%         entxyz = entxyz(:, 2:4);
%         entxyz(:,3) = entxyz(:,3) * Z_factor;
%         h_ent = plot3(entxyz(: , 1), entxyz(:, 2), entxyz(:, 3), 'kp','MarkerFacecolor', 'k');
%         handles.h_ent = h_ent;
%     end
% end

set(gcf,'color','w')
axis equal
axis off
xlim([min(xyz(:,2)) - .05*(max(xyz(:,2))-min(xyz(:,2))), max(xyz(:,2)) + .05*(max(xyz(:,2))-min(xyz(:,2)))]);
ylim([min(xyz(:,3)) - .05*(max(xyz(:,3))-min(xyz(:,3))), max(xyz(:,3)) + .05*(max(xyz(:,3))-min(xyz(:,3)))]);
if max(xyz(:,4)) > min(xyz(:,4))
    zlim([min(xyz(:,4)) - .05*(max(xyz(:,4))-min(xyz(:,4))), max(xyz(:,4)) + .05*(max(xyz(:,4))-min(xyz(:,4)))]);
end
alpha(0.5)
az = handles.az;
el = handles.el;
view(az,el)
set(gca,'position',[0 0.03 .6 .97])
rotate3d on

%表格
original_taz_id = unique(xyz(:,1));
ut_data = repmat(original_taz_id, 1 , 2);
ut = uitable(check_fig, 'data', ut_data, 'ColumnName', {'Origin TAZ ID', 'Modified TAZ ID'},...
     'ColumnEditable', [false true], 'Units', 'normalized', 'CellSelectionCallback', @cellsel_callback_TAZ,...
     'CellEditCallback', @celledit_callback_TAZ);
set(ut, 'Position', [.65 .08 .26 .8])
set(ut, 'ColumnWidth',{150})
% handles.TAZ_ID_check_tabale_data = ut_data;
% guidata(hObject, handles);

%标注
% global centroid_h_GL centroid_GL new_centroid_h_GL
ids = unique(xyz(:,1));
for kkk = 1 : length(ids)
    crt = xyz(xyz(:,1) == ids(kkk) , 2:4);
    crt_rst = polygeom(crt(:,1) , crt(:,2));
    centroid(kkk , 1:2) = crt_rst(2:3);
    centroid(kkk, 3) = crt(1, 3);
end
for kkk = 1 : length(ids)
    centroid_h{kkk} = text(centroid(kkk,1), centroid(kkk,2), centroid(kkk,3), num2str(ids(kkk)) , 'color', 'k');
end
% centroid_h_GL = centroid_h;
% centroid_GL = centroid;
% clear new_centroid_h_GL
handles.centroid_h = centroid_h;
handles.centroid = centroid;
new_centroid_h{length(ids)} = [];
handles.new_centroid_h = new_centroid_h;
guidata(hObject, handles);
% %奇怪的问题
% axis on
% set(gca, 'xcolor','w')
% set(gca, 'ycolor','w')
% set(gca, 'zcolor','w')

%检查
check_button = uicontrol(check_fig, 'Style', 'pushbutton', 'String', 'Check the Modified TAZ IDs',...
        'Unit', 'normalized', 'Position', [.65 .90 .12 .06], 'FontSize', 10,...
        'Callback', @check_button_TAZ);  
%保存
save_button = uicontrol(check_fig, 'Style', 'pushbutton', 'String', 'Save the Modified TAZ IDs',...
        'Unit', 'normalized', 'Position', [.79 .90 .12 .06], 'FontSize', 10,...
        'Callback', @saveButton_TAZ_Callback); 
handles = guidata(hObject);
handles.save_button = save_button;
guidata(hObject, handles);

%保存回调
function saveButton_TAZ_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global drawnow_sel_GL 
main_gui_h = findall(0 , 'type', 'figure', 'tag', 'figure1');
handles = guidata(main_gui_h);
if ~isfield(handles, 'check_TAZ_flag') | handles.check_TAZ_flag ~= 1
    errordlg('You must check the modified TAZ IDs first!', 'Check Error');
    return
end
XYZ = handles.XYZ;
figure_child_h = get(get(hObject, 'Parent'),'Child');           %获得figure中各子图句柄
for jj = 1 : length(figure_child_h)
    if isequal(get(figure_child_h(jj), 'Type'), 'uitable')
        uitable_h = figure_child_h(jj);                                  %获得uitable句柄
        break
    end
end
crt_ut_data = get(uitable_h , 'data');
crt_original_data = crt_ut_data(:,1);
crt_modified_data = crt_ut_data(:,2);

if isfield(handles, 'centroid_h')
    centroid_h = handles.centroid_h;
    for ki = 1 : length(centroid_h)
        delete(centroid_h{ki});
    end
end
if isfield(handles, 'new_centroid_h')
    new_centroid_h = handles.new_centroid_h;
    for ki = 1 : length(new_centroid_h)
        delete(new_centroid_h{ki});
    end
end
if exist('drawnow_sel_GL', 'var')
    delete(drawnow_sel_GL)
end
% 更新XYZ数据
for i = 1 : size(XYZ, 1)
    oldone = XYZ(i, 1);
    newone = crt_modified_data(crt_original_data == oldone);
    XYZ(i, 1) = newone;
end
handles.XYZ = XYZ;
guidata(main_gui_h, handles);
% 更新表格
set(uitable_h , 'data', repmat(unique(XYZ(:,1)), 1, 2));
% 重置标注
if ~isfield(handles , 'Z_factor')
    Z_factor = str2double(get(handles.edit_Z_factor, 'String'));
else
    Z_factor = handles.Z_factor
end
clear centroid_h  centroid new_centroid_h
xyz = XYZ;
xyz(:,4) = xyz(:,4) * Z_factor;             %竖向拉开
ids = unique(xyz(:,1));
for kkk = 1 : length(ids)
    crt = xyz(xyz(:,1) == ids(kkk) , 2:4);
    crt_rst = polygeom(crt(:,1) , crt(:,2));
    centroid(kkk , 1:2) = crt_rst(2:3);
    centroid(kkk, 3) = crt(1, 3);
end
for kkk = 1 : length(ids)
    centroid_h{kkk} = text(centroid(kkk,1), centroid(kkk,2), centroid(kkk,3), num2str(ids(kkk)) , 'color', 'k');
end
handles.centroid_h = centroid_h;
handles.centroid = centroid;
new_centroid_h{length(ids)} = [];
handles.new_centroid_h = new_centroid_h;
guidata(main_gui_h, handles);
close_GoOn = questdlg('Are you sure that all TAZ IDs are correctly modified?' , 'Finish the Modification',...
    'No, go on modifiying' , 'Yes, close the window',  'No, go on modifiying' );
if isequal(close_GoOn, 'No, go on modifiying')
    return
else
    close(gcf);
end


%选中回调
function cellsel_callback_TAZ(hTab , event)
main_gui_h = findall(0 , 'type', 'figure', 'tag', 'figure1');
handles = guidata(main_gui_h);
global  drawnow_sel_GL 
% XYZ = XYZ_GL;
% Z_factor = Z_factor_GL;
XYZ = handles.XYZ;
if ~isfield(handles , 'Z_factor')
    Z_factor = str2double(get(handles.edit_Z_factor, 'String'));
else
    Z_factor = handles.Z_factor
end
if exist('drawnow_sel_GL', 'var')
    delete(drawnow_sel_GL)
end
if ~isempty(event.Indices)
    data = get(hTab, 'Data');
    iRow = event.Indices(1);
    iCol = event.Indices(2);
    XYZ(:,4) = XYZ(:,4) * Z_factor;   
    crtIndex = data(iRow, 1);
    crt_xyz = XYZ(XYZ(:,1) == crtIndex, 2:4);
    drawnow_sel = patch(crt_xyz(:,1) , crt_xyz(:,2) , crt_xyz(:,3) , [1,0.2,0.2],...
        'FaceAlpha', .6);
    drawnow_sel_GL = drawnow_sel;
end


%修改回调
function celledit_callback_TAZ(hTab, event)
% global  centroid_GL centroid_h_GL new_centroid_h_GL
main_gui_h = findall(0 , 'type', 'figure', 'tag', 'figure1');
handles = guidata(main_gui_h);
centroid = handles.centroid;
centroid_h = handles.centroid_h;
new_centroid_h = handles.new_centroid_h;
handles.check_TAZ_flag = 0;                 %每次修改之后，都要重新检查
% centroid = centroid_GL;
% if exist('new_centroid_h_GL', 'var')
%     new_centroid_h = new_centroid_h_GL;
% end
if isempty(event.Error)
    data = get(hTab, 'Data');
    iRow = event.Indices(1);
    iCol = event.Indices(2);
%     crtIndex = data(iRow, 1);
    crtIndex = iRow;
    delete(centroid_h{crtIndex});
    if isempty(new_centroid_h{crtIndex}) == 0
        delete(new_centroid_h{crtIndex});
    end
    new_centroid_h{crtIndex} = text(centroid(crtIndex,1), ...
       centroid(crtIndex,2), centroid(crtIndex,3), ...
       num2str(data(iRow, iCol)) , 'color', 'r', 'FontWeight', 'bold');
end
handles.new_centroid_h = new_centroid_h;
guidata(main_gui_h, handles);
% new_centroid_h_GL = new_centroid_h;

%检查回调
function check_button_TAZ(hObject, callbackdata)
clear check_TAZ_flag
main_gui_h = findall(0 , 'type', 'figure', 'tag', 'figure1');
handles = guidata(main_gui_h);
check_TAZ_flag = 0;
XYZ = handles.XYZ;
if ~isfield(handles , 'Z_factor')
    Z_factor = str2double(get(handles.edit_Z_factor, 'String'));
else
    Z_factor = handles.Z_factor
end
global  check_TAZ_err_GL  
if exist('check_TAZ_err_GL', 'var')
    for i = 1 : length(check_TAZ_err_GL)
        if isempty(check_TAZ_err_GL{i}) == 0
            delete(check_TAZ_err_GL{i});
        end
    end
end
figure_child_h = get(get(hObject, 'Parent'),'Child');           %获得figure中各子图句柄
for jj = 1 : length(figure_child_h)
    if isequal(get(figure_child_h(jj), 'Type'), 'uitable')
        uitable_h = figure_child_h(jj);                                  %获得uitable句柄
    end
end
crt_ut_data = get(uitable_h , 'data');
crt_original_data = crt_ut_data(:,1);
crt_modified_data = crt_ut_data(:,2);
for i = 1 : length(crt_modified_data)
    if isnan(crt_modified_data(i)) == 1
        XYZ(:,4) = XYZ(:,4) * Z_factor;
        crtIndex = crt_original_data(i);
        crt_xyz = XYZ(XYZ(:,1) == crtIndex, 2:4);
        check_TAZ_err{1} = patch(crt_xyz(:,1) , crt_xyz(:,2) , crt_xyz(:,3) , 'w');
        set(check_TAZ_err{1},  'EdgeColor', 'r', 'FaceColor', 'none', 'LineWidth', 3)
        check_TAZ_err_GL = check_TAZ_err;
        errordlg(['There exists an empty ID in row ' , num2str(i) , ' !'], 'Check Error');
        return
    end
end
unique_crt_modified_data = unique(crt_modified_data);
if length(unique_crt_modified_data) ~= length(crt_modified_data)
    sta = tabulate(crt_modified_data);
    err_which = find(sta(:,2) >= 2);
    err_where = find(crt_modified_data == sta(err_which(1), 1));
    err_original = crt_original_data(err_where(1:2));
    XYZ(:,4) = XYZ(:,4) * Z_factor;
    for k = 1 : 2
        crt_xyz = XYZ(XYZ(:,1) == err_original(k), 2:4);
        check_TAZ_err{k} = patch(crt_xyz(:,1) , crt_xyz(:,2) , crt_xyz(:,3) , 'w');
        set(check_TAZ_err{k},  'EdgeColor', 'r', 'FaceColor', 'none', 'LineWidth', 3)
    end
    check_TAZ_err_GL = check_TAZ_err;
    errordlg(['There exist 2 same IDs in row ' , num2str(err_where(1)), ' and ' , num2str(err_where(2)) , ' !'], 'Check Error');
    return
end     
msgbox('No problem found. You can save.');
check_TAZ_flag = 1;
handles.check_TAZ_flag = check_TAZ_flag;
guidata(main_gui_h, handles);




% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --------------------------------------------------------------------
function Adj_Ent_ID_Callback(hObject, eventdata, handles)
% hObject    handle to Adj_Ent_ID (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if ~isfield(handles, 'XYZ')
    errordlg('There is NO valid TAZ input' , 'No TAZ Data')
    return
end
XYZ = handles.XYZ;
if ~isfield(handles, 'ENTXYZ')
    errordlg('There is NO valid Entrance input' , 'No Entrance Data')
    return
end
if exist('check_Ent_fig', 'var') | exist('check_Ent_fig', 'class')
    close(check_Ent_fig);
end
% 关闭除主fig之外的所有fig
all_figs = findall(0, 'type', 'figure');
for af_i = 1 : length(all_figs)
    crt_fig_in_all_figs = all_figs(af_i);
    if ~isequal(get(crt_fig_in_all_figs, 'tag') , 'figure1')
        delete(crt_fig_in_all_figs)
    end
end
check_Ent_fig = figure('Name' , 'Check / Modify the Entrance ID ' , 'NumberTitle' , 'off',...
    'Position', [250 100 1400 850], 'Color', 'w', 'Unit', 'normalized');
if ~isfield(handles , 'Z_factor')
    Z_factor = str2double(get(handles.edit_Z_factor, 'String'));
else
    Z_factor = handles.Z_factor
end
% Z_factor_GL = Z_factor;
figure(check_Ent_fig)
axis equal
axis off
xyz = XYZ;
xyz(:,4) = xyz(:,4) * Z_factor;             %竖向拉开
%画全体
unique_XYZ = unique(xyz(: , 1));
for i = 1 : size(unique_XYZ)
    crtTAZindex = unique_XYZ(i);
    index = find(xyz(:,1) == crtTAZindex);
    hold on
    patch(xyz(index,2) , xyz(index,3) , xyz(index,4) , [0.8,0.8,0.8])
end
% 画出入口
entxyz = handles.ENTXYZ;
entxyz(:,4) = entxyz(:,4) * Z_factor;
h_ent = plot3(entxyz(: , 2), entxyz(:, 3), entxyz(:, 4), 'kp','MarkerFacecolor', 'k');

set(gcf,'color','w')
axis equal
axis off
xyz_taz_ent = [xyz; entxyz];            %只是用来确定四个边界
xlim([min(xyz_taz_ent(:,2)) - .05*(max(xyz_taz_ent(:,2))-min(xyz_taz_ent(:,2))), max(xyz_taz_ent(:,2)) + .05*(max(xyz_taz_ent(:,2))-min(xyz_taz_ent(:,2)))]);
ylim([min(xyz_taz_ent(:,3)) - .05*(max(xyz_taz_ent(:,3))-min(xyz_taz_ent(:,3))), max(xyz_taz_ent(:,3)) + .05*(max(xyz_taz_ent(:,3))-min(xyz_taz_ent(:,3)))]);
if max(xyz(:,4)) > min(xyz(:,4))
    zlim([min(xyz_taz_ent(:,4)) - .05*(max(xyz_taz_ent(:,4))-min(xyz_taz_ent(:,4))), max(xyz_taz_ent(:,4)) + .05*(max(xyz_taz_ent(:,4))-min(xyz_taz_ent(:,4)))]);
end
alpha(0.5)
az = handles.az;
el = handles.el;
view(az,el)
set(gca,'position',[0 0.03 .6 .97])
rotate3d on

%表格
original_ent_id = unique(entxyz(:,1));
ut_ent_data = repmat(original_ent_id, 1 , 2);
ut = uitable(check_Ent_fig, 'data', ut_ent_data, 'ColumnName', {'Origin TAZ ID', 'Modified TAZ ID'},...
     'ColumnEditable', [false true], 'Units', 'normalized', 'CellSelectionCallback', @cellsel_callback_Ent,...
     'CellEditCallback', @celledit_callback_Ent);
set(ut, 'Position', [.65 .08 .26 .8])
set(ut, 'ColumnWidth',{150})
% handles.TAZ_ID_check_tabale_data = ut_data;
% guidata(hObject, handles);

%标注
% global centroid_h_GL centroid_GL new_centroid_h_GL
zrange = max(xyz_taz_ent(:,4)) - min(xyz_taz_ent(:,4));
for kkk = 1 : size(entxyz,1)
    ent_label_h{kkk} = text(entxyz(kkk,2), entxyz(kkk,3), entxyz(kkk,4)+0.025*zrange, num2str(entxyz(kkk,1)) , 'color', 'k');
end
% centroid_h_GL = centroid_h;
% centroid_GL = centroid;
% clear new_centroid_h_GL
handles.zrange = zrange;
handles.ent_label_h = ent_label_h;
new_ent_label_h{size(entxyz, 1)} = [];
handles.new_ent_label_h = new_ent_label_h;
guidata(hObject, handles);


%检查
check_button = uicontrol(check_Ent_fig, 'Style', 'pushbutton', 'String', '<html>Check the Modified<br>Entrance IDs</html>',...
        'Unit', 'normalized', 'Position', [.65 .90 .12 .06], 'FontSize', 10, ...
        'Callback', @check_button_Ent);
% set(check_button, 'HorizontalAlignment', 'center');
%保存
save_button = uicontrol(check_Ent_fig, 'Style', 'pushbutton', 'String', '<html>Check the Modified<br>Entrance IDs</html>',...
        'Unit', 'normalized', 'Position', [.79 .90 .12 .06], 'FontSize', 10, ...
        'Callback', @saveButton_Ent_Callback); 
% set(save_button, 'HorizontalAlignment', 'center');
handles = guidata(hObject);
handles.save_button = save_button;
guidata(hObject, handles);

%保存回调
function saveButton_Ent_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global drawnow_sel_GL_Ent
main_gui_h = findall(0 , 'type', 'figure', 'tag', 'figure1');
handles = guidata(main_gui_h);
if ~isfield(handles, 'check_Ent_flag') | handles.check_Ent_flag ~= 1
    errordlg('You must check the modified Entrance IDs first!', 'Check Error');
    return
end
entxyz = handles.ENTXYZ;
figure_child_h = get(get(hObject, 'Parent'),'Child');           %获得figure中各子图句柄
for jj = 1 : length(figure_child_h)
    if isequal(get(figure_child_h(jj), 'Type'), 'uitable')
        uitable_h = figure_child_h(jj);                                  %获得uitable句柄
        break
    end
end
crt_ut_data = get(uitable_h , 'data');
crt_original_data = crt_ut_data(:,1);
crt_modified_data = crt_ut_data(:,2);

if isfield(handles, 'ent_label_h')
    ent_label_h = handles.ent_label_h;
    for ki = 1 : length(ent_label_h)
        delete(ent_label_h{ki});
    end
end
if isfield(handles, 'new_ent_label_h')
    new_ent_label_h = handles.new_ent_label_h;
    for ki = 1 : length(new_ent_label_h)
        delete(new_ent_label_h{ki});
    end
end
if exist('drawnow_sel_GL_Ent', 'var')
    delete(drawnow_sel_GL_Ent)
end
% 更新ENTXYZ数据
for i = 1 : size(entxyz, 1)
    oldone = entxyz(i, 1);
    newone = crt_modified_data(crt_original_data == oldone);
    entxyz(i, 1) = newone;
end
handles.ENTXYZ = entxyz;
guidata(main_gui_h, handles);
% 更新表格
set(uitable_h , 'data', repmat(unique(entxyz(:,1)), 1, 2));
% 重置标注
if ~isfield(handles , 'Z_factor')
    Z_factor = str2double(get(handles.edit_Z_factor, 'String'));
else
    Z_factor = handles.Z_factor
end
clear ent_label_h   new_ent_label_h
entxyz(:,4) = entxyz(:,4) * Z_factor;             %竖向拉开
zrange = handles.zrange;

for kkk = 1 : size(entxyz, 1)
    ent_label_h{kkk} = text(entxyz(kkk,2), entxyz(kkk,3), ...
        entxyz(kkk,4)+0.025*zrange, num2str(entxyz(kkk,1)) , 'color', 'k');
end
handles.ent_label_h = ent_label_h;
new_ent_label_h{size(entxyz, 1)} = [];
handles.new_ent_label_h = new_ent_label_h;
guidata(main_gui_h, handles);
close_GoOn = questdlg('Are you sure that all Entrance IDs are correctly modified?' , 'Finish the Modification',...
    'No, go on modifiying' , 'Yes, close the window',  'No, go on modifiying' );
if isequal(close_GoOn, 'No, go on modifiying')
    return
else
    close(gcf);
end


%选中回调
function cellsel_callback_Ent(hTab , event)
main_gui_h = findall(0 , 'type', 'figure', 'tag', 'figure1');
handles = guidata(main_gui_h);
global  drawnow_sel_GL_Ent
% XYZ = XYZ_GL;
% Z_factor = Z_factor_GL;
ENTXYZ = handles.ENTXYZ;
if ~isfield(handles , 'Z_factor')
    Z_factor = str2double(get(handles.edit_Z_factor, 'String'));
else
    Z_factor = handles.Z_factor
end
if exist('drawnow_sel_GL_Ent', 'var')
    delete(drawnow_sel_GL_Ent)
end

% 获得默认的marksersize大小，2倍突出之
% 关闭除主fig之外的所有fig
all_figs = findall(0, 'type', 'figure');
for af_i = 1 : length(all_figs)
    crt_fig_in_all_figs = all_figs(af_i);
    if ~isequal(get(crt_fig_in_all_figs, 'tag') , 'figure1')
        check_Ent_fig_acquire = crt_fig_in_all_figs;
        break;
    end
end
axis_acquire = findall(check_Ent_fig_acquire, 'type', 'axes');          %回到axis
for axis_i = 1 : length(axis_acquire)
    if isequal(get(axis_acquire(axis_i), 'tag'), 'MATLAB_Rotate3D_Axes') == 0
        axis_acquire = axis_acquire(axis_i);
        break
    end
end
line_acquire = findall(axis_acquire, 'type', 'line');                    %回到line
default_marker_size = get(line_acquire, 'markersize');

if ~isempty(event.Indices)
    data = get(hTab, 'Data');
    iRow = event.Indices(1);
    iCol = event.Indices(2);
    ENTXYZ(:,4) = ENTXYZ(:,4) * Z_factor;   
    crtIndex = data(iRow, 1);
    crt_entxyz = ENTXYZ(ENTXYZ(:,1) == crtIndex, 2:4);
    drawnow_sel_ent = plot3(crt_entxyz(: , 1), crt_entxyz(:, 2), crt_entxyz(:, 3), ...
        'rp','MarkerFacecolor', 'r', 'MarkerSize', 2*default_marker_size);
    drawnow_sel_GL_Ent = drawnow_sel_ent;
end


%修改回调
function celledit_callback_Ent(hTab, event)
main_gui_h = findall(0 , 'type', 'figure', 'tag', 'figure1');
handles = guidata(main_gui_h);
ent_label_h = handles.ent_label_h;
new_ent_label_h = handles.new_ent_label_h;
entxyz = handles.ENTXYZ;
zrange = handles.zrange;
if ~isfield(handles , 'Z_factor')
    Z_factor = str2double(get(handles.edit_Z_factor, 'String'));
else
    Z_factor = handles.Z_factor
end
entxyz(:, 4) = entxyz(: ,4) * Z_factor;
handles.check_Ent_flag = 0;                 %每次修改之后，都要重新检查
if isempty(event.Error)
    data = get(hTab, 'Data');
    iRow = event.Indices(1);
    iCol = event.Indices(2);
%     crtIndex = data(iRow, 1);
    crtIndex = find(entxyz(:,1) == data(iRow,1));
    delete(ent_label_h{crtIndex});
    if isempty(new_ent_label_h{crtIndex}) == 0
        delete(new_ent_label_h{crtIndex});
    end
    new_ent_label_h{crtIndex} = text(entxyz(crtIndex,2), ...
       entxyz(crtIndex,3), entxyz(crtIndex,4)+0.025*zrange, ...
       num2str(data(iRow, iCol)) , 'color', 'r', 'FontWeight', 'bold');
end
handles.new_ent_label_h = new_ent_label_h;
guidata(main_gui_h, handles);
% new_centroid_h_GL = new_centroid_h;

%检查回调
function check_button_Ent(hObject, callbackdata)
clear check_Ent_flag
main_gui_h = findall(0 , 'type', 'figure', 'tag', 'figure1');
handles = guidata(main_gui_h);
check_Ent_flag = 0;
figure_child_h = get(get(hObject, 'Parent'),'Child');           %获得figure中各子图句柄
for jj = 1 : length(figure_child_h)
    if isequal(get(figure_child_h(jj), 'Type'), 'uitable')
        uitable_h = figure_child_h(jj);                                  %获得uitable句柄
    end
end
crt_ut_data = get(uitable_h , 'data');
crt_original_data = crt_ut_data(:,1);
crt_modified_data = crt_ut_data(:,2);
for i = 1 : length(crt_modified_data)
    if isnan(crt_modified_data(i)) == 1
        errordlg(['There exists an empty ID in row ' , num2str(i) , ' !'], 'Check Error');
        return
    end
end
unique_crt_modified_data = unique(crt_modified_data);
if length(unique_crt_modified_data) ~= length(crt_modified_data)
    sta = tabulate(crt_modified_data);
    err_which = find(sta(:,2) >= 2);
    err_where = find(crt_modified_data == sta(err_which(1), 1));
    errordlg(['There exist 2 same IDs in row ' , num2str(err_where(1)), ' and ' , num2str(err_where(2)) , ' !'], 'Check Error');
    return
end     
msgbox('No problem found. You can save.');
check_Ent_flag = 1;
handles.check_Ent_flag = check_Ent_flag;
guidata(main_gui_h, handles);


% --------------------------------------------------------------------
function Untitled_16_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --------------------------------------------------------------------
function Untitled_17_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
dxf2coord_ccsim;
if ~exist('lwpolylines', 'var') | isequal(lwpolylines, []) | size(lwpolylines, 2) ~= 4
    errordlg('Fail to load from dxf.', 'TAZ');
    return
end
msgbox('Successfully load TAZ base data from dxf.', 'TAZ');
handles.XYZ = lwpolylines;
NTAZ = length(unique(lwpolylines(:, 1)));
set(handles.Num_TAZ, 'string', num2str(NTAZ));
handles.NTAZ = NTAZ;
guidata(hObject, handles);


% --------------------------------------------------------------------
function Untitled_18_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
dxf2coord_ccsim;
if isequal(points, []) | size(points, 2) ~= 4
    errordlg('Fail to load from dxf.', 'Entrance');
    return
end
msgbox('Successfully load Entrance base data from dxf.', 'Entrance');
handles.ENTXYZ = points;
NENT = length(points(:,1));
handles.NENT = NENT;
guidata(hObject, handles);
set(handles.Num_ent, 'string', num2str(NENT));


% --------------------------------------------------------------------
function clear_base_data_Callback(hObject, eventdata, handles)
% hObject    handle to clear_base_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 2016-3-18：加了userdata属性，判断是不是要问，如果是1，则要问，如果是0，直接默认是sure
% ask_sure = get(hObject, 'userdata');
% if ask_sure == 1
sure = questdlg('Are you sure that you are going to clear and reset all the configured data?', 'Clear and Reset',...
    'Yes', 'No', 'No');
% elseif ask_sure == 0
%     sure = 'Yes';
% else
%     return
% end
rm_list = {'NTAZ', 'XYZ', 'ENTXYZ', 'NENT', 'NPED', 'X_area', 'X_dist', 'X_dist_ent', 'X_stdf', 'X_stdf_ent',...
        'X_familarity', 'X_ent_distrib', 'X_ent_distrib_load_ind_derived', 'b_area', 'b_familarity', 'b_dist',...
        'b_stdf', 'b_visited', 'b_past', 'consume_rawdata', 'time_var', 'EntTime_distrib_type', 'EntTime_distrib',...
        'space_time_result_flag', 'timely_taz_stat_result', 'path_rawdata', 'space_time_rawdata', 'X_ind_ent',...
        'X_ind_ent_time', 'ent_time_distr', 'stay_time_rawdata', 'stay_time_distr', 'traffic_time',...
        'Sim_result', 'Sim_mean_OD', 'Sim_OD_3d', 'Sim_gn', 'Sim_cv', 'Sim_mean_actpp', 'Sim_taz_distrib',...
        'Sim_mean_taz_distrib', 'Sim_mean_gn', 'Sim_mean_cv', 'b_sim_times', 'Sim_actpp', 'consume_prob', 'expenditure_distr',...
        'Comp_TAZ_distrib', 'Comp_cv', 'Comp_gn', 'Comp_mean_actpp', 'Comp_OD', 'od_abs_mode_max', 'od_abs_mode_min', 'od_abs_mode',...
        'PlotChoice', 'marker_size', 'dyn_rst_play_start_time', 'dyn_rst_play_end_time', 'dyn_rst_play_step_size', 'dyn_rst_play_speed',...
         'b_familarity_user', 'b_dist_user', 'b_stdf_user', 'b_visited_user', 'b_past_user', 'b_area_user', 'colormap_legend_fig',...
         'base_area', 'comp_timely_taz_stat_result', 'comp_expenditure_distr', 'centroid_h', 'centroid', 'new_centroid_h',...
         'fname', 'pname', 'dyn_var','capacity'};
exist_var(1) = isfield(handles, 'NTAZ'); exist_var(2) = isfield(handles, 'XYZ'); exist_var(3) = isfield(handles, 'ENTXYZ');
exist_var(4) = isfield(handles, 'NENT'); exist_var(5) = isfield(handles, 'NPED'); exist_var(6) = isfield(handles, 'X_area');
exist_var(7) = isfield(handles, 'X_dist'); exist_var(8) = isfield(handles, 'X_dist_ent'); exist_var(9) = isfield(handles, 'X_stdf');
exist_var(10) = isfield(handles, 'X_stdf_ent'); exist_var(11) = isfield(handles, 'X_familarity'); exist_var(12) = isfield(handles, 'X_ent_distrib');
exist_var(13) = isfield(handles, 'X_ent_distrib_load_ind_derived'); exist_var(14) = isfield(handles, 'b_area'); 
exist_var(15) = isfield(handles, 'b_familarity'); exist_var(16) = isfield(handles, 'b_dist'); exist_var(17) = isfield(handles, 'b_stdf');
exist_var(18) = isfield(handles, 'b_visited'); exist_var(19) = isfield(handles, 'b_past'); exist_var(20) = isfield(handles, 'consume_rawdata');
exist_var(21) = isfield(handles, 'time_var'); exist_var(22) = isfield(handles, 'EntTime_distrib_type');  exist_var(23) = isfield(handles, 'EntTime_distrib');
exist_var(24) = isfield(handles, 'space_time_result_flag'); exist_var(25) = isfield(handles, 'timely_taz_stat_result');
exist_var(26) = isfield(handles, 'path_rawdata');  exist_var(27) = isfield(handles, 'space_time_rawdata');
exist_var(28) = isfield(handles, 'X_ind_ent');  exist_var(29) = isfield(handles, 'X_ind_ent_time');
exist_var(30) = isfield(handles, 'ent_time_distr');  exist_var(31) = isfield(handles, 'stay_time_rawdata'); 
exist_var(32) = isfield(handles, 'stay_time_distr');  exist_var(33) = isfield(handles, 'traffic_time'); 
exist_var(34) = isfield(handles, 'Sim_result');   exist_var(35) = isfield(handles, 'Sim_mean_OD');
exist_var(36) = isfield(handles, 'Sim_OD_3d');   exist_var(37) = isfield(handles, 'Sim_gn');  
exist_var(38) = isfield(handles, 'Sim_cv');  exist_var(39) = isfield(handles, 'Sim_mean_actpp');
exist_var(40) = isfield(handles, 'Sim_taz_distrib');  exist_var(41) = isfield(handles, 'Sim_mean_taz_distrib'); 
exist_var(42) = isfield(handles, 'Sim_mean_gn');   exist_var(43) = isfield(handles, 'Sim_mean_cv'); 
exist_var(44) = isfield(handles, 'b_sim_times');   exist_var(45) = isfield(handles, 'Sim_actpp'); 
exist_var(46) = isfield(handles, 'consume_prob');   exist_var(47) = isfield(handles, 'expenditure_distr');
exist_var(48) = isfield(handles, 'Comp_TAZ_distrib');  exist_var(49) = isfield(handles, 'Comp_cv'); 
exist_var(50) = isfield(handles, 'Comp_gn');   exist_var(51) = isfield(handles, 'Comp_mean_actpp');
exist_var(52) = isfield(handles, 'Comp_OD');    exist_var(53) = isfield(handles, 'od_abs_mode_max');
exist_var(54) = isfield(handles, 'od_abs_mode_min');  exist_var(55) = isfield(handles, 'od_abs_mode');
exist_var(56) = isfield(handles, 'PlotChoice');     exist_var(57) = isfield(handles, 'marker_size');
exist_var(58) = isfield(handles, 'dyn_rst_play_start_time');  exist_var(59) = isfield(handles, 'dyn_rst_play_end_time');
exist_var(60) = isfield(handles, 'dyn_rst_play_step_size');  exist_var(61) = isfield(handles, 'dyn_rst_play_speed');
exist_var(62) = isfield(handles, 'b_familarity_user');  exist_var(63) = isfield(handles, 'b_dist_user');
exist_var(64) = isfield(handles, 'b_stdf_user');  exist_var(65) = isfield(handles, 'b_visited_user');
exist_var(66) = isfield(handles, 'b_past_user');  exist_var(67) = isfield(handles, 'b_area_user');
exist_var(68) = isfield(handles, 'colormap_legend_fig'); exist_var(69) = isfield(handles, 'base_area');
exist_var(70) = isfield(handles, 'comp_timely_taz_stat_result'); exist_var(71) = isfield(handles, 'comp_expenditure_distr');
exist_var(72) = isfield(handles, 'centroid_h');     exist_var(73) = isfield(handles,  'centroid');    
exist_var(74) = isfield(handles,  'new_centroid_h');   exist_var(75) = isfield(handles,  'fname');
exist_var(76) = isfield(handles,  'pname');   exist_var(77) = isfield(handles,  'dyn_var');
exist_var(78) = isfield(handles, 'capacity');

if isequal(sure, 'Yes')
    handles = rmfield(handles, rm_list(exist_var));
    guidata(hObject, handles)
end
rm_list2 = {'user_def_var' , 'selected_pre_def_var_value' , 'adv_var' , 'X_adv', 'beta_adv', ...
    'logit_long_form', 'long_form_var_index', 'long_form_choice_index', 'long_form_var_names', 'F'};
exist_var2(1) = isfield(handles, 'user_def_var'); exist_var2(2) = isfield(handles, 'selected_pre_def_var_value');
exist_var2(3) = isfield(handles, 'adv_var'); exist_var2(4) = isfield(handles, 'X_adv');
exist_var2(5) = isfield(handles, 'beta_adv'); exist_var2(6) = isfield(handles, 'logit_long_form');
exist_var2(7) = isfield(handles, 'long_form_var_index');  exist_var2(8) = isfield(handles, 'long_form_choice_index');
exist_var2(9) = isfield(handles, 'long_form_var_names');  exist_var2(10) = isfield(handles, 'F');

if isequal(sure, 'Yes')
    handles = rmfield(handles, rm_list2(exist_var2));
    guidata(hObject, handles)
end

cla reset
set(gcf,'color','w')
axis equal
axis off
set(handles.Num_TAZ, 'string', '')
set(handles.Num_ent, 'string', '')
set(handles.Num_Ped, 'string', '')
set(handles.AreaInput, 'string', 'Waiting for Input', 'Enable', 'on')
set(handles.FamInput, 'string', 'Waiting for Input', 'Enable', 'on')
set(handles.DistInput, 'string', 'Waiting for Input', 'Enable', 'on')
set(handles.StdfInput, 'string', 'Waiting for Input', 'Enable', 'on')
set(handles.e_a, 'string', '0.0001', 'style', 'edit')
set(handles.e_b, 'string', '1.4', 'style', 'edit')
set(handles.e_c, 'string', '-0.01', 'style', 'edit')
set(handles.edit_b_stdf, 'string', '-0.4', 'style', 'edit')
set(handles.edit_b_visited, 'string', '-1.5', 'style', 'edit')
set(handles.edit_b_past, 'string', '0.6', 'style', 'edit')
set(handles.edit_Comp_actpp, 'string', '')
handles.b_sim_times = 10;
handles.od_t = 1;
handles.od_abs_mode = 0;
handles.az = -37;
handles.el = 19;
handles.active_handles = handles.blank_handles;
set(handles.change_od_mode, 'checked', 'off')

if handles.adv_mode == 1
    set(handles.e_a, 'string', 'N/A', 'style', 'text')
    set(handles.e_b, 'string', 'N/A', 'style', 'text')
    set(handles.e_c, 'string', 'N/A', 'style', 'text')
    set(handles.edit_b_stdf, 'string', 'N/A', 'style', 'text')
    set(handles.edit_b_visited, 'string', 'N/A', 'style', 'text')
    set(handles.edit_b_past, 'string', 'N/A', 'style', 'text')
    set(handles.AreaInput, 'string', 'Advance Mode', 'Enable', 'off')
    set(handles.FamInput, 'string', 'Advance Mode', 'Enable', 'off')
    set(handles.DistInput, 'string', 'Advance Mode', 'Enable', 'off')
    set(handles.StdfInput, 'string', 'Advance Mode', 'Enable', 'off')
    set(handles.beta_panel, 'title', 'Behaivoral Coefficients: NOT Available in Advance Mode')
    set(handles.xs_panel, 'title', 'Explanatory Variables: Waiting for Variable Defination in Advance Mode')

end
guidata(hObject, handles);

% --------------------------------------------------------------------
function XYZ_shp_Callback(hObject, eventdata, handles)
% hObject    handle to XYZ_shp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 关闭除主fig之外的所有fig
all_figs = findall(0, 'type', 'figure');
for af_i = 1 : length(all_figs)
    crt_fig_in_all_figs = all_figs(af_i);
    if ~isequal(get(crt_fig_in_all_figs, 'tag') , 'figure1')
        delete(crt_fig_in_all_figs)
    end
end
hinstr = {'You are going to load TAZ base data from shapefile. Notice that:'; '' ;'';...
    '1. Make sure that you have .shp, .shx, .dbf files with the same name. ';'';...
    '2. It can not load from a 3D-shapefile (with PolygonZ class) directly, ';...
       'you have to convert it to common 2D-shapefile as following steps:';
    '     1) ''ArcToolbox'' -- ''Conversion Tools'' -- ''To Shapefile'' -- ''Feature Class to Shapefile(multiple)''';
    '     2) Select your 3D-shapefile as the ''Input Feature'', then select the ''Output Folder''';
    '     3) Click the Environments button on the bottom, go to ''M Values'' and select ''Disabled'' in ''Output has M Values''';
    '     4) Go to ''Z values'' and select ''Disabled'' in ''Ouput has Z Values'', then click ''OK''';
    '     5) Finished, there would be a 2D-polygon copy of your original file, in which Z vaule would be stored as evaluation field and all other fields reseverd.';
    };
aa = msgbox(hinstr, 'Hints');
% default_figure_position = get(0,'DefaultFigurePosition');
% set(0,'DefaultFigurePosition', [default_figure_position(1:2),default_figure_position(3)*1.5,default_figure_position(4)]);
% set(aa, 'Units','normalized')
% set(aa , 'Position', [.3 .4 .4 .2])
% set(0, 'DefaultFigurePosition',default_figure_position)
waitfor(aa);
[fname , pname]=uigetfile('*.shp' , 'Open the Shapgefile');
if isequal(fname, 0) | isequal(pname, 0)
    return
end
fullname = strcat(pname, fname);
try 
    XYZ_shp = shaperead(fullname);
catch
   errordlg('Failed to read data from shp, make sure that you are NOT dealing with 3D-shp (with polygonZ)', 'Error');
   return
end
NTAZ = length(XYZ_shp);
all_fields = fieldnames(XYZ_shp);
exclude_fields = {'Geometry', 'BoundingBox', 'FID_', 'Entity', 'Layer', 'Color', 'Linetype', 'LineWt', 'RefName', 'X', 'Y', 'Elevation'};
temp_fields = setdiff(all_fields, exclude_fields);
valid_fields{1, 1} = 'None';
j = 2;
for i = 1 : length(temp_fields)
    if isnumeric(getfield(XYZ_shp(1) , temp_fields{i}))
        valid_fields{j,1} = temp_fields{i};
        j = j + 1;
    end
end
clear temp_fields
valid_XYZ_shp = rmfield(XYZ_shp, setdiff(all_fields, valid_fields));
valid_XYZ_table = struct2table(valid_XYZ_shp);
choose_fig = figure('Name' , 'Choose the Attribute Fields' ,  'Unit', 'normalized', ...
    'NumberTitle' , 'off', 'Position', [.35 .1 .3 .8], 'Color', 'w', 'Menubar', 'none');

if ~isfield(handles, 'adv_mode') | handles.adv_mode == 0                                %简单模式
    
    ID_choose_popupmenu = uicontrol('Parent', choose_fig, 'style', 'popupmenu',...
        'Unit', 'normalized', 'Position', [.06 .8 .19 .1], 'String', valid_fields ,...
        'CallBack', @ID_choose_popumenu_callback);
    area_choose_popupmenu = uicontrol('Parent', choose_fig, 'style', 'popupmenu',...
        'Unit', 'normalized', 'Position', [.31 .8 .19 .1], 'String', valid_fields,...
        'CallBack', @area_choose_popumenu_callback);
    familarity_choose_popupmenu = uicontrol('Parent', choose_fig, 'style', 'popupmenu',...
        'Unit', 'normalized', 'Position', [.55 .8 .19 .1], 'String', valid_fields,...
        'CallBack', @familarity_choose_popumenu_callback);
    save_pushbutton = uicontrol('Parent', choose_fig, 'style', 'pushbutton',...
        'Unit', 'normalized', 'Position', [.80 .87 .14 .08], 'String', 'OK', 'Fontsize', 12,...
        'CallBack', @save_pushbutton_callback);
    ID_text = uicontrol('Parent', choose_fig, 'style', 'text',...
        'Unit', 'normalized', 'Position', [.06 .92 .19 .02], 'String', 'Real TAZ ID',...
        'BackGroundColor', 'w', 'FontSize', 12);
    area_text = uicontrol('Parent', choose_fig, 'style', 'text',...
        'Unit', 'normalized', 'Position', [.31 .92 .19 .02], 'String', 'Area',...
        'BackGroundColor', 'w', 'FontSize', 12);
    familarity_text = uicontrol('Parent', choose_fig, 'style', 'text',...
        'Unit', 'normalized', 'Position', [.55 .92 .19 .02], 'String', 'Attractiveness',...
        'BackGroundColor', 'w', 'FontSize', 12);
    % 自动设定值
    find_ID = strcmpi(valid_fields, 'ID');
    if sum(find_ID) == 1
        set(ID_choose_popupmenu, 'value', find(find_ID == 1));
    end
    find_area = strcmpi(valid_fields , 'area');
    if sum(find_area) == 1
        set(area_choose_popupmenu, 'value', find(find_area == 1));
    end
    find_familarity = strcmpi(valid_fields, 'attract');
    if sum(find_familarity) == 1
        set(familarity_choose_popupmenu, 'value', find(find_familarity == 1));
    else
        find_familarity = strcmpi(valid_fields, 'attractiveness');
        if sum(find_familarity) == 1
            set(familarity_choose_popupmenu, 'value', find(find_familarity == 1));
        else
            find_familarity = strcmpi(valid_fields, 'attractive');
            if sum(find_familarity) == 1
                set(familarity_choose_popupmenu, 'value', find(find_familarity == 1));
            end
        end
    end
    
    %设置表格数据
    % format long g
    data = nan(NTAZ , 3);
    if get(ID_choose_popupmenu, 'value') ~= 1
        select_ID_field = valid_fields{get(ID_choose_popupmenu, 'value')};
        try
            data(:,1) = table2array(valid_XYZ_table(: , select_ID_field));
        catch
            errordlg(['The field [',select_ID_field , '] is not suitable for ID'], 'Error')
            return
        end
    else
        data(:,1) = [1 : NTAZ]';
    end
    if get(area_choose_popupmenu, 'value') ~= 1
        select_area_field = valid_fields{get(area_choose_popupmenu, 'value')};
        try
            data(:,2) = table2array(valid_XYZ_table(: , select_area_field));
        catch
            errordlg(['The field [',select_area_field , '] is not suitable for Area'], 'Error')
            return
        end
    end
    if get(familarity_choose_popupmenu, 'value') ~= 1
        select_familarity_field = valid_fields{get(familarity_choose_popupmenu, 'value')};
        try
            data(:,3) = table2array(valid_XYZ_table(: , select_familarity_field));
        catch
            errordlg(['The field [',select_familarity_field , '] is not suitable for Attractiveness'], 'Error')
            return
        end
    end
    
    ut = uitable('Parent', choose_fig, 'data', data, 'ColumnName', {'Real TAZ ID', 'Area', 'Attractiveness'},...
        'ColumnEditable', [false false false false], 'Units', 'normalized');
    set(ut, 'Position', [.1 .075 .8 .75])
    set(ut, 'ColumnWidth',{135})
    set(ut, 'ColumnFormat', {'numeric', 'bank',  'numeric'})
    % 存储数据-次要
    handles.NTAZ = NTAZ;
    set(handles.Num_TAZ, 'string', num2str(NTAZ));
    handles.valid_XYZ_table = valid_XYZ_table;
    handles.valid_fields = valid_fields;
    handles.XYZ_shp = XYZ_shp;
    guidata(hObject, handles);
    
    
elseif handles.adv_mode == 1                %高级模式
    set(choose_fig, 'name', 'Choose the attribute fields (Advance Mode)')
    set(choose_fig , 'Position', [.25 .1 .5 .8]);
    if ~isfield(handles, 'adv_var')
        errordlg('In advance mode, you must firstly define your variables in Advance menu', 'No Variables');
        return
    else
%         adv_var = handles.adv_var;            %考虑到有矩阵变量和更新变量的存在，不直接用这个
        selected_pre_def_var_value = handles.selected_pre_def_var_value;
        user_def_var = handles.user_def_var;
    end
    if any(selected_pre_def_var_value == 1)
        pre_def_area_temp = 'Area';
    else
        pre_def_area_temp = [];
    end
    if any(selected_pre_def_var_value == 2)
        pre_def_familarity_temp = 'Attractiveness';
    else
        pre_def_familarity_temp = [];
    end
    adv_var_static = [pre_def_area_temp; pre_def_familarity_temp; user_def_var];             %只要静态属性，不要矩阵和动态属性
    % 选择变量表格
    choose_var_ut_column_name = {'Name', 'Source'};
    choose_var_ut_column_format = {'char', valid_fields'};
    choose_var_ut_data = ['ID'; adv_var_static];
    for i = 1 : size(choose_var_ut_data, 1)
        choose_var_ut_data{i, 2} = 'None';
    end
    choose_rst = ones(size(choose_var_ut_data, 1), 1);      %用于下一步显示数据
        % 自动设定值
        find_ID = strcmpi(valid_fields, 'ID');
        if sum(find_ID) == 1
            choose_var_ut_data{1, 2} = valid_fields{find_ID == 1};
            choose_rst(1) = find(find_ID == 1);
        end
        for kkk = 2 : size(choose_var_ut_data ,1)
            crt_set_var = choose_var_ut_data{kkk, 1};
            if isequal(crt_set_var , 'Area')
                find_area = strcmpi(valid_fields , 'area');
                if sum(find_area) == 1
                    choose_var_ut_data{kkk, 2} = valid_fields{find_area == 1};
                    choose_rst(kkk) = find(find_area == 1);
                end
            elseif isequal(crt_set_var , 'Attractiveness')
                find_familarity = strcmpi(valid_fields, 'attract');
                if sum(find_familarity) == 1
                    choose_var_ut_data{kkk, 2} = valid_fields{find_familarity == 1};
                    choose_rst(kkk) = find(find_familarity == 1);
                else
                    find_familarity = strcmpi(valid_fields, 'attractiveness');
                    if sum(find_familarity) == 1
                        choose_var_ut_data{kkk, 2} = valid_fields{find_familarity == 1};
                        choose_rst(kkk) = find(find_familarity == 1);
                    else
                        find_familarity = strcmpi(valid_fields, 'attractive');
                        if sum(find_familarity) == 1
                            choose_var_ut_data{kkk, 2} = valid_fields{find_familarity == 1};
                            choose_rst(kkk) = find(find_familarity == 1);
                        end
                    end
                end
            else
                find_crt_user_def = strcmpi(valid_fields , crt_set_var);
                if sum(find_crt_user_def) == 1
                    choose_var_ut_data{kkk, 2} = valid_fields{find_crt_user_def == 1};
                    choose_rst(kkk) = find(find_crt_user_def == 1);
                end
            end
        end
    choose_var_ut = uitable('parent', choose_fig, 'data', choose_var_ut_data,...
        'ColumnName', choose_var_ut_column_name, 'ColumnFormat', ...
        choose_var_ut_column_format, 'ColumnEditable', [false, true],...
        'unit', 'normalized', 'position', [.05 .2 .25 .7], ...
        'CellEditCallback', @adv_choose_var_ut_edit_callback);
    choose_var_ut_str = uicontrol('parent', choose_fig, 'style', 'text',...
        'string', 'Variable Table', 'unit', 'normalized', 'position', ...
        [.05 .905 .25 .03], 'fontsize', 12, 'fontweight', 'bold',...
        'backgroundcolor', 'w');
    set(choose_var_ut, 'columnwidth', {100, 100})
    % 变量显示表格
    show_var_ut_column_name = choose_var_ut_data(: , 1);
    show_var_ut_column_name = show_var_ut_column_name';
    show_var_ut_data = nan(NTAZ , length(show_var_ut_column_name));
    show_var_ut_column_format{1} = 'numeric';
    choose_rst_str = get(choose_var_ut, 'data');
    choose_rst_str = choose_rst_str(:, end);
%     for cri = 1 : length(choose_rst_str)
%         choose_rst(cri,1) = find(strcmpi(valid_fields, choose_rst_rst{cri}) == 1);
%     end
    if ~isequal(choose_rst_str{1}  , 'None')
        select_ID_field = choose_rst_str{1};
        try
            show_var_ut_data(:,1) = table2array(valid_XYZ_table(: , select_ID_field));
        catch
            errordlg(['The field [',select_ID_field , '] is not suitable for ID'], 'Error')
            return
        end
    else
        data(:,1) = [1 : NTAZ]';
    end
    
    for ij = 2 : length(choose_rst_str)
        crt_select_field = choose_rst_str{ij};
        show_var_ut_column_format{ij} = 'bank';
        if ~isequal(crt_select_field, 'None')
            try
                show_var_ut_data(:,ij) = table2array(valid_XYZ_table(: , crt_select_field));
                if isequal(round(show_var_ut_data(:,ij)), show_var_ut_data(:,ij))
                    show_var_ut_column_format{ij} = 'numeric';
                end
            catch
                errordlg(['The field [',crt_select_field , '] is not suitable for ', show_var_ut_column_name(ij)], 'Error')
                return
            end
        end
    end
    show_var_ut = uitable('parent', choose_fig, 'data', show_var_ut_data,...
        'ColumnName', show_var_ut_column_name, 'ColumnFormat', ...
        show_var_ut_column_format, 'ColumnEditable', false,...
        'unit', 'normalized', 'position', [.35 .08 .6 .82], 'UserData','show_var_ut');
    set(show_var_ut, 'columnwidth', 'auto')
    show_var_ut_str = uicontrol('parent', choose_fig, 'style', 'text',...
        'string', 'Data Table', 'unit', 'normalized', 'position', ...
        [.35 .905 .6 .03], 'fontsize', 12, 'fontweight', 'bold',...
        'backgroundcolor', 'w');
        % 存储数据-次要
    handles.NTAZ = NTAZ;
    set(handles.Num_TAZ, 'string', num2str(NTAZ));
    handles.valid_XYZ_table = valid_XYZ_table;
    handles.valid_fields = valid_fields;
    handles.XYZ_shp = XYZ_shp;
    guidata(hObject, handles);
    
    % OK
    adv_ok_pushbutton = uicontrol('parent', choose_fig, 'style', 'pushbutton',...
        'string', 'OK', 'unit', 'normalized', 'position', [.1 .085 .14 .09],...
        'callback', @adv_ok_pushbutton_callback, 'fontsize', 12);
end

% 以上为各个回调函数
function ID_choose_popumenu_callback(hObject, eventdata)
main_gui_h = findall(0 , 'type', 'figure', 'tag', 'figure1');
handles = guidata(main_gui_h);
valid_fields = handles.valid_fields;
valid_XYZ_table = handles.valid_XYZ_table;
ut = findall(get(hObject, 'Parent') , 'type', 'uitable');
data = get(ut, 'data');
NTAZ = size(data , 1);
if get(hObject, 'value') ~= 1
    select_ID_field = valid_fields{get(hObject, 'value')};
    try
        data(:,1) = table2array(valid_XYZ_table(: , select_ID_field));
    catch
        errordlg(['The field [',select_ID_field , '] is not suitable for ID'], 'Error')
        return
    end
else
    data(:,1) = [1 : NTAZ]';
end
set(ut, 'data', data)

function area_choose_popumenu_callback(hObject, eventdata)
main_gui_h = findall(0 , 'type', 'figure', 'tag', 'figure1');
handles = guidata(main_gui_h);
valid_fields = handles.valid_fields;
valid_XYZ_table = handles.valid_XYZ_table;
ut = findall(get(hObject, 'Parent') , 'type', 'uitable');
data = get(ut, 'data');
NTAZ = size(data , 1);
if get(hObject, 'value') ~= 1
    select_ID_field = valid_fields{get(hObject, 'value')};
    try
        data(:,2) = table2array(valid_XYZ_table(: , select_ID_field));
    catch
        errordlg(['The field [',select_ID_field , '] is not suitable for ID'], 'Error')
        return
    end
else
    data(:,2) = nan(NTAZ, 1)';
end
set(ut, 'data', data)

function familarity_choose_popumenu_callback(hObject, eventdata)
main_gui_h = findall(0 , 'type', 'figure', 'tag', 'figure1');
handles = guidata(main_gui_h);
valid_fields = handles.valid_fields;
valid_XYZ_table = handles.valid_XYZ_table;
ut = findall(get(hObject, 'Parent') , 'type', 'uitable');
data = get(ut, 'data');
NTAZ = size(data , 1);
if get(hObject, 'value') ~= 1
    select_ID_field = valid_fields{get(hObject, 'value')};
    try
        data(:,3) = table2array(valid_XYZ_table(: , select_ID_field));
    catch
        errordlg(['The field [',select_ID_field , '] is not suitable for ID'], 'Error')
        return
    end
else
    data(:,3) = nan(NTAZ, 1)';
end
set(ut, 'data', data)

function save_pushbutton_callback(hObject, eventdata)
main_gui_h = findall(0 , 'type', 'figure', 'tag', 'figure1');
handles = guidata(main_gui_h);
XYZ_shp = handles.XYZ_shp;
ut = findall(get(hObject, 'Parent') , 'type', 'uitable');
data = get(ut, 'data');
XYZ = [];
for i = 1 : length(XYZ_shp)
    crt_ID = data(i, 1);
    crt_X = XYZ_shp(i).X;
    crt_X = crt_X(isnan(crt_X) == 0)';
    crt_Y = XYZ_shp(i).Y;
    crt_Y = crt_Y(isnan(crt_Y) == 0)';
    % 有可能导进去的数据没有elevation字段，需要添加：2016-09-13
    if isfield(XYZ_shp(i), 'Elevation')
        crt_Z = XYZ_shp(i).Elevation;
    else
        crt_Z = 0;
    end
    crt_XYZ = [crt_ID*ones(length(crt_X) , 1), crt_X, crt_Y, crt_Z*ones(length(crt_X) , 1)];
    XYZ = [XYZ; crt_XYZ];
end
handles.XYZ = XYZ;
if sum(isnan(data(:,2))) == 0                   %如果area有输入
    % 2016-3-23：要先按TAZID排序啊亲！
    tazid_area = data(:,1:2);
    tazid_area = sortrows(tazid_area, 1);
    handles.X_area = tazid_area(:,2);
%     handles.X_area = data(:,2);
    set(handles.AreaInput, 'string', 'Finished');
end
if sum(isnan(data(:, 3))) == 0                  %如果familarity有输入
    % 2016-3-23：要先按TAZID排序啊亲！
    tazid_familarity = data(:,[1,3]);
    tazid_familarity = sortrows(tazid_familarity, 1);
    handles.X_familarity = tazid_familarity(:,2);
%     handles.X_familarity = data(:, 3);
    set(handles.FamInput, 'string', 'Finished: aggregate');
end
if isfield(handles, 'XYZ_shp')
    handles = rmfield(handles, 'XYZ_shp');
end
if isfield(handles, 'valid_fields')
    handles = rmfield(handles, 'valid_fields');
end
if isfield(handles, 'valid_XYZ_table')
    handles = rmfield(handles, 'valid_XYZ_table');
end
guidata(main_gui_h, handles);
close(gcf)

function adv_choose_var_ut_edit_callback(hTab, event)
if ~isempty(event.Indices)
    main_gui_h = findall(0 , 'type', 'figure', 'tag', 'figure1');
    handles = guidata(main_gui_h);
    valid_fields = handles.valid_fields;
    valid_XYZ_table = handles.valid_XYZ_table;
    show_var_ut = findall(get(hTab, 'Parent') , 'type', 'uitable', 'UserData', 'show_var_ut');
    show_var_ut_data = get(show_var_ut, 'data');
    show_var_ut_column_format = get(show_var_ut, 'columnformat');
    NTAZ = size(show_var_ut_data , 1);
    choose_rst_alldata = get(hTab, 'data');
    iLine = event.Indices(1);
    iColumn = event.Indices(2);
    if iLine == 1 & iColumn == 2                    %改动的是ID
        if ~isequal(choose_rst_alldata{iLine, iColumn}  , 'None')
            select_ID_field = choose_rst_alldata{iLine, iColumn};
            try
                show_var_ut_data(:,1) = table2array(valid_XYZ_table(: , select_ID_field));
            catch
                errordlg(['The field [',select_ID_field , '] is not suitable for ID'], 'Error')
                return
            end
        else
            show_var_ut_data(:,1) = [1 : NTAZ]';
        end
    elseif iLine ~= 1 & iColumn == 2            %改动的是其它属性
        crt_select_field = choose_rst_alldata{iLine, iColumn};
        if ~isequal(crt_select_field, 'None')
            try
                show_var_ut_data(:,iLine) = table2array(valid_XYZ_table(: , crt_select_field));
                 if isequal(round(show_var_ut_data(:,iLine)), show_var_ut_data(:,iLine))
                    show_var_ut_column_format{iLine} = 'numeric';
                 else
                     show_var_ut_column_format{iLine} = 'bank';
                end
            catch
                errordlg(['The field [',crt_select_field , '] is not suitable for ', show_var_ut_column_name(iLine)], 'Error')
                return
            end
        else
            show_var_ut_data(:, iLine) = nan(NTAZ,  1);
        end
    end
    set(show_var_ut, 'data', show_var_ut_data)
    set(show_var_ut, 'columnformat', show_var_ut_column_format);
end

function adv_ok_pushbutton_callback(hObject, eventdata)
main_gui_h = findall(0 , 'type', 'figure', 'tag', 'figure1');
handles = guidata(main_gui_h);
XYZ_shp = handles.XYZ_shp;
X_adv = handles.X_adv;
ut = findall(get(hObject, 'Parent') , 'type', 'uitable', 'UserData', 'show_var_ut');
adv_var_static = get(ut, 'columnname');
data = get(ut, 'data');
XYZ = [];
for i = 1 : length(XYZ_shp)
    crt_ID = data(i, 1);
    crt_X = XYZ_shp(i).X;
    crt_X = crt_X(isnan(crt_X) == 0)';
    crt_Y = XYZ_shp(i).Y;
    crt_Y = crt_Y(isnan(crt_Y) == 0)';
    % 如果直接从二维SHP导入，有可能没有Elevation字段：2016-09-13
    if isfield(XYZ_shp(i), 'Elevation')
        crt_Z = XYZ_shp(i).Elevation;
    else
        crt_Z = 0;
    end
    crt_XYZ = [crt_ID*ones(length(crt_X) , 1), crt_X, crt_Y, crt_Z*ones(length(crt_X) , 1)];
    XYZ = [XYZ; crt_XYZ];
end
handles.XYZ = XYZ;
for var_i = 2 : size(data, 2)
    if sum(isnan(data(:, var_i))) == 0
        crt_var_name = adv_var_static{var_i};          %不-1是因为adv_var_static直接读的是表头，包括了ID
        crt_var_name = lower(crt_var_name);
        if isequal(crt_var_name , 'attractiveness')
            crt_var_name = 'familarity';
        elseif isequal(crt_var_name , 'stair(difference)')
            crt_var_name = 'stdf';
        elseif isequal(crt_var_name , 'distance')
            crt_var_name = 'dist';
        end
        % 2016-3-23：先按照id顺序排个序啊亲！
        data = sortrows(data, 1);
        if isfield(X_adv, crt_var_name)
            eval(['X_adv.' crt_var_name '= data(:, var_i);']);
        end
    end
end
if isfield(X_adv, 'area') & ~isempty(X_adv.area) & ~isnan(X_adv.area(1))
    set(handles.AreaInput, 'string', 'Finished')
end
if isfield(X_adv, 'familarity') & ~isempty(X_adv.familarity) & ~isnan(X_adv.familarity(1))
    set(handles.FamInput, 'string', 'Finished: aggregate')
end
    
handles.X_adv = X_adv;
if isfield(handles, 'XYZ_shp')
    handles = rmfield(handles, 'XYZ_shp');
end
if isfield(handles, 'valid_fields')
    handles = rmfield(handles, 'valid_fields');
end
if isfield(handles, 'valid_XYZ_table')
    handles = rmfield(handles, 'valid_XYZ_table');
end
guidata(main_gui_h, handles);
close(gcf)



% --------------------------------------------------------------------
function Untitled_20_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load_taz_info_Callback(hObject, eventdata, handles)


% --------------------------------------------------------------------
function Untitled_21_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load_ent_info_Callback(hObject, eventdata, handles)


% --------------------------------------------------------------------
function bc_distribution_at_entrances_Callback(hObject, eventdata, handles)
% hObject    handle to bc_distribution_at_entrances (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isfield(handles , 'NENT')
     errordlg('Please firstly input Num of Entrances' , 'NENT Error')
     return
end
if ~isfield(handles, 'NPED')
    errordlg('You must firtly set the Num. of individual in simulation.', 'Error')
    return
else
    NPED = handles.NPED;
end
NENT = handles.NENT;
[choice_rst ,ok] = listdlg(...
    'ListString'  , {'Aggregate: Using Entrance-CSV','Aggregate: Directly Entering',...
    'Aggregate: Deriving From Individual Information','Individual Level: Using Exact Indivudial Infromation', 'Check Data'},...
    'SelectionMode', 'single', 'Name', 'Entrance Distribution Data', ...
    'ListSize', [270, 120]);
if ok == 0
    return
end
switch choice_rst
    case 3
        if ~isfield(handles , 'X_ent_distrib_load_ind_derived')
            errordlg('There is NO derived entrance distribution data.', 'Entrance Distribution Eroor');
            return
        else
            handles.X_ent_distrib = handles.X_ent_distrib_load_ind_derived;
            guidata(hObject , handles);
        end
         judge = 'This is aggregate entrance distribution';
            ent_distrib = [[1:NENT]' , handles.X_ent_distrib];
            show = strvcat(judge , 'Entrance    Ratio' , num2str(ent_distrib));
            msgbox(show)
    case 1
        if ~isfield(handles , 'X_ent_distrib_load_entrance')
            errordlg('There is NO aggregate entrance distribution data in Entrance-CSV file', 'Entrance Distribution Eroor');
            return
        else
            X_ent_distrib = handles.X_ent_distrib_load_entrance;
            handles.X_ent_distrib = X_ent_distrib;
            guidata(hObject , handles);
            
        end
        judge = 'This is aggregate entrance distribution';
            ent_distrib = [[1:NENT]' , X_ent_distrib];
            show = strvcat(judge , 'Entrance    Ratio' , num2str(ent_distrib));
            msgbox(show)
    case 4
        if ~isfield(handles , 'X_ind_ent')
            errordlg('There is NO individual-specific entrance distribution data in Individual-Information-CSV file', 'Entrance Distribution Eroor');
            return
        else
            X_ent_distrib = handles.X_ind_ent;
            handles.X_ent_distrib = X_ent_distrib;
            guidata(hObject , handles);
        end
        judge = strvcat('This is individual level entrance distribution' , 'Here is the derived aggregate entrance distribution');
           derived = handles.X_ent_distrib_load_ind_derived;
           ent_distrib = [[1:NENT]' , derived];
            show = strvcat(judge , 'Entrance    Ratio' , num2str(ent_distrib));
            msgbox(show)
    case 2
        str = ['Please enter space(/comma)-separated distribution ratios in the order: from Entrance_1 to Entrance_' , num2str(NENT)];
        pasted_value = inputdlgWC([str, '; OR please enter ONLY ONE abitrary number for EVEN distribution among ALL entrances'] , 'Area Data Input', [1 80 ]);
        if isempty(pasted_value) == 1
            return
        end
        pasted_value = str2num(pasted_value{:});
        if length(pasted_value) == NENT
            X_ent_distrib = pasted_value';
            X_ent_distrib = X_ent_distrib / sum(X_ent_distrib);
            handles.X_ent_distrib = X_ent_distrib;
            guidata(hObject,handles);
        elseif length(pasted_value) == 1
            X_ent_distrib = ones(NENT , 1) * (1 / NENT);
            handles.X_ent_distrib = X_ent_distrib;
            guidata(hObject,handles);
        else
            errordlg('Input Num of area data NEITHER equal equal Num of TAZ NOR equal 1' , 'Entrance Distribution Input Error')
            return
        end
        judge = 'This is aggregate entrance distribution';
            ent_distrib = [[1:NENT]' , X_ent_distrib];
            show = strvcat(judge , 'Entrance    Ratio' , num2str(ent_distrib));
            msgbox(show)
    case 5
        if ~isfield(handles , 'X_ent_distrib')
        warndlg('There is NO valid entrance distribution input' ,'Entrance Distribution Data Input')
    else
        X_ent_distrib = handles.X_ent_distrib;
        if length(X_ent_distrib) == NENT
            judge = 'This is aggregate entrance distribution';
            ent_distrib = [[1:NENT]' , X_ent_distrib];
            show = strvcat(judge , 'Entrance    Ratio' , num2str(ent_distrib));
            msgbox(show)
        else
           judge = strvcat('This is individual level entrance distribution' , 'Here is the derived aggregate entrance distribution');
           derived = handles.X_ent_distrib_load_ind_derived;
           ent_distrib = [[1:NENT]' , derived];
            show = strvcat(judge , 'Entrance    Ratio' , num2str(ent_distrib));
            msgbox(show)
        end
    end
end


% --------------------------------------------------------------------
function excel_confi_file_Callback(hObject, eventdata, handles)
% hObject    handle to excel_confi_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_24_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_25_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Load_Individual_Information_menu_Callback(hObject, eventdata, handles)
% hObject    handle to Load_Individual_Information_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load_ind_fam_Callback(hObject, eventdata, handles)
% [fname_ind_csv , pname_ind_csv]=uigetfile('*.csv' , 'Open the Individual CSV');
% if fname_ind_csv == 0
%     return
% end
% fullname_ind_csv = strcat(pname_ind_csv,fname_ind_csv);
% try
%     ind_csv = csvread(fullname_ind_csv);
% catch
%     errordlg('Fail to open the CSV file');
%     return
% end
% ids = unique(ind_csv(: , 1));
% NPED = length(ids);
% handles.Num_Ped.String = NPED;
% handles.NPED = NPED;
% guidata(hObject , handles);
% if size(ind_csv) >= 2
%     X_ind_ent = unique(ind_csv(:,1:2) , 'rows');
%     handles.X_ind_ent = X_ind_ent;
%     tab = tabulate(X_ind_ent(: , 2));
%     X_ent_distrib_load_ind_derived = tab(: , [3]);
%     X_ent_distrib_load_ind_derived = X_ent_distrib_load_ind_derived / 100;
%     handles.X_ent_distrib_load_ind_derived = X_ent_distrib_load_ind_derived;
% %     handles.X_ent_distrib_load_ind = X_ind_ent(: , 2);
%     guidata(hObject , handles);
% end


% --------------------------------------------------------------------
function Untitled_27_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function New_ccsim_editor_Callback(hObject, eventdata, handles)
% hObject    handle to New_ccsim_editor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
v_h = ccsim_editor;                %子界面的句柄


% --------------------------------------------------------------------
function use_current_Callback(hObject, eventdata, handles)
% hObject    handle to use_current (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isfield(handles, 'XYZ') & ~isfield(handles, 'ENTXYZ')
    errordlg('No valid TAZ or entrance data', 'No Data')
    return
end
if isfield(handles, 'XYZ')
    XYZ = handles.XYZ;
else
    XYZ = 0;
end
if isfield(handles, 'ENTXYZ')
    ENTXYZ = handles.ENTXYZ;
else
    ENTXYZ = 0;
end
v_h = ccsim_editor(XYZ, ENTXYZ);                %子界面的句柄


% --------------------------------------------------------------------
function Untitled_28_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menu_stair_ac_Callback(hObject, eventdata, handles)
% hObject    handle to menu_stair_ac (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.adv_mode == 1
    if ~isfield(handles, 'X_adv')
        errordlg('You must firstly define vairables', 'Advance Mode Error')
        return
    end
    if ~isfield(handles.X_adv, 'stdf')
        errordlg('Stair Variable is not inluded in the variable list you define', ...
            'Advance Mode Error')
        return
    end
end
if ~isfield(handles, 'XYZ')
    errordlg('No TAZs data', 'Error')
    return
else
    XYZ = handles.XYZ;
end

if ~isfield(handles, 'NENT')
    errordlg('No Num. of entrance', 'Error')
    return
else
    NENT = handles.NENT;
end

all_figs = findall(0, 'type', 'figure');
for af_i = 1 : length(all_figs)
    crt_fig_in_all_figs = all_figs(af_i);
    if ~isequal(get(crt_fig_in_all_figs, 'tag') , 'figure1')
        delete(crt_fig_in_all_figs)
    end
end

stair_matrix_autocalculation = figure('Name' , 'Distance in Stairs' , 'NumberTitle' , 'off',...
    'Position', [250 100 1400 850], 'Color', 'w', 'Unit', 'normalized');
if ~isfield(handles , 'Z_factor')
    Z_factor = str2double(get(handles.edit_Z_factor, 'String'));
else
    Z_factor = handles.Z_factor;
end
% Z_factor_GL = Z_factor;
figure(stair_matrix_autocalculation)
axis equal
axis off
xyz = XYZ;
xyz(:,4) = xyz(:,4) * Z_factor;             %竖向拉开
%画全体
unique_XYZ = unique(xyz(: , 1));
for i = 1 : length(unique_XYZ)
    crtTAZindex = unique_XYZ(i);
    index = find(xyz(:,1) == crtTAZindex);
    hold on
    XYZ_patch_h{i} = patch(xyz(index,2) , xyz(index,3) , xyz(index,4) , [0.8,0.8,0.8]);     %按ID编号从小到大（1-NTAZ）画图
end
handles.XYZ_patch_h = XYZ_patch_h;
set(gcf,'color','w')
axis equal
axis off
xlim([min(xyz(:,2)) - .05*(max(xyz(:,2))-min(xyz(:,2))), max(xyz(:,2)) + .05*(max(xyz(:,2))-min(xyz(:,2)))]);
ylim([min(xyz(:,3)) - .05*(max(xyz(:,3))-min(xyz(:,3))), max(xyz(:,3)) + .05*(max(xyz(:,3))-min(xyz(:,3)))]);
if max(xyz(:,4)) > min(xyz(:,4))
    zlim([min(xyz(:,4)) - .05*(max(xyz(:,4))-min(xyz(:,4))), max(xyz(:,4)) + .05*(max(xyz(:,4))-min(xyz(:,4)))]);
end
alpha(0.5)
az = handles.az;
el = handles.el;
view(az,el)
set(gca,'position',[0 0.03 .5 .97])
rotate3d on

%标注
ids = unique(xyz(:,1));
for kkk = 1 : length(ids)
    crt = xyz(xyz(:,1) == ids(kkk) , 2:4);
    crt_rst = polygeom(crt(:,1) , crt(:,2));
    centroid(kkk , 1:2) = crt_rst(2:3);
    centroid(kkk, 3) = crt(1, 3);
end
for kkk = 1 : length(ids)
    centroid_h{kkk} = text(centroid(kkk,1), centroid(kkk,2), centroid(kkk,3), num2str(ids(kkk)) , 'color', 'k');
    centroid_temp(kkk, :) = [ids(kkk), centroid(kkk,1), centroid(kkk,2), centroid(kkk,3)];
end
handles.centroid_temp = centroid_temp;
%自动计算建筑
ID_Z = unique(XYZ(:, [1 4]),'rows');
handles.ID_Z = ID_Z;
unique_ID = unique(XYZ(:,1));
NTAZ = length(unique_ID);
for i = 1 : length(unique_ID)
    crt_rst = polygeom(XYZ(XYZ(:,1)==unique_ID(i),2), XYZ(XYZ(:,1)==unique_ID(i),3));
    centroids(i, :) = [unique_ID(i), crt_rst(2), crt_rst(3)];
end
for i = 1 : size(centroids, 1)
    crtXYZ = XYZ(XYZ(:,1) == centroids(i, 1), 2:3);
    check_polygonTAZ(:,i) = inpolygon(centroids(:,2), centroids(:,3), crtXYZ(:,1), crtXYZ(:,2));
end 
Floor_under_index = ID_Z(ID_Z(:,2)<=0, 1);
Floor_under_z = ID_Z(ID_Z(:,2)<=0, 2);
Floor_above_index = ID_Z(ID_Z(:,2)>=0, 1); 
Floor_above_index_bf = Floor_above_index;
Floor_above_Z = ID_Z(ID_Z(:,2)>=0, 2);
Floor_above_Z_bf = Floor_above_Z;
usefull_check_polygonTAZ = check_polygonTAZ(Floor_above_index, Floor_above_index);
usefull_check_polygonTAZ_bf = usefull_check_polygonTAZ;
BUI = {};
k = 1;
while length(Floor_above_index) > 0
    if sum(usefull_check_polygonTAZ(: , 1)) < 2
        Floor_above_index(1) = [];
        Floor_above_Z(1) = [];
        usefull_check_polygonTAZ(:, 1) = [];
        usefull_check_polygonTAZ(1, :) = [];
    else
        find_index = usefull_check_polygonTAZ(: , 1) == 1;
        BUI{k, 1} = Floor_above_index(find_index);
        BUI{k, 2} = Floor_above_Z(find_index);
        Floor_above_index(find_index) = [];
        Floor_above_Z(find_index) = [];
        usefull_check_polygonTAZ(find_index, :) = [];
        usefull_check_polygonTAZ(:, find_index) = [];
        k = k + 1;
    end
end
if ~isempty(BUI)
BUI_table = BUI(:, 1);
for k = 1 : length(BUI_table)
    crt = mat2str(BUI_table{k});
    crt = crt(2: end-1);
    BUI_table{k} = crt;
end
BUI_table = [BUI_table; ' '];
else
    BUI_table = {' '};
end

%显示建筑%
BU_color = rand(size(BUI, 1), 3);
handles.BU_color = BU_color;
guidata(hObject, handles);
for i = 1 : size(BUI, 1)
    crtBU = BUI{i, 1};
    if length(crtBU) > 1
        for k = 1 : length(crtBU)
            set(XYZ_patch_h{crtBU(k)}, 'facecolor', BU_color(i, :));
        end
    end
end
%显示建筑%

%表格初始化
BU_ut = uitable(stair_matrix_autocalculation, 'data', BUI_table, 'ColumnName', {'TAZ ID'},...
     'ColumnEditable', [true], 'Units', 'normalized', ...
     'CellEditCallback', @celledit_callback_BU_ut);
set(BU_ut, 'Position', [.5 .7 .135 .2])
set(BU_ut, 'ColumnWidth',{145})

AC = {};
AC_table = [AC; ' '];
AC_ut = uitable(stair_matrix_autocalculation, 'data', AC_table, 'ColumnName', {'TAZ ID'},...
     'ColumnEditable', [true], 'Units', 'normalized', ...
     'CellEditCallback', @celledit_callback_AC_ut);
set(AC_ut, 'Position', [.665 .7 .135 .2])
set(AC_ut, 'ColumnWidth',{145})
%表格初始化

% button  %
cal_button = uicontrol(stair_matrix_autocalculation, 'style', 'pushbutton',...
     'string', 'Calculate', 'Units', 'normalized', ...
     'Callback', @cal_button_callback, 'Position', [0.84 0.83 0.09 0.07],...
     'fontsize', 14);
 
 ok_button = uicontrol(stair_matrix_autocalculation, 'style', 'pushbutton',...
     'string', 'OK', 'Units', 'normalized', ...
     'Callback', @ok_button_callback, 'Position', [0.84 0.73 0.09 0.07],...
     'fontsize', 14);
 % button  %
 
 % title  %
BUI_text = uicontrol(stair_matrix_autocalculation, 'style', 'text',...
     'string', 'Buidings', 'Units', 'normalized', ...
     'Position', [.5 .91 .135 .03],...
     'fontsize', 14, 'backgroundcolor', [1 1 1]);
AC_text = uicontrol(stair_matrix_autocalculation, 'style', 'text',...
     'string', 'Above Connections', 'Units', 'normalized', ...
     'Position', [.665 .91 .135 .03],...
     'fontsize', 14, 'backgroundcolor', [1 1 1]);
 X_stdf_text = uicontrol(stair_matrix_autocalculation, 'style', 'text',...
     'string', 'Stairs: TAZ - TAZ', 'Units', 'normalized', ...
     'Position', [.5 .61 .3 .03],...
     'fontsize', 14, 'backgroundcolor', [1 1 1]);
  X_stdf_ent_text = uicontrol(stair_matrix_autocalculation, 'style', 'text',...
     'string', 'Stairs: TAZ - Entrance', 'Units', 'normalized', ...
     'Position', [.82 .61 .15 .03],...
     'fontsize', 14, 'backgroundcolor', [1 1 1]);
 % title  % 

handles.BUI = BUI;
handles.AC = AC;
handles.Floor_under_z = Floor_under_z;
handles.Floor_under_index = Floor_under_index;
guidata(hObject, handles);

% 结果表格初始化  %
X_stdf = nan(NTAZ);
X_stdf_ut = uitable(stair_matrix_autocalculation, 'data', X_stdf,...
     'ColumnEditable', true, 'Units', 'normalized');
set(X_stdf_ut, 'Position', [.5 .1 .3 .5])
set(X_stdf_ut, 'visible','off', 'ColumnWidth', mat2cell(40*ones(1,NTAZ), 1, ones(1, NTAZ)))

% 先搞定出入口，简化处理
if isfield(handles, 'ENTXYZ')
    ENTXYZ = handles.ENTXYZ;
    ENT_ID_Z = ENTXYZ(:, [1 4]);
    ALL_Z = [ID_Z(:,2); ENT_ID_Z(:,2)];
    ALL_Z = unique(ALL_Z);      %搞层数
    for i = 1 : NENT
        ENT_ID_floor(i, :) = [ENT_ID_Z(i,1), find(ALL_Z == ENT_ID_Z(i,2))];
    end
    for i = 1 : NTAZ
        ID_floor(i, :) = [ID_Z(i,1), find(ALL_Z == ID_Z(i,2))];
    end
    for i = 1 : NENT
        X_stdf_ent(:, i) = abs(ENT_ID_floor(i,2) - ID_floor(:,2));
    end
else
    X_stdf_ent = zeros(NTAZ, NENT);
end

X_stdf_ent_ut = uitable(stair_matrix_autocalculation, 'data', X_stdf_ent,...
     'ColumnEditable', true, 'Units', 'normalized');
set(X_stdf_ent_ut, 'Position', [.82 .1 .15 .5])
set(X_stdf_ent_ut, 'visible','off', 'ColumnWidth', mat2cell(40*ones(1,NENT), 1, ones(1, NENT)))
 % 结果表格初始化  %


function cal_button_callback(hObject , callbackdata)
% 根据Building与Above Connection计算STDF, 需要Floor_under_z,Floor_under_index,BUI,
% AC, NTAZ, graphkshortestpaths
main_gui_h = findall(0 , 'type', 'figure', 'tag', 'figure1');
handles = guidata(main_gui_h);
NTAZ = handles.NTAZ;
NENT = handles.NENT;
Floor_under_z = handles.Floor_under_z;
Floor_under_index = handles.Floor_under_index;
AC = handles.AC;
BUI = handles.BUI;
NBUI = size(BUI, 1);
NAC = size(AC, 1);
conn_Z = 9999 * ones(NTAZ, NTAZ);              %竖向可达矩阵， -9999代表没有路，阻抗无限大，初始化
unique_Floor_under_z = unique(Floor_under_z);
if length(unique_Floor_under_z) > 1
    for i = 1 : length(unique_Floor_under_z)-1
        crt_under = Floor_under_index(Floor_under_z == unique_Floor_under_z(i));
        crt_upper = Floor_under_index(Floor_under_z == unique_Floor_under_z(i+1));
        conn_Z(crt_under, crt_under) = 0.0000001;
        conn_Z(crt_upper, crt_upper) = 0.0000001;
        conn_Z(crt_under, crt_upper) = 1;
        conn_Z(crt_upper, crt_under) = 1;
    end
elseif length(unique_Floor_under_z) == 1
    conn_Z(Floor_under_index, Floor_under_index) = 0.0000001;
end

if NBUI > 0
    for i = 1 : NBUI            %BU: 第1列为输入的TAZ编号，第2列为对应的Z
        crtBU_index = BUI{i, 1};
        crtBU_z = BUI{i, 2};
        %2016-3-20,应该输成列向量，用分号，如果用了逗号，转置
        if size(crtBU_index, 1) == 1 & size(crtBU_index, 2) >= 1
            crtBU_index = crtBU_index';
        elseif size(crtBU_index, 1) > 1 & size(crtBU_index, 2) > 1
            errordlg('Invalid inupt: you should use the same separator.', 'Error')
            return
        end
        crtBU = [crtBU_index, crtBU_z];
        unique_z = unique(crtBU_z);
        if length(unique_z) == 1
            conn_Z(crtBU_index, crtBU_index) = 0.0000001;
        else
            for k = 1 : length(unique_z)-1
                crtBU_under = crtBU(crtBU(:,2)==unique_z(k), 1);
                crtBU_upper = crtBU(crtBU(:,2)==unique_z(k+1), 1);
                conn_Z(crtBU_under, crtBU_upper) = 1;
                conn_Z(crtBU_upper, crtBU_under) = 1;
                conn_Z(crtBU_under, crtBU_under) = 0.0000001;
                conn_Z(crtBU_upper, crtBU_upper) = 0.0000001;
            end
        end
    end
end
if NAC > 0
    for i = 1 : NAC         %AC，连廊，第1列，为连廊编号,第2列为输入的TAZ编号
        crtAC_index = AC{i, 1};
        conn_Z(crtAC_index, crtAC_index) = 0.0000001;
    end
end
conn_Z_s = sparse(conn_Z);
stdf = nan(NTAZ, NTAZ);
for i = 1 : NTAZ
    stdf(i ,i) = 0;
end
for i = 1 : NTAZ-1
    for j = i : NTAZ
        [d, p] = graphkshortestpaths(conn_Z_s, i, j ,1);
        stdf(i, j) = floor(d);
        stdf(j, i) = floor(d);
    end
end
X_stdf = stdf;
handles.X_stdf = stdf;
guidata(main_gui_h, handles);
this_figure_h = findall(0 , 'type', 'figure', 'name', 'Distance in Stairs');
all_uitable = findall(this_figure_h, 'type', 'uitable');
for k = 1 : length(all_uitable)
    if isequal(size(get(all_uitable(k), 'data')), [NTAZ NTAZ])
        X_stdf_ut = all_uitable(k);
        break
    end
end
for k = 1 : length(all_uitable)
    if isequal(size(get(all_uitable(k), 'data')), [NTAZ NENT])
        X_stdf_ent_ut = all_uitable(k);
        break
    end
end
set(X_stdf_ut, 'data', X_stdf, 'visible', 'on')
set(X_stdf_ent_ut, 'visible', 'on')
% 根据Building与Above Connection计算STDF




% show = strvcat('TAZ - TAZ Matrix: ' , num2str(stdf));
% h1 = figure;
% data = uicontrol('style','text','units','normalized','string',show,...
%     'horizontalalignment','center','position',[.1 .1 .88 .88]);
% button = uicontrol('style','pushbutton','units','normalized','string','OK','position',[.4 .02 .2 .08],'Callback','close(gcf)');

% 各种回调函数
function celledit_callback_BU_ut(hTab , event)
main_gui_h = findall(0 , 'type', 'figure', 'tag', 'figure1');
handles = guidata(main_gui_h);
ID_Z = handles.ID_Z;
if ~isempty(event.Indices)
    data = get(hTab, 'Data');
    if ~isequal(data{end}, ' ')
        data = [data ; ' '];
        set(hTab, 'Data', data);
    end
    while length(data) >= 2 & length(data{end-1}) == 0
        data = data(1:end-1);
    end
    set(hTab, 'Data', data);
end
try
    BUI_table_new = get(hTab, 'data');
    for i = 1 : length(BUI_table_new)
        crt_ID = BUI_table_new{i};
        crt_ID = str2num(crt_ID);
        BUI{i, 1} = crt_ID;
        crt_Z = [];
        for k = 1 : length(crt_ID)
            crt_Z(k, 1) = ID_Z(ID_Z(:,1)==crt_ID(k), 2);
        end
        BUI{i, 2} = crt_Z;
    end
catch
    errordlg('Fail to update the data, check your input in the ''Buildings'' table', ...
        'Table Data Error')
    return
end
% 显示建筑更新
BU_color = handles.BU_color;
XYZ_patch_h = handles.XYZ_patch_h;
for i = 1 : length(XYZ_patch_h)
    set(XYZ_patch_h{i}, 'facecolor', [.8 .8 .8])
end
if size(BUI,1) > size(BU_color, 1)
    BU_color = [BU_color; rand(size(BUI,1) - size(BU_color, 1), 3)];
end
for i = 1 : size(BUI, 1)
    crtBU = BUI{i, 1};
    if length(crtBU) > 1
        for k = 1 : length(crtBU)
            set(XYZ_patch_h{crtBU(k)}, 'facecolor', BU_color(i, :));
        end
    end
end

handles.BUI = BUI;
guidata(main_gui_h, handles);


function celledit_callback_AC_ut(hTab , event)
main_gui_h = findall(0 , 'type', 'figure', 'tag', 'figure1');
handles = guidata(main_gui_h);
centroid_temp = handles.centroid_temp;
if isfield(handles, 'line_h')
    line_h = handles.line_h;
    for k = 1 : length(line_h)
        delete(line_h{k})
    end
    clear line_h
end
if ~isempty(event.Indices)
    data = get(hTab, 'Data');
    if ~isequal(data{end}, ' ')
        data = [data ; ' '];
        set(hTab, 'Data', data);
    end
    while length(data) >= 2 & length(data{end-1}) == 0
        data = data(1:end-1);
    end
    set(hTab, 'Data', data);
end
try
    AC_table_new = get(hTab, 'data');
    line_h = {};
    for i = 1 : length(AC_table_new)
        crt_ID = AC_table_new{i};
        crt_ID = str2num(crt_ID);
        AC{i, 1} = crt_ID;
    end
catch
    errordlg('Fail to update the data, check your input in the ''Above Connections'' table', ...
        'Table Data Error')
    return
end
for i = 1 : length(AC)
    crt_ID = AC{i};
    %连线
    if length(crt_ID) > 1
        for kk = 1 : length(crt_ID) -1
            for jj = kk + 1
                x_from = centroid_temp(centroid_temp(:,1)==crt_ID(kk), 2);
                x_to = centroid_temp(centroid_temp(:,1)==crt_ID(jj), 2);
                y_from = centroid_temp(centroid_temp(:,1)==crt_ID(kk), 3);
                y_to = centroid_temp(centroid_temp(:,1)==crt_ID(jj), 3);
                z_from = centroid_temp(centroid_temp(:,1)==crt_ID(kk), 4);
                z_to = centroid_temp(centroid_temp(:,1)==crt_ID(jj), 4);
                line_h{end+1} = line([x_from; x_to], [y_from; y_to], [z_from; z_to],...
                    'linewidth',2, 'color',[.5 .5 .5]);
            end
        end
    end
end
handles.AC = AC;
handles.line_h = line_h;
guidata(main_gui_h, handles);


function ok_button_callback(hObject, callbackdata)
main_gui_h = findall(0 , 'type', 'figure', 'tag', 'figure1');
handles = guidata(main_gui_h);
this_figure_h = findall(0 , 'type', 'figure', 'name', 'Distance in Stairs');
all_uitable = findall(this_figure_h, 'type', 'uitable');
NTAZ = handles.NTAZ;
NENT = handles.NENT;
for k = 1 : length(all_uitable)
    if isequal(size(get(all_uitable(k), 'data')), [NTAZ NTAZ])
        X_stdf_ut = all_uitable(k);
        break
    end
end
for k = 1 : length(all_uitable)
    if isequal(size(get(all_uitable(k), 'data')), [NTAZ NENT])
        X_stdf_ent_ut = all_uitable(k);
        break
    end
end
X_stdf = get(X_stdf_ut, 'data');
X_stdf_ent = get(X_stdf_ent_ut, 'data');
handles.X_stdf = X_stdf;
handles.X_stdf_ent = X_stdf_ent;

%插入advance mode
if handles.adv_mode == 1 & isfield(handles, 'X_adv') & isfield(handles.X_adv, 'stdf')
    handles.X_adv.stdf.taz = X_stdf;
    handles.X_adv.stdf.ent = X_stdf_ent;
end

if isfield(handles, 'BUI')
    handles = rmfield(handles, 'BUI');
end
if isfield(handles, 'AC')
    handles = rmfield(handles, 'AC');
end
if isfield(handles, 'Floor_under_index')
    handles = rmfield(handles, 'Floor_under_index');
end
if isfield(handles, 'Floor_under_z')
    handles = rmfield(handles, 'Floor_under_z');
end
if isfield(handles, 'XYZ_patch_h')
    handles = rmfield(handles, 'XYZ_patch_h');
end
if isfield(handles, 'BU_color')
    handles = rmfield(handles, 'BU_color');
end
if isfield(handles, 'line_h')
    handles = rmfield(handles, 'line_h');
end
if isfield(handles, 'centroid_temp')
    handles = rmfield(handles, 'centroid_temp');
end
set(handles.StdfInput, 'string', 'Finished');
guidata(main_gui_h, handles);
close(gcf)



    


% --------------------------------------------------------------------
function advance_mode_Callback(hObject, eventdata, handles)
% hObject    handle to advance_mode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function adv_def_var_Callback(hObject, eventdata, handles)
% hObject    handle to adv_def_var (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%-------------------%界面%-------------------%
% 关闭除主fig之外的所有fig
all_figs = findall(0, 'type', 'figure');
for af_i = 1 : length(all_figs)
    crt_fig_in_all_figs = all_figs(af_i);
    if ~isequal(get(crt_fig_in_all_figs, 'tag') , 'figure1')
        delete(crt_fig_in_all_figs)
    end
end
var_def = figure('Name' , 'Variable Definition' , 'NumberTitle' , 'off',...
    'Position', [650 300 500 500], 'Color', 'w', 'Unit', 'normalized',...
    'Menubar', 'none');
pre_def_str = 'Please check the following pre-defined variable names';
user_def_str = 'Please input the user-defined varible names';
pre_def_str_ui = uicontrol('parent', var_def, 'style', 'text', ...
    'string', pre_def_str, 'unit','normalized', 'position', [.1 .8 .35 .12],...
    'backgroundcolor', 'w', 'fontsize', 10, 'fontweight', 'bold');
pre_def_var_list = uicontrol('parent', var_def, 'style', 'listbox',...
    'string', {'Area'; 'Attractiveness'; 'Distance'; 'Stair (Difference)'; ...
    'Visited'; 'Cummulated Visited'}, 'max', 6, 'min', 0, ...
    'unit', 'normalized', 'position', [.1 .15 .35 .65]);
if isfield(handles, 'selected_pre_def_var_value')
    selected_pre_def_var_value = handles.selected_pre_def_var_value;
else
    selected_pre_def_var_value = 1:6;
end
set(pre_def_var_list, 'value', selected_pre_def_var_value);
pre_def_var_sel_all = uicontrol('parent', var_def, 'style', 'pushbutton', ...
    'string', 'Select All', 'unit', 'normalized', 'position', [.11 .06 .14 .07],...
    'callback', @def_var_sel_all_callback);
pre_def_var_sel_none = uicontrol('parent', var_def, 'style', 'pushbutton', ...
    'string', 'Select None', 'unit', 'normalized', 'position', [.3 .06 .14 .07], ...
    'callback', @def_var_sel_none_callback);
user_def_str_ui = uicontrol('parent', var_def, 'style', 'text', ...
    'string', user_def_str, 'unit','normalized', 'position', [.55 .8 .35 .12],...
    'backgroundcolor', 'w', 'fontsize', 10, 'fontweight', 'bold');
if isfield(handles, 'user_def_var')
    user_def_var = handles.user_def_var;
    user_def_var_ut_data = [user_def_var; ' '];
else
    user_def_var_ut_data = {' '};
end
user_def_var_ut = uitable('parent', var_def, 'data', user_def_var_ut_data, 'ColumnName', {'Variable Name'},...
    'ColumnEditable', true, 'units', 'normalized', 'position', [.55 .15 .35 .65],...
    'ColumnWidth', {143}, 'CellEditCallback', @user_def_var_ut_callback);
var_def_ok_ = uicontrol('parent', var_def, 'style', 'pushbutton', ...
    'string', 'OK', 'unit', 'normalized', 'position', [.655 .06 .14 .07],...
    'callback', @var_def_ok_callback);

%-------------------%各种callback%-------------------%
function def_var_sel_all_callback(hObject, callbackdata)
crt_gui_h = findall(0, 'type', 'figure', 'name', 'Variable Definition');
pre_def_var_list = findall(crt_gui_h, 'type' , 'uicontrol', 'style', 'listbox');
set(pre_def_var_list, 'value', 1:6)

function def_var_sel_none_callback(hObject, callbackdata)
crt_gui_h = findall(0, 'type', 'figure', 'name', 'Variable Definition');
pre_def_var_list = findall(crt_gui_h, 'type' , 'uicontrol', 'style', 'listbox');
set(pre_def_var_list, 'value', [])


function user_def_var_ut_callback(hTab , event)
if ~isempty(event.Indices)
    data = get(hTab, 'Data');
    iRow = event.Indices(1);
    iCol = event.Indices(2);
    edit_data = data{iRow, iCol};
    edit_data = strtrim(lower(edit_data));
    reserve_name = {'area', 'attractiveness', 'familarity', 'stair(difference)',...
        'stdf', 'distance', 'dist', 'visited', 'past'};
    if  ismember(edit_data, reserve_name)
        errordlg('Can NOT use reserved variable names which are used as pre-defined names', 'Name Error')
        data{iRow, iCol} = '';
    end
    if ~isempty(edit_data) & ~isletter(edit_data(1))
        errordlg('Variable name must start with a letter.', 'Name Error')
        data{iRow, iCol} = '';
    end
    if ~isequal(length(unique(data)),  length(data))
        errordlg('Can NOT use the same variable name', 'Name Error')
        data{iRow, iCol} = '';
    end
    if ~isequal(data{end}, ' ')
        data = [data ; ' '];
        set(hTab, 'Data', data);
    end
    while length(data) >= 2 & length(data{end-1}) == 0
        data = data(1:end-1);
    end
    k = 1;
    while length(data) >= 2 & k < length(data)      %删除中间的空格
        if length(data{k}) == 0
            data(k) = [];
        else
            k = k + 1;
        end
    end
    set(hTab, 'Data', data);
end

function var_def_ok_callback(hObject, callbackdata)
main_gui_h = findall(0 , 'type', 'figure', 'tag', 'figure1');
handles = guidata(main_gui_h);
crt_gui_h = findall(0, 'type', 'figure', 'name', 'Variable Definition');
pre_def_var_list = findall(crt_gui_h, 'type' , 'uicontrol', 'style', 'listbox');
user_def_var_ut = findall(crt_gui_h, 'type', 'uitable');
pre_def_var_all = {'Area'; 'Attractiveness'; 'Distance'; 'Stair(Difference)'; ...
    'Visited'; 'Past'};
selected_pre_def_var_value = get(pre_def_var_list, 'value');
selected_pre_def_var = pre_def_var_all(selected_pre_def_var_value);
user_def_var_raw = get(user_def_var_ut, 'data');
user_def_var = {};
for k = 1 : length(user_def_var_raw)
    if ~isequal(user_def_var_raw{k}, ' ') & length(user_def_var_raw{k}) > 0
        user_def_var{end+1, 1} = strtrim(user_def_var_raw{k});
    end
end
adv_var = [selected_pre_def_var; user_def_var];
if isempty(adv_var)
    errordlg('You must define at least 1 variable.', 'Error')
    return
end
for i = 1 : length(adv_var)
    crt_var_name = lower(adv_var{i});
    if isequal(crt_var_name , 'attractiveness')
        crt_var_name = 'familarity';
    elseif isequal(crt_var_name , 'stair(difference)')
        crt_var_name = 'stdf';
    elseif isequal(crt_var_name , 'distance')
        crt_var_name = 'dist';
    end
    try
        eval(['X_adv.' crt_var_name '=[];']);
    catch
        errordlg(['The No. ', num2str(i-length(selected_pre_def_var)), ' user defined variable name is invalid.'], 'Error')
        return
    end
end
%数据继承
if isfield(handles, 'X_adv')
    old_X_adv = handles.X_adv;          %可能已经有老数据
    old_fields = fields(old_X_adv);
    new_fields = fields(X_adv);
    for i = 1 : length(new_fields)
        crt_field = new_fields{i};
        if ismember(crt_field ,  old_fields) & eval(['~isempty(old_X_adv.' crt_field ');'])
            eval(['X_adv.' crt_field '= old_X_adv.' crt_field ';']);
        end
    end
end
handles.user_def_var = user_def_var;
handles.selected_pre_def_var_value = selected_pre_def_var_value;
handles.adv_var = adv_var;
handles.X_adv = X_adv;

num_used = sum(ismember([1 2 3 4], selected_pre_def_var_value));
set(handles.AreaInput, 'string', 'N/A', 'Enable', 'off')
set(handles.FamInput, 'string', 'N/A', 'Enable', 'off')
set(handles.DistInput, 'string', 'N/A', 'Enable', 'off')
set(handles.StdfInput, 'string', 'N/A', 'Enable', 'off')
if num_used == 0
    set(handles.xs_panel, 'title', 'Explanatory Variables: None Variable is used in Advance Mode')
else
    set(handles.xs_panel, 'title', 'Explanatory Variables: Some Variables are used in Advance Mode')
    if ismember(1, selected_pre_def_var_value)
        set(handles.AreaInput, 'string', 'Waiting for Input', 'Enable', 'on')
        if ~isempty(X_adv.area) & ~isnan(X_adv.area(1))
            set(handles.AreaInput, 'string', 'Finished')
        end
    end
    if ismember(2, selected_pre_def_var_value)
        set(handles.FamInput, 'string', 'Waiting for Input', 'Enable', 'on')
        if ~isempty(X_adv.familarity) & ~isnan(X_adv.familarity(1))
            if size(X_adv.familarity, 2) > 1
                set(handles.FamInput, 'string', 'Finished: individual-level')
            else
                set(handles.FamInput, 'string', 'Finished: aggregate')
            end
        end
    end
    if ismember(3, selected_pre_def_var_value)
        set(handles.DistInput, 'string', 'Waiting for Input', 'Enable', 'on')
        if isfield(X_adv.dist, 'taz')  & isfield(X_adv.dist, 'ent')
            set(handles.DistInput, 'string', 'Finished')
        elseif isfield(X_adv.dist, 'taz')  & ~isfield(X_adv.dist, 'ent')
            set(handles.DistInput, 'string', 'Need TAZ-Entrance Matrix')
        elseif ~isfield(X_adv.dist, 'taz')  & isfield(X_adv.dist, 'ent')
            set(handles.DistInput, 'string', 'Need TAZ-TAZ Matrix')
        end
    end
    if ismember(4, selected_pre_def_var_value)
        set(handles.StdfInput, 'string', 'Waiting for Input', 'Enable', 'on')
        if isfield(X_adv.stdf, 'taz')  & isfield(X_adv.stdf, 'ent')
            set(handles.StdfInput, 'string', 'Finished')
        elseif isfield(X_adv.stdf, 'taz')  & ~isfield(X_adv.stdf, 'ent')
            set(handles.StdfInput, 'string', 'Need TAZ-Entrance Matrix')
        elseif ~isfield(X_adv.stdf, 'taz')  & isfield(X_adv.stdf, 'ent')
            set(handles.StdfInput, 'string', 'Need TAZ-TAZ Matrix')
        end
    end
end

guidata(main_gui_h, handles);
close(gcf)


% --------------------------------------------------------------------
function use_advance_Callback(hObject, eventdata, handles)
% hObject    handle to use_advance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla reset
set(gcf,'color','w')
axis equal
axis off
main_fig = findall(0 , 'type', 'figure', 'tag', 'figure1');
% if isempty(main_fig)
%     main_fig = findall(0, 'type', 'figure', 'name', 'Commercial Complex SIMlator (Advance Mode)');
% end
if isfield(handles, 'fname')
    file_name = handles.fname;
else
    file_name = 'Unnamed';
end
if strcmp(get(hObject,'Checked'),'on')
    set(hObject,'Checked','off');
    set(main_fig, 'name', ['鼓浪屿游客行为模拟器'])
else 
    set(hObject,'Checked','on');
    set(main_fig, 'name', ['鼓浪屿游客行为模拟器 '])
end
if strcmp(get(hObject , 'Checked'), 'on')               %如果当前选中，进入高级模式
    handles.adv_mode = 1;
    msgbox('Switch to advance mode, which allows user defined variables.', 'Mode')
    set(handles.beta_panel, 'title', 'Behaivoral Coefficients: NOT Available in Advance Mode')
    if ~isfield(handles, 'X_adv')
        set(handles.xs_panel, 'title', 'Explanatory Variables: Waiting for Variable Defination in Advance Mode')
        set(handles.AreaInput, 'string', 'Advance Mode', 'Enable', 'off')
        set(handles.FamInput, 'string', 'Advance Mode', 'Enable', 'off')
        set(handles.DistInput, 'string', 'Advance Mode', 'Enable', 'off')
        set(handles.StdfInput, 'string', 'Advance Mode', 'Enable', 'off')
    else
        X_adv = handles.X_adv;
        selected_pre_def_var_value = handles.selected_pre_def_var_value;
        num_used = sum(ismember([1 2 3 4], selected_pre_def_var_value));
        set(handles.AreaInput, 'string', 'N/A', 'Enable', 'off')
        set(handles.FamInput, 'string', 'N/A', 'Enable', 'off')
        set(handles.DistInput, 'string', 'N/A', 'Enable', 'off')
        set(handles.StdfInput, 'string', 'N/A', 'Enable', 'off')
        if num_used == 0
            set(handles.xs_panel, 'title', 'Explanatory Variables: None Variable is used in Advance Mode')
        else
            set(handles.xs_panel, 'title', 'Explanatory Variables: Some Variables are used in Advance Mode')
            if ismember(1, selected_pre_def_var_value)
                set(handles.AreaInput, 'string', 'Waiting for Input', 'Enable', 'on')
                if ~isempty(X_adv.area) & ~isnan(X_adv.area(1))
                    set(handles.AreaInput, 'string', 'Finished')
                end
            end
            if ismember(2, selected_pre_def_var_value)
                set(handles.FamInput, 'string', 'Waiting for Input', 'Enable', 'on')
                if ~isempty(X_adv.familarity) & ~isnan(X_adv.familarity(1))
                    if size(X_adv.familarity, 2) > 1
                        set(handles.FamInput, 'string', 'Finished: individual-level')
                    else
                        set(handles.FamInput, 'string', 'Finished: aggregate')
                    end
                end
            end
            if ismember(3, selected_pre_def_var_value)
                set(handles.DistInput, 'string', 'Waiting for Input', 'Enable', 'on')
                if isfield(X_adv.dist, 'taz')  & isfield(X_adv.dist, 'ent')
                    set(handles.DistInput, 'string', 'Finished')
                elseif isfield(X_adv.dist, 'taz')  & ~isfield(X_adv.dist, 'ent')
                    set(handles.DistInput, 'string', 'Need TAZ-Entrance Matrix')
                elseif ~isfield(X_adv.dist, 'taz')  & isfield(X_adv.dist, 'ent')
                    set(handles.DistInput, 'string', 'Need TAZ-TAZ Matrix')
                end
            end
            if ismember(4, selected_pre_def_var_value)
                set(handles.StdfInput, 'string', 'Waiting for Input', 'Enable', 'on')
                if isfield(X_adv.stdf, 'taz')  & isfield(X_adv.stdf, 'ent')
                    set(handles.StdfInput, 'string', 'Finished')
                elseif isfield(X_adv.stdf, 'taz')  & ~isfield(X_adv.stdf, 'ent')
                    set(handles.StdfInput, 'string', 'Need TAZ-Entrance Matrix')
                elseif ~isfield(X_adv.stdf, 'taz')  & isfield(X_adv.stdf, 'ent')
                    set(handles.StdfInput, 'string', 'Need TAZ-TAZ Matrix')
                end
            end
        end
    end
    set(handles.adv_def_var, 'enable', 'on');
    set(handles.queue_on_check, 'enable', 'on');
    set(handles.def_time_var, 'enable', 'on');
    set(handles.def_dyn_var, 'enable', 'on');
    set(handles.input_user_def_vars, 'enable', 'on');
    set(handles.e_a, 'string', 'N/A', 'style', 'text')
    set(handles.e_b, 'string', 'N/A', 'style', 'text')
    set(handles.e_c, 'string', 'N/A', 'style', 'text')
    set(handles.edit_b_stdf, 'string', 'N/A', 'style', 'text')
    set(handles.edit_b_visited, 'string', 'N/A', 'style', 'text')
    set(handles.edit_b_past, 'string', 'N/A', 'style', 'text')
    set(handles.use_predefine_with_fam, 'Enable', 'off');
    set(handles.use_predefine_without_fam, 'Enable', 'off');
    set(handles.use_user_define_coef, 'Enable', 'off');
    set(handles.excel_confi_file, 'Enable', 'off');
    set(handles.save_confi, 'Enable', 'off');
    set(handles.open_confi, 'Enable', 'off');
else
    handles.adv_mode = 0;
    temp1 = msgbox('Switch to general mode, which only use pre-defined variables.', 'Mode');
    set(handles.adv_def_var, 'enable', 'off')
    set(handles.queue_on_check, 'enable', 'off');
    set(handles.input_user_def_vars, 'enable', 'off');
    set(handles.def_time_var, 'enable', 'off');
    set(handles.def_dyn_var, 'enable', 'off');
    rm_list = {'X_area', 'X_dist', 'X_dist_ent', 'X_stdf', 'X_stdf_ent',...
        'X_familarity',  'b_area', 'b_familarity', 'b_dist',...
        'b_stdf', 'b_visited', 'b_past'};
    exist_var(1) = isfield(handles, 'X_area');
    exist_var(2) = isfield(handles, 'X_dist'); exist_var(3) = isfield(handles, 'X_dist_ent'); exist_var(4) = isfield(handles, 'X_stdf');
    exist_var(5) = isfield(handles, 'X_stdf_ent'); exist_var(6) = isfield(handles, 'X_familarity');  exist_var(7) = isfield(handles, 'b_area');
    exist_var(8) = isfield(handles, 'b_familarity'); exist_var(9) = isfield(handles, 'b_dist'); exist_var(10) = isfield(handles, 'b_stdf');
    exist_var(11) = isfield(handles, 'b_visited'); exist_var(12) = isfield(handles, 'b_past');
    handles = rmfield(handles, rm_list(exist_var));
    set(handles.beta_panel, 'title', 'Behaivoral Coefficients')
    set(handles.xs_panel, 'title', 'Explanatory Variables')
    set(handles.AreaInput, 'string', 'Waiting for Input', 'Enable', 'on')
    set(handles.FamInput, 'string', 'Waiting for Input', 'Enable', 'on')
    set(handles.DistInput, 'string', 'Waiting for Input', 'Enable', 'on')
    set(handles.StdfInput, 'string', 'Waiting for Input', 'Enable', 'on')
    set(handles.e_a, 'string', '0.0001', 'style', 'Edit')
    set(handles.e_b, 'string', '1.4', 'style', 'Edit')
    set(handles.e_c, 'string', '-0.01', 'style', 'Edit')
    set(handles.edit_b_stdf, 'string', '-0.4', 'style', 'Edit')
    set(handles.edit_b_visited, 'string', '-1.5', 'style', 'Edit')
    set(handles.edit_b_past, 'string', '0.6', 'style', 'Edit')
    set(handles.use_predefine_with_fam, 'Enable', 'on');
    set(handles.use_predefine_without_fam, 'Enable', 'on');
    set(handles.use_user_define_coef, 'Enable', 'on');
    set(handles.excel_confi_file, 'Enable', 'on');
    set(handles.save_confi, 'Enable', 'on');
    set(handles.open_confi, 'Enable', 'on');
end
guidata(hObject , handles)


% --------------------------------------------------------------------
function AreaInput_menu_Callback(hObject, eventdata, handles)
% hObject    handle to AreaInput_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
AreaInput_Callback(hObject, eventdata, handles)


% --------------------------------------------------------------------
function Untitled_29_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_29 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
input= inputdlgWC('input your field');
if isempty(input)| isempty(input{:}) 
    return
end
input = cell2mat(input);
anwer = isfield(handles, input);
a=msgbox(num2str(anwer));
if anwer == 1
waitfor(a)
disp(eval(['handles.' input]))
eval(['a = handles.' input, ';'])
dbstop in ccsim at 11984
end


% --------------------------------------------------------------------
function FamInput_menu_Callback(hObject, eventdata, handles)
% hObject    handle to FamInput_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
FamInput_Callback(hObject, eventdata, handles)


% --------------------------------------------------------------------
function DistInput_menu_Callback(hObject, eventdata, handles)
% hObject    handle to DistInput_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
DistInput_Callback(hObject, eventdata, handles)


% --------------------------------------------------------------------
function StdfInput_menu_Callback(hObject, eventdata, handles)
% hObject    handle to StdfInput_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
StdfInput_Callback(hObject, eventdata, handles)


% --------------------------------------------------------------------
function input_user_def_vars_Callback(hObject, eventdata, handles)
% hObject    handle to input_user_def_vars (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 关闭除主fig之外的所有fig
if ~isfield(handles, 'NTAZ')
    errordlg('There is NO Num. of TAZ data', 'Error')
    return
else
    NTAZ = handles.NTAZ;
end
if ~isfield(handles, 'user_def_var') 
    errordlg('There are NO user definded variables', 'Error')
    return
else
    user_def_var = handles.user_def_var;
    X_adv = handles.X_adv;
end
all_figs = findall(0, 'type', 'figure');
for af_i = 1 : length(all_figs)
    crt_fig_in_all_figs = all_figs(af_i);
    if ~isequal(get(crt_fig_in_all_figs, 'tag') , 'figure1')
        delete(crt_fig_in_all_figs)
    end
end
[fname , pname]=uigetfile('*.csv' , 'Open the User Defined Varaible Data');
if isequal(fname, 0) | isequal(pname, 0)
    return
end
fullname = strcat(pname, fname);
try 
    ud_input_csv_rawdata = csvread(fullname, 1, 0);     %第一行必须是表头，即为字符串
    [NTAZ_data, NVAR_data] = size(ud_input_csv_rawdata);
    if NTAZ_data ~= NTAZ
        errordlg('The Num. of rows in the data does NOT equals with Num. of TAZ', 'Error')
        return
    end
    fid = fopen(fullname);
    ud_input_csv_scan_raw = textscan(fid, '%s', 'delimiter', ',');
    ud_input_csv_scan_raw = ud_input_csv_scan_raw{:};
    fclose(fid);
    if length(ud_input_csv_scan_raw) ~= (NTAZ_data+1) * NVAR_data
        errordlg('It seemes that there are some missing variable names or data values in your csv file', 'Error')
        return
    end
    ud_input_csv_var_name = ud_input_csv_scan_raw(1: NVAR_data);
    if ~isequal(unique(ud_input_csv_rawdata(:,1)), [1:NTAZ]') | ~isequal(lower(ud_input_csv_var_name{1}), 'id')
        errordlg('The csv file must have ID variable in its first column', 'Error')
        return
    end
    if ~isequal(length(unique(ud_input_csv_var_name)), length(ud_input_csv_var_name))
        errordlg('The csv file must have unique variable names in its first row', 'Error')
        return
    end
catch
   errordlg('Failed to open the csv file', 'Open Error');
   return
end
ud_input_fig = figure('Name' , 'User Defined Variables' ,  'Unit', 'normalized', ...
    'NumberTitle' , 'off', 'Position', [.25 .1 .5 .8], 'Color', 'w', 'Menubar', 'none');
fields = ud_input_csv_var_name;
fields{1} = 'No Change';
data = ud_input_csv_rawdata;
data = sortrows(data, 1);       %按第1列ID排序
%再次检查ID的可靠性
if ~isequal(data(:,1) , [1:NTAZ]')
    errordlg('The csv file must have ID variable in its first column', 'Error')
    return
end
handles.ud_input_data = data;
handles.ud_input_fields = fields;
guidata(hObject, handles);
 
% 选择变量表格
choose_var_ut_column_name = {'Name', 'Source'};
choose_var_ut_column_format = {'char', fields'};
choose_var_ut_data = [user_def_var];
for i = 1 : size(choose_var_ut_data, 1)
    choose_var_ut_data{i, 2} = 'No Change';
end
choose_rst = ones(size(choose_var_ut_data, 1), 1);      %用于下一步显示数据
% 自动设定值
for kkk = 1 : size(choose_var_ut_data ,1)
    crt_set_var = choose_var_ut_data{kkk, 1};
    find_crt_user_def = strcmpi(fields , crt_set_var);
    if sum(find_crt_user_def) == 1
        choose_var_ut_data{kkk, 2} = fields{find_crt_user_def == 1};
        choose_rst(kkk) = find(find_crt_user_def == 1);
    end
end
choose_var_ut = uitable('parent', ud_input_fig, 'data', choose_var_ut_data,...
    'ColumnName', choose_var_ut_column_name, 'ColumnFormat', ...
    choose_var_ut_column_format, 'ColumnEditable', [false, true],...
    'unit', 'normalized', 'position', [.05 .2 .25 .7], ...
    'CellEditCallback', @ud_input_choose_var_ut_edit_callback);
choose_var_ut_str = uicontrol('parent', ud_input_fig, 'style', 'text',...
    'string', 'Variable Table', 'unit', 'normalized', 'position', ...
    [.05 .905 .25 .03], 'fontsize', 12, 'fontweight', 'bold',...
    'backgroundcolor', 'w');
set(choose_var_ut, 'columnwidth', {100, 100})

% 变量显示表格
show_var_ut_column_name = ['ID'; choose_var_ut_data(: , 1)];
show_var_ut_column_name = show_var_ut_column_name';
show_var_ut_data = nan(NTAZ , length(show_var_ut_column_name));
%第1列作为ID列，强制为1-NTAZ，前面已对此做过检查，不合要求的不能导入，同时，此时的数据都是已经按ID排好序的了
show_var_ut_data(:,1) = [1:NTAZ]';                                  
show_var_ut_column_format{1} = 'numeric';
choose_rst_str = get(choose_var_ut, 'data');            %selected fields name list one by one
choose_rst_str = choose_rst_str(:, end);

for ij = 1 : length(choose_rst_str)
    crt_select_field = choose_rst_str{ij};
    show_var_ut_column_format{ij+1} = 'bank';       %注意，变量表的列数比数据表的行数少1，因为变量表里不再放ID了， bank是初始化格式
    if ~isequal(crt_select_field, 'No Change')
        try
            [temp, crt_index] = ismember(crt_select_field, fields);
            show_var_ut_data(:,ij+1) = data(:, crt_index);
            if isequal(round(show_var_ut_data(:,ij+1)), show_var_ut_data(:,ij+1))
                show_var_ut_column_format{ij+1} = 'numeric';
            end
        catch
            errordlg(['The field [',crt_select_field , '] is not suitable for ', show_var_ut_column_name(ij+1)], 'Error')
            return
        end
    else
        if ~isfield(X_adv, lower(show_var_ut_column_name{ij+1}))
            errordlg('Error 1005: something strange, check the program', 'Error')
            return
        else
            eval(['old_value = X_adv.' lower(show_var_ut_column_name{ij+1}) ';']);
            if isempty(old_value)
                show_var_ut_data(:,ij+1) = nan(NTAZ,  1);
            elseif ~isempty(old_value) & isequal(size(old_value), [NTAZ,  1])
                show_var_ut_data(:,ij+1) = old_value;
                if isequal(old_value, round(old_value))
                    show_var_ut_column_format{ij+1} = 'numeric';
                end
            else
                errordlg('Error 1006: something strange, check the program', 'Error')
                return
            end
        end
    end
end
show_var_ut = uitable('parent', ud_input_fig, 'data', show_var_ut_data,...
    'ColumnName', show_var_ut_column_name, 'ColumnFormat', ...
    show_var_ut_column_format, 'ColumnEditable', false,...
    'unit', 'normalized', 'position', [.35 .08 .6 .82], 'UserData','show_var_ut');
set(show_var_ut, 'columnwidth', 'auto')
show_var_ut_str = uicontrol('parent', ud_input_fig, 'style', 'text',...
    'string', 'Data Table', 'unit', 'normalized', 'position', ...
    [.35 .905 .6 .03], 'fontsize', 12, 'fontweight', 'bold',...
    'backgroundcolor', 'w');

% OK
ud_input_ok_pushbutton = uicontrol('parent', ud_input_fig, 'style', 'pushbutton',...
    'string', 'OK', 'unit', 'normalized', 'position', [.1 .085 .14 .09],...
    'callback', @ud_input_ok_pushbutton_callback, 'fontsize', 12);

% 回调函数
function ud_input_choose_var_ut_edit_callback(hTab, event)
if ~isempty(event.Indices)
    main_gui_h = findall(0 , 'type', 'figure', 'tag', 'figure1');
    handles = guidata(main_gui_h);
    fields = handles.ud_input_fields;
    data = handles.ud_input_data;
    show_var_ut = findall(get(hTab, 'Parent') , 'type', 'uitable', 'UserData', 'show_var_ut');
    show_var_ut_data = get(show_var_ut, 'data');
    show_var_ut_column_format = get(show_var_ut, 'columnformat');
    show_var_ut_column_name = get(show_var_ut, 'columnname');
    NTAZ = handles.NTAZ;
    X_adv = handles.X_adv;
    choose_rst_alldata = get(hTab, 'data');
    iLine = event.Indices(1);
    iColumn = event.Indices(2);
    crt_select_field = choose_rst_alldata{iLine, iColumn};
    if ~isequal(crt_select_field, 'No Change')
        try
            [temp, crt_index] = ismember(crt_select_field, fields);
            show_var_ut_data(:,iLine+1) = data(:, crt_index);
            if isequal(round(show_var_ut_data(:,iLine+1)), show_var_ut_data(:,iLine+1))
                show_var_ut_column_format{iLine+1} = 'numeric';
            else
                show_var_ut_column_format{iLine+1} = 'bank';
            end
        catch
            errordlg(['The field [',crt_select_field , '] is not suitable for ', show_var_ut_column_name(iLine+1)], 'Error')
            return
        end
    else
        if ~isfield(X_adv, lower(show_var_ut_column_name{iLine+1}))
            errordlg('Error 1007: something strange, check the program', 'Error')
            return
        else
            eval(['old_value = X_adv.' lower(show_var_ut_column_name{iLine+1}) ';']);
            if isempty(old_value)
                show_var_ut_data(:,iLine+1) = nan(NTAZ,  1);
            elseif ~isempty(old_value) & isequal(size(old_value), [NTAZ,  1])
                show_var_ut_data(:,iLine+1) = old_value;
                if isequal(round(old_value), old_value)
                    show_var_ut_column_format{iLine+1} = 'numeric';
                else
                    show_var_ut_column_format{iLine+1} = 'bank';
                end
            else
                errordlg('Error 1008: something strange, check the program', 'Error')
                return
            end
        end
    end

    set(show_var_ut, 'data', show_var_ut_data)
    set(show_var_ut, 'columnformat', show_var_ut_column_format);
end

function ud_input_ok_pushbutton_callback(hObject, eventdata)
main_gui_h = findall(0 , 'type', 'figure', 'tag', 'figure1');
handles = guidata(main_gui_h);
fields = handles.ud_input_fields;
X_adv = handles.X_adv;
NTAZ = handles.NTAZ;
ut = findall(get(hObject, 'Parent') , 'type', 'uitable', 'UserData', 'show_var_ut');
ud_var = get(ut, 'columnname');
data = get(ut, 'data');
for var_i = 2 : size(data, 2)
    if sum(isnan(data(:, var_i))) == 0
        crt_var_name = ud_var{var_i};          %不-1是因为ud_var直接读的是表头，包括了ID
        crt_var_name = lower(crt_var_name);
        if isfield(X_adv, crt_var_name)
            eval(['X_adv.' crt_var_name '= data(:, var_i);']);
        end
    end
end 
handles.X_adv = X_adv;
if isfield(handles, 'ud_input_data')
    handles = rmfield(handles, 'ud_input_data');
end
if isfield(handles, 'ud_input_fields')
    handles = rmfield(handles, 'ud_input_fields');
end
guidata(main_gui_h, handles);
close(gcf)


% --------------------------------------------------------------------
function see_situation_Callback(hObject, eventdata, handles)
% hObject    handle to see_situation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function see_status_Callback(hObject, eventdata, handles)
% hObject    handle to see_status (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --------------------------------------------------------------------
function right_click_Callback(hObject, eventdata, handles)
% hObject    handle to right_click (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function see_status_main_Callback(hObject, eventdata, handles)
% hObject    handle to see_status_main (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
adv_mode = handles.adv_mode;
crt_fig = findall(0, 'name', 'Current Status');
if ~isempty(crt_fig)
    delete(crt_fig)
end
if adv_mode == 1
    % 各类基础数据
    if ~isfield(handles, 'adv_var')
        bd_str = '- You shoulds specify the variables in advance mode';
    elseif ~isfield(handles, 'XYZ')
        bd_str = '- You should load the TAZ information';
    elseif ~isfield(handles, 'NTAZ')
        bd_str = '- You should input the Num of TAZs';
    elseif ~isfield(handles, 'NENT')
        bd_str = '- You should input the number of entrances';
    elseif ~isfield(handles, 'NPED')
        bd_str = '- You should input the number of individuals';
    else
        bd_str = [];
    end
    
    if isempty(bd_str) & isfield(handles, 'X_adv')
        X_adv = handles.X_adv;
        all_var = fieldnames(X_adv);
        %对变量进行分类：一列的属性，二维的矩阵，特殊的有可能会不一样的变量，以及动态变量
        var_col = cell(0);
        var_mat = cell(0);
        var_dyn = cell(0);
        for ii = 1 : length(all_var)
            if isequal(all_var{ii}, 'dist') | isequal(all_var{ii}, 'stdf')
                var_mat{end+1} = all_var{ii};
            elseif isequal(all_var{ii}, 'past') | isequal(all_var{ii}, 'visited')
                var_dyn{end+1} = all_var{ii};
            else
                var_col{end+1} = all_var{ii};
            end
        end
    end
    
    if isempty(bd_str) & exist('var_col', 'var') & length(var_col) >= 1
        for ii = 1 : length(var_col)                %不允许有空value，除了动态变量
            if isempty(getfield(X_adv, var_col{ii}))
                crt_col_name = var_col{ii};
                if isequal(crt_col_name, 'familarity')      %换换名字
                    crt_col_name = 'Attractiveness';
                elseif isequal(crt_col_name, 'area')
                    crt_col_name = 'Area';
                elseif isequal(crt_col_name, 'past')
                    crt_col_name = 'Past';
                elseif isequal(crt_col_name, 'visited')
                    crt_col_name = 'Visited';
                end
                bd_str = ['- You should input the value of the variable ''', crt_col_name, ''''];
                break
            end
        end
    end
    
    if isempty(bd_str) & exist('var_mat', 'var') & length(var_mat) >= 1
        for ii = 1 : length(var_mat)                %对于矩阵变量，要检查是否两个矩阵都有了
            crt_var_mat = var_mat{ii};
            if ~isfield(getfield(X_adv, crt_var_mat), 'taz') | isempty(getfield(getfield(X_adv, crt_var_mat), 'taz')) | ...
                    ~isfield(getfield(X_adv, crt_var_mat), 'ent') | isempty(getfield(getfield(X_adv, crt_var_mat), 'ent'))
                if isequal(crt_var_mat, 'dist')         %改一下名字
                    crt_var_mat = 'Distance';
                elseif isequal(crt_var_mat, 'stdf')
                    crt_var_mat = 'Stair';
                end
                bd_str = ['- You should completely input the value of the matrix variable ''', crt_var_mat, ''''];
                if strcmp(crt_var_mat, 'Stair')
                    bd_str = [bd_str, ', you can calculate it automatically.'];
                end
                break
            end
        end
    end
    
    if isempty(bd_str)
        bd_str = '- You have input all neccessary base data.';
    end
    
    % 模型相关
    if ~isfield(handles, 'beta_adv') 
        md_str1 = '- There is no model.';
    else
        md_str1 = '- There exist a model.';
    end
    
    if ~isfield(handles, 'path_rawdata')
        md_str2  = '- If you want to estimate a new model, you need to input path data.';
    elseif ~isequal(bd_str ,'- You have input all neccessary base data.')
        md_str2 = '- If you want to estimate a new model, you should specify neccessary base data';
    else
        md_str2 = '- You can estimate a new model.';
    end
    
    if ~isfield(handles, 'time_var')
        md_str3 = '- If you want to estimate time-specific coefficients, you need to define time variables.';
    elseif ~isfield(handles, 'space_time_path_rawdata')
        md_str3 = '- If you want to estimate time-specific coefficients, you need to input spatiotemproal path data.';
    else
        md_str3 = '- If you estimate a new model, there would be time-specific coefficients included.';
    end
    
    if ~isfield(handles, 'dyn_var')
        md_str4 = '- You do not include any dynamic variable in your model.';
    else
        md_str4 = '- You have specify dynamic variables, they will work if you check and use them.';
    end
    md_str = strvcat(md_str1, md_str2, md_str3, md_str4);
    
    % 模拟相关
    if ~isfield(handles, 'beta_adv')
        sm_str1 = '- You must have a model to simulate.';
    elseif  ~isfield(handles, 'NPED')
        sm_str1 = '- You must input Num. of individuals to simulate.';
    elseif ~isfield(handles, 'X_ent_distrib')
        sm_str1 = '- You must input individuals'' spatial distribution among entrances.';
    elseif ~isequal(bd_str ,'- You have input all neccessary base data.')
        sm_str1 = '- You must input neccessary base data.';
    else
        sm_str1 = '- You can do spatial behavior simulation.';
    end
    
    if ~strcmp(sm_str1, '- You can do spatial behavior simulation.')
        sm_str2 = '';
    elseif ~isfield(handles, 'X_ind_ent_time') & ~isfield(handles, 'ent_time_distr')
        sm_str2 = '- If you want to do spatiotemporal behavior simulation, you must input entry time distribution or exact entry time data for every individual.';
    elseif isfield(handles, 'X_ind_ent_time') & ~isfield(handles, 'ent_time_distr') & length(handles.X_ind_ent_time) ~= handles.NPED
        sm_str2 = '- If you want to do spatiotemporal behavior simulation, you must input entry time distribution, for your individual entry time data is incomplete.';
    elseif ~isfield(handles, 'stay_time_distr')
        sm_str2 = '- If you want to do spatiotemporal behavior simulation, you must input TAZ stay time distribution.';
    elseif ~isfield(handles, 'traffic_time')
        sm_str2 = '- If you want to do spatiotemporal behavior simulation, you must input traffic time distribution.';
    elseif ~isfield(handles, 'EntTime_distrib_type') | ~isfield(handles, 'EntTime_distrib')
        sm_str2 = '- You can do spatiotemporal behavior simulation, but since you did not specify type of entry time distribution, it would be automatically decided';
    else
        sm_str2 = '- You can do spatiotemporal behavior simulation.';
    end
    
    if ~isfield(handles, 'capacity')
        sm_str31 = '- If you want to consider queue effect, you must input capacity data.';
    elseif handles.queue_on == 0
        sm_str31 = '- If you want to consider queue effect, you must check queue on.';
    elseif ~isfield(handles, 'dyn_var')
        sm_str31 = '- You can simulate queue effect, but individual would not consider queue when making choice unless you define it as dynamic variable.';
    else
        sm_str31 = '- You can simulated queue effect, and individual would consider queue when making choice, if you check and use it as dynamic variable.';
    end
    
    if ~isfield(handles, 'dyn_var')
        sm_str32 = '- If you want to make individuals taking density into consideration when making choice, you must define it as dynamic variable.';
    elseif ~isfield(handles, 'base_area')
        sm_str32 = '- If you wnat to make individuals taking density into consideration when making choice, you must input base area data.';
    else
        sm_str32 = '- You can simulate density effect, if you check and use it as dynamic variable.';
    end
    
    if ~isfield(handles, 'Sim_result')
        sm_str4 = '- If you want to do consuming simulation, you must firstly finish a spatial/spatiotemporal simulation.';
    elseif ~isfield(handles, 'consume_prob')
        sm_str4 = '- If you want to do consuming simulation, you must input TAZ consuming probability data.';
    elseif ~isfield(handles, 'expenditure_distr')
        sm_str4 = '- If you want to do consuming simulation, you must input TAZ expenditure distribution data.';
    else
        sm_str4 = '- You can do consuming simulation.';
    end
    sm_str = strvcat(sm_str1, sm_str2, sm_str31, sm_str32, sm_str4);
    
    if isfield(handles, 'Sim_mean_taz_distrib') & isfield(handles, 'timely_taz_stat_result') & isfield(handles, 'base_area')
        rs_str1 = '- You have got total & dynamic individual distribution result, you can visualize (plot/video) and export it.';
        rs_str2 = '- You have got total & dynamic density result, you can visualize (plot/video) and export it.';
    elseif isfield(handles, 'Sim_mean_taz_distrib') & isfield(handles, 'timely_taz_stat_result') & ~isfield(handles, 'base_area')
        rs_str1 = '- You have got total & dynamic individual distribution result, you can visualize (plot/video) and export it.';
        rs_str2 = '';
    elseif isfield(handles, 'Sim_mean_taz_distrib') & ~isfield(handles, 'timely_taz_stat_result') & isfield(handles, 'base_area')
        rs_str1 = '- You have got total (static) individual distribution result, you can visualize (plot) and export it.';
        rs_str2 = '- You have got total (static) density result, you can visualize (plot) and export it.';
    elseif isfield(handles, 'Sim_mean_taz_distrib') & ~isfield(handles, 'timely_taz_stat_result') & ~isfield(handles, 'base_area')
        rs_str1 = '- You have got total (static) individual distribution result, you can visualize (plot) and export it.';
        rs_str2 = '';
    elseif ~isfield(handles, 'Sim_mean_taz_distrib') & ~isfield(handles, 'timely_taz_stat_result') 
        rs_str1 = '';
        rs_str2 = '';
    end
    if isfield(handles, 'timely_taz_queue_population_result')
        rs_str3 = '- You have got dynamic queue volumn result, you can visualize (plot/video) and export it.';
    else
        rs_str3 = '';
    end
    if isfield(handles, 'timely_taz_queue_time_result')
        rs_str4 = '- You have got dynamic queue time result, you can visualize (plot/video) and export it.';
    else 
        rs_str4 = '';
    end
    if isfield(handles, 'Sim_mean_OD')
        rs_str5 = 'You have got total (static) OD distribution result, you can visualize (plot) and export it.';
    else
        rs_str5 = '';
    end
    if isfield(handles, 'Sim_result_money')
        rs_str6 = 'You have got total (static) consuming result, you can visualize (plot) and export it.';
    else
        rs_str6 = '';
    end
    
    if isfield(handles, 'Comp_TAZ_distrib') & isfield(handles, 'base_area') & isfield(handles, 'comp_timely_taz_stat_result')
        comp_available = {'total & dynamic individual distribution' , 'total & dynamic density'};
    elseif isfield(handles, 'Comp_TAZ_distrib') & ~isfield(handles, 'base_area') & isfield(handles, 'comp_timely_taz_stat_result')
        comp_available = {'total & dynamic individual distribution' };
    elseif isfield(handles, 'Comp_TAZ_distrib') & isfield(handles, 'base_area') & ~isfield(handles, 'comp_timely_taz_stat_result')
        comp_available = {'total (static) individual distribution' , 'total (static) density'};
    elseif isfield(handles, 'Comp_TAZ_distrib') & ~isfield(handles, 'base_area') & ~isfield(handles, 'comp_timely_taz_stat_result')
        comp_available = {'total (static) individual distribution' };
    elseif ~isfield(handles, 'Comp_TAZ_distrib') & ~isfield(handles, 'comp_timely_taz_stat_result')
        comp_available = cell(0);
    end
    if isfield(handles,  'comp_timely_taz_queue_population_result')
        comp_available{end+1} = 'dynamic queue volumn';
    end
    if isfield(handles, 'comp_timely_taz_queue_time_result')
        comp_available{end+1} = 'dynamic queue time';
    end
    if isfield(handles, 'Comp_OD')
        comp_available{end+1} = 'total (static) OD distribution';
    end
    if isfield(handles, 'comp_expenditure_distr')
        comp_avaialbe{end+1} = 'total (static) consuming';
    end
    
    rs_str7 = '- Current available comparison result: ';
    if ~isempty(comp_available) & length(comp_available) > 1
        for kkk = 1 : length(comp_available)-1
            rs_str7 = [rs_str7, '''', comp_available{kkk}, ''', '];
        end
        rs_str7 = [rs_str7, '''', comp_available{end}, '''.'];
    elseif length(comp_available) == 1
        rs_str7 = [rs_str7, '''', comp_available{end}, '''.'];
    else
        rs_str7 = [rs_str7, 'None'];
    end
    rs_str123456 = strvcat(rs_str1, rs_str2, rs_str3, rs_str4, rs_str5, rs_str6);
    if isempty(rs_str123456)
        rs_str123456 = '- There is no available simulation result.';
    end
    rs_str = strvcat(rs_str123456, rs_str7);
    
    
%     all_str = {bd_str; ' ';  md_str; ' ' ; sm_str};
%     msgbox(all_str, 'Current Status (Advance Mode)')
end

if adv_mode == 0
    % 各类基础数据
    if ~isfield(handles, 'XYZ')
        bd_str = '- You should load the TAZ information';
    elseif ~isfield(handles, 'NTAZ')
        bd_str = '- You should input the Num of TAZs';
    elseif ~isfield(handles, 'NENT')
        bd_str = '- You should input the number of entrances';
    elseif ~isfield(handles, 'NPED')
        bd_str = '- You should input the number of individuals to simulate.';
    elseif ~isfield(handles, 'X_area')
        bd_str = '- You should input the value of the variable: area';
    elseif ~isfield(handles, 'X_dist')
        bd_str = '- You should input the value of the variable: distance (TAZ-TAZ)';
    elseif ~isfield(handles, 'X_dist_ent')
        bd_str = '- You should input the value of the variable: distance (TAZ-entrance)';
    elseif ~isfield(handles, 'X_stdf')
        bd_str = ['- You should input the value of the variable: stair (TAZ-TAZ), ',...
            'you can calculate it automatically.'];
    elseif ~isfield(handles, 'X_stdf_ent')
        bd_str = ['- You should input the value of the variable: stair (TAZ-entrance), ',...
            'you can calculate it automatically.'];
    else
        bd_str = [];
    end
    
    if isempty(bd_str)
        bd_str = '- You have input all neccessary base data.';
    end
    
    % 模型相关
    if ~isfield(handles, 'b_area_user') | ~isfield(handles, 'b_dist_user') | ~isfield(handles, 'b_stdf_user') | ~isfield(handles, 'b_visited_user') | ~isfield(handles, 'b_past_user')
        md_str1 = '- There are only predefined models, no user-defined model, you can use predefined model.';
    else
        md_str1 = '- There are both predefined models and user-defined model, you can select one of them.';
    end
    
    if ~isfield(handles, 'path_rawdata')
        md_str2  = '- If you want to estimate a new model, you need to input path data.';
    elseif ~isequal(bd_str ,'- You have input all neccessary base data.')
        md_str2 = '- If you want to estimate a new model, you should specify neccessary base data';
    else
        md_str2 = '- You can estimated a new model.';
    end
    md_str = strvcat(md_str1, md_str2);
    
    % 模拟相关
    if ~isfield(handles, 'NPED')
        sm_str1 = '- You should input the number of individuals to simulate.';
    elseif ~isfield(handles, 'X_ent_distrib')
        sm_str1 = '- You must input consumers'' spatial distribution among entrances.';
    elseif ~isequal(bd_str ,'- You have input all neccessary base data.')
        sm_str1 = '- You must input neccessary base data.';
    else
        sm_str1 = '- You can do spatial behavior simulation.';
    end
    
    if ~strcmp(sm_str1, '- You can do spatial behavior simulation.')
        sm_str2 = '';
    elseif ~isfield(handles, 'X_ind_ent_time') & ~isfield(handles, 'ent_time_distr')
        sm_str2 = '- If you want to do spatiotemporal behavior simulation, you must input entry time distribution or exact entry time data for every individual.';
    elseif isfield(handles, 'X_ind_ent_time') & ~isfield(handles, 'ent_time_distr') & length(handles.X_ind_ent_time) ~= handles.NPED
        sm_str2 = '- If you want to do spatiotemporal behavior simulation, you must input entry time distribution, for your individual entry time data is incomplete.';
    elseif ~isfield(handles, 'stay_time_distr')
        sm_str2 = '- If you want to do spatiotemporal behavior simulation, you must input TAZ stay time distribution.';
    elseif ~isfield(handles, 'traffic_time')
        sm_str2 = '- If you want to do spatiotemporal behavior simulation, you must input traffic time distribution.';
    elseif ~isfield(handles, 'EntTime_distrib_type') | ~isfield(handles, 'EntTime_distrib')
        sm_str2 = '- You can do spatiotemporal behavior simulation, but since you did not specify type of entry time distribution, it would be automatically decided';
    else
        sm_str2 = '- You can do spatiotemporal behavior simulation.';
    end
    
    if ~isfield(handles, 'Sim_result')
        sm_str4 = '- If you want to do consuming simulation, you must firstly finish a spatial/spatiotemporal simulation.';
    elseif ~isfield(handles, 'consume_prob')
        sm_str4 = '- If you want to do consuming simulation, you must input TAZ consuming probability data.';
    elseif ~isfield(handles, 'expenditure_distr')
        sm_str4 = '- If you want to do consuming simulation, you must input TAZ expenditure distribution data.';
    else
        sm_str4 = '- You can do consuming simulation.';
    end
    sm_str = strvcat(sm_str1, sm_str2, sm_str4);
    
    if isfield(handles, 'Sim_mean_taz_distrib') & isfield(handles, 'timely_taz_stat_result') & isfield(handles, 'base_area')
        rs_str1 = '- You have got total & dynamic individual distribution result, you can visualize (plot/video) and export it.';
        rs_str2 = '- You have got total & dynamic density result, you can visualize (plot/video) and export it.';
    elseif isfield(handles, 'Sim_mean_taz_distrib') & isfield(handles, 'timely_taz_stat_result') & ~isfield(handles, 'base_area')
        rs_str1 = '- You have got total & dynamic individual distribution result, you can visualize (plot/video) and export it.';
        rs_str2 = '';
    elseif isfield(handles, 'Sim_mean_taz_distrib') & ~isfield(handles, 'timely_taz_stat_result') & isfield(handles, 'base_area')
        rs_str1 = '- You have got total (static) individual distribution result, you can visualize (plot) and export it.';
        rs_str2 = '- You have got total (static) density result, you can visualize (plot) and export it.';
    elseif isfield(handles, 'Sim_mean_taz_distrib') & ~isfield(handles, 'timely_taz_stat_result') & ~isfield(handles, 'base_area')
        rs_str1 = '- You have got total (static) individual distribution result, you can visualize (plot) and export it.';
        rs_str2 = '';
    elseif ~isfield(handles, 'Sim_mean_taz_distrib') & ~isfield(handles, 'timely_taz_stat_result') 
        rs_str1 = '';
        rs_str2 = '';
    end
    if isfield(handles, 'Sim_mean_OD')
        rs_str5 = 'You have got total (static) OD distribution result, you can visualize (plot) and export it.';
    else
        rs_str5 = '';
    end
    if isfield(handles, 'Sim_result_money')
        rs_str6 = 'You have got total (static) consuming result, you can visualize (plot) and export it.';
    else
        rs_str6 = '';
    end
    if isfield(handles, 'Comp_TAZ_distrib') & isfield(handles, 'base_area') & isfield(handles, 'comp_timely_taz_stat_result')
        comp_available = {'total & dynamic individual distribution' , 'total & dynamic density'};
    elseif isfield(handles, 'Comp_TAZ_distrib') & ~isfield(handles, 'base_area') & isfield(handles, 'comp_timely_taz_stat_result')
        comp_available = {'total & dynamic individual distribution' };
    elseif isfield(handles, 'Comp_TAZ_distrib') & isfield(handles, 'base_area') & ~isfield(handles, 'comp_timely_taz_stat_result')
        comp_available = {'total (static) individual distribution' , 'total (static) density'};
    elseif isfield(handles, 'Comp_TAZ_distrib') & ~isfield(handles, 'base_area') & ~isfield(handles, 'comp_timely_taz_stat_result')
        comp_available = {'total (static) individual distribution' };
    elseif ~isfield(handles, 'Comp_TAZ_distrib') & ~isfield(handles, 'comp_timely_taz_stat_result')
        comp_available = cell(0);
    end
    if isfield(handles, 'Comp_OD')
        comp_available{end+1} = 'total (static) OD distribution';
    end
    if isfield(handles, 'comp_expenditure_distr')
        comp_avaialbe{end+1} = 'total (static) consuming';
    end
    
    rs_str7 = '- Current available comparison result: ';
    if ~isempty(comp_available) & length(comp_available) > 1
        for kkk = 1 : length(comp_available)-1
            rs_str7 = [rs_str7, '''', comp_available{kkk}, ''', '];
        end
        rs_str7 = [rs_str7, '''', comp_available{end}, '''.'];
    elseif length(comp_available) == 1
        rs_str7 = [rs_str7, '''', comp_available{end}, '''.'];
    else
        rs_str7 = [rs_str7, 'None'];
    end
    rs_str1256 = strvcat(rs_str1, rs_str2, rs_str5, rs_str6);
    if isempty(rs_str1256)
        rs_str1256 = '- There is no available simulation result.';
    end
    rs_str = strvcat(rs_str1256, rs_str7);
    
% %     all_str = {bd_str; ' ';  md_str; ' ' ; sm_str};
% %     msgbox(all_str, 'Current Status')
end

crt_status_fig = figure('name', 'Current Status', 'NumberTitle', 'off',...
    'menubar', 'none', 'toolbar', 'none', 'unit', 'normalized',...
    'color', 'w', 'position', [.35 .1 .3 .8]);
bd_panel = uipanel('parent', crt_status_fig, 'title', 'Base Data', 'unit',...
    'normalized', 'fontsize', 15, 'fontweight', 'bold', 'position',...
    [.05 .9 .9 .08]);
md_panel =uipanel('parent', crt_status_fig, 'title', 'Logit Model', 'unit',...
    'normalized', 'fontsize', 15, 'fontweight', 'bold', 'position',...
    [.05 .73 .9 .15]);
sm_panel =uipanel('parent', crt_status_fig, 'title', 'Simulation', 'unit',...
    'normalized', 'fontsize', 15, 'fontweight', 'bold', 'position',...
    [.05 .42 .9 .29]);
rs_panel =uipanel('parent', crt_status_fig, 'title', 'Result', 'unit',...
    'normalized', 'fontsize', 15, 'fontweight', 'bold', 'position',...
    [.05 .1 .9 .3]);
crt_status_ok = uicontrol('parent', crt_status_fig, 'style', 'pushbutton',...
    'unit', 'normalized', 'string', 'OK', 'fontsize', 12, 'position',...
    [.35 .02 .3 .06], 'callback', @crt_status_ok_callback, 'KeyPressFcn', ...
    @crt_status_ok_key_press);
uicontrol(crt_status_ok);
bd_str_h = uicontrol('parent', bd_panel, 'style', 'text', 'unit', 'normalized',...
    'position', [.02 .02 .96 .92], 'backgroundcolor', 'w', 'string', bd_str, ...
    'HorizontalAlignment', 'left','fontsize', 10);
md_str_h = uicontrol('parent', md_panel, 'style', 'text', 'unit', 'normalized',...
    'position', [.02 .02 .96 .92], 'backgroundcolor', 'w', 'string', md_str,...
    'HorizontalAlignment', 'left','fontsize', 10);
sm_str_h = uicontrol('parent', sm_panel, 'style', 'text', 'unit', 'normalized',...
    'position', [.02 .02 .96 .92], 'backgroundcolor', 'w', 'string', sm_str,...
    'HorizontalAlignment', 'left','fontsize', 10);
rs_str_h = uicontrol('parent', rs_panel, 'style', 'text', 'unit', 'normalized',...
    'position', [.02 .02 .96 .92], 'backgroundcolor', 'w', 'string', rs_str,...
    'HorizontalAlignment', 'left','fontsize', 10);

function crt_status_ok_callback(hObject, eventdata)
crt_fig = findall(0, 'name', 'Current Status');
close(crt_fig)

function crt_status_ok_key_press(hObject, eventdata)
crt_fig = findall(0, 'name', 'Current Status');
if isequal(eventdata.Key, 'return')
    drawnow
    close(crt_fig)
end


% --------------------------------------------------------------------
function Untitled_30_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_30 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function ind_consuming_ober_Callback(hObject, eventdata, handles)
% hObject    handle to ind_consuming_ober (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[fname , pname] = uigetfile('*.csv' , 'Open the Individual Consuming Oberservation CSV');
if isequal(fname, 0) | isequal(pname, 0)
    return
end
fullname = strcat(pname,fname);

table_data = importdata(fullname);
if isfield(table_data, 'colheaders')
    colheaders = table_data.colheaders;
    TAZID_index = find(ismember(colheaders, 'TAZID'));
    if isempty(TAZID_index)
        %         errordlg('This csv contains the variable header, but none or more than 1 ''IndividualID'' is found.', 'Error');
        %         return
        TAZID_index = listdlg('PromptString','Select TAZ ID Variable:','SelectionMode','single',...
            'ListString',colheaders);
        if isempty(TAZID_index)
            return
        end
    end
    Expenditure_index = find(ismember(colheaders, 'Expenditure'));
    if isempty(Expenditure_index)
        %         errordlg('This csv contains the variable header, but none or more than 1 ''TAZID'' is not found.', 'Error');
        %         return
        Expenditure_index = listdlg('PromptString','Select Expenditure Variable:','SelectionMode','single',...
            'ListString',colheaders);
        if isempty(Expenditure_index)
            return
        end
    end
    try
        consume_rawdata = csvread(fullname, 1, 0);
    catch
        errordlg('Unable to open the individual consuming CSV', 'Open Error')
        return
    end
    consume_rawdata = consume_rawdata(:, [TAZID_index, Expenditure_index]);
else
    try
        consume_rawdata = csvread(fullname);
    catch
        errordlg('Unable to open the individual consuming CSV', 'Open Error')
        return
    end
end


%因为上面已经针对带表头的方式调整过了，下面的调整其实只是针对不带表头直接调的
if size(consume_rawdata, 2) == 1 | size(consume_rawdata, 2) > 3
    errordlg('Invalid data format', 'Open Error')
    return
end
if size(consume_rawdata, 2) == 3
    consume_rawdata = consume_rawdata(:, 2:3);
end
handles.consume_rawdata = consume_rawdata;
guidata(hObject, handles);
msgbox('Successfully input individual consuming observations')



% --------------------------------------------------------------------
function consum_prob_Callback(hObject, eventdata, handles)
% hObject    handle to consum_prob (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isfield(handles , 'NTAZ')
     errordlg('Please firstly input Num of TAZs' , 'NTAZ Error')
     return
end
NTAZ = handles.NTAZ;
choice1 = questdlg('Do you want to input consuming probability data or just check the data?' , 'Consuming Probability Data'...
    , 'Input Data' , 'Check Data' , 'Input Data');
if isequal(choice1, 'Input Data')
    choice2 = questdlg('Please choose the way of inputting consuming probability data' , 'Consuming Probability Data',...
        'Load CSV File'  ,'Directly Type or Copy / Paste' , 'Automatic Calculatoin', 'Automatic Calculatoin');
    switch choice2
        case 'Directly Type or Copy / Paste'
            str = ['Please enter space(/comma)-separated consuming probability values in the order: from TAZ_1 to TAZ_' , num2str(NTAZ)];
            same_pasted_value = inputdlgWC({str, 'OR please enter the same consuming probability for All TAZS'} , 'Consuming Probability Data', [1 80 ; 1 45]);
            if isempty(same_pasted_value)
                return
            end
            pasted_value = same_pasted_value{1};
            same_value = same_pasted_value{2};
            if length(pasted_value) ~= 0
                try
                    pasted_value = str2num(pasted_value);
                catch
                    errordlg('Invalid Input', 'Input Error')
                    return
                end
                if length(pasted_value) == NTAZ & sum(pasted_value>=0 & pasted_value<=1) == NTAZ
                    consume_prob = pasted_value';
                    handles.consume_prob = consume_prob;
                    guidata(hObject,handles);
                elseif length(pasted_value) ~= NTAZ
                    errordlg('Input Num of consuming probability data NOT equal Num of TAZ' , 'Input Error')
                    return
                else
                    errordlg('All consuming probability data must be between 0 to 1' , 'Input Error')
                    return
                end
            elseif length(same_value) ~= 0
                try
                    same_value = str2num(same_value);
                catch
                    errordlg('Invalid Input', 'Input Error')
                    return
                end
                if same_value >= 0 & same_value <= 1
                    consume_prob = same_value * ones(NTAZ, 1);
                    handles.consume_prob = consume_prob;
                    guidata(hObject,handles);
                else
                    errordlg('The consuming probability must be between 0 to 1', 'Input Error')
                    return
                end
            end
        case 'Load CSV File'
            [fname , pname] = uigetfile('*.csv' , 'Open the Consuming Probability CSV');
            if isequal(fname, 0) | isequal(pname, 0)
                return
            end
            fullname = strcat(pname,fname);
            %两列：TAZID， ConsumingProb
            varnames = {'TAZID', 'ConsumingProb'};
            varstring = {'TAZ ID', 'Consuming Probability'};
            [consume_prob, flag] = open_csv(fullname, 2, varnames, varstring);
            if flag == 0
                return
            end
%             try
%                 consume_prob = csvread(fullname);
%             catch
%                 try
%                     consume_prob = csvread(fullname, 1, 0);
%                 catch
%                     errordlg('Unable to open the consuming probability csv', 'Open Error')
%                     return
%                 end
%             end
            [nrow , ncol] = size(consume_prob);
            if nrow == NTAZ 
                if ncol == 1 & sum(consume_prob>=0 & consume_prob<=1) == NTAZ
                    handles.consume_prob = consume_prob;
                    guidata(hObject,handles);
                elseif ncol == 2 & sum(consume_prob(:,2)>=0 & consume_prob(:,2)<=1) == NTAZ
                    consume_prob = sortrows(consume_prob , 1);
                    consume_prob = consume_prob(: , 2);
                    handles.consume_prob = consume_prob;
                    guidata(hObject,handles);
                elseif ncol < 1 | ncol > 2
                    errordlg('Invalid data format', 'Input Error')
                    return
                else
                    errordlg('All consuming probability data must be between 0 to 1' , 'Input Error')
                    return
                end
            else
                errordlg('Input Num of consuming probability data NOT equal Num of TAZ' , 'Input Error')
                return
            end
        case 'Automatic Calculatoin'
            clear consume_prob
            if ~isfield(handles , 'consume_rawdata')
                errordlg('NO individual consuming observation inputting' , 'Input Error')
                return
            else
                consume_rawdata = handles.consume_rawdata;
                consume_or_not = consume_rawdata;
                consume_or_not(:, 2) = consume_or_not(:, 2) > 0;
                all_mean_prob = mean(consume_or_not(:,2));
                consume_prob = [];      %初始化
                for itaz = 1 : NTAZ
                    crt_taz_consume_or_not = consume_or_not(consume_or_not(:,1) == itaz, 2);
                    if ~isempty(crt_taz_consume_or_not)         %有数据
                        consume_prob = [consume_prob; mean(crt_taz_consume_or_not)];
                    else                                        %没数据
                        input_ok = 0;
                        while input_ok == 0
                            need_to_input = inputdlgWC(['Warning: there is no individual observaltion for TAZ_', num2str(itaz), ...
                                ', please input a proper value (default: mean value for all observations).'] , ...
                                'Consuming Probability Data', 1, mat2cell(num2str(all_mean_prob),1 ,1));
                            waitfor(need_to_input);
                            try
                                crt_input = str2num(cell2mat(need_to_input));
                            catch
                                errordlg('Invalid input, please re-input.', 'Input Error')
                            end
                            if ~isempty(crt_input) & crt_input >= 0 & crt_input <= 1
                                input_ok = 1;
                            end
                        end
                        consume_prob = [consume_prob; crt_input];
                    end
                end
                if length(consume_prob) == NTAZ;
                    handles.consume_prob = consume_prob;
                    guidata(hObject,handles);
                else
                    errordlg('Input Num of consuming probability data NOT equal Num of TAZ' , 'Input Error')
                    return
                end
            end
    end
    
    %完成后显示一下
    if isfield(handles , 'consume_prob')
        consume_prob = handles.consume_prob;
        taz_consume_prob = [[1:NTAZ]' , consume_prob];
        show = strvcat('TAZ    Consuming Probability' , num2str(taz_consume_prob));
        msgbox(show)
    end

elseif isequal(choice1 , 'Check Data')
    if ~isfield(handles , 'consume_prob')
        warndlg('There is NO valid consuming probability input' ,'Consuming Probability Data')
        return
    else
        consume_prob = handles.consume_prob;
        taz_consume_prob = [[1:NTAZ]' , consume_prob];
        show = strvcat('TAZ    Consuming Probability' , num2str(taz_consume_prob));
        msgbox(show)
    end
    
end


% --------------------------------------------------------------------
function expend_distr_Callback(hObject, eventdata, handles)
% hObject    handle to expend_distr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function expend_distr_kd_Callback(hObject, eventdata, handles)
% hObject    handle to expend_distr_kd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isfield(handles , 'NTAZ')
    errordlg('Please firstly input Num of TAZs' , 'NTAZ Error')
    return
end
NTAZ = handles.NTAZ;

if ~isfield(handles , 'consume_rawdata')
    errordlg('NO individual consuming observation inputting' , 'Input Error')
    return
else
    consume_rawdata = handles.consume_rawdata;
    expenditure = consume_rawdata(consume_rawdata(:,2)>0, :);
    all_mean_kd = fitdist(expenditure(:,2), 'kernel');
    [all_mean_f, all_mean_x] = ksdensity(expenditure(:,2));
    expenditure_distr = cell(0);      %初始化
    %第一列：小区编号；第二列，分布object；第三列：画图X；第四列：画图Y；第五列：分布类型（1为ksdensity，2为正态，3为对数正态）；第六列：分布参数（ks可能没有）
    for itaz = 1 : NTAZ
        expenditure_distr{itaz, 1} = itaz;
        crt_taz_expenditure = expenditure(expenditure(:,1) == itaz, 2);
        if ~isempty(crt_taz_expenditure)            %有数据
            expenditure_distr{itaz, 2} = fitdist(crt_taz_expenditure, 'kernel');
            [crtf, crtx] = ksdensity(crt_taz_expenditure);
            expenditure_distr{itaz, 3} = crtx;
            expenditure_distr{itaz, 4} = crtf;
            expenditure_distr{itaz, 5} = 1;
            expenditure_distr{itaz, 6} = [nan, nan];
        else                                        %没数据
            input_ok = 0;
            while input_ok == 0
                need_to_input = questdlg(['Warning: there is no individual observaltion for TAZ_', num2str(itaz), ...
                    ' please select another way.'] , ...
                    'Expenditure Distribution Data', 'Use overall kernel density distribution', 'Define a normal distribution', 'Use overall distribution');
                waitfor(need_to_input);
                if isequal(need_to_input, 'Use overall kernel density distribution')
                    expenditure_distr{itaz, 2} = all_mean_kd;
                    expenditure_distr{itaz, 3} = all_mean_x;
                    expenditure_distr{itaz, 4} = all_mean_f;
                    expenditure_distr{itaz, 5} = 1;
                    expenditure_distr{itaz, 6} = [nan, nan];
                    input_ok = 1;
                elseif isequal(need_to_input, 'Define a normal distribution')
                    def_norm = inputdlgWC({'mu: ', 'sigma: '}, '', 1, {'0' , '0'});
                    try
                        def_mu = str2num(def_norm{1});
                        def_sigma = str2num(def_norm{2});
                    catch
                        e1 = errordlg('Invalid input', 'Input Error');
                        waitfor(e1)
                        continue
                    end
                    if def_mu < 0
                        e2 = errordlg('Mean expenditure must be non-negative', 'Input Error');
                        waitfor(e2)
                        continue
                    end
                    if def_sigma < 0
                        e3 = errordlg('Sigma must non-negative', 'Input Error');
                        waitfor(e3)
                        continue
                    end
                    crt_pd = makedist('Normal', 'mu', def_mu, 'sigma', def_sigma);
                    expenditure_distr{itaz, 2} = crt_pd;
                    crt_x = linspace(def_mu - 3.2*def_sigma, def_mu + 3.2*def_sigma, 100);
                    expenditure_distr{itaz, 3} = crt_x;
                    expenditure_distr{itaz, 4} = pdf(crt_pd, crt_x);
                    expenditure_distr{itaz, 5} = 2;
                    expenditure_distr{itaz, 6} = [def_mu, def_sigma];
                    input_ok = 1;
                elseif isempty(need_to_input)
                    return
                end
            end
        end
    end
    if size(expenditure_distr, 1) == NTAZ;
        handles.expenditure_distr = expenditure_distr;
        guidata(hObject,handles);
        msgbox('Finished.')
    else
        errordlg('Input Num of expenditure distribution data do NOT equal Num of TAZ' , 'Input Error')
        return
    end
end
    
    



    


% --------------------------------------------------------------------
function expend_distr_norm_Callback(hObject, eventdata, handles)
% hObject    handle to expend_distr_norm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isfield(handles , 'NTAZ')
     errordlg('Please firstly input Num of TAZs' , 'NTAZ Error')
     return
end
NTAZ = handles.NTAZ;
choice1 = questdlg('Do you want to input expenditure distribution or check distribution parameter?' , 'Expenditure Distribution Data'...
    , 'Input distribution' , 'Check distribution parameter' , 'Input distribution');
if isequal(choice1, 'Input distribution')
    choice2 = questdlg('Please choose the way of inputing expenditure distribution.' , 'Expenditure Distribution Data'...
        , 'Load CSV File' , 'Automatic Estimation' , 'Automatic Estimation');
    if isequal(choice2, 'Automatic Estimation')
        if ~isfield(handles , 'consume_rawdata')
            errordlg('NO individual consuming observation inputting' , 'Input Error')
            return
        else
            consume_rawdata = handles.consume_rawdata;
            expenditure = consume_rawdata(consume_rawdata(:,2)>0, :);
            all_mu = mean(expenditure(:,2));
            all_sigma = std(expenditure(:,2));
            all_norm_pd = makedist('normal', all_mu, all_sigma);
            all_x = linspace(all_mu - 3.2*all_sigma, all_mu + 3.2*all_sigma, 100);
            all_f = pdf(all_norm_pd, all_x);
            
            expenditure_distr = cell(0);      %初始化
            %第一列：小区编号；第二列，分布object；第三列：画图X；第四列：画图Y；第五列：分布类型（1为ksdensity，2为正态，3为对数正态）；第六列：分布参数[mu, sigma]
            for itaz = 1 : NTAZ
                expenditure_distr{itaz, 1} = itaz;
                crt_taz_expenditure = expenditure(expenditure(:,1) == itaz, 2);
                if ~isempty(crt_taz_expenditure)            %有数据
                    crt_mu = mean(crt_taz_expenditure);
                    crt_sigma = std(crt_taz_expenditure);
                    crt_norm_pd = makedist('normal', crt_mu, crt_sigma);
                    crt_x = linspace(crt_mu - 3.2*crt_sigma, crt_mu + 3.2*crt_sigma, 100);
                    crt_f = pdf(crt_norm_pd, crt_x);
                    expenditure_distr{itaz, 2} = crt_norm_pd;
                    expenditure_distr{itaz, 3} = crt_x;
                    expenditure_distr{itaz, 4} = crt_f;
                    expenditure_distr{itaz, 5} = 2;
                    expenditure_distr{itaz, 6} = [crt_mu, crt_sigma];
                else                                        %没数据
                    input_ok = 0;
                    while input_ok == 0
                        need_to_input = questdlg(['Warning: there is no individual observaltion for TAZ_', num2str(itaz), ...
                            ' please select another way.'] , ...
                            'Expenditure Distribution Data', 'Use overall normal distribution', 'Define a normal distribution', 'Use overall distribution');
                        waitfor(need_to_input);
                        if isequal(need_to_input, 'Use overall normal distribution')
                            expenditure_distr{itaz, 2} = all_norm_pd;
                            expenditure_distr{itaz, 3} = all_x;
                            expenditure_distr{itaz, 4} = all_f;
                            expenditure_distr{itaz, 5} = 2;
                            expenditure_distr{itaz, 6} = [all_mu, all_sigma];
                            input_ok = 1;
                        elseif isequal(need_to_input, 'Define a normal distribution')
                            def_norm = inputdlgWC({'mu: ', 'sigma: '}, '', 1, {'0' , '0'});
                            try
                                def_mu = str2num(def_norm{1});
                                def_sigma = str2num(def_norm{2});
                            catch
                                e1 = errordlg('Invalid input', 'Input Error');
                                waitfor(e1)
                                continue
                            end
                            if def_mu < 0
                                e2 = errordlg('Mean expenditure must be non-negative', 'Input Error');
                                waitfor(e2)
                                continue
                            end
                            if def_sigma < 0
                                e3 = errordlg('Sigma must non-negative', 'Input Error');
                                waitfor(e3)
                                continue
                            end
                            crt_pd = makedist('Normal', 'mu', def_mu, 'sigma', def_sigma);
                            expenditure_distr{itaz, 2} = crt_pd;
                            crt_x = linspace(def_mu - 3.2*def_sigma, def_mu + 3.2*def_sigma, 100);
                            expenditure_distr{itaz, 3} = crt_x;
                            expenditure_distr{itaz, 4} = pdf(crt_pd, crt_x);
                            expenditure_distr{itaz, 5} = 2;
                            expenditure_distr{itaz, 6} = [def_mu, def_sigma];
                            input_ok = 1;
                        elseif isempty(need_to_input)
                            return
                        end
                    end
                end
            end
        end
    elseif isequal(choice2, 'Load CSV File')
        [fname , pname] = uigetfile('*.csv' , 'Open the Expenditure Normal Distribution Parameter CSV');
        if isequal(fname, 0) | isequal(pname, 0)
            return
        end
        fullname = strcat(pname,fname);
        %三列，TAZID, Mu, Sigma
        varnames = {'TAZID', 'Mu', 'Sigma'};
        varstring = {'TAZ ID', 'Mu', 'Sigma'};
        [exp_distr_para, flag] = open_csv(fullname, 3, varnames, varstring);
        if flag == 0
            return
        end
%         try
%             exp_distr_para = csvread(fullname);
%         catch
%             try
%                 exp_distr_para = csvread(fullname, 1, 0);
%             catch
%                 errordlg('Unable to open the normal distribution parameter csv', 'Open Error')
%                 return
%             end
%         end
        [nrow , ncol] = size(exp_distr_para);
        if nrow == NTAZ
            if ncol == 2
                exp_distr_para_mu = exp_distr_para(:,1);
                exp_distr_para_sigma = exp_distr_para(:,2);
            elseif ncol == 3 
                exp_distr_para = sortrows(exp_distr_para , 1);
                exp_distr_para = exp_distr_para(: , 2:3);
                exp_distr_para_mu = exp_distr_para(:,1);
                exp_distr_para_sigma = exp_distr_para(:,2);
            elseif ncol < 2 | ncol > 3
                errordlg('Invalid data format', 'Input Error')
                return
            end
        else
            errordlg('Input Num of distribution parameter data NOT equal Num of TAZ' , 'Input Error')
            return
        end
        
        %检查数据，并生成分布信息的大cell数组
        for ki = 1 : NTAZ
            expenditure_distr{ki, 1} = ki;
            crt_mu = exp_distr_para_mu(ki);
            crt_sigma = exp_distr_para_sigma(ki);
            if crt_mu < 0 
                errordlg('Mean value must non-negative', 'Input Error')
                return
            end
            if crt_sigma < 0
                errordlg('Sigma value must be non-negative', 'Input Error')
                return
            end
            crt_pd = makedist('Normal', 'mu', crt_mu, 'sigma', crt_sigma); 
            expenditure_distr{ki, 2} = crt_pd;
            crt_x = linspace(crt_mu - 3.2*crt_sigma, crt_mu + 3.2*crt_sigma, 100);
            expenditure_distr{ki, 3} = crt_x;
            expenditure_distr{ki, 4} = pdf(crt_pd, crt_x);
            expenditure_distr{ki, 5} = 2;
            expenditure_distr{ki, 6} = [crt_mu, crt_sigma];
        end
    elseif isempty(choice2)
        return
    end
    if size(expenditure_distr, 1) == NTAZ;
        handles.expenditure_distr = expenditure_distr;
        guidata(hObject,handles);
        msgbox('Finished.')
    else
        errordlg('Input Num of expenditure distribution data do NOT equal Num of TAZ' , 'Input Error')
        return
    end
    
elseif isequal(choice1 , 'Check distribution parameter')
    if ~isfield(handles , 'expenditure_distr')
        warndlg('There is NO valid expenditure distribution input' ,'Expenditure Distribution Data')
        return
    else
        expenditure_distr = handles.expenditure_distr;
        distr_type = [];
        for taz_i = 1 : NTAZ
            distr_par(taz_i, :) = [taz_i, expenditure_distr{taz_i, 6}];
            if expenditure_distr{taz_i, 5} == 2 
                distr_type = strvcat(distr_type, '     normal');
            elseif expenditure_distr{taz_i, 5} == 3
                distr_type = strvcat(distr_type, '     log-normal');
            elseif expenditure_distr{taz_i, 5} == 1
                distr_type = strvcat(distr_type, '     kernel density');
            end
        end
        show = strvcat('TAZ     mu     sigma     type' , strcat(num2str(distr_par), distr_type));
        msgbox(show)
    end
    
end


% --------------------------------------------------------------------
function expend_distr_lognorm_Callback(hObject, eventdata, handles)
% hObject    handle to expend_distr_lognorm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isfield(handles , 'NTAZ')
     errordlg('Please firstly input Num of TAZs' , 'NTAZ Error')
     return
end
NTAZ = handles.NTAZ;
choice1 = questdlg('Do you want to estimate expenditure distribution or check distribution parameter?' , 'Expenditure Distribution Data'...
    , 'Input distribution' , 'Check distribution parameter' , 'Input distribution');
if isequal(choice1, 'Input distribution')
    choice2 = questdlg('Please choose the way of inputing expenditure distribution.' , 'Expenditure Distribution Data'...
        , 'Load CSV File' , 'Automatic Estimation' , 'Automatic Estimation');
    if isequal(choice2, 'Automatic Estimation')
        if ~isfield(handles , 'consume_rawdata')
            errordlg('NO individual consuming observation inputting' , 'Input Error')
            return
        else
            consume_rawdata = handles.consume_rawdata;
            expenditure = consume_rawdata(consume_rawdata(:,2)>0, :);
            %         all_ln_pd = fitdist(expenditure(:,2), 'Lognormal');
            %         all_ln_mu = all_ln_pd.mu;
            %         all_ln_sigma = all_ln_pd.sigma;
            all_ln_mu = mean(log(expenditure(:,2)));
            all_ln_sigma = std(log(expenditure(:,2)));
            all_ln_pd = makedist('Lognormal', 'mu', all_ln_mu, 'sigma', all_ln_sigma);
            all_x = linspace(max(0, mean(expenditure(:,2)) - 3.2 * std(expenditure(:,2)) ) , ...
                mean(expenditure(:,2)) + 3.2 * std(expenditure(:,2))  ,100  );
            all_f = pdf(all_ln_pd, all_x);
            
            expenditure_distr = cell(0);      %初始化
            %第一列：小区编号；第二列，分布object；第三列：画图X；第四列：画图Y；第五列：分布类型（1为ksdensity，2为正态，3为对数正态）；第六列：分布参数[mu, sigma]
            for itaz = 1 : NTAZ
                expenditure_distr{itaz, 1} = itaz;
                crt_taz_expenditure = expenditure(expenditure(:,1) == itaz, 2);
                if ~isempty(crt_taz_expenditure)            %有数据
                    crt_ln_mu = mean(log(crt_taz_expenditure));
                    crt_ln_sigma = std(log(crt_taz_expenditure));
                    crt_ln_pd = makedist('Lognormal', 'mu', crt_ln_mu, 'sigma', crt_ln_sigma);
                    %                 crt_ln_pd = fitdist(crt_taz_expenditure, 'Lognormal');
                    %                 crt_ln_mu = crt_ln_pd.mu;
                    %                 crt_ln_sigma = crt_ln_pd.sigma;
                    crt_x = linspace( max(0, mean(crt_taz_expenditure) - 3.2*std(crt_taz_expenditure))  , ...
                        mean(crt_taz_expenditure) + 3.2*std(crt_taz_expenditure)  , 100);
                    crt_f = pdf(crt_ln_pd, crt_x);
                    expenditure_distr{itaz, 2} = crt_ln_pd;
                    expenditure_distr{itaz, 3} = crt_x;
                    expenditure_distr{itaz, 4} = crt_f;
                    expenditure_distr{itaz, 5} = 3;
                    expenditure_distr{itaz, 6} = [crt_ln_mu, crt_ln_sigma];
                else                                        %没数据
                    input_ok = 0;
                    while input_ok == 0
                        need_to_input = questdlg(['Warning: there is no individual observaltion for TAZ_', num2str(itaz), ...
                            ' please select another way.'] , ...
                            'Expenditure Distribution Data', 'Use overall log-normal distribution', ...
                            'Define a log-normal distribution', 'Define a normal distribution', 'Use overall distribution');
                        waitfor(need_to_input);
                        if isequal(need_to_input, 'Use overall log-normal distribution')
                            expenditure_distr{itaz, 2} = all_ln_pd;
                            expenditure_distr{itaz, 3} = all_x;
                            expenditure_distr{itaz, 4} = all_f;
                            expenditure_distr{itaz, 5} = 3;
                            expenditure_distr{itaz, 6} = [all_ln_mu, all_ln_sigma];
                            input_ok = 1;
                        elseif isequal(need_to_input, 'Define a log-normal distribution')
                            def_ln = inputdlgWC({'mu: ', 'sigma: '}, '', 1, {'0' , '0'});
                            try
                                def_ln_mu = str2num(def_ln{1});
                                def_ln_sigma = str2num(def_ln{2});
                            catch
                                e1 = errordlg('Invalid input', 'Input Error');
                                waitfor(e1)
                                continue
                            end
                            if def_sigma < 0
                                e3 = errordlg('Sigma must non-negative', 'Input Error');
                                waitfor(e3)
                                continue
                            end
                            crt_ln_pd = makedist('Lognormal', 'mu', def_ln_mu, 'sigma', def_ln_sigma);
                            expenditure_distr{itaz, 2} = crt_ln_pd;
                            %生成一组随机数
                            trial = random(crt_ln_pd, 100, 1);
                            crt_x = linspace(max(0, mean(trial) - 3.2*std(trial)), ...
                                mean(trial) + 3.2*std(trial), 100);
                            expenditure_distr{itaz, 3} = crt_x;
                            expenditure_distr{itaz, 4} = pdf(crt_ln_pd, crt_x);
                            expenditure_distr{itaz, 5} = 3;
                            expenditure_distr{itaz, 6} = [def_ln_mu, def_ln_sigma];
                            input_ok = 1;
                        elseif isequal(need_to_input, 'Define a normal distribution')
                            def_norm = inputdlgWC({'mu: ', 'sigma: '}, '', 1, {'0' , '0'});
                            try
                                def_mu = str2num(def_norm{1});
                                def_sigma = str2num(def_norm{2});
                            catch
                                e1 = errordlg('Invalid input', 'Input Error');
                                waitfor(e1)
                                continue
                            end
                            if def_mu < 0
                                e2 = errordlg('Mean expenditure must be non-negative', 'Input Error');
                                waitfor(e2)
                                continue
                            end
                            if def_sigma < 0
                                e3 = errordlg('Sigma must non-negative', 'Input Error');
                                waitfor(e3)
                                continue
                            end
                            crt_pd = makedist('Normal', 'mu', def_mu, 'sigma', def_sigma);
                            expenditure_distr{itaz, 2} = crt_pd;
                            crt_x = linspace(def_mu - 3.2*def_sigma, def_mu + 3.2*def_sigma, 100);
                            expenditure_distr{itaz, 3} = crt_x;
                            expenditure_distr{itaz, 4} = pdf(crt_pd, crt_x);
                            expenditure_distr{itaz, 5} = 2;
                            expenditure_distr{itaz, 6} = [def_mu, def_sigma];
                            input_ok = 1;
                        elseif isempty(need_to_input)
                            return
                        end
                    end
                end
            end
        end
        
    elseif isequal(choice2, 'Load CSV File')
        [fname , pname] = uigetfile('*.csv' , 'Open the Expenditure Log-Normal Distribution Parameter CSV');
        if isequal(fname, 0) | isequal(pname, 0)
            return
        end
        fullname = strcat(pname,fname);
        %三列，TAZID, Mu, Sigma
        varnames = {'TAZID', 'Mu', 'Sigma'};
        varstring = {'TAZ ID', 'Mu', 'Sigma'};
        [exp_distr_para, flag] = open_csv(fullname, 3, varnames, varstring);
        if flag == 0
            return
        end
%         try
%             exp_distr_para = csvread(fullname);
%         catch
%             try
%                 exp_distr_para = csvread(fullname, 1, 0);
%             catch
%                 errordlg('Unable to open the log-normal distribution parameter csv', 'Open Error')
%                 return
%             end
%         end
        [nrow , ncol] = size(exp_distr_para);
        if nrow == NTAZ
            if ncol == 2
                exp_distr_para_mu = exp_distr_para(:,1);
                exp_distr_para_sigma = exp_distr_para(:,2);
            elseif ncol == 3 
                exp_distr_para = sortrows(exp_distr_para , 1);
                exp_distr_para = exp_distr_para(: , 2:3);
                exp_distr_para_mu = exp_distr_para(:,1);
                exp_distr_para_sigma = exp_distr_para(:,2);
            elseif ncol < 2 | ncol > 3
                errordlg('Invalid data format', 'Input Error')
                return
            end
        else
            errordlg('Input Num of distribution parameter data NOT equal Num of TAZ' , 'Input Error')
            return
        end
        
        %检查数据，并生成分布信息的大cell数组
        for ki = 1 : NTAZ
            expenditure_distr{ki, 1} = ki;
            crt_ln_mu = exp_distr_para_mu(ki);
            crt_ln_sigma = exp_distr_para_sigma(ki);
            if crt_ln_sigma < 0
                errordlg('Sigma value must be non-negative', 'Input Error')
                return
            end
            crt_ln_pd = makedist('Lognormal', 'mu', crt_ln_mu, 'sigma', crt_ln_sigma);
            expenditure_distr{ki, 2} = crt_ln_pd;
            trial = random(crt_ln_pd, 200, 1);
            crt_x = linspace(max(0, mean(trial) - 3.2*std(trial)), ...
                mean(trial) + 3.2*std(trial), 200);
            expenditure_distr{ki, 3} = crt_x;
            expenditure_distr{ki, 4} = pdf(crt_ln_pd, crt_x);
            expenditure_distr{ki, 5} = 3;
            expenditure_distr{ki, 6} = [crt_ln_mu, crt_ln_sigma];
        end
        
    elseif isempty(choice2)
        return
    end
    
    if size(expenditure_distr, 1) == NTAZ;
        handles.expenditure_distr = expenditure_distr;
        guidata(hObject,handles);
        msgbox('Finished.')
    else
        errordlg('Input Num of expenditure distribution data do NOT equal Num of TAZ' , 'Input Error')
        return
    end
    
    
elseif isequal(choice1 , 'Check distribution parameter')
    if ~isfield(handles , 'expenditure_distr')
        warndlg('There is NO valid expenditure distribution input' ,'Expenditure Distribution Data')
        return
    else
        expenditure_distr = handles.expenditure_distr;
        distr_type = [];
        for taz_i = 1 : NTAZ
            distr_par(taz_i, :) = [taz_i, expenditure_distr{taz_i, 6}];
            if expenditure_distr{taz_i, 5} == 2
                distr_type = strvcat(distr_type, '     normal');
            elseif expenditure_distr{taz_i, 5} == 3
                distr_type = strvcat(distr_type, '     log-normal');
            elseif expenditure_distr{taz_i, 5} == 1
                distr_type = strvcat(distr_type, '     kernel density');
            end
        end
        show = strvcat('TAZ     mu     sigma     type' , strcat(num2str(distr_par), distr_type));
        msgbox(show)
    end
    
    
end


% --------------------------------------------------------------------
function den_plot_expenditure_Callback(hObject, eventdata, handles)
% hObject    handle to den_plot_expenditure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isfield(handles , 'expenditure_distr')
    warndlg('There is NO valid expenditure distribution input' ,'Expenditure Distribution Data')
    return
else
    expenditure_distr = handles.expenditure_distr;
    % 关闭除主fig之外的所有fig
    all_figs = findall(0, 'type', 'figure');
    for af_i = 1 : length(all_figs)
        crt_fig_in_all_figs = all_figs(af_i);
        if ~isequal(get(crt_fig_in_all_figs, 'tag') , 'figure1')
            delete(crt_fig_in_all_figs)
        end
    end
    
    expenditure_distr_fig = figure('Name' , 'Probability Density Function of Expenditure Distribution' , 'NumberTitle' , 'off',...
        'Unit', 'normalized', 'Position', [.2 .1 .6 .8], 'Color', 'w', 'Toolbar', 'none', 'Menubar', 'none');
    taz_id_str = uicontrol('parent', expenditure_distr_fig, 'style', 'text', 'string', 'TAZ ID: ', 'unit', 'normalized', ...
        'position',[.2, .9, .1, .06], 'fontsize', 18, 'fontweight', 'bold', 'backgroundcolor', 'w');
    taz_id_input = uicontrol('parent', expenditure_distr_fig, 'style', 'edit', 'string', '1 ', 'unit', 'normalized', ...
        'position',[.32, .92, .15, .04], 'fontsize', 18, 'fontweight', 'bold', 'callback', @expenditure_distr_fig_taz_id);
    %初始化均显示为TAZ=1的情况
    type_taz1 = expenditure_distr{1, 5};
    switch type_taz1
        case 1
            typestr_taz1 = 'kernel density';
        case 2
            typestr_taz1 = 'normal';
        case 3
            typestr_taz1 = 'log-normal';
    end
    x_taz1 = expenditure_distr{1, 3};
    f_taz1 = expenditure_distr{1, 4};
    distr_type_str = uicontrol('parent', expenditure_distr_fig, 'style', 'text', 'string', ['Distribution: ', typestr_taz1], 'unit', 'normalized', ...
        'position',[.5, .9, .3, .06], 'fontsize', 18, 'fontweight', 'bold', 'backgroundcolor', 'w', 'userdata', 1);
    distr_axes = axes('parent', expenditure_distr_fig, 'unit', 'normalized', 'position', [.125, .1, .8, .775]);
    distr_plot = plot(x_taz1, f_taz1);
    xlabel('Expenditure')
    ylabel('Probability Density')
    crt_xlim = get(gca, 'xlim');
    xlim([0 , crt_xlim(2)])
    set(gca, 'fontsize', 15)
end

%画各TAZ的消费额分布时，调节TAZ编号时的callback
function expenditure_distr_fig_taz_id(hObject, eventdata, handles)
main_gui_h = findall(0 , 'type', 'figure', 'tag', 'figure1');
handles = guidata(main_gui_h);
expenditure_distr = handles.expenditure_distr;
NTAZ = handles.NTAZ;
expenditure_distr_fig = findall(0, 'type', 'figure','name','Probability Density Function of Expenditure Distribution');
taz_id_input = findall(expenditure_distr_fig, 'type', 'uicontrol', 'style', 'edit');
distr_type_str = findall(expenditure_distr_fig, 'type', 'uicontrol', 'style', 'text', 'userdata', 1);
distr_axes  = findall(expenditure_distr_fig, 'type', 'axes', 'position', [.125, .1, .8, .775]);
crtTAZ = get(taz_id_input, 'string');
try 
    crtTAZ = str2num(crtTAZ);
catch
    errordlg('Invalid input', 'Input Error')
    return
end
if round(crtTAZ)~=crtTAZ | crtTAZ<1 | crtTAZ>NTAZ
    errordlg('Invalid input', 'Input Error')
    return
elseif isempty(crtTAZ)
    set(distr_type_str, 'string',  '');
    cla(distr_axes);
else
    type_crtTAZ = expenditure_distr{crtTAZ, 5};
    switch type_crtTAZ
        case 1
            typestr_crtTAZ = 'kernel density';
        case 2
            typestr_crtTAZ = 'normal';
        case 3
            typestr_crtTAZ = 'log-normal';
    end
    x_crtTAZ = expenditure_distr{crtTAZ, 3};
    f_crtTAZ = expenditure_distr{crtTAZ, 4};
    
    set(distr_type_str, 'string', ['Distribution: ', typestr_crtTAZ]);
    cla(distr_axes);
    distr_plot = plot(x_crtTAZ, f_crtTAZ);
    xlabel('Expenditure')
    ylabel('Probability Density')
    crt_xlim = get(gca, 'xlim');
    xlim([0 , crt_xlim(2)])
    set(gca, 'fontsize', 15)
end


% --------------------------------------------------------------------
function Untitled_32_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Spatial_behavior_sim_Callback(hObject, eventdata, handles)
% hObject    handle to Spatial_behavior_sim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Sim_Callback(hObject, eventdata, handles)


% --------------------------------------------------------------------
function consume_behavior_sim_Callback(hObject, eventdata, handles)
% hObject    handle to consume_behavior_sim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tic;
hw = waitbar(0 , 'Prepare and Check Data. Please Wait.','Name', 'Consuming Simulation Process');
if ~isfield(handles, 'Sim_result')
    errordlg('You must firstly simulate spatial behavior.', 'Error')
    close(hw)
    return
else
    result_withoutMoney = handles.Sim_result;
end
if ~isfield(handles, 'NTAZ')
    errordlg('No Num. of TAZ data', 'Error')
    close(hw)
    return
else
    NTAZ = handles.NTAZ;
end
if ~isfield( handles, 'consume_prob')
    errordlg('You must firstly have consuming probability data.', 'Error')
    close(hw)
    return
else
     consume_prob = handles. consume_prob;
end
if ~isfield(handles, 'expenditure_distr')
    errordlg('You must firstly have expenditure distribution data.', 'Error')
    close(hw)
    return
else
    expenditure_distr = handles.expenditure_distr;
end
waitbar(0 , hw , 'Begin Consuming Simulation')
toc_sim_start = toc;
for i = 1 : length(result_withoutMoney)
    crt_result_withoutMoney = result_withoutMoney(i).taz;
    [ crt_TAZMoneyResult ] = MoneySim_GUI( crt_result_withoutMoney, consume_prob, expenditure_distr, NTAZ );
    TAZMoneyResult(i).taz = crt_TAZMoneyResult;
    process = i / length(result_withoutMoney)
    waitbar(process , hw , ['Consuming Simulation Process: ', num2str(i), ' of ', ...
        num2str(length(result_withoutMoney)), ', ', num2str(round(process*100)) , '%'])
end
toc_sim_end = toc;
% finish_str = strvcat('Consuming Simulatoin Finished. Press ''Enter'' to quit.',...
%     ['Total prcessing elapsed time(s): ', num2str(toc_sim_end), '.  Single-time-simulation elapsed time(s): ', num2str((toc_sim_end - toc_sim_start) / length(result_withoutMoney))]);
waitbar(1 , hw , 'Consuming Simulatoin Finished');
handles.Sim_result_money = TAZMoneyResult;
guidata(hObject, handles)
close(hw)
str = strvcat('Consuming Simulatoin Finished', ['Total prcessing elapsed time(s): ', num2str(toc_sim_end)],...
    ['Single-time-simulation elapsed time(s): ', num2str((toc_sim_end - toc_sim_start) / length(result_withoutMoney))])
msgbox(str, 'Finished')


% --------------------------------------------------------------------
function def_time_var_Callback(hObject, eventdata, handles)
% hObject    handle to def_time_var (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isfield(handles, 'adv_var')
    errordlg('You should firstly define variables in advance mode.')
    return
else
    adv_var = handles.adv_var;
end
%-------------------%界面%-------------------%
% 关闭除主fig之外的所有fig
all_figs = findall(0, 'type', 'figure');
for af_i = 1 : length(all_figs)
    crt_fig_in_all_figs = all_figs(af_i);
    if ~isequal(get(crt_fig_in_all_figs, 'tag') , 'figure1')
        delete(crt_fig_in_all_figs)
    end
end
instruction_str1 = ['1. In order to include specific time as explanatory variables, ',...
    'you have to firstly define a time interval which you interest in, ',...
    'then it will be set into the model and simulation by interacting with another attribute variable, ',...
    'which may be already defined or newly created just for interaction with time.'];
instruction_str2 = ['2. When seting time interval, proper fomart is HHMM, first 2 digits refer to hour, ',...
    'last 2 digits refer to minute, ', 'you can specify both start time and end time, if you leave the start time ',...
    'to be empty, then the time interval would be any time before the end time, or if you leave the end time ',...
    'to be empty, then the time interval would be any time after the start time.'];
instruction_str3 = ['3. In all time-included models and simulations, the basic unit is minute.'];
instruction_str123 = msgbox(strvcat('Instructions: ', instruction_str1, instruction_str2, instruction_str3), 'Instructions');
waitfor(instruction_str123);


time_var_def = figure('Name' , 'Time Variable Definition' , 'NumberTitle' , 'off',...
    'Position', [650 350 500 400], 'Color', 'w', 'Unit', 'normalized',...
    'Menubar', 'none');
time_var_list = uicontrol('Parent', time_var_def, 'style', 'listbox', 'unit', 'normalized',...
    'position', [.05 .1 .65 .8]);
if isfield(handles, 'time_var')
    time_var = handles.time_var;
    set(time_var_def, 'userdata', time_var);
    crt_time_var_list_compound = cell(0);
    for i = 1 : length(time_var)
        %下面要干的事是：如果发现handles里有已经定义好的time_var，把它一个一个读入，在list中显示，比较麻烦，调用以前写的add模块中追加的东西
        %所以应该是crt的，都成了new前缀了
        new_time_var = time_var{i};
        if isempty(new_time_var.start_time)
            new_time_var_start_time_disp = ' ';
        else
            start_hh = floor(new_time_var.start_time / 100);
            start_mm = new_time_var.start_time - 100*floor(new_time_var.start_time / 100);
            start_hh = num2str(start_hh);
            if length(start_hh) == 1
                start_hh = ['0', start_hh];
            end
            start_mm = num2str(start_mm);
            if length(start_mm) == 1
                start_mm = ['0', start_mm];
            end
            new_time_var_start_time_disp = [start_hh, ':', start_mm];
        end
        if isempty(new_time_var.end_time)
            new_time_var_end_time_disp = ' ';
        else
            end_hh = num2str(   floor(new_time_var.end_time / 100)   );
            end_mm = num2str(   new_time_var.end_time - 100*floor(new_time_var.end_time / 100)   );
            if length(end_hh) == 1
                end_hh = ['0', end_hh];
            end
            if length(end_mm) == 1
                end_mm = ['0', end_mm];
            end
            new_time_var_end_time_disp = [end_hh, ':', end_mm];
        end
        new_str = [new_time_var.name, ':  [', new_time_var_start_time_disp, ' ~ ', new_time_var_end_time_disp, '] * ', ...
            new_time_var.interaction_var_name];
        crt_time_var_list_compound{end+1} = new_str;
    end
    set(time_var_list, 'string', crt_time_var_list_compound)
end
time_var_add = uicontrol('Parent', time_var_def, 'style', 'pushbutton', 'unit', 'normalized', ...
    'position', [.75 .82 .2 .08],'callback', @time_var_add_callback, 'String', 'Add', 'Fontsize', 12);
time_var_check = uicontrol('Parent', time_var_def, 'style', 'pushbutton', 'unit', 'normalized', ...
    'position', [.75 .72 .2 .08],'callback', @time_var_check_callback, 'String', 'Check', 'Fontsize', 12);
time_var_edit_time = uicontrol('Parent', time_var_def, 'style', 'pushbutton', 'unit', 'normalized',...
    'position', [.75 .62 .2 .08],'callback', @time_var_edit_time_callback, 'String', 'Edit Time', 'Fontsize', 12);
time_var_delete = uicontrol('Parent', time_var_def, 'style', 'pushbutton', 'unit', 'normalized',...
    'position', [.75 .52 .2 .08],'callback', @time_var_delete_callback, 'String', 'Delete', 'Fontsize', 12);
if isempty(get(time_var_list, 'string'))
    set(time_var_check, 'enable', 'off');
    set(time_var_delete, 'enable', 'off');
    set(time_var_edit_time, 'enable', 'off');
else
    set(time_var_check, 'enable', 'on');
    set(time_var_delete, 'enable', 'on');
    set(time_var_edit_time, 'enable', 'on');
end
% time_var_all = uicontrol('Parent', time_var_def, 'style', 'pushbutton', 'unit', 'normalized',...
%     'position', [.75 .42 .2 .08],'callback', @time_var_all_callback, 'String', 'Use All', 'Fontsize', 12);
% time_var_none = uicontrol('Parent', time_var_def, 'style', 'pushbutton', 'unit', 'normalized', ...
%     'position', [.75 .32 .2 .08],'callback', @time_var_none_callback, 'String', 'Use None', 'Fontsize', 12);
time_var_ok = uicontrol('Parent', time_var_def, 'style', 'pushbutton', 'unit', 'normalized',...
    'position', [.75 .1 .2 .1],'callback', @time_var_ok_callback, 'String', 'OK', 'Fontsize', 12);

%-------------------%各种callback%-------------------%
function time_var_ok_callback(hObject, callbackdata)
crt_gui_h = findall(0, 'type', 'figure', 'name', 'Time Variable Definition');
time_var_list = findall(crt_gui_h, 'type' , 'uicontrol', 'style', 'listbox');
main_fig = findall(0, 'type', 'figure', 'tag', 'figure1');
handles = guidata(main_fig);
if ~isempty(get(crt_gui_h, 'userdata'))
    time_var = get(crt_gui_h, 'userdata');
    if length(time_var) ~= length(get(time_var_list, 'string'))
        errordlg('Something strange happen, see error 5325', 'Error')
        return
    end
    handles.time_var = time_var;
    guidata(main_fig, handles);
else
    %有可能都删除光了
    if isfield(handles, 'time_var')
        handles = rmfield(handles, 'time_var');
    end
    guidata(main_fig, handles);
end
close(crt_gui_h)

function time_var_edit_time_callback(hObject, callbackdata)
crt_gui_h = findall(0, 'type', 'figure', 'name', 'Time Variable Definition');
time_var_list = findall(crt_gui_h, 'type' , 'uicontrol', 'style', 'listbox');
time_var_check = findall(crt_gui_h, 'type' , 'uicontrol', 'style', 'pushbutton', 'string', 'Check');
time_var_delete = findall(crt_gui_h, 'type' , 'uicontrol', 'style', 'pushbutton', 'string', 'Delete');
time_var_edit_time = findall(crt_gui_h, 'type' , 'uicontrol', 'style', 'pushbutton', 'string', 'Edit Time');
crt_selection = get(time_var_list, 'value');
all_string = get(time_var_list, 'string');
crt_name = regexp(all_string{crt_selection}, '^(.+?): ' ,'tokens');
crt_name = crt_name{:}{:};
time_var = get(crt_gui_h, 'userdata');
if ~isequal(crt_name, time_var{crt_selection}.name)
    errordlg('Something strange happen, see error 5324','Error')
    return
else
    prompt = {'Enter the new start time (Format: HHMM):','Enter the new end time (Format: HHMM):'};
    dlg_title = 'New Time';
    num_lines = 1;
    default_interval = {'0000','2400'};
    time_interval_def = inputdlgWC(prompt, dlg_title, num_lines, default_interval);
    if isempty(time_interval_def)
        return
    end
    try
        start_time = str2num(time_interval_def{1});
        end_time = str2num(time_interval_def{2});
    catch
        errordlg('Invalid input', 'Error')
        return
    end
    if isempty(start_time) & isempty(end_time)
        return
    elseif ~isempty(start_time) & (start_time<0 | start_time> 2400 | ~isequal(start_time, round(start_time)))
        errordlg('Invalid start time input', 'Error')
        return
    elseif ~isempty(end_time) & (end_time<0 | end_time> 2400 | ~isequal(end_time, round(end_time)))
        errordlg('Invalid end time input', 'Error')
        return
    else
        time_var{crt_selection}.start_time = start_time;
        time_var{crt_selection}.end_time = end_time;
        set(crt_gui_h, 'userdata', time_var);
        %以下是修改后的显示
        if isempty(time_var{crt_selection}.start_time)
            new_time_var_start_time_disp = ' ';
        else
            start_hh = floor(time_var{crt_selection}.start_time / 100);
            start_mm = time_var{crt_selection}.start_time - 100*floor(time_var{crt_selection}.start_time / 100);
            start_hh = num2str(start_hh);
            if length(start_hh) == 1
                start_hh = ['0', start_hh];
            end
            start_mm = num2str(start_mm);
            if length(start_mm) == 1
                start_mm = ['0', start_mm];
            end
            new_time_var_start_time_disp = [start_hh, ':', start_mm];
        end
        if isempty(time_var{crt_selection}.end_time)
            new_time_var_end_time_disp = ' ';
        else
            end_hh = num2str(   floor(time_var{crt_selection}.end_time / 100)   );
            end_mm = num2str(   time_var{crt_selection}.end_time - 100*floor(time_var{crt_selection}.end_time / 100)   );
            if length(end_hh) == 1
                end_hh = ['0', end_hh];
            end
            if length(end_mm) == 1
                end_mm = ['0', end_mm];
            end
            new_time_var_end_time_disp = [end_hh, ':', end_mm];
        end
        new_str = [time_var{crt_selection}.name, ':  [', new_time_var_start_time_disp, ' ~ ', new_time_var_end_time_disp, '] * ', ...
            time_var{crt_selection}.interaction_var_name];
        all_string{crt_selection} = new_str;
        set(time_var_list, 'string', all_string, 'value', crt_selection);
        
    end
end


function time_var_delete_callback(hObject, callbackdata)
crt_gui_h = findall(0, 'type', 'figure', 'name', 'Time Variable Definition');
time_var_list = findall(crt_gui_h, 'type' , 'uicontrol', 'style', 'listbox');
time_var_check = findall(crt_gui_h, 'type' , 'uicontrol', 'style', 'pushbutton', 'string', 'Check');
time_var_delete = findall(crt_gui_h, 'type' , 'uicontrol', 'style', 'pushbutton', 'string', 'Delete');
time_var_edit_time = findall(crt_gui_h, 'type' , 'uicontrol', 'style', 'pushbutton', 'string', 'Edit Time');
crt_selection = get(time_var_list, 'value');
all_string = get(time_var_list, 'string');
crt_name = regexp(all_string{crt_selection}, '^(.+?): ' ,'tokens');
crt_name = crt_name{:}{:};
time_var = get(crt_gui_h, 'userdata');
if ~isequal(crt_name, time_var{crt_selection}.name)
    errordlg('Something strange happen, see error 5324','Error')
    return
else
    confirm = questdlg(['Are you sure to delete this variable: ', crt_name], 'Delete', 'Yes', 'No', 'Yes');
    if isequal(confirm, 'No')
        return
    elseif isequal(confirm, 'Yes')
        time_var(crt_selection) = [];
        set(crt_gui_h, 'userdata', time_var);
        all_string(crt_selection) = [];
        set(time_var_list, 'string', all_string, 'value', 1);
        if isempty(time_var)
            set(time_var_check, 'enable', 'off');
            set(time_var_delete, 'enable', 'off');
            set(time_var_edit_time, 'enable', 'off');
        end
    else
        return
    end
end



function time_var_check_callback(hObject, callbackdata)
crt_gui_h = findall(0, 'type', 'figure', 'name', 'Time Variable Definition');
time_var_list = findall(crt_gui_h, 'type' , 'uicontrol', 'style', 'listbox');
crt_selection = get(time_var_list, 'value');
all_string = get(time_var_list, 'string');
crt_name = regexp(all_string{crt_selection}, '^(.+?): ' ,'tokens');
crt_name = crt_name{:}{:};
time_var = get(crt_gui_h, 'userdata');
if ~isequal(crt_name, time_var{crt_selection}.name)
    errordlg('Something strange happen, see error 5321','Error')
    return
else
    crt_check_var = time_var{crt_selection};
end
crt_check_var_name = crt_check_var.name;
name_disp = ['Name: ', crt_check_var_name];
crt_check_var_origin = crt_check_var.origin;
new_time_var_start_time = crt_check_var.start_time;     %之所以用new，还是一样想用以前写过的程序
new_time_var_end_time = crt_check_var.end_time;
if isempty(new_time_var_start_time)
    new_time_var_start_time_disp = ' ';
else
    start_hh = floor(new_time_var_start_time / 100);
    start_mm = new_time_var_start_time - 100*floor(new_time_var_start_time / 100);
    start_hh = num2str(start_hh);
    if length(start_hh) == 1
        start_hh = ['0', start_hh];
    end
    start_mm = num2str(start_mm);
    if length(start_mm) == 1
        start_mm = ['0', start_mm];
    end
    new_time_var_start_time_disp = [start_hh, ':', start_mm];
end
if isempty(new_time_var_end_time)
    new_time_var_end_time_disp = ' ';
else
    end_hh = num2str(   floor(new_time_var_end_time / 100)   );
    end_mm = num2str(   new_time_var_end_time - 100*floor(new_time_var_end_time / 100)   );
    if length(end_hh) == 1
        end_hh = ['0', end_hh];
    end
    if length(end_mm) == 1
        end_mm = ['0', end_mm];
    end
    new_time_var_end_time_disp = [end_hh, ':', end_mm];
end
time_interval_disp = ['Time Interval: ', new_time_var_start_time_disp , ' ~ ', new_time_var_end_time_disp]; 
crt_check_var_interactoin = crt_check_var.interaction_var_name;
interaction_disp = ['Interaction With: ', crt_check_var_interactoin];
if crt_check_var_origin == 1
    other_str = ['You can check ''',crt_check_var_interactoin, ''' in other module'];
    msgbox(strvcat(name_disp, time_interval_disp, interaction_disp, other_str), 'Check');
else
    other_str = ['''', crt_check_var_interactoin, ''' is just created only for interaction, click ''OK'' to check it.'];
    go_on = msgbox(strvcat(name_disp, time_interval_disp, interaction_disp, other_str), 'Check');
    waitfor(go_on);
    crt_X_created_interaction_var = crt_check_var.X_created_interaction_var;
    msgbox(strvcat(['TAZ   Value'], num2str([[1:length(crt_X_created_interaction_var)]', ...
        crt_X_created_interaction_var])), 'Check')
end



function time_var_add_callback(hObject, callbackdata)
crt_gui_h = findall(0, 'type', 'figure', 'name', 'Time Variable Definition');
time_var_list = findall(crt_gui_h, 'type' , 'uicontrol', 'style', 'listbox');
time_var_check = findall(crt_gui_h, 'type' , 'uicontrol', 'style', 'pushbutton', 'string', 'Check');
time_var_delete = findall(crt_gui_h, 'type' , 'uicontrol', 'style', 'pushbutton', 'string', 'Delete');
time_var_edit_time = findall(crt_gui_h, 'type' , 'uicontrol', 'style', 'pushbutton', 'string', 'Edit Time');
crt_time_var_list_compound = get(time_var_list, 'string');      %_compound是指显示的str并不只是变量名，需要再提取
crt_time_var_names = cell(0);
crt_interaction_var_names = cell(0);
if length(crt_time_var_list_compound) >= 1
    for i = 1 : length(crt_time_var_list_compound)
        crt_string_compound = crt_time_var_list_compound{i};
        crt_name = regexp(crt_string_compound, '^(.+?): ' ,'tokens');
        crt_time_var_names{i, 1} = crt_name{:}{:};
        crt_interaction_name = regexp(crt_string_compound, '^.+?: .+? * (.+?)$' ,'tokens');
        crt_interaction_var_names{i, 1} = crt_interaction_name{:}{:};
    end
end

new_time_var_name = inputdlgWC('Please input the name of this new time-related variable',...
    'Name', 1, {'time1'});
if isempty(new_time_var_name) | isempty(new_time_var_name{:})
    return
else
    try
        new_time_var_name = cell2mat(new_time_var_name);
    catch
        errordlg('Invalid input', 'Error')
        return
    end
end
if sum(ismember(crt_time_var_names, new_time_var_name)) ~= 0
    errordlg('This name has been used, change a new name', 'Error')
    return
end
if isempty(new_time_var_name) | (~isempty(new_time_var_name) & ~isletter(new_time_var_name(1)))
    errordlg('The variable name must start with a letter', 'Error')
    return
end
new_time_var.name = new_time_var_name;

prompt = {'Enter the start time (Format: HHMM):','Enter the end time (Format: HHMM):'};
dlg_title = 'Time';
num_lines = 1;
default_interval = {'0000','2400'};
time_interval_def = inputdlgWC(prompt, dlg_title, num_lines, default_interval);
if isempty(time_interval_def) 
    return
end
try 
    start_time = str2num(time_interval_def{1});
    end_time = str2num(time_interval_def{2});
catch
    errordlg('Invalid input', 'Error')
    return
end
if isempty(start_time) & isempty(end_time)
    return
elseif ~isempty(start_time) & (start_time<0 | start_time> 2400 | ~isequal(start_time, round(start_time)))
    errordlg('Invalid start time input', 'Error')
    return
elseif ~isempty(end_time) & (end_time<0 | end_time> 2400 | ~isequal(end_time, round(end_time)))
    errordlg('Invalid end time input', 'Error')
    return
else
    new_time_var.start_time = start_time;
    new_time_var.end_time = end_time;
end

if exist('new_time_var', 'var') & isfield(new_time_var, 'start_time')
    choice = questdlg('How do you set the interaction variable?', 'Interaction', 'Use Already Defined Varaible',...
        'Create a New Variable Only for Interaction', 'Use Already Defined Varaible');
    main_fig = findall(0, 'type', 'figure', 'tag', 'figure1');
    handles = guidata(main_fig);
    if isequal(choice, 'Use Already Defined Varaible')
        %来自已定义的变量，这些变量在模型中也单独出现
        new_time_var.origin = 1;
        if ~isfield(handles, 'adv_var')
            errordlg('You should firstly define variables in advance mode.')
            return
        else
            adv_var = handles.adv_var;
        end
        [temp_selection, temp_ok] = listdlg('PromptString','Select interaction variable:',...
            'SelectionMode','single', 'ListString',adv_var);
        if temp_ok == 0
            return
        else
            choosen_var = adv_var{temp_selection};
            interaction_var_name = choosen_var;
        end
        new_time_var.interaction_var_name = interaction_var_name;
        
    elseif isequal(choice, 'Create a New Variable Only for Interaction')
        %来自新定义的变量，这些变量只交互，不在模型中出现
        if ~isfield(handles, 'NTAZ')
            errordlg('You should fisrtly input Num of TAZ', 'Error');
            return
        else
            NTAZ = handles.NTAZ;
        end
        interaction_var_name = inputdlgWC('Please input the name of this new created variable for interacting with time',...
            'Name', 1, {'interaction1'});
        if isempty(interaction_var_name) | isempty(interaction_var_name{:})
            return
        else
            try
                interaction_var_name = cell2mat(interaction_var_name);
            catch
                errordlg('Invalid input', 'Error')
                return
            end
        end
        if isempty(interaction_var_name) | (~isempty(interaction_var_name) & ~isletter(interaction_var_name(1)))
            errordlg('The variable name must start with a letter', 'Error')
            return
        end
%         if sum(ismember(crt_interaction_var_names, interaction_var_name)) ~= 0
%             errordlg('This name has been used, change a new name', 'Error')
%             return
%         end
        new_time_var.interaction_var_name = interaction_var_name;
        new_time_var.origin = 2;
        choice2 = questdlg('Please choose the way of creating this variable' , 'Input',...
            'Load CSV File'  ,'Directly Type or Copy / Paste', 'Load CSV File');
        % 2016-3-8改：允许输入NTAZ或NTAZ+1的值，不管是直接输还是导CSV，相应调整Logit估计程序，如果NTAZ，就把回家设为0
        %否则，就直接使用，这样的目的是考虑时间变量中，有可能想单纯想回家的虚拟变量模式
        switch choice2
            case 'Directly Type or Copy / Paste'
                str = ['Please enter space(/comma)-separated values in the order: from TAZ_1 to TAZ_, you may add another value at last for go home.'...
                    , num2str(NTAZ)];
                same_pasted_value = inputdlgWC({str, 'OR please enter the same value for All TAZS'} , 'Input', [1 80 ; 1 45]);
                pasted_value = same_pasted_value{1};
                same_value = same_pasted_value{2};
                if length(pasted_value) ~= 0
                    try
                        pasted_value = str2num(pasted_value);
                    catch
                        errordlg('Invalid Input', 'Input Error')
                        return
                    end
                    if length(pasted_value) == NTAZ | length(pasted_value) == NTAZ+1
                        created_interaction_var = pasted_value';
                        new_time_var.X_created_interaction_var = created_interaction_var;
                    else
                        errordlg('Input Num of values do NOT equal Num of TAZ or Num of TAZ plus 1 (Go Home)' , 'Input')
                        return
                    end
                elseif length(same_value) ~= 0
                    try
                        same_value = str2num(same_value);
                    catch
                        errordlg('Invalid Input', 'Input Error')
                        return
                    end
                    created_interaction_var = same_value * ones(NTAZ, 1);
                    new_time_var.X_created_interaction_var = created_interaction_var;
                end
            case 'Load CSV File'
                [fname , pname] = uigetfile('*.csv' , 'Open the Data CSV');
                if isequal(fname, 0) | isequal(pname, 0)
                    return
                end
                fullname = strcat(pname,fname);
                %两列，一列TAZID，二列Value
                varnames = {'TAZID', 'Value'};
                varstring = {'TAZ ID', 'Interactive Variable'};
                [created_interaction_var_csv, flag] = open_csv(fullname, 2, varnames, varstring);
                if flag == 0
                    return
                end
%                 try
%                     created_interaction_var_csv = csvread(fullname);
%                 catch
%                     try 
%                         created_interaction_var_csv = csvread(fullname, 1, 0);
%                     catch
%                         errordlg('Fail to open the csv file', 'Open Error')
%                         return
%                     end
%                 end
                [nrow , ncol] = size(created_interaction_var_csv);
                if  nrow == NTAZ+1 & ~isequal(created_interaction_var_csv(:,end), [zeros(NTAZ,1);1])
                    errordlg(['This variable has set an additional value for go-home alternative, ',...
                        'but it is not a dummy variable.'], 'Error')
                    return
                end
                if nrow == NTAZ | nrow == NTAZ+1
                    if ncol == 1
                        new_time_var.X_created_interaction_var = created_interaction_var_csv;
                    elseif ncol == 2
                        created_interaction_var_csv = sortrows(created_interaction_var_csv , 1);
                        created_interaction_var_csv = created_interaction_var_csv(: , 2);
                        new_time_var.X_created_interaction_var = created_interaction_var_csv;
                    else
                        errordlg('The input csv file should contain no more than 2 columns of data', 'Input Error')
                        return
                    end
                else
                    errordlg('Input Num of values do NOT equal Num of TAZ or Num of TAZ plus 1 (Go Home)' , 'Input Error')
                    return
                end
        end
    else
        return
    end
    %将新定义的变量写入定义time_var界面的userdata中
    if isempty(get(crt_gui_h, 'userdata'))
        time_var{1} = new_time_var;
    else
        time_var = get(crt_gui_h, 'userdata');
        time_var{end+1} = new_time_var;
    end
    set(crt_gui_h, 'userdata', time_var);
    if isempty(new_time_var.start_time)
        new_time_var_start_time_disp = ' ';
    else
        start_hh = floor(new_time_var.start_time / 100);
        start_mm = new_time_var.start_time - 100*floor(new_time_var.start_time / 100);
        start_hh = num2str(start_hh);
        if length(start_hh) == 1
            start_hh = ['0', start_hh];
        end
        start_mm = num2str(start_mm);
        if length(start_mm) == 1
            start_mm = ['0', start_mm];
        end
        new_time_var_start_time_disp = [start_hh, ':', start_mm];
    end
    if isempty(new_time_var.end_time)
        new_time_var_end_time_disp = ' ';
    else
        end_hh = num2str(   floor(new_time_var.end_time / 100)   );
        end_mm = num2str(   new_time_var.end_time - 100*floor(new_time_var.end_time / 100)   );
        if length(end_hh) == 1
            end_hh = ['0', end_hh];
        end
        if length(end_mm) == 1
            end_mm = ['0', end_mm];
        end
        new_time_var_end_time_disp = [end_hh, ':', end_mm];
    end
    new_str = [new_time_var.name, ':  [', new_time_var_start_time_disp, ' ~ ', new_time_var_end_time_disp, '] * ', ...
        new_time_var.interaction_var_name];
    crt_time_var_list_compound{end+1} = new_str;
    set(time_var_list, 'string', crt_time_var_list_compound, 'value', length(crt_time_var_list_compound));
end
if isempty(get(time_var_list, 'string'))
    set(time_var_check, 'enable', 'off');
    set(time_var_delete, 'enable', 'off');
    set(time_var_edit_time, 'enable', 'off');
else
    set(time_var_check, 'enable', 'on');
    set(time_var_delete, 'enable', 'on');
    set(time_var_edit_time, 'enable', 'on');
end


% --------------------------------------------------------------------
function path_data_wide_form_Callback(hObject, eventdata, handles)
% hObject    handle to path_data_wide_form (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[fname , pname]=uigetfile('*.csv' , 'Open the Path CSV');
if isequal(fname, 0) | isequal(pname, 0)
    return
end
fullname = strcat(pname,fname);
try 
    path_rawdata = csvread(fullname);
catch
    try 
        path_rawdata = csvread(fullname, 1, 0);
        NPath = size(path_rawdata, 1);
    catch
        msgbox('Unable to open the Path CSV')
        return
    end
end
handles.path_rawdata = path_rawdata;
guidata(hObject, handles);
msgbox(['Successfully import ', num2str(NPath) ' path(s)']);


% --------------------------------------------------------------------
function path_data_long_form_Callback(hObject, eventdata, handles)
% hObject    handle to path_data_long_form (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% str = strvcat('Instructions: ', '1. The first colume should be IDs of consumers.', ...
%     '2. The second column should be IDs of entraces or TAZs, which constitue the paths.', ...
%     '3. There could be more columns recording other informations such as stay time, but they will be used here.',...
%     '4. For each consumer, the first path node should always be the entrance.');
%
str= strvcat('Instructions: ', ['1. Please firstly load a csv file containg entrace ID for each individual, '...
    'then load a csv file contraing a serie of TAZ IDs in the path for each individual.'],...
    '2. For entrance information csv, default variable names are ''IndividualID'' and ''EntranceID''.',...
    '3. For TAZ-path information csv, default variable names are ''IndividualID'' and ''TAZID''.');
instr = msgbox(str, 'Instractions');
waitfor(instr)

[fname , pname]=uigetfile('*.csv' , 'Open the Entrance Information CSV');
if isequal(fname, 0) | isequal(pname, 0)
    return
end
fullname = strcat(pname,fname);

table_data = importdata(fullname);
if isfield(table_data, 'colheaders')
    colheaders = table_data.colheaders;
    IndID_index = find(ismember(colheaders, 'IndividualID'));
    if isempty(IndID_index)
        %         errordlg('This csv contains the variable header, but none or more than 1 ''IndividualID'' is found.', 'Error');
        %         return
        IndID_index = listdlg('PromptString','Select Individual ID Variable:','SelectionMode','single',...
            'ListString',colheaders);
        if isempty(IndID_index)
            return
        end
    end
    EntID_index = find(ismember(colheaders, 'EntranceID'));
    if isempty(EntID_index)
        %         errordlg('This csv contains the variable header, but none or more than 1 ''EntranceID'' is not found.', 'Error');
        %         return
        EntID_index = listdlg('PromptString','Select Entrance ID Variable:','SelectionMode','single',...
            'ListString',colheaders);
        if isempty(EntID_index)
            return
        end
    end
    try
        entrance_data = csvread(fullname, 1, 0);
    catch
        msgbox('Unable to open the Entrance Information CSV')
        return
    end
    entrance_data  = entrance_data(:, [IndID_index(1), EntID_index(1)]);
else
    try
        entrance_data = csvread(fullname);
        entrance_data = entrance_data(:, 1:2);
    catch
        msgbox('Unable to open the Entrance Information CSV')
        return
    end
end



[fname , pname]=uigetfile('*.csv' , 'Open the TAZ-Path Information CSV');
if isequal(fname, 0) | isequal(pname, 0)
    return
end
fullname = strcat(pname,fname);

table_data = importdata(fullname);
if isfield(table_data, 'colheaders')
    colheaders = table_data.colheaders;
    IndID_index = find(ismember(colheaders, 'IndividualID'));
    if isempty(IndID_index)
        %         errordlg('This csv contains the variable header, but none or more than 1 ''IndividualID'' is found.', 'Error');
        %         return
        IndID_index = listdlg('PromptString','Select Individual ID Variable:','SelectionMode','single',...
            'ListString',colheaders);
        if isempty(IndID_index)
            return
        end
    end
    TAZID_index = find(ismember(colheaders, 'TAZID'));
    if isempty(TAZID_index)
        %         errordlg('This csv contains the variable header, but none or more than 1 ''TAZID'' is not found.', 'Error');
        %         return
        TAZID_index = listdlg('PromptString','Select TAZ ID Variable:','SelectionMode','single',...
            'ListString',colheaders);
        if isempty(TAZID_index)
            return
        end
    end
    try
        pathTAZ_data = csvread(fullname, 1, 0);
    catch
        msgbox('Unable to open the  TAZ-Path Information CSV')
        return
    end
    pathTAZ_data  =  pathTAZ_data(:, [IndID_index(1), TAZID_index(1)]);
else
    try
        pathTAZ_data = csvread(fullname);
        pathTAZ_data = pathTAZ_data(:, 1:2);
    catch
        msgbox('Unable to open the  TAZ-Path Information CSV')
        return
    end
end

if size( entrance_data, 1) ~= length(unique(pathTAZ_data(:,1)))
    errordlg('Num of Individuals is not equal among entrance data and path-TAZ data', 'Error')
    return
end

%以前都是按宽表写的，所以下面要转成宽表的形式
stat = tabulate(pathTAZ_data(:,1));
max_path_length = max(stat(:,2)) + 1 + 1;   %+1是因为还要加上消费者编号，再加1是加上入口
%只要前两列：第一列消费者编号，第二列TAZ编号/出入口编号
allPED = unique(pathTAZ_data(:,1));
path_rawdata = [];      %宽表初始化
for i = 1 : length(allPED)
    crtPED = allPED(i);
    crt_path = pathTAZ_data(pathTAZ_data(:,1) == crtPED, 2);
    crt_entrance = entrance_data(entrance_data(:,1) == crtPED, 2);
    if isempty(crt_entrance)
        errordlg(['Can not find the entrance of consumer ID ', num2str(crtPED)], 'Error');
        return
    end
    path_rawdata = [path_rawdata; [crtPED; crt_entrance; crt_path; zeros(max_path_length-2-length(crt_path),1)]'];
end
handles.path_rawdata = path_rawdata;
guidata(hObject, handles);
msgbox(['Successfully import ', num2str(length(allPED)) ' path(s)']);


% --------------------------------------------------------------------
function time_data_Callback(hObject, eventdata, handles)
% hObject    handle to time_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function space_time_path_Callback(hObject, eventdata, handles)
% hObject    handle to space_time_path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
str= strvcat('Instructions: ', ['1. Please firstly load a csv file containg entrace ID and entrance arriving time for each individual, '...
    'then load a csv file contraing a serie of TAZ IDs and corresponding arriving time (format: HHMM) & stay time (unite: minute) ',...
    'in the path for each individual.'],...
    '2. For entrance information csv, default variable names are ''IndividualID'', ''EntranceID'', ''Time''.',...
    '3. For TAZ-path information csv, default variable names are ''IndividualID'', ''TAZID'', ''Time''. ''Stay''.');
instr = msgbox(str, 'Instractions');
waitfor(instr)

[fname , pname]=uigetfile('*.csv' , 'Open the Entrance Information CSV');
if isequal(fname, 0) | isequal(pname, 0)
    return
end
fullname = strcat(pname,fname);

table_data = importdata(fullname);
if isfield(table_data, 'colheaders')
    colheaders = table_data.colheaders;
    IndID_index = find(ismember(colheaders, 'IndividualID'));
    if isempty(IndID_index)
        IndID_index = listdlg('PromptString','Select Individual ID Variable:','SelectionMode','single',...
            'ListString',colheaders);
        if isempty(IndID_index)
            return
        end
    end
    EntID_index = find(ismember(colheaders, 'EntranceID'));
    if isempty(EntID_index)
        EntID_index = listdlg('PromptString','Select Entrance ID Variable:','SelectionMode','single',...
            'ListString',colheaders);
        if isempty(EntID_index)
            return
        end
    end
    EntTime_index = find(ismember(colheaders, 'Time'));
    if isempty(EntTime_index)
        EntTime_index = listdlg('PromptString','Select Entrance Arriving Time Variable:','SelectionMode','single',...
            'ListString',colheaders);
        if isempty(EntTime_index)
            return
        end
    end
    try
        entrance_data = csvread(fullname, 1, 0);
    catch
        errordlg('Unable to open the Entrance Information CSV', 'Open Error')
        return
    end
    entrance_data  = entrance_data(:, [IndID_index(1), EntID_index(1), EntTime_index(1)]);
else
    try
        entrance_data = csvread(fullname);
        entrance_data = entrance_data(:, 1:3);      %默认前三列
    catch
        errordlg('Unable to open the Entrance Information CSV', 'Open Error')
        return
    end
end

[fname , pname]=uigetfile('*.csv' , 'Open the TAZ-Path Information CSV');
if isequal(fname, 0) | isequal(pname, 0)
    return
end
fullname = strcat(pname,fname);

table_data = importdata(fullname);
if isfield(table_data, 'colheaders')
    colheaders = table_data.colheaders;
    IndID_index = find(ismember(colheaders, 'IndividualID'));
    if isempty(IndID_index)
        IndID_index = listdlg('PromptString','Select Individual ID Variable:','SelectionMode','single',...
            'ListString',colheaders);
        if isempty(IndID_index)
            return
        end
    end
    TAZID_index = find(ismember(colheaders, 'TAZID'));
    if isempty(TAZID_index)
        TAZID_index = listdlg('PromptString','Select TAZ ID Variable:','SelectionMode','single',...
            'ListString',colheaders);
        if isempty(TAZID_index)
            return
        end
    end
    TAZTime_index = find(ismember(colheaders, 'Time'));
    if isempty(TAZTime_index)
        TAZTime_index = listdlg('PromptString','Select TAZ Arriving Time Variable:','SelectionMode','single',...
            'ListString',colheaders);
        if isempty(TAZTime_index)
            return
        end
    end
    Stay_index = find(ismember(colheaders, 'Stay'));
    if isempty(Stay_index)
        Stay_index = listdlg('PromptString','Select Stay Time Variable:','SelectionMode','single',...
            'ListString',colheaders);
        if isempty(Stay_index)
            return
        end
    end
    try
        pathTAZ_data = csvread(fullname, 1, 0);
    catch
        errordlg('Unable to open the  TAZ-Path Information CSV', 'Open Error')
        return
    end
    pathTAZ_data  =  pathTAZ_data(:, [IndID_index(1), TAZID_index(1), TAZTime_index(1), Stay_index(1)]);
else
    try
        pathTAZ_data = csvread(fullname);
        pathTAZ_data = pathTAZ_data(:, 1:4);        %默认前4行
    catch
        errordlg('Unable to open the  TAZ-Path Information CSV', 'Open Error')
        return
    end
end

if size( entrance_data, 1) ~= length(unique(pathTAZ_data(:,1)))
    errordlg('Num of Individuals is not equal among entrance data and path-TAZ data', 'Error')
    return
end

%----------先留一个只含空间的path_rawdata---------%
%以前都是按宽表写的，所以下面要转成宽表的形式
stat = tabulate(pathTAZ_data(:,1));
max_path_length = max(stat(:,2)) + 1 + 1;   %+1是因为还要加上消费者编号，再加1是加上入口
%只要前两列：第一列消费者编号，第二列TAZ编号/出入口编号
allPED = unique(pathTAZ_data(:,1));
path_rawdata = [];      %宽表初始化
for i = 1 : length(allPED)
    crtPED = allPED(i);
    crt_path = pathTAZ_data(pathTAZ_data(:,1) == crtPED, 2);
    crt_entrance = entrance_data(entrance_data(:,1) == crtPED, 2);
    if isempty(crt_entrance)
        errordlg(['Can not find the entrance of consumer ID ', num2str(crtPED)], 'Error');
        return
    end
    path_rawdata = [path_rawdata; [crtPED; crt_entrance; crt_path; zeros(max_path_length-2-length(crt_path),1)]'];
end
handles.path_rawdata = path_rawdata;
guidata(hObject, handles);
%----------以上：先留一个只含空间的path_rawdata---------%

%-----------下面生一个时空都有的cell：space_time_path_rawdata----------%
space_time_path_rawdata = cell(0);
for i = 1 : length(allPED)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
    crtPED = allPED(i);
    space_time_path_rawdata{i, 1} = crtPED;
    space_time_path_rawdata{i, 2} = entrance_data(entrance_data(:,1) == crtPED, 2:3);
    space_time_path_rawdata{i, 3} = pathTAZ_data(pathTAZ_data(:,1) == crtPED, 2:4);
end
handles.space_time_path_rawdata = space_time_path_rawdata;
guidata(hObject, handles);
msgbox(['Successfully import ', num2str(length(allPED)) ' path(s)']);


% --------------------------------------------------------------------
function entrance_arrving_time_Callback(hObject, eventdata, handles)
% hObject    handle to entrance_arrving_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function stay_time_Callback(hObject, eventdata, handles)
% hObject    handle to stay_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function traffic_time_menu_Callback(hObject, eventdata, handles)
% hObject    handle to traffic_time_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

function hint_msgbox = traffic_time_hint()
hint_str1 = ['1. There are 3 methods to set traffic time data, ''Directly Inputting Unique Value'' ',...
    'and ''Calculate Using Speed'' will completely replace the existed data, so you''d better firstly run one of them ',...
    'to get the base data, and then you can use ''Estimate from Spatiotemporal Path '' method to partially ',...
    'overlap the base data, since this method generally can not get the full data for lack of observations.'];
hint_str2 = ['2. After using above methods, you can manually adjust specific results in the table interface.'];
hint_str3 = ['3. Pre-requirments: distance matrix (if not advance mode, also stair matrix) is needed for ',...
    '''Calculate Using Speed'' mdethod; spatialtemporal path data is needed for ''Directly Inputting Unique Value'' ',...
    'method and is also recommended for ''Calculate Using Speed'' mdethod for automatically estimate speed; no ',...
    'pre-requirments for ''Directly Inputting Unique Value'' method'];
hint_strs = strvcat('Instructions: ', hint_str1, hint_str2, hint_str3);
hint_msgbox = msgbox(hint_strs, 'Instructions');


% --------------------------------------------------------------------
function ent_time_ksdensity_from_ind_obs_Callback(hObject, eventdata, handles)
% hObject    handle to ent_time_ksdensity_from_ind_obs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isfield(handles, 'X_ind_ent_time')
    str = 'You have already input an individual observation data, do you want to use it?';
    choice = questdlg(str, 'Entrance Time Distribtuion', 'Yes, use it', ...
        'No, use new data', 'Yes, use it');
    if isempty(choice)
        return
    elseif isequal(choice , 'Yes, use it')
        use_already = 1;
    elseif isequal(choice , 'No, use new data')
        use_already = 0;
    end
else
    %没有现成的
    temp = msgbox('There is no individual observation data, you have to load one now.', 'Data');
    waitfor(temp);
    use_already = 0;
end
if use_already == 1
    ent_time_rawdata = handles.X_ind_ent_time;
    ent_time_rawdata = ent_time_rawdata(:, 2);
else
    [fname , pname]=uigetfile('*.csv' , 'Open the Entrance Time Individual Observation CSV');
    if isequal(fname, 0) | isequal(pname, 0)
        return
    end
    fullname = strcat(pname,fname);
    table_data = importdata(fullname);
    if isfield(table_data, 'colheaders')
        colheaders = table_data.colheaders;
        EntTime_index = find(ismember(colheaders, 'Time'));
        if isempty(EntTime_index)
            EntTime_index = listdlg('PromptString','Select Arriving Time Variable:','SelectionMode','single',...
                'ListString',colheaders);
            if isempty(EntTime_index)
                return
            end
        end
        try
            ent_time_rawdata = csvread(fullname , 1 , 0);
        catch
            errordlg('Failed to open the data', 'Error')
            return
        end
        ent_time_rawdata = ent_time_rawdata(:, EntTime_index(1));
    else
        try 
            ent_time_rawdata = csvread(fullname);
            ent_time_rawdata = ent_time_rawdata(:, 1);
        catch
            errordlg('Failed to open the data', 'Error')
            return
        end
    end  
end

% 以下，转成时间差形式后估计
try
    t2 = WDtimeConvert(ent_time_rawdata , 1);
catch
    errordlg('Invalid data format.', 'Error')
    return
end
[k , x2 , bdw] = ksdensity(t2);
x = WDtimeConvert(x2 , 3);
x_h = floor(x / 100);
x_m = x - x_h*100;
pd = fitdist(t2 , 'kernel');
ent_time_distr.plot_x_h = x_h;
ent_time_distr.plot_x_m = x_m;
ent_time_distr.plot_k = k;
ent_time_distr.type = 1;        %1为核密度，2为自定义的曲线
ent_time_distr.pd = pd;                 %注意：这个pd生成的是时间差
handles.ent_time_distr = ent_time_distr;
guidata(hObject, handles);
msgbox('Finished')



% --------------------------------------------------------------------
function def_cumlative_distr_Callback(hObject, eventdata, handles)
% hObject    handle to def_cumlative_distr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 关闭除主fig之外的所有fig
all_figs = findall(0, 'type', 'figure');
for af_i = 1 : length(all_figs)
    crt_fig_in_all_figs = all_figs(af_i);
    if ~isequal(get(crt_fig_in_all_figs, 'tag') , 'figure1')
        delete(crt_fig_in_all_figs)
    end
end
%----------主界面---------------%
ent_time_cdf_def_fig = figure('Name' , 'Entrance Time Distributoin Definition' , 'NumberTitle' , 'off',...
     'Color', 'w', 'Unit', 'normalized', 'Position', [.1 .1 .8 .8],...
    'Menubar', 'none');
ent_time_cdf_def_axes = axes('parent',ent_time_cdf_def_fig, 'unit', 'normalized', ...
    'position', [.05, .075, .77, .9]);

%先画一点
ent_time_cdf_define = [datenum(1988,2,10,0,0,0), 0 ; datenum(1988,2,10,24,0,0),1];
set(ent_time_cdf_def_fig, 'userdata', ent_time_cdf_define);
xtick_hours = 0:1:24;
xtick_years = 1988 * ones(1 , size(xtick_hours,2));
xtick_months = 2 * ones(1 , size(xtick_hours,2));
xtick_days = 10 * ones(1 , size(xtick_hours,2));
xtick_minutes = zeros(1,size(xtick_hours,2));
xtick_seconds = zeros(1,size(xtick_hours,2));
xtick_data = datenum(xtick_years,xtick_months,xtick_days,xtick_hours,xtick_minutes,xtick_seconds);
for i=1:length(xtick_data)
    xtick_data_label{i} = datestr(xtick_data(i),'HH:MM');
end

distr_plot = plot(ent_time_cdf_define(:,1) , ent_time_cdf_define(:,2) , 'bo-','linewidth',2,...
    'markersize',10);
set(gca , 'xtick' , xtick_data)
set(gca , 'xticklabel' , xtick_data_label)
set(gcf , 'color' , 'w')
set(gca , 'fontsize' , 10)
xlabel('Time','fontsize',15,'fontname','Comic Sans MS')
ylabel('Cumulative Probability' , 'fontsize',15,'fontname','Comic Sans MS')
set(gca,'fontname','Comic Sans MS')
grid on

ent_time_cdf_def_add = uicontrol('parent',ent_time_cdf_def_fig, 'unit', 'normalized', ...
    'position', [.85, .9, .1, .07], 'string', 'Add', 'fontsize', 15, 'callback', @ent_time_cdf_def_add_callback);
ent_time_cdf_def_delete = uicontrol('parent',ent_time_cdf_def_fig, 'unit', 'normalized', ...
    'position', [.85, .8, .1, .07], 'string', 'Delete', 'fontsize', 15, 'callback', @ent_time_cdf_def_delete_callback);
ent_time_cdf_def_ok = uicontrol('parent',ent_time_cdf_def_fig, 'unit', 'normalized', ...
    'position', [.85, .5, .1, .07], 'string', 'OK', 'fontsize', 15, 'callback', @ent_time_cdf_def_ok_callback);

%------------callback合集----------------%
function ent_time_cdf_def_add_callback(hObject, callbackdata)
crt_gui_h = findall(0, 'type', 'figure', 'name', 'Entrance Time Distributoin Definition');
ent_time_cdf_def_axes = findall(crt_gui_h, 'type' , 'axes');
ent_time_cdf_define = get(crt_gui_h, 'userdata');
[crtx, crtP] = ginput(1);
while ~(crtx >= datenum(1988,2,10,0,0,0) & crtx <= datenum(1988,2,10,24,0,0) & crtP >= 0 & crtP <= 1)
    [crtx, crtP] = ginput(1);
end
crtx_date_vec = datevec(crtx);
crt_time = crtx_date_vec(4)*100 + crtx_date_vec(5);
%以下：数字化输入标记点
noproblem = 0;
while noproblem == 0
    prompt = {'Time (Format: HHMM):','Cumulative Probability:'};
    dlg_title = 'CDF Plot';
    num_lines = 1;
    default_input = {num2str(crt_time), num2str(crtP)};
    confirm_input_point = inputdlgWC(prompt, dlg_title, num_lines, default_input);
    if isempty(confirm_input_point)
        return
    end
    try
        crt_time = str2num(confirm_input_point{1});
        crtP = str2num(confirm_input_point{2});
    catch
        temp1 = errordlg('Invalid input: can not get numerical value', 'Error');
        waitfor(temp1)
        continue
    end
    if isempty(crt_time) | isempty(crtP);
        temp2 = errordlg('Invalid input:empty input', 'Error');
        waitfor(temp2)
        continue
    end
    crt_h = floor(crt_time / 100);
    crt_m = crt_time - 100*crt_h;
    if crt_h < 0 | crt_h > 24 | crt_m < 0 | crt_m >= 60 | crtP < 0 | crtP > 1
        temp3 = errordlg('Invalid input: wrong time format or probability range', 'Error');
        waitfor(temp3)
        continue
    end
    crt_datenum = datenum(1988, 2, 10, crt_h, crt_m, 0);
    ent_time_cdf_define = [ent_time_cdf_define ; [crt_datenum, crtP]];
    ent_time_cdf_define = sortrows(ent_time_cdf_define, 1);
    if length(ent_time_cdf_define(:,1)) ~= length(unique(ent_time_cdf_define(:,1)))
        temp4 = errordlg('You can not see the same time twice', 'Error');
        waitfor(temp4)
        continue
    end
    crt_index = find(ent_time_cdf_define(:,1) == crt_datenum);
    if crt_index == 1
        if ent_time_cdf_define(crt_index, 2) > ent_time_cdf_define(crt_index+1, 2)
            temp5 = errordlg('The cumulative probability must be non-decreasing along with time.', 'Error');
            waitfor(temp5)
            continue
        end
    elseif crt_index > 1 & crt_index < size(ent_time_cdf_define, 1)
        if ent_time_cdf_define(crt_index, 2) < ent_time_cdf_define(crt_index-1, 2) | ent_time_cdf_define(crt_index, 2) > ent_time_cdf_define(crt_index+1, 2)
            temp5 = errordlg('The cumulative probability must be non-decreasing along with time.', 'Error');
            waitfor(temp5)
            continue
        end
    elseif crt_index == ent_time_cdf_define
        if ent_time_cdf_define(crt_index, 2) < ent_time_cdf_define(crt_index-1, 2) 
            temp5 = errordlg('The cumulative probability must be non-decreasing along with time.', 'Error');
            waitfor(temp5)
            continue
        end
    end
    noproblem = 1;
end
crt_line = get(ent_time_cdf_def_axes, 'child');
delete(crt_line)
distr_plot = plot(ent_time_cdf_define(:,1) , ent_time_cdf_define(:,2) , 'bo-','linewidth',2,...
    'markersize',10);
set(crt_gui_h, 'userdata', ent_time_cdf_define);
%以上：数字化输入标记点

xtick_hours = 0:1:24;
xtick_years = 1988 * ones(1 , size(xtick_hours,2));
xtick_months = 2 * ones(1 , size(xtick_hours,2));
xtick_days = 10 * ones(1 , size(xtick_hours,2));
xtick_minutes = zeros(1,size(xtick_hours,2));
xtick_seconds = zeros(1,size(xtick_hours,2));
xtick_data = datenum(xtick_years,xtick_months,xtick_days,xtick_hours,xtick_minutes,xtick_seconds);
for i=1:length(xtick_data)
    xtick_data_label{i} = datestr(xtick_data(i),'HH:MM');
end
set(gca , 'xtick' , xtick_data)
set(gca , 'xticklabel' , xtick_data_label)
xlabel('Time','fontsize',15,'fontname','Comic Sans MS')
ylabel('Cumulative Probability' , 'fontsize',15,'fontname','Comic Sans MS')
set(gca,'fontname','Comic Sans MS')
grid on

function ent_time_cdf_def_delete_callback(hObject, callbackdata)
crt_gui_h = findall(0, 'type', 'figure', 'name', 'Entrance Time Distributoin Definition');
ent_time_cdf_def_axes = findall(crt_gui_h, 'type' , 'axes');
ent_time_cdf_define = get(crt_gui_h, 'userdata');
[crtx, crtP] = ginput(1);
while ~(crtx >= datenum(1988,2,10,0,0,0) & crtx <= datenum(1988,2,10,24,0,0) & crtP >= 0 & crtP <= 1)
    [crtx, crtP] = ginput(1);
end
temp = ent_time_cdf_define(:,1);     %复制一份，用来查找删除哪个点
temp = sort([temp; crtx]);
crt_index = find(temp == crtx);
if crt_index == 1 | crt_index == 2
    delete_index = 2;
elseif crt_index == length(temp) | crt_index == length(temp) - 1
    delete_index = size(ent_time_cdf_define, 1) - 1;
else
    left_dist = abs(crtx - temp(crt_index - 1));
    right_dist = abs(crtx - temp(crt_index + 1));
    if left_dist >= right_dist
        delete_index = crt_index;
    else
        delete_index = crt_index - 1;
    end
end
hold on
highlight = plot(ent_time_cdf_define(delete_index, 1), ent_time_cdf_define(delete_index, 2), 'rx', 'markersize', 30);
choice = questdlg('Do you want to delete this control point?', 'CDF', 'Yes', 'No', 'Yes');
if isequal(choice, 'Yes')
    ent_time_cdf_define(delete_index, :) = [];
    delete(highlight)
    crt_line = get(ent_time_cdf_def_axes, 'child');
    delete(crt_line)
    distr_plot = plot(ent_time_cdf_define(:,1) , ent_time_cdf_define(:,2) , 'bo-','linewidth',2,...
        'markersize',10);
    set(crt_gui_h, 'userdata', ent_time_cdf_define);
    xtick_hours = 0:1:24;
    xtick_years = 1988 * ones(1 , size(xtick_hours,2));
    xtick_months = 2 * ones(1 , size(xtick_hours,2));
    xtick_days = 10 * ones(1 , size(xtick_hours,2));
    xtick_minutes = zeros(1,size(xtick_hours,2));
    xtick_seconds = zeros(1,size(xtick_hours,2));
    xtick_data = datenum(xtick_years,xtick_months,xtick_days,xtick_hours,xtick_minutes,xtick_seconds);
    for i=1:length(xtick_data)
        xtick_data_label{i} = datestr(xtick_data(i),'HH:MM');
    end
    set(gca , 'xtick' , xtick_data)
    set(gca , 'xticklabel' , xtick_data_label)
    xlabel('Time','fontsize',15,'fontname','Comic Sans MS')
    ylabel('Cumulative Probability' , 'fontsize',15,'fontname','Comic Sans MS')
    set(gca,'fontname','Comic Sans MS')
    grid on
    
elseif isequal(choice, 'No')
    delete(highlight)
    return
else
    return
end

function ent_time_cdf_def_ok_callback(hObject, callbackdata)
crt_gui_h = findall(0, 'type', 'figure', 'name', 'Entrance Time Distributoin Definition');
ent_time_cdf_def_axes = findall(crt_gui_h, 'type' , 'axes');
ent_time_cdf_define = get(crt_gui_h, 'userdata');
main_fig = findall(0, 'type', 'figure', 'tag', 'figure1');
handles = guidata(main_fig);

ent_time_distr.type = 2;        %1为核密度，2为自定义的曲线
ent_time_distr.ent_time_cdf_define = ent_time_cdf_define;
handles.ent_time_distr = ent_time_distr;
guidata(main_fig, handles);
close(crt_gui_h);





% --------------------------------------------------------------------
function entrance_time_distr_plot_Callback(hObject, eventdata, handles)
% hObject    handle to entrance_time_distr_plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isfield(handles, 'ent_time_distr')
    errordlg('You must firstly have a entrance time distribution', 'Error')
    return
else
    ent_time_distr = handles.ent_time_distr;
end
% 关闭除主fig之外的所有fig
all_figs = findall(0, 'type', 'figure');
for af_i = 1 : length(all_figs)
    crt_fig_in_all_figs = all_figs(af_i);
    if ~isequal(get(crt_fig_in_all_figs, 'tag') , 'figure1')
        delete(crt_fig_in_all_figs)
    end
end
%以下：定义显示的时间段%
prompt = {'Enter the start time in the axis (Format: HHMM):','Enter the end time in the axis (Format: HHMM):'};
dlg_title = 'Time';
num_lines = 1;
default_interval = {'0000','2400'};
time_interval_def = inputdlgWC(prompt, dlg_title, num_lines, default_interval);
if isempty(time_interval_def) 
    return
end
try 
    start_time = str2num(time_interval_def{1});
    end_time = str2num(time_interval_def{2});
catch
    errordlg('Invalid input', 'Error')
    return
end
if isempty(start_time) & isempty(end_time)
    return
elseif ~isempty(start_time) & (start_time<0 | start_time> 2400 | ~isequal(start_time, round(start_time)))
    errordlg('Invalid start time input', 'Error')
    return
elseif ~isempty(end_time) & (end_time<0 | end_time> 2400 | ~isequal(end_time, round(end_time)))
    errordlg('Invalid end time input', 'Error')
    return
elseif WDtimeConvert(start_time, 1) >= WDtimeConvert(end_time, 1)
    errordlg('Start time must be earlier than end time', 'Error')
    return
end
%以上：定义显示的时间段%

% %-----------------------以下：时间坐标轴------------------------%
xtick_hours = 0:1:24;
xtick_years = 1988 * ones(1 , size(xtick_hours,2));
xtick_months = 2 * ones(1 , size(xtick_hours,2));
xtick_days = 10 * ones(1 , size(xtick_hours,2));
xtick_minutes = zeros(1,size(xtick_hours,2));
xtick_seconds = zeros(1,size(xtick_hours,2));
xtick_data = datenum(xtick_years,xtick_months,xtick_days,xtick_hours,xtick_minutes,xtick_seconds);
for i=1:length(xtick_data)
    xtick_data_label{i} = datestr(xtick_data(i),'HH:MM');
end
% %-----------------------以上：时间坐标轴------------------------%

if ent_time_distr.type == 1         %核密度类
    x_h = ent_time_distr.plot_x_h;
    x_m = ent_time_distr.plot_x_m;
    k = ent_time_distr.plot_k;
   
    figure
    xdate=datenum(1988 , 2 , 10 , x_h , x_m , 0);
    distr_plot = plot(xdate , k , 'b-','linewidth',2);
    set(gca , 'xtick' , xtick_data)
    set(gca , 'xticklabel' , xtick_data_label)
    set(gcf , 'color' , 'w')
    set(gca , 'fontsize' , 10)
    title('Entry Time Curve' , 'fontname','Comic Sans MS','fontsize',18,'fontweight','bold')
    xlabel('Time','fontsize',15,'fontname','Comic Sans MS')
    ylabel('Kernel Density' , 'fontsize',15,'fontname','Comic Sans MS')
    set(gca,'fontname','Comic Sans MS')
    % ylim([0,20000])
    xlim([datenum(1988,2,10, floor(start_time/100), start_time-floor(start_time/100)*100 ,0) , ...
        datenum(1988,2,10, floor(end_time/100), end_time-floor(end_time/100)*100 ,0)])            %5：00-24：00
else
    ent_time_cdf_define = ent_time_distr.ent_time_cdf_define;
    figure
    distr_plot = plot(ent_time_cdf_define(:,1) , ent_time_cdf_define(:,2) , 'b-','linewidth',2);
    set(gca , 'xtick' , xtick_data)
    set(gca , 'xticklabel' , xtick_data_label)
    set(gcf , 'color' , 'w')
    set(gca , 'fontsize' , 10)
    title('Entry Time Curve' , 'fontname','Comic Sans MS','fontsize',18,'fontweight','bold')
    xlabel('Time','fontsize',15,'fontname','Comic Sans MS')
    ylabel('Cumulative Probability' , 'fontsize',15,'fontname','Comic Sans MS')
    set(gca,'fontname','Comic Sans MS')
    xlim([datenum(1988,2,10, floor(start_time/100), start_time-floor(start_time/100)*100 ,0) , ...
        datenum(1988,2,10, floor(end_time/100), end_time-floor(end_time/100)*100 ,0)])          
end


% --------------------------------------------------------------------
function stay_time_distr_kd_Callback(hObject, eventdata, handles)
% hObject    handle to stay_time_distr_kd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isfield(handles , 'NTAZ')
    errordlg('Please firstly input Num of TAZs' , 'NTAZ Error')
    return
end
NTAZ = handles.NTAZ;

if ~isfield(handles , 'stay_time_rawdata')
    errordlg('NO individual stay time observation inputting' , 'Input Error')
    return
else
    stay_time = handles.stay_time_rawdata;
    all_mean_kd = fitdist(stay_time(:,2), 'kernel');
    [all_mean_f, all_mean_x] = ksdensity(stay_time(:,2));
    stay_time_distr = cell(0);      %初始化
    %第一列：小区编号；第二列，分布object；第三列：画图X；第四列：画图Y；第五列：分布类型（1为ksdensity，2为正态，3为对数正态）；第六列：分布参数（ks可能没有）
    for itaz = 1 : NTAZ
        stay_time_distr{itaz, 1} = itaz;
        crt_taz_stay_time = stay_time(stay_time(:,1) == itaz, 2);
        if ~isempty(crt_taz_stay_time)            %有数据
            stay_time_distr{itaz, 2} = fitdist(crt_taz_stay_time, 'kernel');
            [crtf, crtx] = ksdensity(crt_taz_stay_time);
            stay_time_distr{itaz, 3} = crtx;
            stay_time_distr{itaz, 4} = crtf;
            stay_time_distr{itaz, 5} = 1;
            stay_time_distr{itaz, 6} = [nan, nan];
        else                                        %没数据
            input_ok = 0;
            while input_ok == 0
                need_to_input = questdlg(['Warning: there is no individual observaltion for TAZ_', num2str(itaz), ...
                    ' please select another way.'] , ...
                    'Stay Time Distribution Data', 'Use overall kernel density distribution', 'Define a normal distribution', 'Use overall distribution');
                waitfor(need_to_input);
                if isequal(need_to_input, 'Use overall kernel density distribution')
                    stay_time_distr{itaz, 2} = all_mean_kd;
                    stay_time_distr{itaz, 3} = all_mean_x;
                    stay_time_distr{itaz, 4} = all_mean_f;
                    stay_time_distr{itaz, 5} = 1;
                    stay_time_distr{itaz, 6} = [nan, nan];
                    input_ok = 1;
                elseif isequal(need_to_input, 'Define a normal distribution')
                    def_norm = inputdlgWC({'mu: ', 'sigma: '}, '', 1, {'30' , '0'});
                    try
                        def_mu = str2num(def_norm{1});
                        def_sigma = str2num(def_norm{2});
                    catch
                        e1 = errordlg('Invalid input', 'Input Error');
                        waitfor(e1)
                        continue
                    end
                    if def_mu < 0
                        e2 = errordlg('Mean stay time must be non-negative', 'Input Error');
                        waitfor(e2)
                        continue
                    end
                    if def_sigma < 0
                        e3 = errordlg('Sigma must non-negative', 'Input Error');
                        waitfor(e3)
                        continue
                    end
                    crt_pd = makedist('Normal', 'mu', def_mu, 'sigma', def_sigma);
                    stay_time_distr{itaz, 2} = crt_pd;
                    crt_x = linspace(def_mu - 3.2*def_sigma, def_mu + 3.2*def_sigma, 100);
                    stay_time_distr{itaz, 3} = crt_x;
                    stay_time_distr{itaz, 4} = pdf(crt_pd, crt_x);
                    stay_time_distr{itaz, 5} = 2;
                    stay_time_distr{itaz, 6} = [def_mu, def_sigma];
                    input_ok = 1;
                elseif isempty(need_to_input)
                    return
                end
            end
        end
    end
    if size(stay_time_distr, 1) == NTAZ;
        handles.stay_time_distr = stay_time_distr;
        guidata(hObject,handles);
        msgbox('Finished.')
    else
        errordlg('Input Num of stay time distribution data do NOT equal Num of TAZ' , 'Input Error')
        return
    end
end


% --------------------------------------------------------------------
function stay_time_distr_normal_Callback(hObject, eventdata, handles)
% hObject    handle to stay_time_distr_normal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isfield(handles , 'NTAZ')
     errordlg('Please firstly input Num of TAZs' , 'NTAZ Error')
     return
end
NTAZ = handles.NTAZ;
choice1 = questdlg('Do you want to input stay time distribution or check distribution parameter?' , 'Stay Time Distribution Data'...
    , 'Input distribution' , 'Check distribution parameter' , 'Input distribution');
if isequal(choice1, 'Input distribution')
    choice2 = questdlg('Please choose the way of inputing stay time distribution.' , 'Stay Time Distribution Data'...
        , 'Load CSV File' , 'Automatic Estimation' , 'Automatic Estimation');
    if isequal(choice2, 'Automatic Estimation')
        if ~isfield(handles , 'stay_time_rawdata')
            errordlg('NO individual stay time observation inputting' , 'Input Error')
            return
        else
            stay_time = handles.stay_time_rawdata;
            all_mu = mean(stay_time(:,2));
            all_sigma = std(stay_time(:,2));
            all_norm_pd = makedist('normal', all_mu, all_sigma);
            all_x = linspace(all_mu - 3.2*all_sigma, all_mu + 3.2*all_sigma, 100);
            all_f = pdf(all_norm_pd, all_x);
            
            stay_time_distr = cell(0);      %初始化
            %第一列：小区编号；第二列，分布object；第三列：画图X；第四列：画图Y；第五列：分布类型（1为ksdensity，2为正态，3为对数正态）；第六列：分布参数[mu, sigma]
            for itaz = 1 : NTAZ
                stay_time_distr{itaz, 1} = itaz;
                crt_taz_stay_time = stay_time(stay_time(:,1) == itaz, 2);
                if ~isempty(crt_taz_stay_time)            %有数据
                    crt_mu = mean(crt_taz_stay_time);
                    crt_sigma = std(crt_taz_stay_time);
                    crt_norm_pd = makedist('normal', crt_mu, crt_sigma);
                    crt_x = linspace(crt_mu - 3.2*crt_sigma, crt_mu + 3.2*crt_sigma, 100);
                    crt_f = pdf(crt_norm_pd, crt_x);
                    stay_time_distr{itaz, 2} = crt_norm_pd;
                    stay_time_distr{itaz, 3} = crt_x;
                    stay_time_distr{itaz, 4} = crt_f;
                    stay_time_distr{itaz, 5} = 2;
                    stay_time_distr{itaz, 6} = [crt_mu, crt_sigma];
                else                                        %没数据
                    input_ok = 0;
                    while input_ok == 0
                        need_to_input = questdlg(['Warning: there is no individual observaltion for TAZ_', num2str(itaz), ...
                            ' please select another way.'] , ...
                            'Stay Time Distribution Data', 'Use overall normal distribution', 'Define a normal distribution', 'Use overall distribution');
                        waitfor(need_to_input);
                        if isequal(need_to_input, 'Use overall normal distribution')
                            stay_time_distr{itaz, 2} = all_norm_pd;
                            stay_time_distr{itaz, 3} = all_x;
                            stay_time_distr{itaz, 4} = all_f;
                            stay_time_distr{itaz, 5} = 2;
                            stay_time_distr{itaz, 6} = [all_mu, all_sigma];
                            input_ok = 1;
                        elseif isequal(need_to_input, 'Define a normal distribution')
                            def_norm = inputdlgWC({'mu: ', 'sigma: '}, '', 1, {'30' , '0'});
                            try
                                def_mu = str2num(def_norm{1});
                                def_sigma = str2num(def_norm{2});
                            catch
                                e1 = errordlg('Invalid input', 'Input Error');
                                waitfor(e1)
                                continue
                            end
                            if def_mu < 0
                                e2 = errordlg('Mean stay time must be non-negative', 'Input Error');
                                waitfor(e2)
                                continue
                            end
                            if def_sigma < 0
                                e3 = errordlg('Sigma must non-negative', 'Input Error');
                                waitfor(e3)
                                continue
                            end
                            crt_pd = makedist('Normal', 'mu', def_mu, 'sigma', def_sigma);
                            stay_time_distr{itaz, 2} = crt_pd;
                            crt_x = linspace(def_mu - 3.2*def_sigma, def_mu + 3.2*def_sigma, 100);
                            stay_time_distr{itaz, 3} = crt_x;
                            stay_time_distr{itaz, 4} = pdf(crt_pd, crt_x);
                            stay_time_distr{itaz, 5} = 2;
                            stay_time_distr{itaz, 6} = [def_mu, def_sigma];
                            input_ok = 1;
                        elseif isempty(need_to_input)
                            return
                        end
                    end
                end
            end
        end
    elseif isequal(choice2, 'Load CSV File')
        [fname , pname] = uigetfile('*.csv' , 'Open the Stay Time Normal Distribution Parameter CSV');
        if isequal(fname, 0) | isequal(pname, 0)
            return
        end
        fullname = strcat(pname,fname);
        %三列，TAZID, Mu, Sigma
        varnames = {'TAZID', 'Mu', 'Sigma'};
        varstring = {'TAZ ID', 'Mu', 'Sigma'};
        [st_distr_para, flag] = open_csv(fullname, 3, varnames, varstring);
        if flag == 0
            return
        end
%         try
%             st_distr_para = csvread(fullname);
%         catch
%             try
%                 st_distr_para = csvread(fullname, 1, 0);
%             catch
%                 errordlg('Unable to open the normal distribution parameter csv', 'Open Error')
%                 return
%             end
%         end
        [nrow , ncol] = size(st_distr_para);
        if nrow == NTAZ
            if ncol == 2
                st_distr_para_mu = st_distr_para(:,1);
                st_distr_para_sigma = st_distr_para(:,2);
            elseif ncol == 3 
                st_distr_para = sortrows(st_distr_para , 1);
                st_distr_para = st_distr_para(: , 2:3);
                st_distr_para_mu = st_distr_para(:,1);
                st_distr_para_sigma = st_distr_para(:,2);
            elseif ncol < 2 | ncol > 3
                errordlg('Invalid data format', 'Input Error')
                return
            end
        else
            errordlg('Input Num of distribution parameter data NOT equal Num of TAZ' , 'Input Error')
            return
        end
        
        %检查数据，并生成分布信息的大cell数组
        for ki = 1 : NTAZ
            stay_time_distr{ki, 1} = ki;
            crt_mu = st_distr_para_mu(ki);
            crt_sigma = st_distr_para_sigma(ki);
            if crt_mu < 0 
                errordlg('Mean value must non-negative', 'Input Error')
                return
            end
            if crt_sigma < 0
                errordlg('Sigma value must be non-negative', 'Input Error')
                return
            end
            crt_pd = makedist('Normal', 'mu', crt_mu, 'sigma', crt_sigma); 
            stay_time_distr{ki, 2} = crt_pd;
            crt_x = linspace(crt_mu - 3.2*crt_sigma, crt_mu + 3.2*crt_sigma, 100);
            stay_time_distr{ki, 3} = crt_x;
            stay_time_distr{ki, 4} = pdf(crt_pd, crt_x);
            stay_time_distr{ki, 5} = 2;
            stay_time_distr{ki, 6} = [crt_mu, crt_sigma];
        end
    elseif isempty(choice2)
        return
    end
    if size(stay_time_distr, 1) == NTAZ;
        handles.stay_time_distr = stay_time_distr;
        guidata(hObject,handles);
        msgbox('Finished.')
    else
        errordlg('Input Num of stay time distribution data do NOT equal Num of TAZ' , 'Input Error')
        return
    end
    
elseif isequal(choice1 , 'Check distribution parameter')
    if ~isfield(handles , 'stay_time_distr')
        warndlg('There is NO valid stay time distribution input' ,'Expenditure Distribution Data')
        return
    else
        stay_time_distr = handles.stay_time_distr;
        distr_type = [];
        for taz_i = 1 : NTAZ
            distr_par(taz_i, :) = [taz_i, stay_time_distr{taz_i, 6}];
            if stay_time_distr{taz_i, 5} == 2 
                distr_type = strvcat(distr_type, '     normal');
            elseif stay_time_distr{taz_i, 5} == 3
                distr_type = strvcat(distr_type, '     log-normal');
            elseif stay_time_distr{taz_i, 5} == 1
                distr_type = strvcat(distr_type, '     kernel density');
            end
        end
        show = strvcat('TAZ     mu     sigma     type' , strcat(num2str(distr_par), distr_type));
        msgbox(show)
    end
end


% --------------------------------------------------------------------
function stay_time_distr_log_normal_Callback(hObject, eventdata, handles)
% hObject    handle to stay_time_distr_log_normal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isfield(handles , 'NTAZ')
     errordlg('Please firstly input Num of TAZs' , 'NTAZ Error')
     return
end
NTAZ = handles.NTAZ;
choice1 = questdlg('Do you want to estimate stay time distribution or check distribution parameter?' , 'Stay Time Distribution Data'...
    , 'Input distribution' , 'Check distribution parameter' , 'Input distribution');
if isequal(choice1, 'Input distribution')
    choice2 = questdlg('Please choose the way of inputing stay time distribution.' , 'Stay Time Distribution Data'...
        , 'Load CSV File' , 'Automatic Estimation' , 'Automatic Estimation');
    if isequal(choice2, 'Automatic Estimation')
        if ~isfield(handles , 'stay_time_rawdata')
            errordlg('NO individual stay time observation inputting' , 'Input Error')
            return
        else
            stay_time = handles.stay_time_rawdata;
            all_ln_mu = mean(log(stay_time(:,2)));
            all_ln_sigma = std(log(stay_time(:,2)));
            all_ln_pd = makedist('Lognormal', 'mu', all_ln_mu, 'sigma', all_ln_sigma);
            all_x = linspace(max(0, mean(stay_time(:,2)) - 3.2 * std(stay_time(:,2)) ) , ...
                mean(stay_time(:,2)) + 3.2 * std(stay_time(:,2))  ,100  );
            all_f = pdf(all_ln_pd, all_x);
            
            stay_time_distr = cell(0);      %初始化
            %第一列：小区编号；第二列，分布object；第三列：画图X；第四列：画图Y；第五列：分布类型（1为ksdensity，2为正态，3为对数正态）；第六列：分布参数[mu, sigma]
            for itaz = 1 : NTAZ
                stay_time_distr{itaz, 1} = itaz;
                crt_taz_stay_time = stay_time(stay_time(:,1) == itaz, 2);
                if ~isempty(crt_taz_stay_time)            %有数据
                    crt_ln_mu = mean(log(crt_taz_stay_time));
                    crt_ln_sigma = std(log(crt_taz_stay_time));
                    crt_ln_pd = makedist('Lognormal', 'mu', crt_ln_mu, 'sigma', crt_ln_sigma);
                    crt_x = linspace( max(0, mean(crt_taz_stay_time) - 3.2*std(crt_taz_stay_time))  , ...
                        mean(crt_taz_stay_time) + 3.2*std(crt_taz_stay_time)  , 100);
                    crt_f = pdf(crt_ln_pd, crt_x);
                    stay_time_distr{itaz, 2} = crt_ln_pd;
                    stay_time_distr{itaz, 3} = crt_x;
                    stay_time_distr{itaz, 4} = crt_f;
                    stay_time_distr{itaz, 5} = 3;
                    stay_time_distr{itaz, 6} = [crt_ln_mu, crt_ln_sigma];
                else                                        %没数据
                    input_ok = 0;
                    while input_ok == 0
                        need_to_input = questdlg(['Warning: there is no individual observaltion for TAZ_', num2str(itaz), ...
                            ' please select another way.'] , ...
                            'Stay Time Distribution Data', 'Use overall log-normal distribution', ...
                            'Define a log-normal distribution', 'Define a normal distribution', 'Use overall distribution');
                        waitfor(need_to_input);
                        if isequal(need_to_input, 'Use overall log-normal distribution')
                            stay_time_distr{itaz, 2} = all_ln_pd;
                            stay_time_distr{itaz, 3} = all_x;
                            stay_time_distr{itaz, 4} = all_f;
                            stay_time_distr{itaz, 5} = 3;
                            stay_time_distr{itaz, 6} = [all_ln_mu, all_ln_sigma];
                            input_ok = 1;
                        elseif isequal(need_to_input, 'Define a log-normal distribution')
                            def_ln = inputdlgWC({'mu: ', 'sigma: '}, '', 1, {'0' , '0'});
                            try
                                def_ln_mu = str2num(def_ln{1});
                                def_ln_sigma = str2num(def_ln{2});
                            catch
                                e1 = errordlg('Invalid input', 'Input Error');
                                waitfor(e1)
                                continue
                            end
                            if def_sigma < 0
                                e3 = errordlg('Sigma must non-negative', 'Input Error');
                                waitfor(e3)
                                continue
                            end
                            crt_ln_pd = makedist('Lognormal', 'mu', def_ln_mu, 'sigma', def_ln_sigma);
                            stay_time_distr{itaz, 2} = crt_ln_pd;
                            %生成一组随机数
                            trial = random(crt_ln_pd, 100, 1);
                            crt_x = linspace(max(0, mean(trial) - 3.2*std(trial)), ...
                                mean(trial) + 3.2*std(trial), 100);
                            stay_time_distr{itaz, 3} = crt_x;
                            stay_time_distr{itaz, 4} = pdf(crt_ln_pd, crt_x);
                            stay_time_distr{itaz, 5} = 3;
                            stay_time_distr{itaz, 6} = [def_ln_mu, def_ln_sigma];
                            input_ok = 1;
                        elseif isequal(need_to_input, 'Define a normal distribution')
                            def_norm = inputdlgWC({'mu: ', 'sigma: '}, '', 1, {'0' , '0'});
                            try
                                def_mu = str2num(def_norm{1});
                                def_sigma = str2num(def_norm{2});
                            catch
                                e1 = errordlg('Invalid input', 'Input Error');
                                waitfor(e1)
                                continue
                            end
                            if def_mu < 0
                                e2 = errordlg('Mean stay time must be non-negative', 'Input Error');
                                waitfor(e2)
                                continue
                            end
                            if def_sigma < 0
                                e3 = errordlg('Sigma must non-negative', 'Input Error');
                                waitfor(e3)
                                continue
                            end
                            crt_pd = makedist('Normal', 'mu', def_mu, 'sigma', def_sigma);
                            stay_time_distr{itaz, 2} = crt_pd;
                            crt_x = linspace(def_mu - 3.2*def_sigma, def_mu + 3.2*def_sigma, 100);
                            stay_time_distr{itaz, 3} = crt_x;
                            stay_time_distr{itaz, 4} = pdf(crt_pd, crt_x);
                            stay_time_distr{itaz, 5} = 2;
                            stay_time_distr{itaz, 6} = [def_mu, def_sigma];
                            input_ok = 1;
                        elseif isempty(need_to_input)
                            return
                        end
                    end
                end
            end
        end
        
    elseif isequal(choice2, 'Load CSV File')
        [fname , pname] = uigetfile('*.csv' , 'Open the Stay Time Log-Normal Distribution Parameter CSV');
        if isequal(fname, 0) | isequal(pname, 0)
            return
        end
        fullname = strcat(pname,fname);
        %三列，TAZID, Mu, Sigma
        varnames = {'TAZID', 'Mu', 'Sigma'};
        varstring = {'TAZ ID', 'Mu', 'Sigma'};
        [st_distr_para, flag] = open_csv(fullname, 3, varnames, varstring);
        if flag == 0
            return
        end
%         try
%             st_distr_para = csvread(fullname);
%         catch
%             try
%                 st_distr_para = csvread(fullname, 1, 0);
%             catch
%                 errordlg('Unable to open the log-normal distribution parameter csv', 'Open Error')
%                 return
%             end
%         end
        [nrow , ncol] = size(st_distr_para);
        if nrow == NTAZ
            if ncol == 2
                st_distr_para_mu = st_distr_para(:,1);
                st_distr_para_sigma = st_distr_para(:,2);
            elseif ncol == 3 
                st_distr_para = sortrows(st_distr_para , 1);
                st_distr_para = st_distr_para(: , 2:3);
                st_distr_para_mu = st_distr_para(:,1);
                st_distr_para_sigma = st_distr_para(:,2);
            elseif ncol < 2 | ncol > 3
                errordlg('Invalid data format', 'Input Error')
                return
            end
        else
            errordlg('Input Num of distribution parameter data NOT equal Num of TAZ' , 'Input Error')
            return
        end
        
        %检查数据，并生成分布信息的大cell数组
        for ki = 1 : NTAZ
            stay_time_distr{ki, 1} = ki;
            crt_ln_mu = st_distr_para_mu(ki);
            crt_ln_sigma = st_distr_para_sigma(ki);
            if crt_ln_sigma < 0
                errordlg('Sigma value must be non-negative', 'Input Error')
                return
            end
            crt_ln_pd = makedist('Lognormal', 'mu', crt_ln_mu, 'sigma', crt_ln_sigma);
            stay_time_distr{ki, 2} = crt_ln_pd;
            trial = random(crt_ln_pd, 200, 1);
            crt_x = linspace(max(0, mean(trial) - 3.2*std(trial)), ...
                mean(trial) + 3.2*std(trial), 200);
            stay_time_distr{ki, 3} = crt_x;
            stay_time_distr{ki, 4} = pdf(crt_ln_pd, crt_x);
            stay_time_distr{ki, 5} = 3;
            stay_time_distr{ki, 6} = [crt_ln_mu, crt_ln_sigma];
        end
        
    elseif isempty(choice2)
        return
    end
    
    if size(stay_time_distr, 1) == NTAZ;
        handles.stay_time_distr = stay_time_distr;
        guidata(hObject,handles);
        msgbox('Finished.')
    else
        errordlg('Input Num of stay time distribution data do NOT equal Num of TAZ' , 'Input Error')
        return
    end
    
    
elseif isequal(choice1 , 'Check distribution parameter')
    if ~isfield(handles , 'stay_time_distr')
        warndlg('There is NO valid stay time distribution input' ,'Stay Time Distribution Data')
        return
    else
        stay_time_distr = handles.stay_time_distr;
        distr_type = [];
        for taz_i = 1 : NTAZ
            distr_par(taz_i, :) = [taz_i, stay_time_distr{taz_i, 6}];
            if stay_time_distr{taz_i, 5} == 2
                distr_type = strvcat(distr_type, '     normal');
            elseif stay_time_distr{taz_i, 5} == 3
                distr_type = strvcat(distr_type, '     log-normal');
            elseif stay_time_distr{taz_i, 5} == 1
                distr_type = strvcat(distr_type, '     kernel density');
            end
        end
        show = strvcat('TAZ     mu     sigma     type' , strcat(num2str(distr_par), distr_type));
        msgbox(show)
    end
end




% --------------------------------------------------------------------
function dens_plot_stay_time_Callback(hObject, eventdata, handles)
% hObject    handle to dens_plot_stay_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isfield(handles , 'stay_time_distr')
    warndlg('There is NO valid stay time distribution input' ,'Stay Time Distribution Data')
    return
else
    stay_time_distr = handles.stay_time_distr;
    % 关闭除主fig之外的所有fig
    all_figs = findall(0, 'type', 'figure');
    for af_i = 1 : length(all_figs)
        crt_fig_in_all_figs = all_figs(af_i);
        if ~isequal(get(crt_fig_in_all_figs, 'tag') , 'figure1')
            delete(crt_fig_in_all_figs)
        end
    end
    
    stay_time_distr_fig = figure('Name' , 'Probability Density Function of Stay Time Distribution' , 'NumberTitle' , 'off',...
        'Unit', 'normalized', 'Position', [.2 .1 .6 .8], 'Color', 'w', 'Toolbar', 'none', 'Menubar', 'none');
    taz_id_str = uicontrol('parent', stay_time_distr_fig, 'style', 'text', 'string', 'TAZ ID: ', 'unit', 'normalized', ...
        'position',[.2, .9, .1, .06], 'fontsize', 18, 'fontweight', 'bold', 'backgroundcolor', 'w');
    taz_id_input = uicontrol('parent', stay_time_distr_fig, 'style', 'edit', 'string', '1 ', 'unit', 'normalized', ...
        'position',[.32, .92, .15, .04], 'fontsize', 18, 'fontweight', 'bold', 'callback', @stay_time_distr_fig_taz_id);
    %初始化均显示为TAZ=1的情况
    type_taz1 = stay_time_distr{1, 5};
    switch type_taz1
        case 1
            typestr_taz1 = 'kernel density';
        case 2
            typestr_taz1 = 'normal';
        case 3
            typestr_taz1 = 'log-normal';
    end
    x_taz1 = stay_time_distr{1, 3};
    f_taz1 = stay_time_distr{1, 4};
    distr_type_str = uicontrol('parent', stay_time_distr_fig, 'style', 'text', 'string', ['Distribution: ', typestr_taz1], 'unit', 'normalized', ...
        'position',[.5, .9, .3, .06], 'fontsize', 18, 'fontweight', 'bold', 'backgroundcolor', 'w', 'userdata', 1);
    distr_axes = axes('parent', stay_time_distr_fig, 'unit', 'normalized', 'position', [.125, .1, .8, .775]);
    distr_plot = plot(x_taz1, f_taz1);
    xlabel('Stay Time (min)')
    ylabel('Probability Density')
    crt_xlim = get(gca, 'xlim');
    xlim([0 , crt_xlim(2)])
    set(gca, 'fontsize', 15)
end

%画各TAZ的停留时间分布时，调节TAZ编号时的callback
function stay_time_distr_fig_taz_id(hObject, eventdata, handles)
main_gui_h = findall(0 , 'type', 'figure', 'tag', 'figure1');
handles = guidata(main_gui_h);
stay_time_distr = handles.stay_time_distr;
NTAZ = handles.NTAZ;
stay_time_distr_fig = findall(0, 'type', 'figure','name','Probability Density Function of Stay Time Distribution');
taz_id_input = findall(stay_time_distr_fig, 'type', 'uicontrol', 'style', 'edit');
distr_type_str = findall(stay_time_distr_fig, 'type', 'uicontrol', 'style', 'text', 'userdata', 1);
distr_axes  = findall(stay_time_distr_fig, 'type', 'axes', 'position', [.125, .1, .8, .775]);
crtTAZ = get(taz_id_input, 'string');
try 
    crtTAZ = str2num(crtTAZ);
catch
    errordlg('Invalid input', 'Input Error')
    return
end
if round(crtTAZ)~=crtTAZ | crtTAZ<1 | crtTAZ>NTAZ
    errordlg('Invalid input', 'Input Error')
    return
elseif isempty(crtTAZ)
    set(distr_type_str, 'string',  '');
    cla(distr_axes);
else
    type_crtTAZ = stay_time_distr{crtTAZ, 5};
    switch type_crtTAZ
        case 1
            typestr_crtTAZ = 'kernel density';
        case 2
            typestr_crtTAZ = 'normal';
        case 3
            typestr_crtTAZ = 'log-normal';
    end
    x_crtTAZ = stay_time_distr{crtTAZ, 3};
    f_crtTAZ = stay_time_distr{crtTAZ, 4};
    
    set(distr_type_str, 'string', ['Distribution: ', typestr_crtTAZ]);
    cla(distr_axes);
    distr_plot = plot(x_crtTAZ, f_crtTAZ);
    xlabel('Stay Time (min)')
    ylabel('Probability Density')
    crt_xlim = get(gca, 'xlim');
    xlim([0 , crt_xlim(2)])
    set(gca, 'fontsize', 15)
end


% --------------------------------------------------------------------
function ind_stay_time_ober_Callback(hObject, eventdata, handles)
% hObject    handle to ind_stay_time_ober (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[fname , pname] = uigetfile('*.csv' , 'Open the Individual Stay Time Oberservation CSV');
if isequal(fname, 0) | isequal(pname, 0)
    return
end
fullname = strcat(pname,fname);

table_data = importdata(fullname);
if isfield(table_data, 'colheaders')
    colheaders = table_data.colheaders;
    TAZID_index = find(ismember(colheaders, 'TAZID'));
    if isempty(TAZID_index)
        TAZID_index = listdlg('PromptString','Select TAZ ID Variable:','SelectionMode','single',...
            'ListString',colheaders);
        if isempty(TAZID_index)
            return
        end
    end
    StayTime_index = find(ismember(colheaders, 'StayTime'));
    if isempty(StayTime_index)
        StayTime_index = listdlg('PromptString','Select Stay Time Variable:','SelectionMode','single',...
            'ListString',colheaders);
        if isempty(StayTime_index)
            return
        end
    end
    try
        stay_time_rawdata = csvread(fullname, 1, 0);
    catch
        errordlg('Unable to open the individual stay time CSV', 'Open Error')
        return
    end
    stay_time_rawdata = stay_time_rawdata(:, [TAZID_index, StayTime_index]);
else
    try
        stay_time_rawdata = csvread(fullname);
    catch
        errordlg('Unable to open the individual stay time CSV', 'Open Error')
        return
    end
end


%因为上面已经针对带表头的方式调整过了，下面的调整其实只是针对不带表头直接调的
if size(stay_time_rawdata, 2) == 1 | size(stay_time_rawdata, 2) > 3
    errordlg('Invalid data format', 'Open Error')
    return
end
if size(stay_time_rawdata, 2) == 3
    stay_time_rawdata = stay_time_rawdata(:, 2:3);
end
handles.stay_time_rawdata = stay_time_rawdata;
guidata(hObject, handles);
msgbox('Successfully input individual stay time observations')


% --------------------------------------------------------------------
function traffic_time_estimation_Callback(hObject, eventdata, handles)
% hObject    handle to traffic_time_estimation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isfield(handles, 'NTAZ')
    errordlg('You must firstly input Num. of TAZ', 'Error')
    return
else
    NTAZ = handles.NTAZ;
end
if ~isfield(handles, 'NENT')
    errordlg('You must firstly input Num. of entrace', 'Error')
    return
else
    NENT = handles.NENT;
end
if ~isfield(handles, 'space_time_path_rawdata')
    errordlg('You must firstly input spatiatemporal path data', 'Error')
    return
else
    space_time_path_rawdata = handles.space_time_path_rawdata;
end
hint_msgbox = traffic_time_hint();
waitfor(hint_msgbox)
[taz_taz_traffic_time, taz_ent_traffic_time, all_mean] = traffic_time_GUI(space_time_path_rawdata, NTAZ, NENT);
all_mean_mu = all_mean.mu;
all_mean_sigma = all_mean.sigma;
if isfield(handles, 'traffic_time')
    allready_have_instr = ['There allready exsit traffic time data, this module will partially replace them ',...
        'using non-empty observation means and stds, if there are no observations for some situatoins, original ',...
        'data will be kept, want to continue?'];
    choice = questdlg(allready_have_instr, 'Existing Data', 'Yes, using new data', 'No, give up', 'Yes, using new data');
    if isequal(choice, 'No, give up') | isempty(choice)
        return
    end
    traffic_time = handles.traffic_time;
else
    traffic_time = struct;
    traffic_time.taz.mu = ones(NTAZ) * all_mean_mu;
    traffic_time.taz.sigma = ones(NTAZ) * all_mean_sigma;
    traffic_time.ent.mu = ones(NTAZ, NENT) * all_mean_mu;
    traffic_time.ent.sigma = ones(NTAZ, NENT) * all_mean_sigma;
    traffic_time.para.dist_speed = [];
    traffic_time.para.stdf_speed = [];
    traffic_time.para.cv_beta = [];
end

lack_observation = 0;
all_situation = 0;
for i = 1 : NTAZ
    for j = i+1 : NTAZ
        if isnan(taz_taz_traffic_time.mu(i, j)) | isnan(taz_taz_traffic_time.sigma(i, j))
            lack_observation = lack_observation + 1;
            all_situation = all_situation + 1;
        else
            traffic_time.taz.mu(i, j) = taz_taz_traffic_time.mu(i, j);
            traffic_time.taz.mu(j, i) = taz_taz_traffic_time.mu(i, j);
            traffic_time.taz.sigma(i, j) = taz_taz_traffic_time.sigma(i, j);
            traffic_time.taz.sigma(j, i) = taz_taz_traffic_time.sigma(i, j);
        end
    end
end
for i = 1 : NTAZ
    for j = 1 : NENT
        if isnan(taz_ent_traffic_time.mu(i, j)) | isnan(taz_ent_traffic_time.sigma(i, j))
            lack_observation = lack_observation + 1;
            all_situation = all_situation + 1;
        else
            traffic_time.ent.mu(i, j) = taz_ent_traffic_time.mu(i, j);
            traffic_time.ent.sigma(i, j) = taz_ent_traffic_time.sigma(i, j);
        end
    end
end
lack_observation_prct = lack_observation / all_situation;
if ~isfield(handles, 'traffic_time') & lack_observation_prct > 0
    lack_obser_instr = ['There are ', 100*lack_observation_prct, '% of OD pairs lacking of ',...
        'observations, they are replaced using mean (' ,num2str(all_mean_mu) ,...
        ') and std (', num2str(all_mean_sigma), ') of all observations.'];
    lack_obwer_warn = warndlg(lack_obser_instr, 'Lack of Oberservations');
end
traffic_time_last_step_check_manually_modify(traffic_time, NTAZ, NENT)





% --------------------------------------------------------------------
function traffic_time_using_speed_Callback(hObject, eventdata, handles)
% hObject    handle to traffic_time_using_speed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isfield(handles, 'NTAZ')
    errordlg('You must firstly input Num. of TAZ', 'Error')
    return
else
    NTAZ = handles.NTAZ;
end
if ~isfield(handles, 'NENT')
    errordlg('You must firstly input Num. of entrace', 'Error')
    return
else
    NENT = handles.NENT;
end

adv_mode = handles.adv_mode;
if adv_mode == 0
    if ~isfield(handles, 'X_dist') | ~isfield(handles, 'X_dist_ent') | ~isfield(handles, 'X_stdf_ent') | ~isfield(handles, 'X_stdf')
        errordlg('You must firstly specify all distance-relte matrix', 'Error')
        return
    else
        X_dist = handles.X_dist;
        X_dist_ent = handles.X_dist_ent;
        X_stdf = handles.X_stdf;
        X_stdf_ent = handles.X_stdf_ent;
    end
else
    if isfield(handles, 'adv_var') & sum(ismember(handles.adv_var, 'Distance')) == 1 & ...
            isfield(handles.X_adv.dist, 'taz') & isfield(handles.X_adv.dist, 'ent') & ...
            ~isempty(handles.X_adv.dist.taz) & ~isempty(handles.X_adv.dist.ent)
        X_dist = handles.X_adv.dist.taz;
        X_dist_ent = handles.X_adv.dist.ent;
        if isfield(handles, 'adv_var') & sum(ismember(handles.adv_var, 'Stair(Difference)')) == 1 &...
                isfield(handles.X_adv.stdf, 'taz') & isfield(handles.X_adv.stdf, 'ent') &...
                ~isempty(handles.X_adv.stdf.taz) & ~isempty(handles.X_adv.stdf.ent)
            X_stdf = handles.X_adv.stdf.taz;
            X_stdf_ent = handles.X_adv.stdf.ent;
        else
            X_stdf = zeros(NTAZ);
            X_stdf_ent = zeros(NTAZ, NENT);
        end
    else
        errordlg('No distance matrix input or empty input.', 'Error')
        return
    end
end
hint_msgbox = traffic_time_hint();
waitfor(hint_msgbox)
if isfield(handles, 'traffic_time')
    allready_have_instr = ['There allready exsit traffic time data, this module will completely replace them, do you ',...
        'want to continue?'];
    choice = questdlg(allready_have_instr, 'Existing Data', 'Yes, using new data', 'No, give up', 'Yes, using new data');
    if isequal(choice, 'No, give up') | isempty(choice)
        return
    end
end
if isfield(handles, 'space_time_path_rawdata')
    space_time_path_rawdata = handles.space_time_path_rawdata;
    [taz_taz_traffic_time, taz_ent_traffic_time, all_mean] = traffic_time_GUI(space_time_path_rawdata, NTAZ, NENT);
    dist_stdf_regress_data = [];
    cv_regress_data = [];
    for i = 1 : NTAZ
        for j = i+1 : NTAZ
            if ~isnan(taz_taz_traffic_time.mu(i, j))
                dist_stdf_regress_data(end+1, [1, 2, 3]) = [X_dist(i, j), X_stdf(i, j),...
                    taz_taz_traffic_time.mu(i, j)];
                cv_regress_data(end+1, [1, 2]) = [taz_taz_traffic_time.mu(i, j), taz_taz_traffic_time.sigma(i, j)];
            end
        end
    end
    for i = 1 : NTAZ
        for j = 1 :NENT
            if ~isnan(taz_ent_traffic_time.mu(i, j))
                dist_stdf_regress_data(end+1, [1, 2, 3]) = [X_dist_ent(i, j), X_stdf_ent(i, j),...
                    taz_ent_traffic_time.mu(i, j)];
                cv_regress_data(end+1, [1, 2]) = [taz_ent_traffic_time.mu(i, j), taz_ent_traffic_time.sigma(i, j)];
            end
        end
    end
    dist_stdf_regress_beta = regress(dist_stdf_regress_data(:,3), dist_stdf_regress_data(:,1:2));
    dist_speed = 1 / dist_stdf_regress_beta(1);
    stdf_speed = 1 / dist_stdf_regress_beta(2);
    cv_beta = regress(cv_regress_data(:,2), cv_regress_data(:,1));
    
else
    dist_speed = 50;
    stdf_speed = 2;
    cv_beta = 0;
end
prompt = {'Enter the horizontal distance speed (m/min), if there exist spatiotemporal path data, estimated speed is set as default:',...
    'Enter the vertical stair speed (floor/min), if there exist spatiotemporal path data, estimated speed is set as default: ',...
    'Enter the CV (coefficient of variation = std / mean) of traffic time: ' };
dlg_title = 'Speed Definition';
num_lines = 1;
default_speed = {num2str(dist_speed),num2str(stdf_speed), num2str(cv_beta)};
speed_def = inputdlgWC(prompt, dlg_title, num_lines, default_speed);
if isempty(speed_def) 
    return
end
try 
    dist_speed = str2num(speed_def{1});
    stdf_speed = str2num(speed_def{2});
    cv_beta = str2num(speed_def{3});
catch
    errordlg('Invalid input', 'Error')
    return
end
if isempty(dist_speed) | isempty(stdf_speed) | isempty(cv_beta)
    return
elseif dist_speed < 0 | stdf_speed < 0 | cv_beta < 0
    errordlg('All values must be non-negative', 'Error')
    return
end
traffic_time = struct;
traffic_time.taz.mu = X_dist / dist_speed + X_stdf / stdf_speed;
traffic_time.taz.sigma = (X_dist / dist_speed + X_stdf / stdf_speed) * cv_beta;
traffic_time.ent.mu = X_dist_ent / dist_speed + X_stdf_ent / stdf_speed;
traffic_time.ent.sigma = (X_dist_ent / dist_speed + X_stdf_ent / stdf_speed) * cv_beta;
traffic_time.para.dist_speed = dist_speed;
traffic_time.para.stdf_speed = stdf_speed;
traffic_time.para.cv_beta = cv_beta;
traffic_time_last_step_check_manually_modify(traffic_time, NTAZ, NENT)

function traffic_time_last_step_check_manually_modify(traffic_time, NTAZ, NENT)
taz_taz_from_to = [];
ent_taz_from_to = [];
for i =  1 : NTAZ
    for j = i+1 :NTAZ
        taz_taz_from_to(end+1, :) = [i, j, traffic_time.taz.mu(i,j), traffic_time.taz.sigma(i, j)];
    end
end
for i = 1 : NENT
    for j = 1 : NTAZ
        ent_taz_from_to(end+1, :) = [i, j, traffic_time.ent.mu(j, i), traffic_time.ent.sigma(j, i)];
    end
end

all_figs = findall(0, 'type', 'figure');
for af_i = 1 : length(all_figs)
    crt_fig_in_all_figs = all_figs(af_i);
    if ~isequal(get(crt_fig_in_all_figs, 'tag') , 'figure1')
        delete(crt_fig_in_all_figs)
    end
end
check_traffic_time_fig = figure('Name' , 'Check and Modify Traffic Time' , 'NumberTitle' , 'off',...
    'Unit', 'normalized', 'Position', [.2 .1 .6 .8], 'Color', 'w', ...
    'Menubar', 'none');
set(check_traffic_time_fig , 'userdata', traffic_time);
str1 = uicontrol('parent', check_traffic_time_fig, 'style', 'text', 'string', 'From TAZs To TAZs: ',...
    'Unit', 'normalized', 'Position', [.1 .9 .35 .05], 'backgroundColor', 'w', 'fontsize', 15, 'fontweight', 'bold');
str2 = uicontrol('parent', check_traffic_time_fig, 'style', 'text', 'string', 'From Entrances To TAZs: ',...
    'Unit', 'normalized', 'Position', [.55 .9 .35 .05], 'backgroundColor', 'w', 'fontsize', 15, 'fontweight', 'bold');
taz_taz_table = uitable('parent', check_traffic_time_fig, 'Unit', 'normalized', 'Position', [.1 .05 .35 .85],...
    'data', taz_taz_from_to , 'columnName', {'FromID', 'ToID', 'Mu', 'Sigma'},'ColumnEditable', [false false true true],...
    'CellEditCallback', @traffic_time_check_table_edit);
ent_taz_table = uitable('parent', check_traffic_time_fig, 'Unit', 'normalized', 'Position', [.55 .15 .35 .75],...
    'data', ent_taz_from_to , 'columnName', {'FromID', 'ToID', 'Mu', 'Sigma'},'ColumnEditable', [false false true true],...
    'CellEditCallback', @traffic_time_check_table_edit);
set(taz_taz_table, 'userdata', taz_taz_from_to);
set(ent_taz_table, 'userdata', ent_taz_from_to);
check_traffic_time_ok = uicontrol('parent', check_traffic_time_fig, 'Unit', 'normalized', 'Position', [.55 .05 .35 .08],...
    'style', 'pushbutton' ,'callback', @check_traffic_time_ok_callback, 'string', 'OK', 'fontsize', 18, 'fontweight', 'bold');

function check_traffic_time_ok_callback(hObject, eventdata, handles)
crt_fig_h = findall(0, 'type', 'figure', 'name', 'Check and Modify Traffic Time');
taz_taz_table = findall(crt_fig_h, 'type', 'uitable', 'position', [.1 .05 .35 .85]);
ent_taz_table = findall(crt_fig_h, 'type', 'uitable', 'position', [.55 .15 .35 .75]);
taz_taz_from_to = get(taz_taz_table, 'data');
ent_taz_from_to = get(ent_taz_table, 'data');
traffic_time = get(crt_fig_h, 'userdata');
for i = 1 : size(taz_taz_from_to, 1)
    from = taz_taz_from_to(i, 1);
    to = taz_taz_from_to(i, 2);
    mu = taz_taz_from_to(i, 3);
    sigma = taz_taz_from_to(i, 4);
    traffic_time.taz.mu(from, to) = mu;
    traffic_time.taz.mu(to, from) = mu;
    traffic_time.taz.sigma(from, to) = sigma;
    traffic_time.taz.sigma(to, from) = sigma;
end
for i = 1 : size(ent_taz_from_to, 1)
    from = ent_taz_from_to(i, 1);
    to = ent_taz_from_to(i, 2);
    mu = ent_taz_from_to(i, 3);
    sigma = ent_taz_from_to(i, 4);
    traffic_time.ent.mu(to, from) = mu;
    traffic_time.ent.sigma(to, from) = sigma;
end
main_fig = findall(0 , 'type', 'figure', 'tag', 'figure1');
% if isempty(main_fig)
%     main_fig = findall(0, 'type', 'figure', 'name', 'Commercial Complex SIMlator (Advance Mode)');
% end
handles = guidata(main_fig);
handles.traffic_time= traffic_time;
guidata(main_fig, handles);
close(crt_fig_h)
 
function traffic_time_check_table_edit(hTab, event)
origin_data = get(hTab, 'userdata');
if isempty(event.Error)
    data = get(hTab, 'Data');
    iRow = event.Indices(1);
    iCol = event.Indices(2);
    if ~isnumeric(data(iRow, iCol)) | data(iRow, iCol) < 0 
        errordlg('Invalid input', 'Error')
        data_back2origin = data;
        data_back2origin(iRow, iCol) = origin_data(iRow, iCol);
        set(hTab, 'data', data_back2origin);
        return
    end
end
    


function [taz_taz_traffic_time, taz_ent_traffic_time, all_mean] = traffic_time_GUI(space_time_path_rawdata, NTAZ, NENT)
%为了估计交通时间而写的小程序，输入的space_time_path_rawdata是一个cell，其中，第一列是消费者编号；
%第二列是入口信息（1*2：入口编号，入口时间），第三列是TAZ信息（N*3：TAZ编号，TAZ时间，TAZ停留）
taz_taz_traffic_time_mu = nan(NTAZ, NTAZ);
taz_taz_traffic_time_sigma = nan(NTAZ, NTAZ);
taz_ent_traffic_time_mu = nan(NTAZ, NENT);
taz_ent_traffic_time_sigma = nan(NTAZ, NENT);
taz_taz_traffic_time_rawdata = cell(NTAZ, NTAZ);
taz_ent_traffic_time_rawdata = cell(NTAZ, NENT);
all_rawdata = [];
for i = 1 : size(space_time_path_rawdata, 1)
    crt_ent_data = space_time_path_rawdata{i, 2};
    crt_path_data = space_time_path_rawdata{i, 3};
    crt_entID = crt_ent_data(1);
    first_tazID = crt_path_data(1, 1);
    try
        crt_entTime = WDtimeConvert(crt_ent_data(2), 1);
        first_tazTime = WDtimeConvert(crt_path_data(1, 2), 1);
    catch
        errordlg('Invalid data format: check your time data', 'Error');
    end
    taz_ent_traffic_time_rawdata{first_tazID, crt_entID}(end+1) = [max(0, first_tazTime - crt_entTime)];
    all_rawdata(end + 1) = [max(0, first_tazTime - crt_entTime)];
    if size(crt_path_data, 1)  >= 2
        for k = 1 : size(crt_path_data, 1) - 1
            crt_path_crt_taz = crt_path_data(k, 1);
            crt_path_next_taz = crt_path_data(k+1, 1);
            crt_path_crt_stay = crt_path_data(k, 3);
            try
                crt_path_crt_time = WDtimeConvert(crt_path_data(k, 2), 1);
                crt_path_next_time = WDtimeConvert(crt_path_data(k+1, 2), 1);
            catch
                errordlg('Invalid data format: check your time data', 'Error');
            end
            taz_taz_traffic_time_rawdata{crt_path_crt_taz, crt_path_next_taz}(end+1) = max(0, crt_path_next_time  - (crt_path_crt_time + crt_path_crt_stay));
            taz_taz_traffic_time_rawdata{crt_path_next_taz, crt_path_crt_taz}(end+1) = max(0, crt_path_next_time  - (crt_path_crt_time + crt_path_crt_stay));
            all_rawdata(end+1) = max(0, crt_path_next_time  - (crt_path_crt_time + crt_path_crt_stay));
        end
    end
end

for i = 1 : NTAZ
    for j = 1 :NTAZ
        if i == j
            taz_taz_traffic_time_mu(i, j) = 0;
            taz_taz_traffic_time_sigma(i, j) = 0;
        elseif i ~= j & ~isempty(taz_taz_traffic_time_rawdata{i, j})
            taz_taz_traffic_time_mu(i, j) = mean(taz_taz_traffic_time_rawdata{i, j});
            taz_taz_traffic_time_sigma(i, j) = std(taz_taz_traffic_time_rawdata{i, j});
        elseif i ~= j & isempty(taz_taz_traffic_time_rawdata{i, j})
            taz_taz_traffic_time_mu(i, j) = nan;
            taz_taz_traffic_time_sigma(i, j) = nan;
        end
    end
end
for i = 1 : NTAZ
    for j = 1 : NENT
        if ~isempty(taz_ent_traffic_time_rawdata{i, j})
            taz_ent_traffic_time_mu(i, j) = mean(taz_ent_traffic_time_rawdata{i, j});
            taz_ent_traffic_time_sigma(i, j) = std(taz_ent_traffic_time_rawdata{i, j});
        else
            taz_ent_traffic_time_mu(i, j) = nan;
            taz_ent_traffic_time_sigma(i, j) = nan;
        end
    end
end
taz_taz_traffic_time.mu = taz_taz_traffic_time_mu;
taz_taz_traffic_time.sigma = taz_taz_traffic_time_sigma;
taz_ent_traffic_time.mu = taz_ent_traffic_time_mu;
taz_ent_traffic_time.sigma = taz_ent_traffic_time_sigma;
all_mean_mu = mean(all_rawdata);
all_mean_sigma = std(all_rawdata);
all_mean.mu = all_mean_mu;
all_mean.sigma = all_mean_sigma;



       


% --------------------------------------------------------------------
function traffic_time_directly_input_Callback(hObject, eventdata, handles)
% hObject    handle to traffic_time_directly_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isfield(handles, 'NTAZ')
    errordlg('You must firstly input Num. of TAZ', 'Error')
    return
else
    NTAZ = handles.NTAZ;
end
if ~isfield(handles, 'NENT')
    errordlg('You must firstly input Num. of entrace', 'Error')
    return
else
    NENT = handles.NENT;
end
hint_msgbox = traffic_time_hint();
waitfor(hint_msgbox)
if isfield(handles, 'traffic_time')
    allready_have_instr = ['There allready exsit traffic time data, this module will completely replace them, do you ',...
        'want to continue?'];
    choice = questdlg(allready_have_instr, 'Existing Data', 'Yes, using new data', 'No, give up', 'Yes, using new data');
    if isequal(choice, 'No, give up') | isempty(choice)
        return
    end
end
prompt = {'Enter the mean traffic time for all situations (min), if you have spatiotemporal path, the sample mean will be set as default: ',...
    'Enter the standard deviation of traffic time for all situations, if you have spatiotemporal path, the sample std will be set as default: ' };
dlg_title = 'Time Definition';
num_lines = 1;
if isfield(handles, 'space_time_path_rawdata')
    space_time_path_rawdata = handles.space_time_path_rawdata;
    [taz_taz_traffic_time, taz_ent_traffic_time, all_mean] = traffic_time_GUI(space_time_path_rawdata, NTAZ, NENT);
    default_time = {num2str(all_mean.mu), num2str(all_mean.sigma)};
else
    default_time = {'5', '0'};
end
time_def = inputdlgWC(prompt, dlg_title, num_lines, default_time);
if isempty(time_def) 
    return
end
try 
    mean_traffic_time = str2num(time_def{1});
    std_traffic_time = str2num(time_def{2});
catch
    errordlg('Invalid input', 'Error')
    return
end
if isempty(mean_traffic_time) | isempty(std_traffic_time) 
    return
elseif std_traffic_time < 0 | mean_traffic_time < 0
    errordlg('All values must be non-negative', 'Error')
    return
end
traffic_time = struct;
taz_mu = mean_traffic_time * ones(NTAZ);
taz_sigma = std_traffic_time * ones(NTAZ);
for i = 1 : NTAZ
    taz_mu(i, i) = 0;
    taz_sigma(i, i) = 0;
end
traffic_time.taz.mu = taz_mu;
traffic_time.taz.sigma = taz_sigma;
traffic_time.ent.mu = mean_traffic_time * ones(NTAZ, NENT);
traffic_time.ent.sigma = std_traffic_time * ones(NTAZ, NENT);
traffic_time.para.dist_speed = [];
traffic_time.para.stdf_speed = [];
traffic_time.para.cv_beta = [];
traffic_time_last_step_check_manually_modify(traffic_time, NTAZ, NENT)


% --------------------------------------------------------------------
function spatiotemporal_simulation_Callback(hObject, eventdata, handles)
% hObject    handle to spatiotemporal_simulation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
adv_mode = handles.adv_mode;
% 简单模式
if adv_mode == 0
    % --- Firstly Check the Data.
    tic;
    hw = waitbar(0 , 'Prepare and Check Data. Please Wait.','Name', 'Simulation Process');
    if isfield(handles, 'NTAZ')
        NTAZ = handles.NTAZ;
    else
        errordlg('Num. of TAZ is neccessary')
        close(hw)
        return
    end
    if isfield(handles, 'NPED')
        NPED = handles.NPED;
    else
        errordlg('Num. of Consumers is neccessary')
        close(hw)
        return
    end
    if isfield(handles, 'NENT')
        NENT = handles.NENT;
    else
        errordlg('Num. of ENT is neccessary')
        close(hw)
        return
    end
    if isfield(handles, 'b_area')
        b_area = handles.b_area;
    else
        b_area = 0.0001;
    end
    if isfield(handles , 'b_familarity')
        b_familarity = handles.b_familarity;
    else
        b_familarity = 1.4;
    end
    if isfield(handles , 'b_dist')
        b_dist = handles.b_dist;
    else
        b_dist = -0.01;
    end
    if isfield(handles , 'b_stdf')
        b_stdf = handles.b_stdf;
    else
        b_stdf = -0.4;
    end
    if isfield(handles , 'b_visited')
        b_visited = handles.b_visited;
    else
        b_visited = -1.5;
    end
    if isfield(handles , 'b_past')
        b_past = handles.b_past;
    else
        b_past = 0.6;
    end
    
    % CCSSR input %
    B.area = b_area;
    B.familarity = b_familarity;
    B.dist = b_dist;
    B.stdf = b_stdf;
    B.visited = b_visited;
    B.past = b_past;
    
    if isfield(handles , 'X_area')
        X_area = handles.X_area;
    else
        errordlg('Area data is neccessary')
        close(hw)
        return
    end
    if isfield(handles , 'X_dist')
        X_dist = handles.X_dist;
    else
        errordlg('Horizontal distance matrix among TAZs is neccessary')
        close(hw)
        return
    end
    if isfield(handles , 'X_dist_ent')
        X_dist_ent = handles.X_dist_ent;
    else
        errordlg('Horizontal distance matrix between TAZs and entrances is neccessary')
        close(hw)
        return
    end
    if isfield(handles , 'X_stdf')
        X_stdf = handles.X_stdf;
    else
        errordlg('Vertical distance matrix(in stairs) among TAZs is neccessary')
        close(hw)
        return
    end
    if isfield(handles, 'X_stdf_ent')
        X_stdf_ent = handles.X_stdf_ent;
    else
        errordlg('Vertical distance matrix(in stairs) between TAZs and entrances is neccessary')
        close(hw)
        return
    end
    
    % CCSSR input %
    EV.area = X_area;
    EV.dist = X_dist;
    EV.dist_ent = X_dist_ent;
    EV.stdf = X_stdf;
    EV.stdf_ent = X_stdf_ent;
    EV.NTAZ = NTAZ;
    EV.NENT = NENT;
    
    if isfield(handles , 'X_familarity')
        X_familarity = handles.X_familarity;
        % 先简单处理下：如果是集合熟悉度，那就都一样地用这个，如果是不存在，就都设成0
        % 只有一种可能性：是个体熟悉度，但个体数又不等于模拟人数，这种情况在单次模拟中
        % 再去抽样吧
        if size(X_familarity , 2) == 1
            X_familarity = repmat(X_familarity , 1 , NPED);
        end
    else
        X_familarity = zeros(NTAZ , NPED);
    end
    
    if isfield(handles , 'X_ent_distrib')
        X_ent_distrib = handles.X_ent_distrib;
        %     X_ent_distrib = X_ent_distrib(: , 2);
    else
        errordlg('Sptial distributoin of consumers among entrances is neccessary')
        close(hw)
        return
    end
    
    %入口时间分布
    if isfield(handles, 'EntTime_distrib_type') & isfield(handles, 'EntTime_distrib')
        EntTime_distrib_type = handles.EntTime_distrib_type;
        EntTime_distrib = handles.EntTime_distrib;
        if EntTime_distrib_type == 1 & length(EntTime_distrib) ~= NPED
            errordlg(['You ask to use individual-level exact entry time, but ', ...
                'the Num. of entry time data do not equal with the Num. of individuals ',...
                'you want to simulate.'], 'Error')
            close(hw)
            return
        end
    else
        %如果没有指定入口时间分布，则用默认值
        if isfield(handles, 'X_ind_ent_time') & size(handles.X_ind_ent_time, 1) == NPED
            %如果有个体入口时间的精确记录，且与模拟人数一样，这就是要看模拟精度的，就用精确记录
            EntTime_distrib_type = 3;
            X_ind_ent_time = handles.X_ind_ent_time;
            X_ind_ent_time = sortrows(X_ind_ent_time, 1);
            EntTime_distrib = X_ind_ent_time(:, 2);             %不要第1列的消费者ID
            use_EntTiem_distr = 0;      %不用分布
        elseif isfield(handles, 'X_ind_ent_time') & size(handles.X_ind_ent_time, 1) ~= NPED
            %虽然有个体入口时间的精确记录，但与模拟人数不一样，只能用分布
            use_EntTiem_distr = 1;
        elseif ~isfield(handles, 'X_ind_ent_time') 
            %没有个体记录，只能用分布
            use_EntTiem_distr = 1;
        end
        if use_EntTiem_distr == 1
            if ~isfield(handles, 'ent_time_distr')
                errordlg('You must firstly set the entry time distribution, check ''Data''-''Input Time Data''-''Entry Time''.', ...
                    'Entry Time Distribution Error');
                close(hw)
                return
            else
                ent_time_distr = handles.ent_time_distr;
                if ent_time_distr.type == 1
                    EntTime_distrib_type = 1;
                    EntTime_distrib = ent_time_distr.pd;
                else
                    EntTime_distrib_type = 2;
                    EntTime_distrib = ent_time_distr.ent_time_cdf_define;
                end
            end
        end
    end

    % CCSSR input  %
    IND.EntTime_distrib_type = EntTime_distrib_type;
    IND.EntTime_distrib = EntTime_distrib;
    IND.ent_distrib = X_ent_distrib;
    IND.familarity = X_familarity;
    IND.NPED = NPED;
    %-------------
    %设定停留时间与交通时间
    if  isfield(handles, 'stay_time_distr')
        stay_time_distr = handles.stay_time_distr;
    else
        errordlg('You must firstly set the stay time distribution, check ''Data''-''Input Time Data''-''TAZ Stay Time''.',...
            'Error')
        close(hw)
        return
    end
    if  isfield(handles, 'traffic_time')
        traffic_time = handles.traffic_time;
    else
        errordlg('You must firstly set the traffic time, check ''Data''-''Input Time Data''-''Traffic Time''.',...
            'Error')
        close(hw)
        return
    end
    TM.StayTime = stay_time_distr;
    TM.TrafficTime = traffic_time;
    
    % --- Firstly Check the Data: Finished.
    waitbar(0 , hw , 'Begin Simulation')
    
    
    % set(handles.Sim , 'BackgroundColor' , [0.831 , 0.816 , 0.784])
    % set(handles.Sim , 'BackgroundColor' , [0.831 , 0.816 , 0.784])
    
    % --- Then Run the Simulatoin.
    
    if isfield(handles, 'b_sim_times')
        b_sim_times = handles.b_sim_times;
    else
        b_sim_times = 10;
    end
    toc_sim_start = toc;
    for i = 1 : b_sim_times
        [ result_ped , result_taz ] = CCSSRwithTIME_GUI(EV,IND, B, TM);
        result(i).ped = result_ped;
        result(i).taz = result_taz;
        process = i / b_sim_times;
        waitbar(process , hw , ['Simulation Process: ', num2str(i), ' of ', ...
            num2str(b_sim_times), ', ', num2str(round(process*100)) , '%'])
    end
    toc_sim_end = toc;
    % --- Then Run the Simulatoin: Finished.
    waitbar(1 , hw , 'Simulatoin Finished, Prepare Results')
    handles.Sim_result = result;
end

% 高级模式 （2016/03/01 - ）
if adv_mode == 1
    % --- Firstly Check the Data.
    tic;
    hw = waitbar(0 , 'Prepare and Check Data. Please Wait.','Name', 'Simulation Process');
    if isfield(handles, 'adv_var')
        adv_var = handles.adv_var;
    else
        errordlg('Definition of variables is neccessary in advance mode.')
        close(hw)
        return
    end
    if isfield(handles, 'NTAZ')
        NTAZ = handles.NTAZ;
    else
        errordlg('Num. of TAZ is neccessary.')
        close(hw)
        return
    end
    if isfield(handles, 'NPED')
        NPED = handles.NPED;
    else
        errordlg('Num. of Consumers is neccessary.')
        close(hw)
        return
    end
    if isfield(handles, 'NENT')
        NENT = handles.NENT;
    else
        errordlg('Num. of ENT is neccessary.')
        close(hw)
        return
    end
    if isfield(handles, 'beta_adv')
        beta_adv = handles.beta_adv;
    else
        errordlg('User-defined coefficients are neccessary in advance mode.')
        close(hw)
        return
    end
    
    
    % CCSSR input %
    B = beta_adv;
    
    if ~isfield(handles, 'X_adv')
        errordlg('Some independent varaibles are incomplete.')
        close(hw)
        return
    else                    %将变量分类后，准备检查是否所有的X都已经有数值而不是空（除了动态更新的）
        X_adv = handles.X_adv;
        all_var = fieldnames(X_adv);
        %对变量进行分类：一列的属性，二维的矩阵，特殊的有可能会不一样的变量(familarity)，以及动态变量
        var_col = cell(0);
        var_mat = cell(0);
        var_dyn = cell(0);
        var_fam = cell(0);
        for ii = 1 : length(all_var)
            if isequal(all_var{ii}, 'dist') | isequal(all_var{ii}, 'stdf')
                var_mat{end+1} = all_var{ii};
            elseif isequal(all_var{ii}, 'past') | isequal(all_var{ii}, 'visited')
                var_dyn{end+1} = all_var{ii};
            elseif isequal(all_var{ii}, 'familarity')
                var_fam{end+1} = all_var{ii};
            else
                var_col{end+1} = all_var{ii};
            end
        end
    end
    
    if exist('var_col', 'var') & length(var_col) >= 1
        for ii = 1 : length(var_col)                %不允许有空value，除了动态变量
            if isempty(getfield(X_adv, var_col{ii}))
                crt_col_name = var_col{ii};
                if isequal(crt_col_name, 'familarity')      %换换名字
                    crt_col_name = 'Attractiveness';
                elseif isequal(crt_col_name, 'area')
                    crt_col_name = 'Area';
                elseif isequal(crt_col_name, 'past')
                    crt_col_name = 'Past';
                elseif isequal(crt_col_name, 'visited')
                    crt_col_name = 'Visited';
                end
                errordlg(['Incomplete independent variable input:  ''', crt_col_name, ''''])
                close(hw)
                return
            end
        end
    end
    
    if exist('var_mat', 'var') & length(var_mat) >= 1
        for ii = 1 : length(var_mat)                %对于矩阵变量，要检查是否两个矩阵都有了
            crt_var_mat = var_mat{ii};
            if ~isfield(getfield(X_adv, crt_var_mat), 'taz') | isempty(getfield(getfield(X_adv, crt_var_mat), 'taz')) | ...
                    ~isfield(getfield(X_adv, crt_var_mat), 'ent') | isempty(getfield(getfield(X_adv, crt_var_mat), 'ent'))
                if isequal(crt_var_mat, 'dist')         %改一下名字
                    crt_var_mat = 'Distance';
                elseif isequal(crt_var_mat, 'stdf')
                    crt_var_mat = 'Stair';
                end
                errordlg(['Incomplete independent variable input (matrix):  ''', crt_var_name, ''''])
                close(hw)
                return
            end
        end
    end
    
    %familarity的策略是：如果本身就是二维个体级的，不动，如果本身是一维集合层面的，按所有人相同扩展到二维，
    %如果没有这个变量，那生成一个全是0的，然后再在B中补充一个0系数。
    %最后，再在X_adv中把它去掉（因为这个时候肯定有这个变量了），加到个体IND这个结构体中。
    if exist('var_fam', 'var') & length(var_fam) == 1
        if isempty(getfield(X_adv, var_fam{1}))
            errordlg(['Incomplete independent variable input:  ''Attractiveness'''])
            close(hw)
            return
        else
            X_familarity = getfield(X_adv, var_fam{1});
            if size(X_familarity, 2) == 1
                 X_familarity = repmat(X_familarity , 1 , NPED);
                 X_adv = setfield(X_adv, 'familarity', X_familarity);
            end
        end
    else            %如果没有定义familarity，就加上一个全是0的
        X_familarity = zeros(NTAZ , NPED);
        X_adv = setfield(X_adv, 'familarity', X_familarity);
        B = setfield(B, familarity, 0);
    end
            

    % CCSSR input %
    EV.NTAZ = NTAZ;
    EV.NENT = NENT;
    EV.X = rmfield(X_adv, 'familarity');
    
    
    if isfield(handles , 'X_ent_distrib')
        X_ent_distrib = handles.X_ent_distrib;
        %     X_ent_distrib = X_ent_distrib(: , 2);
    else
        errordlg('Sptial distributoin of consumers among entrances is neccessary')
        close(hw)
        return
    end
    
    %入口时间分布
    if isfield(handles, 'EntTime_distrib_type') & isfield(handles, 'EntTime_distrib')
        EntTime_distrib_type = handles.EntTime_distrib_type;
        EntTime_distrib = handles.EntTime_distrib;
        if EntTime_distrib_type == 3 & length(EntTime_distrib) ~= NPED
            errordlg(['You ask to use individual-level exact entry time, but ', ...
                'the Num. of entry time data do not equal with the Num. of individuals ',...
                'you want to simulate.'], 'Error')
            close(hw)
            return
        end
    else
        %如果没有指定入口时间分布，则用默认值
        if isfield(handles, 'X_ind_ent_time') & size(handles.X_ind_ent_time, 1) == NPED
            %如果有个体入口时间的精确记录，且与模拟人数一样，这就是要看模拟精度的，就用精确记录
            EntTime_distrib_type = 3;
            X_ind_ent_time = handles.X_ind_ent_time;
            X_ind_ent_time = sortrows(X_ind_ent_time, 1);
            EntTime_distrib = X_ind_ent_time(:, 2);             %不要第1列的消费者ID
            use_EntTiem_distr = 0;      %不用分布
        elseif isfield(handles, 'X_ind_ent_time') & size(handles.X_ind_ent_time, 1) ~= NPED
            %虽然有个体入口时间的精确记录，但与模拟人数不一样，只能用分布
            use_EntTiem_distr = 1;
        elseif ~isfield(handles, 'X_ind_ent_time')
            %没有个体记录，只能用分布
            use_EntTiem_distr = 1;
        end
        if use_EntTiem_distr == 1
            if ~isfield(handles, 'ent_time_distr')
                errordlg('You must firstly set the entry time distribution, check ''Data''-''Input Time Data''-''Entry Time''.', ...
                    'Entry Time Distribution Error');
                close(hw)
                return
            else
                ent_time_distr = handles.ent_time_distr;
                if ent_time_distr.type == 1
                    EntTime_distrib_type = 1;
                    EntTime_distrib = ent_time_distr.pd;
                else
                    EntTime_distrib_type = 2;
                    EntTime_distrib = ent_time_distr.ent_time_cdf_define;
                end
            end
        end
    end
    
    % CCSSR input  %
    IND.EntTime_distrib_type = EntTime_distrib_type;
    IND.EntTime_distrib = EntTime_distrib;
    IND.ent_distrib = X_ent_distrib;
    IND.familarity = X_familarity;
    IND.NPED = NPED;
    
    %-------------
    %设定停留时间与交通时间
    if  isfield(handles, 'stay_time_distr')
        stay_time_distr = handles.stay_time_distr;
    else
        errordlg('You must firstly set the stay time distribution, check ''Data''-''Input Time Data''-''TAZ Stay Time''.',...
            'Error')
        close(hw)
        return
    end
    if  isfield(handles, 'traffic_time')
        traffic_time = handles.traffic_time;
    else
        errordlg('You must firstly set the traffic time, check ''Data''-''Input Time Data''-''Traffic Time''.',...
            'Error')
        close(hw)
        return
    end
    TM.StayTime = stay_time_distr;
    TM.TrafficTime = traffic_time;
    
    %如果有时间变量
    if isfield(handles, 'time_var')
        time_var = handles.time_var;
        for tvi = 1 : length(time_var)
            time_var_name{tvi} = time_var{tvi}.name;
        end
    else
        time_var = [];
        time_var_name = [];
    end
    TM.time_var = time_var;
    
    
    % --- Firstly Check the Data: Finished.
    waitbar(0 , hw , 'Begin Simulation')
    
    
    % set(handles.Sim , 'BackgroundColor' , [0.831 , 0.816 , 0.784])
    % set(handles.Sim , 'BackgroundColor' , [0.831 , 0.816 , 0.784])
    
    % --- Then Run the Simulatoin.
    
    if isfield(handles, 'b_sim_times')
        b_sim_times = handles.b_sim_times;
    else
        b_sim_times = 10;
    end
    toc_sim_start = toc;
    
    %所有变量名
    all_var_name = fieldnames(B);
    for ki = 1 : length(all_var_name)
        if ~isequal(all_var_name{ki}, 'familarity') & ~isfield(EV.X, all_var_name{ki}) & sum(ismember(time_var_name, all_var_name{ki})) ~= 1
            %既不是familarity(分到了INV变量里，也不EV.X的正常变量，也不是时间变量)
            errordlg('Something strange happen.(varaible in B can not be found in X), see error 3012.')
            close(hw)
            return
        end
    end
    if length(all_var_name) ~= length(fieldnames(EV.X)) + 1 + length(time_var_name)
        %总系数个数 = 一般环境变量数 + 1个familarity + 时间变量数（无时为空，即为0个）
        errordlg('Something strange happen.(varaible in B can not be found in X), see error 3013.')
        close(hw)
        return
    end
    
    %把all_var_name（所有变量名）分成非时间变量与时间变量，这里不直接用setdiff命令，是为了怕打乱顺序
    non_time_var_name = cell(0);
    for vi = 1 : length(all_var_name)
        if sum(ismember(time_var_name   , all_var_name{vi})) == 0
            non_time_var_name{end+1} = all_var_name{vi};
        end
    end
    VN.non_time_var_name = non_time_var_name;
    VN.time_var_name = time_var_name;
    
    %-----------------------------%
    %2016-3-21: 如果queue_on，要用更复杂的模式
    use_dyn_mode = 0;
    if handles.queue_on == 1 & isfield(handles, 'capacity')
        use_dyn_mode = 1;
    elseif handles.queue_on == 1 & ~isfield(handles, 'capacity')
        errordlg('Something strange happens, use queue on mode but no capacity defined, error 6290.', 'Error')
        close(hw)
        return
    end
    if isfield(handles, 'dyn_var')
        dyn_var = handles.dyn_var;
        if dyn_var.volumn.use == 1
            use_dyn_mode = 1;
        end
        if dyn_var.density.use == 1
            if ~isfield(handles, 'base_area')
                errordlg('You have defined density dynamic variable, but base area data is not provided.', 'Error')
                close(hw)
                return
            end
            use_dyn_mode = 1;
        end
        if dyn_var.queue.use == 1
            if ~isfield(handles, 'capacity')
                errordlg('You have defined queue time dynamic variable, but capacity data is not provided.', 'Error')
                close(hw)
                return
            end
            use_dyn_mode = 1;
        end
    end
    
    for i = 1 : b_sim_times
        %-----------------------------%
        %2016-3-21: 如果queue_on，要用更复杂的模式
        if use_dyn_mode == 0
            [ result_ped , result_taz ] = CCSSRwithTime_GUI_adv(EV,IND, B, VN, TM);
        elseif use_dyn_mode == 1
            %准备DY数据
            if isfield(handles, 'capacity')
                TAZ_Capacity = handles.capacity;
            else
                TAZ_Capacity - inf(NTAZ, 1);
            end
            if isfield(handles, 'base_area')
                TAZ_BaseArea = handles.base_area;
            else
                TAZ_BaseArea = inf(NTAZ, 1);
            end
            if isfield(handles, 'dyn_var')
                X_beta_dynamic = handles.dyn_var;
            else
                X_beta_dynamic.volumn.use = 0;
                X_beta_dynamic.volumn.type = 1;
                X_beta_dynamic.volumn.value = [-inf; 0];
                X_beta_dynamic.density.use = 0;
                X_beta_dynamic.density.type = 1;
                X_beta_dynamic.density.value = [-inf; 0];
                X_beta_dynamic.queue.use = 0;
                X_beta_dynamic.queue.type = 1;
                X_beta_dynamic.queue.value = [-inf; 0];
            end
            DV.TAZ_Capacity = TAZ_Capacity;
            DV.TAZ_BaseArea = TAZ_BaseArea;
            DV.X_beta_dynamic = X_beta_dynamic;
            [ result_ped , result_taz, TimelyTAZ_Stat, TimeSerie ] = ...
                    CCSSRwithTimeDynamic_GUI_adv(EV,IND, B, VN, TM, DV);
            dyn_result(i).taz = TimelyTAZ_Stat;
            dyn_result(i).time_series = TimeSerie;
        end
        result(i).ped = result_ped;
        result(i).taz = result_taz;
        process = i / b_sim_times;
        waitbar(process , hw , ['Simulation Process: ', num2str(i), ' of ', ...
            num2str(b_sim_times), ', ', num2str(round(process*100)) , '%'])
    end
    toc_sim_end = toc;
    % --- Then Run the Simulatoin: Finished.
    waitbar(1 , hw , 'Simulatoin Finished, Prepare General Results')
    handles.Sim_result = result;
end
%模拟完成，开始分析结果
% --- Simulation result analysis
for i = 1 : b_sim_times
    crt_rst = result(i);
    crt_rst_taz = crt_rst.taz;
    crt_rst_taz(end , :) = [];                      %去掉回家
    crt_rst_taz = crt_rst_taz(: , 2);               %去掉TAZ编号
    Sim_taz_distrib(: , i) = crt_rst_taz;
    crt_rst_ped = crt_rst.ped;
    %------以下：OD统计-------%
    crt_OD_3d = zeros(NTAZ , NTAZ);
    for j = 1 : NPED
        crt_ped_path = crt_rst_ped{j , 3};
        for k = 1 : size(crt_ped_path, 2)-1
            crt_ped_path_from = crt_ped_path(1, k);
            crt_ped_path_to = crt_ped_path(1, k + 1);
            crt_OD_3d(crt_ped_path_from , crt_ped_path_to) = crt_OD_3d(crt_ped_path_from , crt_ped_path_to)+1;
        end
    end
    OD_3d(:,:,i) = crt_OD_3d;
    %------以上：OD统计-------%
    crt_gn = llz_gn(ones(NTAZ , 1) , crt_rst_taz , 0);
    crt_cv = std(crt_rst_taz) / mean(crt_rst_taz);
    crt_rst_ped_actpp = cell2mat(crt_rst_ped(: , 4));
    Sim_actpp(: , i) = crt_rst_ped_actpp;
    Sim_gn(i , 1) = crt_gn;
    Sim_cv(i , 1) = crt_cv;
    Sim_mean_actpp(i , 1) = mean(crt_rst_ped_actpp);
end


Sim_mean_OD = mean(OD_3d , 3);
Sim_mean_taz_distrib = mean(Sim_taz_distrib , 2);
Sim_mean_gn = llz_gn(ones(NTAZ , 1) , Sim_mean_taz_distrib , 0);
Sim_mean_cv = std(Sim_mean_taz_distrib) / mean(Sim_mean_taz_distrib);
handles.Sim_mean_OD = Sim_mean_OD;
handles.Sim_OD_3d = OD_3d;
handles.Sim_gn = Sim_gn;
handles.Sim_cv = Sim_cv;
handles.Sim_mean_actpp = Sim_mean_actpp;
handles.Sim_taz_distrib = Sim_taz_distrib;
handles.Sim_mean_taz_distrib = Sim_mean_taz_distrib;
handles.Sim_mean_gn = Sim_mean_gn;
handles.Sim_mean_cv = Sim_mean_cv;
handles.b_sim_times = b_sim_times;
handles.Sim_actpp = Sim_actpp;
handles.space_time_result_flag = 1;
%-------------------------------%
%结果处理：时间统计：只有没有dynamic模拟时才需要
if ~exist('dyn_result', 'var')
    %主要参见space_time_simulate_rst_analysis.m，当时是打算写在一个单独的模块，由用户指定起止时间与步长的，后来觉得没必要
    %指定最小&最大时间与步长
    step_size = 1;
    entry_time = [];
    exit_time = [];
    for i = 1 : length(result)
        entry_time = [entry_time; cell2mat(result(i).ped(:,5))];
        exit_time = [exit_time; cell2mat(result(i).ped(:,6))];
    end
    start_time = min(entry_time);
    end_time = max(exit_time);
    crtTime = start_time;
    %时间统计的间隔，time_statistic_interval,_diff是以分钟差形式,_origin是原始的1940形式
    time_stat_intv_diff = WDtimeConvert(start_time, 1) : step_size : WDtimeConvert(end_time, 1);
    time_stat_intv_origin = WDtimeConvert(time_stat_intv_diff, 3);
    waitbar(0 , hw , 'General Results Finished, Prepare Timely Results')
    for i = 1 : length(result)
        process = i / length(result);
        waitbar(process , hw , ['Timely Results Preparing: For Simulation No. ', num2str(i), ' of ', ...
            num2str(b_sim_times), ', ', num2str(round(process*100)) , '%'])
        crt_path_cell = result(i).ped;
        NPED = size(crt_path_cell, 1);
        crt_timely_taz_stat = zeros(NTAZ , length(time_stat_intv_diff));
        %入口、回游相关统计
        for j = 1 : NPED
            crt_ped_entrance = crt_path_cell{j,2};
            crt_ped_path_with_TIME = crt_path_cell{j,3};
            crt_ped_path = crt_ped_path_with_TIME(1,:);
            crt_ped_path_StartTime = crt_ped_path_with_TIME(2,:);
            crt_ped_path_LastTime = crt_ped_path_with_TIME(3,:);
            for k=1 : length(crt_ped_path)-1
                %时间统计
                crt_ped_crt_start_time = crt_ped_path_StartTime(k);
                crt_ped_next_start_time = crt_ped_path_StartTime(k+1);
                crt_ped_crt_start_time2 = WDtimeConvert(crt_ped_crt_start_time,1);      %后缀2为分钟差形式
                crt_ped_next_start_time2 = WDtimeConvert(crt_ped_next_start_time,1);
                crt_ped_crt_last_time = crt_ped_path_LastTime(k);
                for kk = 1 : length(time_stat_intv_diff)
                    %                 if time_stat_intv_diff(kk) >= crt_ped_crt_start_time2  &  time_stat_intv_diff(kk) < crt_ped_next_start_time2
                    if time_stat_intv_diff(kk) >= crt_ped_crt_start_time2  &  ...
                            time_stat_intv_diff(kk) < crt_ped_crt_start_time2 + crt_ped_crt_last_time
                        %以前是不考虑交通时间的，现在把交通时间剔掉，逻辑是：在小区A起始时间 < 兴趣时间 < 在小区A结束时间（以前是在下一个小区起始时间）
                        %那么在兴趣时间点这一时刻（不是用的时间区间，而是一个时间切片），他一定还在小区A
                        %比如：当前活动开始时间（crt_ped_crt_start_time2）为9:00，加上活动持续时间60m，活动末要走时为10：00，统计时间为9:30，即930>900且930<1000，那么显然此时正在
                        crt_timely_taz_stat(crt_ped_path(k) , kk) = crt_timely_taz_stat(crt_ped_path(k) , kk) + 1;
                        %-------------------%有争议，如果严格到当时的时间切片瞬间的话，这种大（统计区间）包小（活动区间）的情况，小区间就不被
                        %统计到了，但确实也没办法，想想也是，
                        %如果一个超级大的区间（9：00~22：00），几乎所有的活动都成了大包小，总不能把人都算进去啊，防止这种情况只能细化时间区间，比如用5分钟尺度，下面
                        %105-107行的comment类似
                        %                 elseif kk<=length(time_stat_intv_diff)-1 & time_stat_intv_diff(kk) < crt_ped_crt_start_time2 & ...
                        %                         time_stat_intv_diff(kk) < crt_ped_next_start_time2  & time_stat_intv_diff(kk+1) >= crt_ped_crt_start_time2 + crt_ped_crt_last_time
                        %                     %这里可能有点争议，考虑的情况是，如果时间切片画的太大，比如9：00-10：00，但消费者在9:20-9:40去了一个小区，那么它在这个小区的停留就不会被任何时间点记录到
                        %                     %所以才加了这么一段，算是他在一个以当前切片点为起点的时间区间内来过
                        %                     crt_timely_taz_stat(crt_ped_path(k) , kk) = crt_timely_taz_stat(crt_ped_path(k) , kk) + 1;
                    end
                end
            end
            %最后一步要用到持续时间
            crt_ped_EndAction_start_time = crt_ped_path_StartTime(end);
            crt_ped_EndAction_start_time2 = WDtimeConvert(crt_ped_EndAction_start_time,1);
            crt_ped_EndAction_over_time2 = crt_ped_EndAction_start_time2 + crt_ped_path_LastTime(end);
            for kk=1:length(time_stat_intv_diff)
                if time_stat_intv_diff(kk) >= crt_ped_EndAction_start_time2 & time_stat_intv_diff(kk) <= crt_ped_EndAction_over_time2
                    crt_timely_taz_stat(crt_ped_path(end) , kk) = crt_timely_taz_stat(crt_ped_path(end) , kk) + 1;
                    %             elseif kk<=length(time_stat_intv_diff)-1 & time_stat_intv_diff(kk) < crt_ped_crt_start_time2 ...
                    %                     & time_stat_intv_diff(kk) < crt_ped_next_start_time2  & time_stat_intv_diff(kk+1) >= crt_ped_next_start_time2
                    %                 crt_timely_taz_stat(crt_ped_path(end),kk) = crt_timely_taz_stat(crt_ped_path(end),kk) + 1;
                end
            end
            
        end
        timely_taz_stat(:,:,i)=crt_timely_taz_stat;
    end
    timely_taz_stat_mean = mean(timely_taz_stat , 3);                           %将多次模拟的结果平均
    timely_taz_stat_result.detail = timely_taz_stat;
    timely_taz_stat_result.mean = timely_taz_stat_mean;
    timely_taz_stat_result.time_par = [start_time; step_size; end_time];
    timely_taz_stat_result.time_stat_intv_origin = time_stat_intv_origin;
    timely_taz_stat_result.time_stat_intv_diff = time_stat_intv_diff;
end

if exist('dyn_result', 'var')               %如果是通过dynamic模拟的，就会有这个结果
    handles.dyn_result = dyn_result;
    all_time_series = [];
     for i = 1 : length(dyn_result)
        crt_time_series = dyn_result(i).time_series;
        all_time_series = [all_time_series, crt_time_series];
     end
     start_time = min(all_time_series);
        end_time = max(all_time_series);
     step_size = 1;
     time_stat_intv_diff = WDtimeConvert(start_time, 1) : step_size: WDtimeConvert(end_time, 1);
     time_stat_intv_origin = WDtimeConvert(time_stat_intv_diff, 3);
    for i = 1 : length(dyn_result)
        crt_time_series = dyn_result(i).time_series;
        crt_start_time = min(crt_time_series);
        crt_end_time = max(crt_time_series);
        crt_add_before = zeros(NTAZ, WDtimeConvert(crt_start_time, 1) - WDtimeConvert(start_time, 1));
        crt_add_after = zeros(NTAZ, WDtimeConvert(end_time, 1) - WDtimeConvert(crt_end_time, 1));
        crt_volumn_result = dyn_result(i).taz.TAZ_NIND;
        crt_queue_population_result = dyn_result(i).taz.TAZ_Queue;
        crt_queue_time_result = dyn_result(i).taz.TAZ_QueueTime;
        timely_taz_stat(:,:,i) = [crt_add_before, crt_volumn_result, crt_add_after];
        timely_taz_queue_population(:,:,i) = [crt_add_before, crt_queue_population_result, crt_add_after];
        timely_taz_queue_time(:,:,i) = [crt_add_before, crt_queue_time_result,crt_add_after];
    end
    timely_taz_stat_mean = mean(timely_taz_stat , 3);                           %将多次模拟的结果平均
    timely_taz_stat_result.detail = timely_taz_stat;
    timely_taz_stat_result.mean = timely_taz_stat_mean;
    timely_taz_stat_result.time_par = [start_time; step_size; end_time];
    timely_taz_stat_result.time_stat_intv_diff = time_stat_intv_diff;
    timely_taz_stat_result.time_stat_intv_origin = time_stat_intv_origin;
    
    timely_taz_queue_population_mean = mean(timely_taz_queue_population , 3);                           %将多次模拟的结果平均
    timely_taz_queue_population_result.detail = timely_taz_queue_population;
    timely_taz_queue_population_result.mean = timely_taz_queue_population_mean;
    timely_taz_queue_population_result.time_par = [start_time; step_size; end_time];
    timely_taz_queue_population_result.time_stat_intv_diff = time_stat_intv_diff;
    timely_taz_queue_population_result.time_stat_intv_origin = time_stat_intv_origin;
    
    timely_taz_queue_time_mean = mean(timely_taz_queue_time , 3);                           %将多次模拟的结果平均
    timely_taz_queue_time_result.detail = timely_taz_queue_time;
    timely_taz_queue_time_result.mean = timely_taz_queue_time_mean;
    timely_taz_queue_time_result.time_par = [start_time; step_size; end_time];
    timely_taz_queue_time_result.time_stat_intv_diff = time_stat_intv_diff;
    timely_taz_queue_time_result.time_stat_intv_origin = time_stat_intv_origin;
    
    handles.timely_taz_queue_population_result = timely_taz_queue_population_result;
    handles.timely_taz_queue_time_result = timely_taz_queue_time_result;
end

handles.timely_taz_stat_result = timely_taz_stat_result;
guidata(hObject, handles);
waitbar(1 , hw , 'All Results Finished')
close(hw)
toc_all_end = toc;
tt_time = toc_all_end;
single_time = (toc_sim_end - toc_sim_start) / b_sim_times;
set(handles.clocker_tt, 'String' , num2str(tt_time))
set(handles.clocker_single, 'String' , num2str(single_time))



% --------------------------------------------------------------------
function boundary_condition_Callback(hObject, eventdata, handles)
% hObject    handle to bc_distribution_at_entrances (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function bc_entry_time_distribution_Callback(hObject, eventdata, handles)
% hObject    handle to bc_entry_time_distribution (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%这一步其实没啥意思，就是说用分布，还是用exact数据
if ~isfield(handles, 'NPED')
    errordlg('You must firtly set the Num. of individual in simulation.', 'Error')
    return
else
    NPED = handles.NPED;
end

[choice_rst ,ok] = listdlg(...
    'ListString'  , {'Aggregate: Using Distribution','Individual Level: Using Exact Indivudial Infromation'},...
    'SelectionMode', 'single', 'Name', 'Entrance Distribution Data', ...
    'ListSize', [270, 120]);
if ok == 0
    return
end
switch choice_rst
    case 1
        if ~isfield(handles , 'ent_time_distr')
            errordlg('There is NO aggregation-level entry time distributoin data.', 'Entry Time Distribution Eroor');
            return
        else
            ent_time_distr = handles.ent_time_distr;
            if ent_time_distr.type == 1
                EntTime_distrib_type = 1;
                EntTime_distrib = ent_time_distr.pd;
            else
                EntTime_distrib_type = 2;
                EntTime_distrib = ent_time_distr.ent_time_cdf_define;
            end
        end
    case 2
        if ~isfield(handles , 'X_ind_ent_time')
            errordlg('There is NO aggregate entrance distribution data in Entrance-CSV file', 'Eroor');
            return
        else
            X_ind_ent_time = handles.X_ind_ent_time;
            if size(X_ind_ent_time, 1) ~= NPED
                errordlg('The Num. of individual observations do NOT match with Num. of simulation individuals, please swtich to aggregation methods.', 'Eroor');
                return
            end
            EntTime_distrib_type = 3;
            EntTime_distrib = sortrows(X_ind_ent_time, 1);
            EntTime_distrib = EntTime_distrib(:, 2);
        end
end
handles.EntTime_distrib_type = EntTime_distrib_type;
handles.EntTime_distrib = EntTime_distrib;
guidata(hObject, handles);


% --------------------------------------------------------------------
function set_NPED_Callback(hObject, eventdata, handles)
% hObject    handle to set_NPED (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
nped = inputdlgWC('Pless input the Num. of individuals you want to simulate.', 'Input');
if isempty(nped)
    return
end
try 
    nped = str2num(nped{:});
catch
    errordlg('Invalid input.', 'Error')
    return
end
if nped <= 0 | nped ~= round(nped) | isnan(nped) | isempty(nped)
    errordlg('Num. of individuals must be a positive integer.', 'Error')
    return
else
    handles.NPED = nped;
    set(handles.Num_Ped, 'string', num2str(nped));
    guidata(hObject, handles);
end



% --------------------------------------------------------------------
function dynamic_rst_display_Callback(hObject, eventdata, handles)
% hObject    handle to dynamic_rst_display (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


function [time_intv_4stat_column_index, full_data_after, time_intv_stat_after]  = ...
    set_dynamic_display_time_intv(time_intv_stat, full_data_before, start_time, end_time, step_size)
% set(handles.dynamic_rst_display, 'userdata', []);
% 输入：time_intv_stat：统计结果中所使用的时间间隔，有可能不变输出，但也有可能加头加尾输出，输出为time_intv_stat_after
% full_data_before：输入统计结果，有可能不变输出，但也有可能加头加尾输出，输出为fulldata_after
% 输出：time_intv_4stat_column_index：显示所用的时间间隔在统计所用的时间间隔中的索引查找
%----------------------%
% 设定结果的起始时间与时间距
full_data_after = full_data_before; 
NTAZ = size(full_data_after, 1);
time_intv_display = WDtimeConvert(start_time, 1) : step_size : WDtimeConvert(end_time, 1);  %先用分钟差形式
time_intv_display = WDtimeConvert(time_intv_display, 3);                    %再转成1940形式，后缀display表示这个时间定义是用来显示的
%有可能出现显示的最早/最晚时间早于/晚于统计的最早最晚时间，这样就需要补全
if WDtimeConvert(start_time, 1) < WDtimeConvert(time_intv_stat(1), 1)
    %在前面加
    add_ahead = WDtimeConvert(WDtimeConvert(start_time, 1) : 1 : WDtimeConvert(time_intv_stat(1), 1)-1 , 3);
    time_intv_stat = [add_ahead , time_intv_stat];
    full_data_after = [zeros(NTAZ, length(add_ahead)) , full_data_after];     %full_data的行是TAZ，列是时间
end
if WDtimeConvert(end_time, 1) > WDtimeConvert(time_intv_stat(end), 1)
    add_after = WDtimeConvert(WDtimeConvert(time_intv_stat(end), 1)+1 : 1 : WDtimeConvert(end_time, 1), 3);
    time_intv_stat = [time_intv_stat, add_after];
    full_data_after = [full_data_after, zeros(NTAZ, length(add_after))];     %full_data的行是TAZ，列是时间
end
time_intv_stat_after = time_intv_stat;
[found_flag, which_column] = ismember(time_intv_display, time_intv_stat);
if ~isequal(found_flag, ones(1, length(time_intv_display))) | ~isempty(find(which_column == 0))
    %有的显示区间没找到
    errordlg('Something strange happen, see error 3820', 'Error')
    return
else
    time_intv_4stat_column_index = which_column;
end
% set(handles.dynamic_rst_display, 'userdata', which_column);


% --------------------------------------------------------------------
function dynamic_ind_distr_sim_Callback(hObject, eventdata, handles)
% hObject    handle to dynamic_ind_distr_sim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close_other_figurs()
if ~isfield(handles, 'NTAZ')
    errordlg('You must firstly set the Num. of TAZ', 'Error')
    return
else
    NTAZ = handles.NTAZ;
end
if ~isfield(handles, 'NENT')
    errordlg('You must firstly set the Num. of Entrances', 'Error')
    return
else
    NENT = handles.NENT;
end
if ~isfield(handles, 'timely_taz_stat_result')
    errordlg('There is NO spatiotemporal simulation result.', 'Error')
    return
else
    timely_taz_stat_result = handles.timely_taz_stat_result;
end
full_data_before = timely_taz_stat_result.mean;                                    %full data是指精确到每一分的完整时间统计数据
if isfield(handles, 'dyn_rst_play_start_time')
    start_time = handles.dyn_rst_play_start_time;
else
    start_time = 900;
end
if isfield(handles, 'dyn_rst_play_end_time')
    end_time = handles.dyn_rst_play_end_time;
else
    end_time = 2300;
end
if isfield(handles, 'dyn_rst_play_step_size')
    step_size = handles.dyn_rst_play_step_size;
else
    step_size = 30;
end
time_intv_stat_before = timely_taz_stat_result.time_stat_intv_origin;
try
    [time_intv_4stat_column_index, full_data, time_intv_stat]  = ...
        set_dynamic_display_time_intv(time_intv_stat_before, full_data_before, ...
        start_time, end_time, step_size);
catch
    return
end
data = full_data(:, time_intv_4stat_column_index);
time_name = time_intv_stat(time_intv_4stat_column_index);

if ~isfield(handles , 'Z_factor')
    Z_factor = str2double(get(handles.edit_Z_factor, 'String'));
else
    Z_factor = handles.Z_factor
end
if ~isfield(handles , 'marker_size')
    marker_size = 5;
else
    marker_size = handles.marker_size;
end

main_fig = findall(0, 'tag', 'figure1');
main_axes = handles.axes1;
% set(main_axes, 'visible', 'off')
% cla reset
for i = 1 : length(time_name)
    crt_time = time_name(i);
    crt_h = floor(crt_time / 100);
    crt_m = crt_time - 100*crt_h; 
    crt_h = num2str(crt_h);
    crt_m = num2str(crt_m);
    if length(crt_h) == 1
        crt_h = strcat('0', crt_h);
    end
    if length(crt_m) == 1
        crt_m = strcat('0', crt_m);
    end
    time_str{i} = [crt_h, ':', crt_m];
end
    
% set(gcf,'color','w')
% axis equal
% axis off
set(handles.axes1, 'Position', [0.007, 0.02, 0.62, 0.97]);
if ~isfield(handles, 'XYZ')
    errordlg('No TAZ Data', 'TAZ Data');
    return
else
    XYZ = handles.XYZ;
end
xyz = XYZ;              %不用全局变量，用局部变量-----以前把XYZ设成global了，现在就不改了
xyz(:,4) = xyz(:,4) * Z_factor;             %竖向拉开
max_x = max(xyz(:,2));
min_x = min(xyz(:,2));
max_y = max(xyz(:,3));
min_y = min(xyz(:,3));
max_z = max(xyz(:,4));
median_x = (max_x + min_x) / 2;
median_y = (max_y + min_y) / 2;

invisible_fig = figure('visible', 'off','unit', get(main_fig, 'unit'), ...
    'position', get(main_fig, 'position'));
set(invisible_fig,'color','w')
%画底图
unique_XYZ = unique(xyz(: , 1));
for i = 1 : size(unique_XYZ)
    crtTAZindex = unique_XYZ(i);
    index = find(xyz(:,1) == crtTAZindex);
    hold on
    patch(xyz(index,2) , xyz(index,3) , xyz(index,4) , [0.8,0.8,0.8])
end
invisible_ax = findall(invisible_fig, 'type', 'axes');
set(invisible_ax , 'unit', get(gca, 'unit'), 'position', [0.007, 0.02, 0.62, 0.97]);
if isfield(handles , 'Ent_ON')  & isfield(handles , 'ENTXYZ')
    if handles.Ent_ON == 1
        entxyz = handles.ENTXYZ;
        entxyz = entxyz(:, 2:4);
        entxyz(:,3) = entxyz(:,3) * Z_factor;
        h_ent = plot3(entxyz(: , 1), entxyz(:, 2), entxyz(:, 3), 'kp','MarkerFacecolor', 'k');
        handles.h_ent = h_ent;
    end
end
axis off
%图形控制
set(gcf,'color','w')
axis equal
axis off
alpha(0.5)
az = handles.az;
el = handles.el;
view(az, el)
%-------------------------------%
%:以下这段原来是证明是可用的，想试试新方法
hw = waitbar(0 , 'Preparing');
for i = 1 : length(time_name)
    process = i/length(time_name);
    waitbar(process, hw, ['Preparing: ', num2str(round(100*process)), '%']);
    if exist('crt_fig_h', 'var') & ~isempty(crt_fig_h)
        for j = 1 : length(crt_fig_h)
            delete(crt_fig_h{j})
        end
    end
    crt_fig_h = WDplotTAZ_GUI(round(data(:,i)), xyz, 2, marker_size, invisible_ax);
    t = title(invisible_ax, ...
        time_str{i}, 'position', [median_x, median_y, max_z*1.07], 'fontsize', 15);
    F(i) = getframe(invisible_ax);
    [im(i).X, temp] = frame2im(F(i));
end
save('ccsim_redraw', 'im')
waitbar(1, hw, 'Finshed');
handles.F = F;
guidata(hObject, handles);
close(hw)
% %以前是用movie放的，现在不用了，另开一个figure动态放
% movie(gca, F, 1, 1)
if isfield(handles, 'dyn_rst_play_speed')
    speed = handles.dyn_rst_play_speed;
else
    speed = 1;
end
nframe = length(time_name);
all_time = nframe / speed;
str1 = ['1. The play speed is ', num2str(speed), ' fps, therefore the total playing duration would be ', num2str(all_time) ,' seconds, ',...
    'you can reset the speed by checking ''Predefined Parameters''-''Dynamic Result Play Speed''.'];
str2 = ['2. Press ''Enter'' to play / pause the viedo.'];
str3 = ['3. Press ''Right / left arrow'' to advance / go back one frame.'];
instr = msgbox(strvcat('Instructions: ', str1, str2, str3), 'Instructions');
waitfor(instr)
videofigWC(nframe, @ccsim_redraw, speed, [], [], 'name', 'CCSIM Spatiotemproal Simulation: Dynamic Result Player',...
    'unit', 'normalized', 'position', [.05 .05 .9 .9], 'numberTitle', 'off');




% --------------------------------------------------------------------
function standard_confi_Callback(hObject, eventdata, handles)
% hObject    handle to standard_confi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function save_standard_config_Callback(hObject, eventdata, handles)
% hObject    handle to save_standard_config (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isfield(handles, 'fname') & isfield(handles, 'pname')
    %如果是已知路径
    fname = handles.fname;
    pname = handles.pname;
    if isequal(fname, 0) | isequal(pname, 0)
        errordlg('Something strange happend, see error 2581','Error')
        return
    end
else
    [fname , pname] = uiputfile('*.mat' , 'Save the Configuration File');
    if isequal(fname, 0) | isequal(pname, 0)
        return
    end
end
save_standard_config_general_4_save_and_saveas(handles, fname, pname)
% 2016-3-20：保存完了要体现文件名
file_name = fname;
main_fig = findall(0, 'type', 'figure', 'tag', 'figure1');
if handles.adv_mode == 1
    set(main_fig, 'name', ['鼓浪屿游客行为模拟器'])
else
    set(main_fig, 'name', ['鼓浪屿游客行为模拟器'])
end
    
handles.fname = fname;
handles.pname = pname;
%已经保存过了之后，就要更新动态状态，以便于在关闭和新开时检查是否需要新保存
%注：无论是active_handles还是blank_handles都是不包括自己的
active_handles = rmfield(handles, {'blank_handles', 'active_handles'});
handles.active_handles  = active_handles;
guidata(hObject, handles)


function save_standard_config_general_4_save_and_saveas(handles, fname, pname)
adv_mode = handles.adv_mode;
if adv_mode == 1
    %高级模式
    config_h  = handles;                            %初始化为handles，再删除不要的
    %后来发现：其实X_familarity_ind并没有什么用，只是中间数据也被保存进了handles里
    call4_fields_list = {'NTAZ', 'XYZ', 'ENTXYZ', 'NENT', 'NPED', ...           %最基础的东西
        'user_def_var', 'selected_pre_def_var_value','adv_var', 'X_adv', 'time_var', 'X_familarity_ind',...         %变量及X
        'path_rawdata', 'space_time_path_rawdata', 'beta_adv', ...              %路径与系数
        'X_ind_ent', 'X_ind_ent_time', 'X_ent_distrib', 'X_ent_distrib_load_ind_derived','EntTime_distrib_type', 'EntTime_distrib' ,...%个体信息与出入口时空边界
        'ent_time_distr', 'stay_time_rawdata', 'stay_time_distr', 'traffic_time',...       %时间变量
        'Comp_TAZ_distrib', 'Comp_cv', 'Comp_gn', 'Comp_mean_actpp', 'Comp_OD',...          %比较数据
        'consume_rawdata','consume_prob', 'expenditure_distr',...            %消费数据
        'adv_mode', 'base_area', 'comp_timely_taz_stat_result', 'comp_expenditure_distr', 'dyn_var', 'capacity',...
        'queue_on'};          %模式，新增其它
    exist_var(1) = isfield(handles, 'NTAZ'); exist_var(2) = isfield(handles, 'XYZ'); exist_var(3) = isfield(handles, 'ENTXYZ');
    exist_var(4) = isfield(handles, 'NENT'); exist_var(5) = isfield(handles, 'NPED'); exist_var(6) = isfield(handles, 'user_def_var');
    exist_var(7) = isfield(handles, 'selected_pre_def_var_value'); exist_var(8) = isfield(handles, 'adv_var'); exist_var(9) = isfield(handles, 'X_adv');
    exist_var(10) = isfield(handles, 'time_var'); exist_var(11) = isfield(handles, 'X_familarity_ind'); exist_var(12) = isfield(handles, 'path_rawdata');
    exist_var(13) = isfield(handles, 'space_time_path_rawdata'); exist_var(14) = isfield(handles, 'beta_adv');
    exist_var(15) = isfield(handles, 'X_ind_ent'); exist_var(16) = isfield(handles, 'X_ind_ent_time'); exist_var(17) = isfield(handles, 'X_ent_distrib');
    exist_var(18) = isfield(handles, 'X_ent_distrib_load_ind_derived'); exist_var(19) = isfield(handles, 'EntTime_distrib_type'); exist_var(20) = isfield(handles, 'EntTime_distrib');
    exist_var(21) = isfield(handles, 'ent_time_distr'); exist_var(22) = isfield(handles, 'stay_time_rawdata');  exist_var(23) = isfield(handles, 'stay_time_distr');
    exist_var(24) = isfield(handles, 'traffic_time'); exist_var(25) = isfield(handles, 'Comp_TAZ_distrib'); exist_var(26) = isfield(handles, 'Comp_cv');
    exist_var(27) = isfield(handles, 'Comp_gn');    exist_var(28) = isfield(handles, 'Comp_mean_actpp');  exist_var(29) = isfield(handles, 'Comp_OD');
    exist_var(30) = isfield(handles, 'consume_rawdata');  exist_var(31) = isfield(handles, 'consume_prob');  exist_var(32) = isfield(handles, 'expenditure_distr'); 
    exist_var(33) = isfield(handles, 'adv_mode');  exist_var(34) = isfield(handles, 'base_area');  exist_var(35) = isfield(handles, 'comp_timely_taz_stat_result');
    exist_var(36) = isfield(handles, 'comp_expenditure_distr'); exist_var(37) = isfield(handles, 'dyn_var');
    exist_var(38) = isfield(handles, 'capacity');   exist_var(39) = isfield(handles, 'queue_on'); 
    call4_fields_list_exist = call4_fields_list(exist_var);                  %从中找到当前handles中有的字段
    to_delete = setdiff(fieldnames(handles),call4_fields_list_exist);
    config_h = rmfield(config_h, to_delete);
    tic;
    fullname = strcat(pname , fname);
    if exist(fullname, 'file')
        delete(fullname)
    end
    save(fullname, 'config_h');
    msgbox('Finished')
end
if adv_mode == 0
    %一般模式
    config_h  = handles;                            %初始化为handles，再删除不要的
    %后来发现：其实X_familarity_ind并没有什么用，只是中间数据也被保存进了handles里
    call4_fields_list = {'NTAZ', 'XYZ', 'ENTXYZ', 'NENT', 'NPED', ...           %最基础的东西
        'X_area', 'X_dist','X_dist_ent', 'X_stdf', 'X_stdf_ent', 'X_familarity',...         %变量及X
        'path_rawdata', 'space_time_path_rawdata', 'b_area', 'b_familarity', 'b_dist', 'b_stdf', 'b_visited', 'b_past',...              %路径与系数
        'X_ind_ent', 'X_ind_ent_time', 'X_ent_distrib', 'X_ent_distrib_load_ind_derived','EntTime_distrib_type', 'EntTime_distrib' ,...%个体信息与出入口时空边界
        'ent_time_distr', 'stay_time_rawdata', 'stay_time_distr', 'traffic_time',...       %时间变量
        'Comp_TAZ_distrib', 'Comp_cv', 'Comp_gn', 'Comp_mean_actpp', 'Comp_OD',...          %比较数据
        'consume_rawdata','consume_prob', 'expenditure_distr',...            %消费数据
        'adv_mode',...                                                          %模式
        'b_familarity_user', 'b_dist_user', 'b_stdf_user', 'b_visited_user', 'b_past_user', 'b_area_user',...%用户预定义参数   
        'base_area', 'comp_timely_taz_stat_result', 'comp_expenditure_distr', 'dyn_var', 'capacity', 'queue_on'};               %新增其它                                       
    exist_var(1) = isfield(handles, 'NTAZ'); exist_var(2) = isfield(handles, 'XYZ'); exist_var(3) = isfield(handles, 'ENTXYZ');
    exist_var(4) = isfield(handles, 'NENT'); exist_var(5) = isfield(handles, 'NPED'); exist_var(6) = isfield(handles, 'X_area');
    exist_var(7) = isfield(handles, 'X_dist'); exist_var(8) = isfield(handles, 'X_dist_ent'); exist_var(9) = isfield(handles, 'X_stdf');
    exist_var(10) = isfield(handles, 'X_stdf_ent'); exist_var(11) = isfield(handles, 'X_familarity'); exist_var(12) = isfield(handles, 'path_rawdata');
    exist_var(13) = isfield(handles, 'space_time_path_rawdata'); exist_var(14) = isfield(handles, 'b_area');
    exist_var(15) = isfield(handles, 'b_familarity'); exist_var(16) = isfield(handles, 'b_dist'); exist_var(17) = isfield(handles, 'b_stdf');
    exist_var(18) = isfield(handles, 'b_visited'); exist_var(19) = isfield(handles, 'b_past'); exist_var(20) = isfield(handles, 'X_ind_ent');
    exist_var(21) = isfield(handles, 'X_ind_ent_time'); exist_var(22) = isfield(handles, 'X_ent_distrib');  exist_var(23) = isfield(handles, 'X_ent_distrib_load_ind_derived');
    exist_var(24) = isfield(handles, 'EntTime_distrib_type'); exist_var(25) = isfield(handles, 'EntTime_distrib'); exist_var(26) = isfield(handles, 'ent_time_distr');
    exist_var(27) = isfield(handles, 'stay_time_rawdata');    exist_var(28) = isfield(handles, 'stay_time_distr');  exist_var(29) = isfield(handles, 'traffic_time');
    exist_var(30) = isfield(handles, 'Comp_TAZ_distrib');  exist_var(31) = isfield(handles, 'Comp_cv');  exist_var(32) = isfield(handles, 'Comp_gn'); 
    exist_var(33) = isfield(handles, 'Comp_mean_actpp');  exist_var(34) = isfield(handles, 'Comp_OD');  
    exist_var(35) = isfield(handles, 'consume_rawdata');  exist_var(36) = isfield(handles, 'consume_prob');  exist_var(37) = isfield(handles, 'expenditure_distr'); 
    exist_var(38) = isfield(handles, 'adv_mode'); 
    exist_var(39) = isfield(handles, 'b_familarity_user');  exist_var(40) = isfield(handles, 'b_dist_user'); 
    exist_var(41) = isfield(handles, 'b_stdf_user');  exist_var(42) = isfield(handles, 'b_visited_user'); 
    exist_var(43) = isfield(handles, 'b_past_user');  exist_var(44) = isfield(handles, 'b_area_user'); 
    exist_var(45) = isfield(handles, 'base_area');   exist_var(46) = isfield(handles, 'comp_timely_taz_stat_result');
    exist_var(47) = isfield(handles, 'comp_expenditure_distr');  exist_var(48) = isfield(handles, 'dyn_var');
    exist_var(49) = isfield(handles, 'capacity'); exist_var(50) = isfield(handles, 'queue_on');
    call4_fields_list_exist = call4_fields_list(exist_var);                  %从中找到当前handles中有的字段
    to_delete = setdiff(fieldnames(handles),call4_fields_list_exist);
    config_h = rmfield(config_h, to_delete);
    tic;
    fullname = strcat(pname , fname);
    if exist(fullname, 'file')
        delete(fullname)
    end
    save(fullname, 'config_h');
    msg = msgbox('Finished');
    waitfor(msg)
end


% --------------------------------------------------------------------
function open_standard_confi_Callback(hObject, eventdata, handles)
% hObject    handle to open_standard_confi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%没打开前，要清空现在数据，检查是否需要保存
temp1 = handles.active_handles;     %上一次保存/打开新文件/完全新开文件时的数据
temp2 = rmfield(handles, {'blank_handles', 'active_handles'});      %当前的数据
if ~isequaln(temp1, temp2)
    save_quest = questdlg('Do you want to save the current data to a standard configuration file?', 'Save',...
        'Yes', 'No', 'Yes');
    if strcmp(save_quest, 'Yes')
        save_standard_config_Callback(hObject, eventdata, handles)
    elseif isempty(save_quest)
        return
    end
end

% %打开之前先清空，暂时将clear_base_data的userdata设为0，不问直接关，然后再调回为1----曾经用clear base
% data做，现在改用先新建空白档的方式
% set(handles.clear_base_data, 'userdata', 0);
% clear_base_data_Callback(hObject, eventdata, handles)
% set(handles.clear_base_data, 'userdata', 1);
close_other_figurs()
adv_mode = handles.adv_mode;
% if adv_mode == 1
%     errordlg(['Save excel configuration files does NOT work for advance mode, ',...
%         'please switch to save standard configuration file.'], 'Error')
%     return
% end
[fname , pname] = uigetfile('*.mat' , 'Open the Configuration File');
if isequal(fname, 0) | isequal(pname, 0)
    return
end
tic;
fullname = strcat(pname , fname);
try
    load(fullname, 'config_h');
catch
    errordlg('Failed to open the standard configuration file.' , 'Open Error')
    return
end
%已经打开了新文件，就可以清空老数据了
blank_handles = handles.blank_handles;
handles = blank_handles;
handles.active_handles = blank_handles;
handles.blank_handles = blank_handles;          %复原到blank状态
handles.fname = fname;
handles.pname = pname;
cla reset
set(gcf,'color','w')
axis equal
axis off
set(handles.Num_TAZ, 'string', '')
set(handles.Num_ent, 'string', '')
set(handles.Num_Ped, 'string', '')
set(handles.AreaInput, 'string', 'Waiting for Input', 'Enable', 'on')
set(handles.FamInput, 'string', 'Waiting for Input', 'Enable', 'on')
set(handles.DistInput, 'string', 'Waiting for Input', 'Enable', 'on')
set(handles.StdfInput, 'string', 'Waiting for Input', 'Enable', 'on')
set(handles.e_a, 'string', '0.0001', 'style', 'edit')
set(handles.e_b, 'string', '1.4', 'style', 'edit')
set(handles.e_c, 'string', '-0.01', 'style', 'edit')
set(handles.edit_b_stdf, 'string', '-0.4', 'style', 'edit')
set(handles.edit_b_visited, 'string', '-1.5', 'style', 'edit')
set(handles.edit_b_past, 'string', '0.6', 'style', 'edit')
set(handles.edit_Comp_actpp, 'string', '')
set(handles.change_od_mode, 'checked', 'off')
file_name = 'Unnamed';
main_fig = findall(0 , 'type', 'figure', 'tag', 'figure1');
set(main_fig, 'name', ['鼓浪屿游客行为模拟器'])
set(handles.adv_def_var, 'enable', 'off')
set(handles.queue_on_check, 'enable', 'on');
set(handles.input_user_def_vars, 'enable', 'off');
set(handles.def_time_var, 'enable', 'off');
set(handles.def_dyn_var, 'enable', 'off');
set(handles.beta_panel, 'title', 'Behaivoral Coefficients')
set(handles.xs_panel, 'title', 'Explanatory Variables')
set(handles.use_predefine_with_fam, 'Enable', 'on');
set(handles.use_predefine_without_fam, 'Enable', 'on');
set(handles.use_user_define_coef, 'Enable', 'on');
set(handles.excel_confi_file, 'Enable', 'on');
set(handles.save_confi, 'Enable', 'on');
set(handles.open_confi, 'Enable', 'on');

guidata(hObject, handles)
config_fieldnames = fieldnames(config_h);
for i = 1 : length(config_fieldnames)
    handles = setfield(handles, config_fieldnames{i}, getfield(config_h, config_fieldnames{i}));
end
guidata(hObject, handles);
cla reset
set(gcf,'color','w')
axis equal
axis off
main_fig = findall(0 , 'type', 'figure', 'tag', 'figure1');
%---------------------------%
%数据导入之后的相关设置：一般设置（不考虑adv_mode）
if isfield(handles, 'NTAZ')
    set(handles.Num_TAZ, 'string', num2str(handles.NTAZ));
end
if isfield(handles, 'NENT')
    set(handles.Num_ent, 'string', num2str(handles.NENT));
end
if isfield(handles,  'NPED')
    set(handles.Num_Ped, 'string', num2str(handles.NPED));
end
if isfield(handles, 'Comp_mean_actpp')
    set(handles.edit_Comp_actpp, 'string', num2str(handles.Comp_mean_actpp));
end
%---------------------------%
%数据导入之后的相关设置：adv_mode相关设置

file_name = fname;
if handles.adv_mode == 1
    set(handles.use_advance, 'Checked','on')
    set(main_fig, 'name', ['鼓浪屿游客行为模拟器'])
    set(handles.beta_panel, 'title', 'Behaivoral Coefficients: NOT Available in Advance Mode')
    if ~isfield(handles, 'X_adv')
        set(handles.xs_panel, 'title', 'Explanatory Variables: Waiting for Variable Defination in Advance Mode')
        set(handles.AreaInput, 'string', 'Advance Mode', 'Enable', 'off')
        set(handles.FamInput, 'string', 'Advance Mode', 'Enable', 'off')
        set(handles.DistInput, 'string', 'Advance Mode', 'Enable', 'off')
        set(handles.StdfInput, 'string', 'Advance Mode', 'Enable', 'off')
    else
        X_adv = handles.X_adv;
        selected_pre_def_var_value = handles.selected_pre_def_var_value;
        num_used = sum(ismember([1 2 3 4], selected_pre_def_var_value));
        set(handles.AreaInput, 'string', 'N/A', 'Enable', 'off')
        set(handles.FamInput, 'string', 'N/A', 'Enable', 'off')
        set(handles.DistInput, 'string', 'N/A', 'Enable', 'off')
        set(handles.StdfInput, 'string', 'N/A', 'Enable', 'off')
        if num_used == 0
            set(handles.xs_panel, 'title', 'Explanatory Variables: None Variable is used in Advance Mode')
        else
            set(handles.xs_panel, 'title', 'Explanatory Variables: Some Variables are used in Advance Mode')
            if ismember(1, selected_pre_def_var_value)
                set(handles.AreaInput, 'string', 'Waiting for Input', 'Enable', 'on')
                if ~isempty(X_adv.area) & ~isnan(X_adv.area(1))
                    set(handles.AreaInput, 'string', 'Finished')
                end
            end
            if ismember(2, selected_pre_def_var_value)
                set(handles.FamInput, 'string', 'Waiting for Input', 'Enable', 'on')
                if ~isempty(X_adv.familarity) & ~isnan(X_adv.familarity(1))
                    if size(X_adv.familarity, 2) > 1
                        set(handles.FamInput, 'string', 'Finished: individual-level')
                    else
                        set(handles.FamInput, 'string', 'Finished: aggregate')
                    end
                end
            end
            if ismember(3, selected_pre_def_var_value)
                set(handles.DistInput, 'string', 'Waiting for Input', 'Enable', 'on')
                if isfield(X_adv.dist, 'taz')  & isfield(X_adv.dist, 'ent')
                    set(handles.DistInput, 'string', 'Finished')
                elseif isfield(X_adv.dist, 'taz')  & ~isfield(X_adv.dist, 'ent')
                    set(handles.DistInput, 'string', 'Need TAZ-Entrance Matrix')
                elseif ~isfield(X_adv.dist, 'taz')  & isfield(X_adv.dist, 'ent')
                    set(handles.DistInput, 'string', 'Need TAZ-TAZ Matrix')
                end
            end
            if ismember(4, selected_pre_def_var_value)
                set(handles.StdfInput, 'string', 'Waiting for Input', 'Enable', 'on')
                if isfield(X_adv.stdf, 'taz')  & isfield(X_adv.stdf, 'ent')
                    set(handles.StdfInput, 'string', 'Finished')
                elseif isfield(X_adv.stdf, 'taz')  & ~isfield(X_adv.stdf, 'ent')
                    set(handles.StdfInput, 'string', 'Need TAZ-Entrance Matrix')
                elseif ~isfield(X_adv.stdf, 'taz')  & isfield(X_adv.stdf, 'ent')
                    set(handles.StdfInput, 'string', 'Need TAZ-TAZ Matrix')
                end
            end
        end
    end
    set(handles.adv_def_var, 'enable', 'on');
    set(handles.queue_on_check, 'enable', 'on');
    set(handles.def_time_var, 'enable', 'on');
    set(handles.def_dyn_var, 'enable', 'on');
    set(handles.input_user_def_vars, 'enable', 'on');
    set(handles.e_a, 'string', 'N/A', 'style', 'text')
    set(handles.e_b, 'string', 'N/A', 'style', 'text')
    set(handles.e_c, 'string', 'N/A', 'style', 'text')
    set(handles.edit_b_stdf, 'string', 'N/A', 'style', 'text')
    set(handles.edit_b_visited, 'string', 'N/A', 'style', 'text')
    set(handles.edit_b_past, 'string', 'N/A', 'style', 'text')
    set(handles.use_predefine_with_fam, 'Enable', 'off');
    set(handles.use_predefine_without_fam, 'Enable', 'off');
    set(handles.use_user_define_coef, 'Enable', 'off');
    set(handles.excel_confi_file, 'Enable', 'off');
    set(handles.save_confi, 'Enable', 'off');
    set(handles.open_confi, 'Enable', 'off');
else
    set(handles.use_advance,'Checked','off');
    set(main_fig, 'name', ['鼓浪屿游客行为模拟器'])
    set(handles.adv_def_var, 'enable', 'off');
    set(handles.queue_on_check, 'enable', 'off');
    set(handles.input_user_def_vars, 'enable', 'off');
    set(handles.def_time_var, 'enable', 'off');
    set(handles.def_dyn_var, 'enable', 'off');
    set(handles.beta_panel, 'title', 'Behaivoral Coefficients');
    set(handles.xs_panel, 'title', 'Explanatory Variables');
    
    set(handles.AreaInput, 'string', 'Waiting for Input', 'Enable', 'on');
    set(handles.FamInput, 'string', 'Waiting for Input', 'Enable', 'on');
    set(handles.DistInput, 'string', 'Waiting for Input', 'Enable', 'on');
    set(handles.StdfInput, 'string', 'Waiting for Input', 'Enable', 'on');
    if isfield(handles, 'X_area') & ~isempty(handles.X_area) & ~isnan(handles.X_area(1))
        set(handles.AreaInput, 'string', 'Finished')
    end
    if isfield(handles, 'X_familarity') & ~isempty(handles.X_familarity) & ~isnan(handles.X_familarity(1))
        if size(handles.X_familarity, 2) > 1
            set(handles.FamInput, 'string', 'Finished: individual-level')
        else
            set(handles.FamInput, 'string', 'Finished: aggregate')
        end
    end
    if isfield(handles, 'X_dist') & ~isfield(handles, 'X_dist_ent') 
        set(handles.DistInput, 'string', 'Need TAZ-Entrance Matrix')
    elseif ~isfield(handles, 'X_dist') & isfield(handles, 'X_dist_ent') 
        set(handles.DistInput, 'string', 'Need TAZ-TAZ Matrix')
    elseif isfield(handles, 'X_dist') & isfield(handles, 'X_dist_ent') 
        set(handles.DistInput, 'string', 'Finished')
    end
    if isfield(handles, 'X_stdf') & ~isfield(handles, 'X_stdf_ent') 
        set(handles.StdfInput, 'string', 'Need TAZ-Entrance Matrix')
    elseif ~isfield(handles, 'X_stdf') & isfield(handles, 'X_stdf_ent') 
        set(handles.StdfInput, 'string', 'Need TAZ-TAZ Matrix')
    elseif isfield(handles, 'X_stdf') & isfield(handles, 'X_stdf_ent') 
        set(handles.StdfInput, 'string', 'Finished')
    end
    
    set(handles.use_predefine_with_fam, 'Enable', 'on');
    set(handles.use_predefine_without_fam, 'Enable', 'on');
    set(handles.use_user_define_coef, 'Enable', 'on');
    set(handles.excel_confi_file, 'Enable', 'on');
    set(handles.save_confi, 'Enable', 'on');
    set(handles.open_confi, 'Enable', 'on');
    if isfield(handles, 'b_area')
        set(handles.e_a, 'string', num2str(handles.b_area), 'style', 'Edit')
    else
        set(handles.e_a, 'string', '0.0001', 'style', 'Edit')
    end
    if isfield(handles, 'b_familarity')
        set(handles.e_b, 'string', num2str(handles.b_familarity), 'style', 'Edit')
    else
        set(handles.e_b, 'string', '1.4', 'style', 'Edit')
    end
    if isfield(handles, 'b_dist')
        set(handles.e_c, 'string', num2str(handles.b_dist), 'style', 'Edit')
    else
        set(handles.e_c, 'string', '-0.01', 'style', 'Edit')
    end
    if isfield(handles, 'b_stdf')
        set(handles.edit_b_stdf, 'string', num2str(handles.b_stdf), 'style', 'Edit')
    else
        set(handles.edit_b_stdf, 'string', '-0.4', 'style', 'Edit')
    end
    if isfield(handles, 'b_visited')
        set(handles.edit_b_visited, 'string', num2str(handles.b_visited), 'style', 'Edit')
    else
        set(handles.edit_b_visited, 'string', '-1.5', 'style', 'Edit')
    end
    if isfield(handles, 'b_past')
        set(handles.edit_b_past, 'string', num2str(handles.b_past), 'style', 'Edit')
    else
        set(handles.edit_b_past, 'string', '0.6', 'style', 'Edit')
    end
end
%打开完了，更新当前状态 
active_handles = rmfield(handles, {'blank_handles', 'active_handles'});
handles.active_handles  = active_handles;
guidata(hObject, handles);
msgbox('Successfully load standard configuration file.', 'Finished')


% --------------------------------------------------------------------
function dya_rst_play_time_Callback(hObject, eventdata, handles)
% hObject    handle to dya_rst_play_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
prompt = {'Enter the start time for dynamic result display (Format: HHMM):','Enter the end time for dynamic result display (Format: HHMM):',...
    'Enter the time step size for dynamic result display (Unit: min)'};
dlg_title = 'Time';
num_lines = 1;
default_interval = {'0900','2300', '30'};
time_interval_def = inputdlgWC(prompt, dlg_title, num_lines, default_interval);
if isempty(time_interval_def)
    return
end
try
    start_time = str2num(time_interval_def{1});
    end_time = str2num(time_interval_def{2});
    step_size = str2num(time_interval_def{3});
catch
    errordlg('Invalid input', 'Error')
    return
end
if isempty(start_time) | isempty(end_time) | isempty(step_size)
    return
elseif ~isempty(start_time) & (start_time<0 | start_time> 2400 | ~isequal(start_time, round(start_time)))
    errordlg('Invalid start time input', 'Error')
    return
elseif ~isempty(end_time) & (end_time<0 | end_time> 2400 | ~isequal(end_time, round(end_time)))
    errordlg('Invalid end time input', 'Error')
    return
elseif ~isempty(step_size) & (step_size<0 | ~isequal(step_size, round(step_size)))
    errordlg('Invalid step size input', 'Error')
    return
elseif WDtimeConvert(end_time, 1) < WDtimeConvert(start_time, 1)
    errordlg('End time should not be smaller than start time', 'Error')
    return
end
handles.dyn_rst_play_start_time = start_time;
handles.dyn_rst_play_end_time = end_time;
handles.dyn_rst_play_step_size = step_size;
guidata(hObject, handles);


% --------------------------------------------------------------------
function dya_rst_play_speed_Callback(hObject, eventdata, handles)
% hObject    handle to dya_rst_play_speed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
MS_str = ['This value control the play speed of dynamic result for spatiotempral simulation. ',...
    'The defaut speed is 1 frame per second, you can accelerate / slow down by setting a higher / lower value, ', ...
    'the setting will work through the simulation for result display and video export.'];
new_speed = inputdlgWC(MS_str , 'Play Speed');
if ~isempty(new_speed)
    try
        new_speed = str2double(new_speed{:});
    catch
        errordlg('Invalid Input', 'Input Error')
        return
    end
else
    return
end
if new_speed <= 0
    errordlg('Speed must be positive', 'Input Error')
    return
end
handles.dyn_rst_play_speed = new_speed;
guidata(hObject , handles)


% --------------------------------------------------------------------
function video_Callback(hObject, eventdata, handles)
% hObject    handle to sim_scatter_distri (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function sim_scatter_distri_Callback(hObject, eventdata, handles)
% hObject    handle to sim_scatter_distri (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tic;
% if ~isfield(handles, 'timely_taz_stat_result') & ~isfield(handles, 'F')
%     errordlg('There is no sptiaotempral simulation result right now', 'Error')
%     return
% elseif isfield(handles, 'timely_taz_stat_result') & ~isfield(handles, 'F')
%     errordlg(['There is a sptiaotempral simulation result, but you have to firstly ',...
%         'generate dynamic result by checking ''Simulation''-''Generate and Display Dynamic Results''.'], 'Error');
%     return
% else
%     F = handles.F;
% end
if ~isfield(handles, 'F')
    errordlg('There is no available dynamic result right now, you should firstly check ''Dynamic Results'' to generate one.', ...
        'Error')
else
    F= handles.F;
end
[fname , pname] = uiputfile('*.avi' , 'Save Video');
if isequal(fname, 0) | isequal(pname, 0)
    return
end
fullname = strcat(pname , fname);
if exist(fullname,'file')
    delete(fullname)
end
if isfield(handles, 'dyn_rst_play_speed')
    dyn_rst_play_speed = handles.dyn_rst_play_speed;
else
    dyn_rst_play_speed = 1;
end
movie2avi(F, fullname, 'compression', 'none', 'fps', dyn_rst_play_speed)
elapse_time = toc;
msgbox({[fname, ' saved successfully'];['Elapsed time(s): ',num2str(elapse_time)]})


% --------------------------------------------------------------------
function check_modify_default_coeff_Callback(hObject, eventdata, handles)
% hObject    handle to check_modify_default_coeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 关闭除主fig之外的所有fig
all_figs = findall(0, 'type', 'figure');
for af_i = 1 : length(all_figs)
    crt_fig_in_all_figs = all_figs(af_i);
    if ~isequal(get(crt_fig_in_all_figs, 'tag') , 'figure1')
        delete(crt_fig_in_all_figs)
    end
end
adv_mode = handles.adv_mode ;
if adv_mode == 0
    if ~isfield(handles, 'b_area_user')
        errordlg('There is NO user-defined default coefficient for area.', 'Error')
        return
    else
         b_area_user = handles.b_area_user;
    end
    if ~isfield(handles, 'b_dist_user')
        errordlg('There is NO user-defined default coefficient for distance.', 'Error')
        return
    else
         b_dist_user = handles.b_dist_user;
    end
    if ~isfield(handles, 'b_stdf_user')
        errordlg('There is NO user-defined default coefficient for stair.', 'Error')
        return
    else
         b_stdf_user = handles.b_stdf_user;
    end
    if ~isfield(handles, 'b_visited_user')
        errordlg('There is NO user-defined default coefficient for visited.', 'Error')
        return
    else
         b_visited_user = handles.b_visited_user;
    end
    if ~isfield(handles, 'b_past_user')
        errordlg('There is NO user-defined default coefficient for past.', 'Error')
        return
    else
         b_past_user = handles.b_past_user;
    end
    if ~isfield(handles, 'b_familarity_user')
        b_familarity_user = 0;
    else
         b_familarity_user = handles.b_familarity_user;
    end
    para = [b_area_user; b_familarity_user; b_dist_user; b_stdf_user; b_visited_user; b_past_user];
    var_names = {'area'; 'attractiveness'; 'distance'; 'stair'; 'visited'; 'past'};
    data = [var_names, mat2cell(para, ones(6,1), 1)];
    check_modify_para = figure('Name' , 'Default Coefficients' , 'NumberTitle' , 'off',...
        'Position', [750 300 300 500], 'Color', 'w', 'Unit', 'normalized',...
        'Menubar', 'none');
    check_modify_para_ok = uicontrol('parent', check_modify_para, 'style', 'pushbutton',...
        'string', 'OK', 'fontsize', 12, 'units', 'normalized', 'position', [.05 .05 .9 .076],...
        'callback', @check_modify_para_ok_callback);
elseif adv_mode == 1
    if ~isfield(handles, 'beta_adv')
        errordlg('There is NO valid logit model.', 'Error')
        return
    end
    beta_adv = handles.beta_adv;
    data = cell(0);
    names = fieldnames(beta_adv);
    for kk = 1 : length(names)
        crt_name = names{kk};
        crt_para = getfield(beta_adv, crt_name);
        if isequal(crt_name, 'dist')
            crt_name = 'distance';
        elseif isequal(crt_name, 'stdf')
            crt_name = 'stair';
        elseif isequal(crt_name, 'familarity')
            crt_name = 'attractiveness';
        end
        data{kk, 1} = crt_name;
        data{kk, 2} = crt_para;
    end
    %-------------------------------------%
    %2016-3-20：新增动态参数
    if isfield(handles, 'dyn_var')
        dyn_var = handles.dyn_var;
        data_dyn = cell(0);
        if ~isempty(dyn_var.volumn.value)
            volumn_type = dyn_var.volumn.type;
            volumn_value = dyn_var.volumn.value;
            if volumn_type == 1
                data_dyn{end+1, 1} = 'volumn';
                data_dyn{end, 2} = volumn_value(2);
            else
                cutpoints = [volumn_value(1,:), inf];
                beta = volumn_value(2,:)
                for bk = 1 : length(cutpoints)-1
                    data_dyn{end+1, 1} = ['volumn(',num2str(cutpoints(bk)), '~', num2str(cutpoints(bk+1)), ')'];
                    data_dyn{end, 2} = beta(bk);
                end
            end
        end
        if ~isempty(dyn_var.density.value)
            density_type = dyn_var.density.type;
            density_value = dyn_var.density.value;
            if density_type == 1
                data_dyn{end+1, 1} = 'density';
                data_dyn{end, 2} = density_value(2);
            else
                cutpoints = [density_value(1,:), inf];
                beta = density_value(2,:)
                for bk = 1 : length(cutpoints)-1
                    data_dyn{end+1, 1} = ['density(',num2str(cutpoints(bk)), '~', num2str(cutpoints(bk+1)), ')'];
                    data_dyn{end, 2} = beta(bk);
                end
            end
        end
        if ~isempty(dyn_var.queue.value)
            queue_type = dyn_var.queue.type;
            queue_value = dyn_var.queue.value;
            if queue_type == 1
                data_dyn{end+1, 1} = 'queue';
                data_dyn{end, 2} = queue_value(2);
            else
                cutpoints = [queue_value(1,:), inf];
                beta = queue_value(2,:)
                for bk = 1 : length(cutpoints)-1
                    data_dyn{end+1, 1} = ['queue(',num2str(cutpoints(bk)), '~', num2str(cutpoints(bk+1)), ')'];
                    data_dyn{end, 2} = beta(bk);
                end
            end
        end
        data = [data ; data_dyn];
    end
    check_modify_para = figure('Name' , 'Default Coefficients' , 'NumberTitle' , 'off',...
        'Position', [750 200 300 700], 'Color', 'w', 'Unit', 'normalized',...
        'Menubar', 'none');
    check_modify_para_ok = uicontrol('parent', check_modify_para, 'style', 'pushbutton',...
        'string', 'OK', 'fontsize', 12, 'units', 'normalized', 'position', [.05 .05 .9 .07],...
        'callback', @check_modify_para_ok_callback);
end
check_modify_para_ut = uitable('parent', check_modify_para, 'data', data, ...
    'ColumnName', {'Variable Name', 'Coefficient'}, 'ColumnEditable', [false, true], ...
    'units', 'normalized', 'position', [.05 .15 .9 .8],...
    'CellEditCallback', @check_modify_para_ut_callback, 'ColumnWidth', {110, 100},...
    'ColumnFormat', {'char', 'numeric'});
set(check_modify_para_ut, 'userdata', data);
%-------------check_modify_para相关的callback---------------%
function check_modify_para_ut_callback(hTab, event)
if ~isempty(event.Indices)
    iLine = event.Indices(1);
    iColumn = event.Indices(2);
    table_before = get(hTab, 'userdata');
    table_now = get(hTab, 'data');
    %检查修改是否合法
    if isempty(table_now{iLine, iColumn}) | ~isnumeric(table_now{iLine, iColumn}) |...
            isnan(table_now{iLine, iColumn})
        %如不合法，还原
        errordlg('Invalid input.', 'Error')
        set(hTab, 'data', table_before);
    else
        %如合法，更新
        set(hTab, 'userdata', table_now)
    end
end
function check_modify_para_ok_callback(hObject, eventdata, handles)
main_fig = findall(0 , 'type', 'figure', 'tag', 'figure1');
% if isempty(main_fig)
%     main_fig = findall(0, 'type', 'figure', 'name', 'Commercial Complex SIMlator (Advance Mode)');
% end
crt_fig = findall(0, 'type', 'figure', 'name', 'Default Coefficients');
check_modify_para_ut = findall(crt_fig, 'type', 'uitable');
handles = guidata(main_fig);
adv_mode = handles.adv_mode;
data = get(check_modify_para_ut, 'data');
if adv_mode == 0
    handles.b_area_user = data{1, 2};
    handles.b_familarity_user = data{2, 2};
    handles.b_dist_user = data{3, 2};
    handles.b_stdf_user = data{4, 2};
    handles.b_visited_user = data{5, 2};
    handles.b_past_user = data{6, 2};
elseif adv_mode == 1
    beta = struct;
    dyn_var_index = cell(3,1);
    for kk = 1 : size(data,  1)
        crt_name = data{kk, 1};
        crt_para = data{kk, 2};
        if regexp(crt_name, '^volumn') == 1
            dyn_var_index{1} = [dyn_var_index{1}, kk];      %第一行记录volumn的标识
        elseif regexp(crt_name, '^density') == 1
            dyn_var_index{2} = [dyn_var_index{2}, kk];      %第二行记录density的标识
        elseif regexp(crt_name, '^queue') == 1
            dyn_var_index{3} = [dyn_var_index{3}, kk];      %第三行记录queue的标识
        else
            if isequal(crt_name, 'distance')
                crt_name = 'dist';
            elseif isequal(crt_name, 'stair')
                crt_name = 'stdf';
            elseif isequal(crt_name, 'attractiveness')
                crt_name = 'familarity';
            end
            beta = setfield(beta, crt_name, crt_para);
        end
    end
    %2016-3-20：关于动态变量
    if (~isempty(dyn_var_index{1}) | ~isempty(dyn_var_index{2}) | ~isempty(dyn_var_index{3}))
        %说明经过上面的扫描，至少有一个是动态变量
        if ~isfield(handles, 'dyn_var')
            errordlg('Something strange happends, see error 8710', 'Error')
            return
        else
            dyn_var = handles.dyn_var;
        end
        if length(dyn_var_index{1}) ~= size(dyn_var.volumn.value, 2) | ...
                length(dyn_var_index{2}) ~= size(dyn_var.density.value, 2) |...
                length(dyn_var_index{3}) ~= size(dyn_var.queue.value, 2)
            errordlg('The number of dynamic variables seems to be wrong, strange error 8759.', 'Error')
            return
        end
        if ~isempty(dyn_var_index{1})                       %定义了volumn变量
            if dyn_var.volumn.type == 1
                dyn_var.volumn.value = [-inf; data{dyn_var_index{1},2}];
            else
                for kb = 1 : length(dyn_var_index{1})
                    volumn_new_beta(1, kb) = data{dyn_var_index{1}(kb),2};
                end
                dyn_var.volumn.value = [dyn_var.volumn.value(1,:); volumn_new_beta];
            end
        end
        if ~isempty(dyn_var_index{2})                       %定义了density变量
            if dyn_var.density.type == 1
                dyn_var.density.value = [-inf; data{dyn_var_index{2},2}];
            else
                for kb = 1 : length(dyn_var_index{2})
                    density_new_beta(1, kb) = data{dyn_var_index{2}(kb),2};
                end
                dyn_var.density.value = [dyn_var.density.value(1,:); density_new_beta];
            end
        end
        if ~isempty(dyn_var_index{3})                       %定义了queue变量
            if dyn_var.queue.type == 1
                dyn_var.queue.value = [-inf; data{dyn_var_index{3},2}];
            else
                for kb = 1 : length(dyn_var_index{3})
                    queue_new_beta(1, kb) = data{dyn_var_index{3}(kb),2};
                end
                dyn_var.queue.value = [dyn_var.queue.value(1,:); queue_new_beta];
            end
        end
        handles.dyn_var = dyn_var;
    end
    handles.beta_adv = beta;
    
end
guidata(main_fig, handles);
close(crt_fig)


% --------------------------------------------------------------------
function dynamic_total_num_sim_Callback(hObject, eventdata, handles)
% hObject    handle to dynamic_total_num_sim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close_other_figurs()
if ~isfield(handles, 'NTAZ')
    errordlg('You must firstly set the Num. of TAZ', 'Error')
    return
end
if ~isfield(handles, 'NENT')
    errordlg('You must firstly set the Num. of Entrances', 'Error')
    return
end
if ~isfield(handles, 'timely_taz_stat_result')
    errordlg('There is NO spatiotemporal simulation result.', 'Error')
    return
else 
    timely_taz_stat_result = handles.timely_taz_stat_result;
    full_data_before = timely_taz_stat_result.mean;                                    %full data是指精确到每一分的完整时间统计数据
    if isfield(handles, 'dyn_rst_play_start_time')
        start_time = handles.dyn_rst_play_start_time;
    else
        start_time = 900;
    end
    if isfield(handles, 'dyn_rst_play_end_time')
        end_time = handles.dyn_rst_play_end_time;
    else
        end_time = 2300;
    end
    if isfield(handles, 'dyn_rst_play_step_size')
        step_size = handles.dyn_rst_play_step_size;
    else
        step_size = 30;
    end
    time_intv_stat_before = timely_taz_stat_result.time_stat_intv_origin;
    try
        [time_intv_4stat_column_index, full_data, time_intv_stat]  = ...
            set_dynamic_display_time_intv(time_intv_stat_before, full_data_before, ...
            start_time, end_time, step_size);
    catch
        return
    end
    Y = full_data(:, time_intv_4stat_column_index);
    Y = Y(:);
end
if ~isfield(handles, 'XYZ')
    errordlg('No TAZ Data', 'TAZ Data');
    return
end
%关闭其它小fig
all_figs = findall(0, 'type', 'figure');
for af_i = 1 : length(all_figs)
    crt_fig_in_all_figs = all_figs(af_i);
    if ~isequal(get(crt_fig_in_all_figs, 'tag') , 'figure1')
        delete(crt_fig_in_all_figs)
    end
end
max_value = max(Y);
min_value = min(Y);
color_generate_userdata = struct();
color_generate_userdata.name = 'Sim timely total amount';
color_generate_userdata.Y = Y;
set_color = figure('Name' , 'Set Color Map' , 'NumberTitle' , 'off',...
    'Position', [500 400 800 300], 'Color', 'w', 'Unit', 'normalized',...
    'Menubar', 'none');
color_generate = uicontrol('parent', set_color, 'style', 'pushbutton',...
    'String', 'Generate Classes', 'unit', 'normalized', 'position',...
    [.47, .85, .16, .1], 'fontsize', 10, 'value', 2,...
    'callback', @color_generate_callback,...
    'userdata', color_generate_userdata);     %不得不设userdata，以知道画的什么图
color_class_method = uicontrol('parent', set_color, 'style', 'popupmenu',...
    'String', {'Equal Interval', 'Quantile'}, 'unit', 'normalized', 'position',...
    [.29, .85, .13, .1], 'backgroundcolor', 'w', 'fontsize', 10, 'value', 1,...
    'callback', @color_class_method_callback);
%输入set_color句柄和辅助用的最大最小值，自动布局
set_color_layout(set_color, min_value, max_value);
% 前面的都可以通用，但是OK键不一样，要根据画的图不同而设置不同的callback
set_color_all_ok = uicontrol('parent', set_color, 'style', 'pushbutton', ...
    'string', 'OK', 'fontsize', 10, 'unit', 'normalized', 'position',...
    [.8, .05, .15, .15], 'callback', @color_map_ok_sim_total_amount_time);
%初始化set color，一点开就有色带
crt_handles = guidata(set_color);
%清除可能残留的历史记录
if isfield(crt_handles, 'color_ramp_name')
    crt_handles = rmfield(crt_handles, 'color_ramp_name');
end
if isfield(crt_handles, 'color_ramp_disp');
    crt_handles = rmfield(crt_handles, 'color_ramp_disp')
end
if isfield(crt_handles, 'value_cut_disp')
    crt_handles = rmfield(crt_handles, 'value_cut_disp')
end
%默认class_method = 1 class_num = 5
class_num = 5;
color_ramp_name = 'Reds';
value_cut = linspace(min_value, max_value, class_num+1);
text_place_cut = linspace(.03, .91, class_num+1);
for k = 1 : class_num
    color_place_cut = linspace(.05, .95, class_num+1);
end
color_rgb = brewermap(class_num, color_ramp_name);
%生成色带显示
color_ramp_disp = cell(0);
for k = 1 : class_num
    color_ramp_disp{k} = uicontrol('parent', set_color, 'unit', 'normalized',...
        'style', 'pushbutton', 'position', ...
        [color_place_cut(k), .4, color_place_cut(k+1)-color_place_cut(k), .35],...
        'backgroundcolor', color_rgb(k,:), 'string', '', 'callback', @color_ramp_disp_callback,...
        'userdata', color_rgb(k,:));
end
%生成值文本框
for k = 1 : class_num+1
    value_cut_disp{k} = uicontrol('parent', set_color, 'unit', 'normalized',...
        'style', 'edit', 'position', [text_place_cut(k), .27, .06, .12],...
        'backgroundcolor', 'w', 'string', num2str(value_cut(k)), ...
        'callback', @value_cut_disp_callback,...
        'userdata', value_cut(k),'fontsize', 10);
end
crt_handles.color_ramp_disp = color_ramp_disp;
crt_handles.color_ramp_name = color_ramp_name;
crt_handles.value_cut_disp = value_cut_disp;
guidata(set_color, crt_handles);
%-------------------------------%


% --------------------------------------------------------------------
function input_base_area_Callback(hObject, eventdata, handles)
% hObject    handle to input_base_area (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isfield(handles , 'NTAZ')
    errordlg('Please firstly input Num of TAZs' , 'NTAZ Error')
    return
end
NTAZ = handles.NTAZ;
[choice ,ok] = listdlg(...
    'PromptString','Choose the way of inputting data or check data', ...
    'ListString'  , {'Use Explanatory Variable ''Area''',...
    'Load CSV File','Directly Type or Copy / Paste',...
    'Automatic Calculatoin', 'Check Data'},...
    'SelectionMode', 'single', 'Name', 'Base Area Data', ...
    'ListSize', [270, 120]);
if ok == 0
    return
end
switch choice
    case 1      %同步area数据
        adv_mode = handles.adv_mode;
        if adv_mode == 0 & isfield(handles, 'X_area')
            base_area = handles.X_area;
        elseif adv_mode == 1 & isfield(handles, 'X_adv') &...
                isfield(handles.X_adv, 'area') & ...
                length(handles.X_adv.area) == NTAZ
            base_area = handles.X_adv_area;
        else
            errordlg('No valid explanatory area variable', 'Error')
            return
        end
        scale_par = inputdlgWC(['Please input a scale parameter (default: 1), ',...
            'so that the base area would be multiplied by that parameter.'], 'Scale Parameter',...
            1, {'1'});
        try
            scale_par = str2num(scale_par{:});
        catch
            errordlg('Invalid input', 'Error')
            return
        end
        if isnan(scale_par) | isempty(scale_par) | ~isnumeric(scale_par)
            errordlg('Invalid input', 'Error')
            return
        end
        handles.base_area = base_area * scale_par;
        guidata(hObject, handles);
        msgbox('Finshed')
    case 2      %导入
        [fname , pname] = uigetfile('*.csv' , 'Open the BaseArea Data CSV');
        if isequal(fname, 0) | isequal(pname, 0)
            return
        end
        fullname = strcat(pname,fname);
        table_data = importdata(fullname);
        if isfield(table_data, 'colheaders')
            colheaders = table_data.colheaders;
            TAZID_index = find(ismember(colheaders, 'TAZID'));
            if isempty(TAZID_index)
                TAZID_index = listdlg('PromptString','Select TAZ ID Variable:','SelectionMode','single',...
                    'ListString',colheaders);
                if isempty(TAZID_index)
                    TAZID_index  = [];          %相当于按顺序排列了
                end
            end
            base_area_index = find(ismember(colheaders, 'BaseArea'));
            if isempty(base_area_index)
                base_area_index = listdlg('PromptString','Select Base Area Variable:','SelectionMode','single',...
                    'ListString',colheaders);
                if isempty(base_area_index)
                    return
                end
            end
            try
                base_area_csv = csvread(fullname, 1, 0);
            catch
                errordlg('Fail to open the csv file', 'Open Error')
                return
            end
            base_area_csv = base_area_csv(:, [TAZID_index, base_area_index(1)]);
        else
            try
                base_area_csv = csvread(fullname);
            catch
                errordlg('Fail to open the csv file', 'Open Error')
                return
            end
        end
        [nrow_area , ncol_area] = size(base_area_csv);
        if nrow_area == NTAZ
            if ncol_area == 1
                handles.base_area = base_area_csv;
                guidata(hObject,handles);
            elseif ncol_area == 2
                base_area_csv = sortrows(base_area_csv , 1);
                handles.base_area = base_area_csv(:,2);
                guidata(hObject,handles);
            else
                errordlg('The input csv file should contain no more than 2 columns of data', 'Input Error')
                return
            end
        else
            errordlg('Input Num of base area data NOT equal Num of TAZ' , 'Input Error')
            return
        end
        msgbox('Finshed')
    case 3      %直接输
        str = ['Please enter space(/comma)-separated base areas in the order: from TAZ_1 to TAZ_' , ...
            num2str(NTAZ)];
        same_pasted_value = inputdlgWC({str, 'OR please enter the same base area for All TAZS'} , ...
            'Base Area Data Input', [1 80 ; 1 45]);
        pasted_value = same_pasted_value{1};
        same_value = same_pasted_value{2};
        if length(pasted_value) ~= 0
            try
                pasted_value = str2double(pasted_value);
            catch
                errordlg('Invalid Input', 'Input Error')
                return
            end
            if length(pasted_value) == NTAZ
                base_area = pasted_value';
                handles.base_area = base_area;
                guidata(hObject,handles);
            else
                errordlg('Input Num of base area data NOT equal Num of TAZ' , 'Input Error')
                return
            end
        elseif length(same_value) ~= 0
            try
                same_value = str2double(same_value);
            catch
                errordlg('Invalid Input', 'Input Error')
                return
            end
            base_area = same_value * ones(NTAZ, 1);
            handles.base_area = base_area;
            guidata(hObject,handles);
        end    
        msgbox('Finshed')
    case 4      %自动计算
        if ~isfield(handles , 'XYZ')
            errordlg('NO TAZ inputting' , 'Input Error')
            return
        else
            xyz = handles.XYZ;
            ids = unique(xyz(:,1));
            for kk = 1 : length(ids);
                crt = xyz(xyz(:,1) == ids(kk) , 2:3);
                crt_rst = polygeom(crt(:,1) , crt(:,2));
                base_area(kk , 1) = crt_rst(1);
            end
            if length(base_area) == NTAZ;
                scale_par = inputdlgWC(['Please input a scale parameter (default: 1), ',...
                    'so that the base area would be multiplied by that parameter.'], 'Scale Parameter',...
                    1, {'1'});
                try
                    scale_par = str2double(scale_par{:});
                catch
                    errordlg('Invalid input', 'Error')
                    return
                end
                if isnan(scale_par) | isempty(scale_par) | ~isnumeric(scale_par)
                    errordlg('Invalid input', 'Error')
                    return
                end
                handles.base_area = base_area * scale_par;
                guidata(hObject,handles);
            else
                errordlg('Input Num of base area data NOT equal Num of TAZ' , 'Input Error')
                return
            end
        end
        msgbox('Finshed')
    case 5      %检查数据
        if ~isfield(handles , 'base_area')
            errordlg('There is NO valid base area input' ,'Error')
            return
        else
            base_area = handles.base_area;
            taz_area = [[1:NTAZ]' , base_area];
            show = strvcat('TAZ    BASE AREA' , num2str(taz_area));
            msgbox(show)
        end
end


% --------------------------------------------------------------------
function dynamic_density_sim_Callback(hObject, eventdata, handles)
% hObject    handle to dynamic_density_sim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close_other_figurs()
if ~isfield(handles, 'NTAZ')
    errordlg('You must firstly set the Num. of TAZ', 'Error')
    return
end
if ~isfield(handles, 'NENT')
    errordlg('You must firstly set the Num. of Entrances', 'Error')
    return
end
if ~isfield(handles, 'base_area')
    errordlg('There is no valid base area data.', 'Error')
    return
else
    base_area = handles.base_area;
end
if ~isfield(handles, 'timely_taz_stat_result')
    errordlg('There is NO spatiotemporal simulation result.', 'Error')
    return
else 
    timely_taz_stat_result = handles.timely_taz_stat_result;
    full_data_before = timely_taz_stat_result.mean;                                    %full data是指精确到每一分的完整时间统计数据
    if isfield(handles, 'dyn_rst_play_start_time')
        start_time = handles.dyn_rst_play_start_time;
    else
        start_time = 900;
    end
    if isfield(handles, 'dyn_rst_play_end_time')
        end_time = handles.dyn_rst_play_end_time;
    else
        end_time = 2300;
    end
    if isfield(handles, 'dyn_rst_play_step_size')
        step_size = handles.dyn_rst_play_step_size;
    else
        step_size = 30;
    end
    time_intv_stat_before = timely_taz_stat_result.time_stat_intv_origin;
    try
        [time_intv_4stat_column_index, full_data, time_intv_stat]  = ...
            set_dynamic_display_time_intv(time_intv_stat_before, full_data_before, ...
            start_time, end_time, step_size);
    catch
        return
    end
    Y = full_data(:, time_intv_4stat_column_index);             %此时是人数
    Y = bsxfun(@rdivide, Y, base_area);                         %此时是密度
    Y = Y(:);
end
if ~isfield(handles, 'XYZ')
    errordlg('No TAZ Data', 'TAZ Data');
    return
end
%关闭其它小fig
all_figs = findall(0, 'type', 'figure');
for af_i = 1 : length(all_figs)
    crt_fig_in_all_figs = all_figs(af_i);
    if ~isequal(get(crt_fig_in_all_figs, 'tag') , 'figure1')
        delete(crt_fig_in_all_figs)
    end
end
max_value = max(Y);
min_value = min(Y);
color_generate_userdata = struct();
color_generate_userdata.name = 'Sim timely density';
color_generate_userdata.Y = Y;
set_color = figure('Name' , 'Set Color Map' , 'NumberTitle' , 'off',...
    'Position', [500 400 800 300], 'Color', 'w', 'Unit', 'normalized',...
    'Menubar', 'none');
color_generate = uicontrol('parent', set_color, 'style', 'pushbutton',...
    'String', 'Generate Classes', 'unit', 'normalized', 'position',...
    [.47, .85, .16, .1], 'fontsize', 10, 'value', 2,...
    'callback', @color_generate_callback,...
    'userdata', color_generate_userdata);     %不得不设userdata，以知道画的什么图
color_class_method = uicontrol('parent', set_color, 'style', 'popupmenu',...
    'String', {'Equal Interval', 'Quantile', 'Default Cut-Off'}, 'unit', 'normalized', 'position',...
    [.29, .85, .13, .1], 'backgroundcolor', 'w', 'fontsize', 10, 'value', 3,...
    'callback', @color_class_method_callback);
%输入set_color句柄和辅助用的最大最小值，自动布局
set_color_layout(set_color, min_value, max_value);
% 前面的都可以通用，但是OK键不一样，要根据画的图不同而设置不同的callback
set_color_all_ok = uicontrol('parent', set_color, 'style', 'pushbutton', ...
    'string', 'OK', 'fontsize', 10, 'unit', 'normalized', 'position',...
    [.8, .05, .15, .15], 'callback', @color_map_ok_sim_density_time);
%初始化set color，一点开就有色带
class_num = 5;
color_ramp_name = '*RdYlGn';
value_cut = [0 .3 .5 .7 .9 Inf];
set_color_initializatoin(set_color, class_num, color_ramp_name, value_cut);


% --------------------------------------------------------------------
function input_compariton_data_Callback(hObject, eventdata, handles)
% hObject    handle to input_compariton_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function comp_load_taz_spatial_distr_Callback(hObject, eventdata, handles)
% hObject    handle to comp_load_taz_spatial_distr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
edit_Comp_taz_distrib_Callback(hObject, eventdata, handles)


% --------------------------------------------------------------------
function comp_load_od_matrix_Callback(hObject, eventdata, handles)
% hObject    handle to comp_load_od_matrix (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
edit_Comp_od_Callback(hObject, eventdata, handles)


% --------------------------------------------------------------------
function comp_load_taz_space_time_distr_Callback(hObject, eventdata, handles)
% hObject    handle to comp_load_taz_space_time_distr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tic
if isfield(handles, 'NTAZ')
    NTAZ = handles.NTAZ;
else
    errordlg('Num. TAZ is neccessary', 'Comparison Data Error')
    return
end
choice = questdlg('How do you want to load your comparison spatiotemporal distribution data?',...
    'Input Data', 'Load Space-Time Matrix', 'Estimate from Spatiotemporal Paths', 'Load Space-Time Matrix');
if strcmp(choice, 'Load Space-Time Matrix')
    [fname , pname]=uigetfile('*.xlsx' , 'Open the Comparison Spatiotemporal Distribution XLSX');
    if isequal(fname, 0)
        return
    end
    fullname = strcat(pname, fname);
    try
        Comp = xlsread(fullname , 1);
    catch
        Comp = [];
    end
    if isempty(Comp) 
        try
            Comp = xlsread(fullname , 'Mean Result of All Simulations');
        catch
            errordlg(['Fail to open the file, no valid data in ', ...
                'either ''Sheet1'' or ''Mean Result of All Simulations''.'], 'Error')
            return
        end
    end
    comp_timely_taz_stat = Comp(2:end, 2:end);
    start_time = Comp(1,2);
    end_time = Comp(1,end);
    step_size = (WDtimeConvert(end_time,1) - WDtimeConvert(start_time,1)) /...
        (size(comp_timely_taz_stat, 2) - 1);
    if ~isequal(Comp(1, 2:end), WDtimeConvert(WDtimeConvert(start_time,1):...
            step_size:WDtimeConvert(end_time,1) ,3))
        errordlg('Invalid format: inequal time interval.','Error')
        return
    else
        time_stat_intv_origin = Comp(1, 2:end);
        time_stat_intv_diff = WDtimeConvert(time_stat_intv_origin, 1);
    end
    comp_timely_taz_stat_result.data = comp_timely_taz_stat;
    comp_timely_taz_stat_result.time_par = [start_time; step_size; end_time];
    comp_timely_taz_stat_result.time_stat_intv_origin = time_stat_intv_origin;
    comp_timely_taz_stat_result.time_stat_intv_diff = time_stat_intv_diff;
    handles.comp_timely_taz_stat_result = comp_timely_taz_stat_result;   
elseif strcmp(choice, 'Estimate from Spatiotemporal Paths')
    if isfield(handles, 'space_time_path_rawdata')
        choice2 = questdlg('You have already input spatiotemporal path data, do you want to use this data?',...
            'Comparison Data', 'Yes, use this data', 'No, use new data', 'Yes, use this data');
        if strcmp(choice2, 'Yes, use this data')
            space_time_path_rawdata = handles.space_time_path_rawdata;
            use_new_flag = 0;
        elseif strcmp(choice2, 'No, use new data')
            use_new_flag = 1;
        else
            return
        end
    else
        use_new_flag = 1;
    end
    if use_new_flag == 1
        space_time_path_Callback(hObject, eventdata, handles)
        if ~isfield(handles, 'space_time_path_rawdata')
            %如果新导入没有成功，那边先return了，这边也就return
            return
        end
        space_time_path_rawdata = handles.space_time_path_rawdata;
    end
    %时间统计，主要参见spatiotemporal simulation中最后一段的时间统计
    %主要参见space_time_simulate_rst_analysis.m，当时是打算写在一个单独的模块，由用户指定起止时间与步长的，后来觉得没必要
    %指定最小&最大时间与步长
    step_size = 1;
    entry_time = [];
    exit_time = [];
    NPED = size(space_time_path_rawdata, 1);
    for i = 1 : NPED
        entry_time(i,1) = space_time_path_rawdata{i,2}(2);
        exit_time(i,1) = WDtimeConvert(WDtimeConvert(space_time_path_rawdata{i,3}(end,2),1) + ...
           space_time_path_rawdata{i,3}(end,3), 3) ;
    end
    start_time = min(entry_time);
    end_time = max(exit_time);
    crtTime = start_time;
    %时间统计的间隔，time_statistic_interval,_diff是以分钟差形式,_origin是原始的1940形式
    time_stat_intv_diff = WDtimeConvert(start_time, 1) : step_size : WDtimeConvert(end_time, 1);
    time_stat_intv_origin = WDtimeConvert(time_stat_intv_diff, 3);
    comp_timely_taz_stat = zeros(NTAZ , length(time_stat_intv_diff));
    %入口、回游相关统计
    for j = 1 : NPED
        crt_ped_path_with_TIME = space_time_path_rawdata{j,3};
        crt_ped_path = crt_ped_path_with_TIME(:,1);
        crt_ped_path_StartTime = crt_ped_path_with_TIME(:,2);
        crt_ped_path_LastTime = crt_ped_path_with_TIME(:,3);
        for k=1 : length(crt_ped_path)-1
            %时间统计
            crt_ped_crt_start_time = crt_ped_path_StartTime(k);
            crt_ped_next_start_time = crt_ped_path_StartTime(k+1);
            crt_ped_crt_start_time2 = WDtimeConvert(crt_ped_crt_start_time,1);      %后缀2为分钟差形式
            crt_ped_next_start_time2 = WDtimeConvert(crt_ped_next_start_time,1);
            crt_ped_crt_last_time = crt_ped_path_LastTime(k);
            for kk = 1 : length(time_stat_intv_diff)
                if time_stat_intv_diff(kk) >= crt_ped_crt_start_time2  &  ...
                        time_stat_intv_diff(kk) < crt_ped_crt_start_time2 + crt_ped_crt_last_time
                    %以前是不考虑交通时间的，现在把交通时间剔掉，逻辑是：在小区A起始时间 < 兴趣时间 < 在小区A结束时间（以前是在下一个小区起始时间）
                    %那么在兴趣时间点这一时刻（不是用的时间区间，而是一个时间切片），他一定还在小区A
                    %比如：当前活动开始时间（crt_ped_crt_start_time2）为9:00，加上活动持续时间60m，活动末要走时为10：00，统计时间为9:30，即930>900且930<1000，那么显然此时正在
                    comp_timely_taz_stat(crt_ped_path(k) , kk) = comp_timely_taz_stat(crt_ped_path(k) , kk) + 1;
                    %-------------------%有争议，如果严格到当时的时间切片瞬间的话，这种大（统计区间）包小（活动区间）的情况，小区间就不被
                    %统计到了，但确实也没办法，想想也是，
                    %如果一个超级大的区间（9：00~22：00），几乎所有的活动都成了大包小，总不能把人都算进去啊，防止这种情况只能细化时间区间，比如用5分钟尺度，下面
                    %105-107行的comment类似
                    %                 elseif kk<=length(time_stat_intv_diff)-1 & time_stat_intv_diff(kk) < crt_ped_crt_start_time2 & ...
                    %                         time_stat_intv_diff(kk) < crt_ped_next_start_time2  & time_stat_intv_diff(kk+1) >= crt_ped_crt_start_time2 + crt_ped_crt_last_time
                    %                     %这里可能有点争议，考虑的情况是，如果时间切片画的太大，比如9：00-10：00，但消费者在9:20-9:40去了一个小区，那么它在这个小区的停留就不会被任何时间点记录到
                    %                     %所以才加了这么一段，算是他在一个以当前切片点为起点的时间区间内来过
                    %                     crt_timely_taz_stat(crt_ped_path(k) , kk) = crt_timely_taz_stat(crt_ped_path(k) , kk) + 1;
                end
            end
        end
        %最后一步要用到持续时间
        crt_ped_EndAction_start_time = crt_ped_path_StartTime(end);
        crt_ped_EndAction_start_time2 = WDtimeConvert(crt_ped_EndAction_start_time,1);
        crt_ped_EndAction_over_time2 = crt_ped_EndAction_start_time2 + crt_ped_path_LastTime(end);
        for kk=1:length(time_stat_intv_diff)
            if time_stat_intv_diff(kk) >= crt_ped_EndAction_start_time2 & time_stat_intv_diff(kk) <= crt_ped_EndAction_over_time2
                comp_timely_taz_stat(crt_ped_path(end) , kk) = comp_timely_taz_stat(crt_ped_path(end) , kk) + 1;
                %             elseif kk<=length(time_stat_intv_diff)-1 & time_stat_intv_diff(kk) < crt_ped_crt_start_time2 ...
                %                     & time_stat_intv_diff(kk) < crt_ped_next_start_time2  & time_stat_intv_diff(kk+1) >= crt_ped_next_start_time2
                %                 crt_timely_taz_stat(crt_ped_path(end),kk) = crt_timely_taz_stat(crt_ped_path(end),kk) + 1;
            end
        end
        
    end
    comp_timely_taz_stat_result.data = comp_timely_taz_stat;
    comp_timely_taz_stat_result.time_par = [start_time; step_size; end_time];
    comp_timely_taz_stat_result.time_stat_intv_origin = time_stat_intv_origin;
    comp_timely_taz_stat_result.time_stat_intv_diff = time_stat_intv_diff;
    handles.comp_timely_taz_stat_result = comp_timely_taz_stat_result;   
else
    return
end
guidata(hObject , handles)
clo = toc;
msgbox(strvcat('Finished.', ['Elapse time(s): ', num2str(clo)]))


% --------------------------------------------------------------------
function dynamic_ind_distr_comp_Callback(hObject, eventdata, handles)
% hObject    handle to dynamic_ind_distr_comp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close_other_figurs()
if ~isfield(handles, 'NTAZ')
    errordlg('You must firstly set the Num. of TAZ', 'Error')
    return
else
    NTAZ = handles.NTAZ;
end
if ~isfield(handles, 'NENT')
    errordlg('You must firstly set the Num. of Entrances', 'Error')
    return
else
    NENT = handles.NENT;
end
if ~isfield(handles, 'comp_timely_taz_stat_result') & ~isfield(handles, 'space_time_path_rawdata')
    errordlg('There is NO spatiotemporal comparison result.', 'Error')
    return
elseif ~isfield(handles, 'comp_timely_taz_stat_result') & isfield(handles, 'space_time_path_rawdata')
    errordlg(['There is NO spatiotemporal comparison result, but spatiotemporal ',...
        'path data exists, you can check ''Data'' - ''Input Comparison Data'' -',...
        ' ''Load TAZ Spatiotemporal Distribtuion'' to estimate comparison result'], 'Error')
    return
else
    comp_timely_taz_stat_result = handles.comp_timely_taz_stat_result;
end
full_data_before = comp_timely_taz_stat_result.data;                                    %full data是指精确到每一分的完整时间统计数据
if isfield(handles, 'dyn_rst_play_start_time')
    start_time = handles.dyn_rst_play_start_time;
else
    start_time = 900;
end
if isfield(handles, 'dyn_rst_play_end_time')
    end_time = handles.dyn_rst_play_end_time;
else
    end_time = 2300;
end
if isfield(handles, 'dyn_rst_play_step_size')
    step_size = handles.dyn_rst_play_step_size;
else
    step_size = 30;
end
time_intv_stat_before = comp_timely_taz_stat_result.time_stat_intv_origin;
try
    [time_intv_4stat_column_index, full_data, time_intv_stat]  = ...
        set_dynamic_display_time_intv(time_intv_stat_before, full_data_before, ...
        start_time, end_time, step_size);
catch
    return
end
data = full_data(:, time_intv_4stat_column_index);
time_name = time_intv_stat(time_intv_4stat_column_index);

if ~isfield(handles , 'Z_factor')
    Z_factor = str2double(get(handles.edit_Z_factor, 'String'));
else
    Z_factor = handles.Z_factor
end
if ~isfield(handles , 'marker_size')
    marker_size = 5;
else
    marker_size = handles.marker_size;
end

main_fig = findall(0, 'tag', 'figure1');
main_axes = handles.axes1;
for i = 1 : length(time_name)
    crt_time = time_name(i);
    crt_h = floor(crt_time / 100);
    crt_m = crt_time - 100*crt_h; 
    crt_h = num2str(crt_h);
    crt_m = num2str(crt_m);
    if length(crt_h) == 1
        crt_h = strcat('0', crt_h);
    end
    if length(crt_m) == 1
        crt_m = strcat('0', crt_m);
    end
    time_str{i} = [crt_h, ':', crt_m];
end

set(handles.axes1, 'Position', [0.007, 0.02, 0.62, 0.97]);
if ~isfield(handles, 'XYZ')
    errordlg('No TAZ Data', 'TAZ Data');
    return
else
    XYZ = handles.XYZ;
end
xyz = XYZ;              %不用全局变量，用局部变量-----以前把XYZ设成global了，现在就不改了
xyz(:,4) = xyz(:,4) * Z_factor;             %竖向拉开
max_x = max(xyz(:,2));
min_x = min(xyz(:,2));
max_y = max(xyz(:,3));
min_y = min(xyz(:,3));
max_z = max(xyz(:,4));
median_x = (max_x + min_x) / 2;
median_y = (max_y + min_y) / 2;

invisible_fig = figure('visible', 'off','unit', get(main_fig, 'unit'), ...
    'position', get(main_fig, 'position'));
set(invisible_fig,'color','w')
%画底图
unique_XYZ = unique(xyz(: , 1));
for i = 1 : size(unique_XYZ)
    crtTAZindex = unique_XYZ(i);
    index = find(xyz(:,1) == crtTAZindex);
    hold on
    patch(xyz(index,2) , xyz(index,3) , xyz(index,4) , [0.8,0.8,0.8])
end
invisible_ax = findall(invisible_fig, 'type', 'axes');
set(invisible_ax , 'unit', get(gca, 'unit'), 'position', [0.007, 0.02, 0.62, 0.97]);
if isfield(handles , 'Ent_ON')  & isfield(handles , 'ENTXYZ')
    if handles.Ent_ON == 1
        entxyz = handles.ENTXYZ;
        entxyz = entxyz(:, 2:4);
        entxyz(:,3) = entxyz(:,3) * Z_factor;
        h_ent = plot3(entxyz(: , 1), entxyz(:, 2), entxyz(:, 3), 'kp','MarkerFacecolor', 'k');
        handles.h_ent = h_ent;
    end
end
axis off
%图形控制
set(gcf,'color','w')
axis equal
axis off
alpha(0.5)
az = handles.az;
el = handles.el;
view(az, el)
hw = waitbar(0 , 'Preparing');
for i = 1 : length(time_name)
    process = i/length(time_name);
    waitbar(process, hw, ['Preparing: ', num2str(round(100*process)), '%']);
    if exist('crt_fig_h', 'var') & ~isempty(crt_fig_h)
        for j = 1 : length(crt_fig_h)
            delete(crt_fig_h{j})
        end
    end
    crt_fig_h = WDplotTAZ_GUI(round(data(:,i)), xyz, 1, marker_size, invisible_ax);
    t = title(invisible_ax, ...
        time_str{i}, 'position', [median_x, median_y, max_z*1.07], 'fontsize', 15);
    F(i) = getframe(invisible_ax);
    [im(i).X, temp] = frame2im(F(i));
end
save('ccsim_redraw', 'im')
waitbar(1, hw, 'Finshed');
handles.F = F;
guidata(hObject, handles);
close(hw)
if isfield(handles, 'dyn_rst_play_speed')
    speed = handles.dyn_rst_play_speed;
else
    speed = 1;
end
nframe = length(time_name);
all_time = nframe / speed;
str1 = ['1. The play speed is ', num2str(speed), ' fps, therefore the total playing duration would be ', num2str(all_time) ,' seconds, ',...
    'you can reset the speed by checking ''Predefined Parameters''-''Dynamic Result Play Speed''.'];
str2 = ['2. Press ''Enter'' to play / pause the viedo.'];
str3 = ['3. Press ''Right / left arrow'' to advance / go back one frame.'];
instr = msgbox(strvcat('Instructions: ', str1, str2, str3), 'Instructions');
waitfor(instr)
videofigWC(nframe, @ccsim_redraw, speed, [], [], 'name', 'CCSIM Spatiotemproal Simulation: Dynamic Result Player',...
    'unit', 'normalized', 'position', [.05 .05 .9 .9], 'numberTitle', 'off');


% --------------------------------------------------------------------
function dynamic_total_num_comp_Callback(hObject, eventdata, handles)
% hObject    handle to dynamic_total_num_comp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close_other_figurs()
if ~isfield(handles, 'NTAZ')
    errordlg('You must firstly set the Num. of TAZ', 'Error')
    return
end
if ~isfield(handles, 'NENT')
    errordlg('You must firstly set the Num. of Entrances', 'Error')
    return
end
% if ~isfield(handles, 'base_area')
%     errordlg('There is no valid base area data.', 'Error')
%     return
% else
%     base_area = handles.base_area;
% end
if ~isfield(handles, 'comp_timely_taz_stat_result') & ~isfield(handles, 'space_time_path_rawdata')
    errordlg('There is NO spatiotemporal comparison result.', 'Error')
    return
elseif ~isfield(handles, 'comp_timely_taz_stat_result') & isfield(handles, 'space_time_path_rawdata')
    errordlg(['There is NO spatiotemporal comparison result, but spatiotemporal ',...
        'path data exists, you can check ''Data'' - ''Input Comparison Data'' -',...
        ' ''Load TAZ Spatiotemporal Distribtuion'' to estimate comparison result'], 'Error')
    return
else
    comp_timely_taz_stat_result = handles.comp_timely_taz_stat_result;
    full_data_before = comp_timely_taz_stat_result.data;                                    %full data是指精确到每一分的完整时间统计数据
    if isfield(handles, 'dyn_rst_play_start_time')
        start_time = handles.dyn_rst_play_start_time;
    else
        start_time = 900;
    end
    if isfield(handles, 'dyn_rst_play_end_time')
        end_time = handles.dyn_rst_play_end_time;
    else
        end_time = 2300;
    end
    if isfield(handles, 'dyn_rst_play_step_size')
        step_size = handles.dyn_rst_play_step_size;
    else
        step_size = 30;
    end
    time_intv_stat_before = comp_timely_taz_stat_result.time_stat_intv_origin;
    try
        [time_intv_4stat_column_index, full_data, time_intv_stat]  = ...
            set_dynamic_display_time_intv(time_intv_stat_before, full_data_before, ...
            start_time, end_time, step_size);
    catch
        return
    end
    Y = full_data(:, time_intv_4stat_column_index);             %此时是人数
%     Y = bsxfun(@rdivide, Y, base_area);                         %此时是密度
    Y = Y(:);
end
if ~isfield(handles, 'XYZ')
    errordlg('No TAZ Data', 'TAZ Data');
    return
end
%关闭其它小fig
all_figs = findall(0, 'type', 'figure');
for af_i = 1 : length(all_figs)
    crt_fig_in_all_figs = all_figs(af_i);
    if ~isequal(get(crt_fig_in_all_figs, 'tag') , 'figure1')
        delete(crt_fig_in_all_figs)
    end
end
max_value = max(Y);
min_value = min(Y);
color_generate_userdata = struct();
color_generate_userdata.name = 'Comp timely total amount';
color_generate_userdata.Y = Y;
set_color = figure('Name' , 'Set Color Map' , 'NumberTitle' , 'off',...
    'Position', [500 400 800 300], 'Color', 'w', 'Unit', 'normalized',...
    'Menubar', 'none');
color_generate = uicontrol('parent', set_color, 'style', 'pushbutton',...
    'String', 'Generate Classes', 'unit', 'normalized', 'position',...
    [.47, .85, .16, .1], 'fontsize', 10, 'value', 2,...
    'callback', @color_generate_callback,...
    'userdata', color_generate_userdata);     %不得不设userdata，以知道画的什么图
color_class_method = uicontrol('parent', set_color, 'style', 'popupmenu',...
    'String', {'Equal Interval', 'Quantile'}, 'unit', 'normalized', 'position',...
    [.29, .85, .13, .1], 'backgroundcolor', 'w', 'fontsize', 10, 'value', 1,...
    'callback', @color_class_method_callback);
%输入set_color句柄和辅助用的最大最小值，自动布局
set_color_layout(set_color, min_value, max_value);
% 前面的都可以通用，但是OK键不一样，要根据画的图不同而设置不同的callback
set_color_all_ok = uicontrol('parent', set_color, 'style', 'pushbutton', ...
    'string', 'OK', 'fontsize', 10, 'unit', 'normalized', 'position',...
    [.8, .05, .15, .15], 'callback', @color_map_ok_comp_total_amount_time);
%初始化set color，一点开就有色带
class_num = 5;
color_ramp_name = 'Blues';
value_cut = linspace(min_value, max_value, class_num+1);
set_color_initializatoin(set_color, class_num, color_ramp_name, value_cut);


% --------------------------------------------------------------------
function dynamic_density_comp_Callback(hObject, eventdata, handles)
% hObject    handle to dynamic_density_comp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close_other_figurs()
if ~isfield(handles, 'NTAZ')
    errordlg('You must firstly set the Num. of TAZ', 'Error')
    return
end
if ~isfield(handles, 'NENT')
    errordlg('You must firstly set the Num. of Entrances', 'Error')
    return
end
if ~isfield(handles, 'base_area')
    errordlg('There is no valid base area data.', 'Error')
    return
else
    base_area = handles.base_area;
end
if ~isfield(handles, 'comp_timely_taz_stat_result') & ~isfield(handles, 'space_time_path_rawdata')
    errordlg('There is NO spatiotemporal comparison result.', 'Error')
    return
elseif ~isfield(handles, 'comp_timely_taz_stat_result') & isfield(handles, 'space_time_path_rawdata')
    errordlg(['There is NO spatiotemporal comparison result, but spatiotemporal ',...
        'path data exists, you can check ''Data'' - ''Input Comparison Data'' -',...
        ' ''Load TAZ Spatiotemporal Distribtuion'' to estimate comparison result'], 'Error')
    return
else
    comp_timely_taz_stat_result = handles.comp_timely_taz_stat_result;
    full_data_before = comp_timely_taz_stat_result.data;                                    %full data是指精确到每一分的完整时间统计数据
    if isfield(handles, 'dyn_rst_play_start_time')
        start_time = handles.dyn_rst_play_start_time;
    else
        start_time = 900;
    end
    if isfield(handles, 'dyn_rst_play_end_time')
        end_time = handles.dyn_rst_play_end_time;
    else
        end_time = 2300;
    end
    if isfield(handles, 'dyn_rst_play_step_size')
        step_size = handles.dyn_rst_play_step_size;
    else
        step_size = 30;
    end
    time_intv_stat_before = comp_timely_taz_stat_result.time_stat_intv_origin;
    try
        [time_intv_4stat_column_index, full_data, time_intv_stat]  = ...
            set_dynamic_display_time_intv(time_intv_stat_before, full_data_before, ...
            start_time, end_time, step_size);
    catch
        return
    end
    Y = full_data(:, time_intv_4stat_column_index);             %此时是人数
    Y = bsxfun(@rdivide, Y, base_area);                         %此时是密度
    Y = Y(:);
end
if ~isfield(handles, 'XYZ')
    errordlg('No TAZ Data', 'TAZ Data');
    return
end
%关闭其它小fig
all_figs = findall(0, 'type', 'figure');
for af_i = 1 : length(all_figs)
    crt_fig_in_all_figs = all_figs(af_i);
    if ~isequal(get(crt_fig_in_all_figs, 'tag') , 'figure1')
        delete(crt_fig_in_all_figs)
    end
end
max_value = max(Y);
min_value = min(Y);
color_generate_userdata = struct();
color_generate_userdata.name = 'Comp timely density';
color_generate_userdata.Y = Y;
set_color = figure('Name' , 'Set Color Map' , 'NumberTitle' , 'off',...
    'Position', [500 400 800 300], 'Color', 'w', 'Unit', 'normalized',...
    'Menubar', 'none');
color_generate = uicontrol('parent', set_color, 'style', 'pushbutton',...
    'String', 'Generate Classes', 'unit', 'normalized', 'position',...
    [.47, .85, .16, .1], 'fontsize', 10, 'value', 2,...
    'callback', @color_generate_callback,...
    'userdata', color_generate_userdata);     %不得不设userdata，以知道画的什么图
color_class_method = uicontrol('parent', set_color, 'style', 'popupmenu',...
    'String', {'Equal Interval', 'Quantile', 'Default Cut-Off'}, 'unit', 'normalized', 'position',...
    [.29, .85, .13, .1], 'backgroundcolor', 'w', 'fontsize', 10, 'value', 3,...
    'callback', @color_class_method_callback);
%输入set_color句柄和辅助用的最大最小值，自动布局
set_color_layout(set_color, min_value, max_value);
% 前面的都可以通用，但是OK键不一样，要根据画的图不同而设置不同的callback
set_color_all_ok = uicontrol('parent', set_color, 'style', 'pushbutton', ...
    'string', 'OK', 'fontsize', 10, 'unit', 'normalized', 'position',...
    [.8, .05, .15, .15], 'callback', @color_map_ok_comp_density_time);
%初始化set color，一点开就有色带
class_num = 5;
color_ramp_name = '*RdYlGn';
value_cut = [0 .3 .5 .7 .9 Inf];
set_color_initializatoin(set_color, class_num, color_ramp_name, value_cut);


% --------------------------------------------------------------------
function comp_load_expenditure_distr_Callback(hObject, eventdata, handles)
% hObject    handle to comp_load_expenditure_distr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tic
if isfield(handles, 'NTAZ')
    NTAZ = handles.NTAZ;
else
    errordlg('Num. TAZ is neccessary', 'Comparison Data Error')
    return
end
choice = questdlg('How do you want to load your comparison expenditure distribution data?',...
    'Input Data', 'Directly Load XLSX', 'Estimate from Individual Observatoins', 'Directly Load XLSX');
if strcmp(choice, 'Directly Load XLSX')
    [fname , pname]=uigetfile('*.xlsx' , 'Open the Comparison Expenditure Distribution XLSX');
    if isequal(fname, 0)
        return
    end
    fullname = strcat(pname, fname);
    try
        Comp = xlsread(fullname , 1);
    catch
        Comp = [];
    end
    if isempty(Comp) 
        try
            Comp = xlsread(fullname , 'Mean Result of All Simulations');
        catch
            errordlg(['Fail to open the file, no valid data in ', ...
                'either ''Sheet1'' or ''Mean Result of All Simulations''.'], 'Error')
            return
        end
    end
    comp_expenditure = Comp;
    if ~isequal(size(comp_expenditure, 1), NTAZ)
        errordlg('The Num. of TAZs is not right.','Error')
        return
    end
    handles.comp_expenditure_distr = comp_expenditure;   
elseif strcmp(choice, 'Estimate from Individual Observatoins')
    if isfield(handles, 'consume_rawdata')
        choice2 = questdlg('You have already input individual consuming observation data, do you want to use this data?',...
            'Comparison Data', 'Yes, use this data', 'No, use new data', 'Yes, use this data');
        if strcmp(choice2, 'Yes, use this data')
            consume_rawdata = handles.consume_rawdata;
            use_new_flag = 0;
        elseif strcmp(choice2, 'No, use new data')
            use_new_flag = 1;
        else
            return
        end
    else
        use_new_flag = 1;
    end
    if use_new_flag == 1
        ind_consuming_ober_Callback(hObject, eventdata, handles)
        if ~isfield(handles, 'consume_rawdata')
            %如果新导入没有成功，那边先return了，这边也就return
            return
        end
        consume_rawdata = handles.consume_rawdata;
    end
    %总消费额统计
    comp_expenditure = zeros(NTAZ, 1);
    for k = 1 : size(consume_rawdata,1)
        comp_expenditure(consume_rawdata(k,1)) = ...
            comp_expenditure(consume_rawdata(k,1)) + consume_rawdata(k,2);
    end
    handles.comp_expenditure_distr = comp_expenditure;  
else
    return
end
guidata(hObject , handles)
clo = toc;
msgbox(strvcat('Finished.', ['Elapse time(s): ', num2str(clo)]))


% --------------------------------------------------------------------
function overall_check_modify_var_Callback(hObject, eventdata, handles)
% hObject    handle to overall_check_modify_var (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close_other_figurs()
adv_mode = handles.adv_mode;
if adv_mode == 1 & ~isfield(handles, 'X_adv')
    errordlg('You must firstly set the variables in advance mode.', 'Error')
    return
end
if ~isfield(handles, 'XYZ')
    errordlg('There is NO TAZ data.', 'Error')
    return
else
    xyz = handles.XYZ;
end
if ~isfield(handles, 'NTAZ')
    errordlg('You must firstly set the Num. of TAZs', 'Error')
    return
else
    NTAZ = handles.NTAZ;
end

if ~isfield(handles , 'Z_factor')
    Z_factor = str2double(get(handles.edit_Z_factor, 'String'));
else
    Z_factor = handles.Z_factor
end
xyz(:,4) = xyz(:,4) * Z_factor;             %竖向拉开
unique_XYZ = unique(xyz(: , 1));
if length(unique_XYZ) ~= NTAZ
    errordlg('Num. of TAZs is not right.', 'Error')
    return
end

%---%-------------准备数据-------------%----%
%   三部分构成：解释变量（基础+自定义+时间），时间中的交互变量， 基底面积+容量
expln_X_name = cell(0);
expln_X = [];
nonexpln_X_name = cell(0);
nonexpln_X = [];

if adv_mode == 0
    %一般模式;
    if isfield(handles, 'X_area') & length(handles.X_area) == NTAZ
        expln_X_name{end+1} = 'area';
        expln_X = [expln_X, handles.X_area];
    end
    if isfield(handles, 'X_familarity') & size(handles.X_familarity,2) == 1 &...
            length(handles.X_familarity) == NTAZ
        expln_X_name{end+1} = 'attractiveness';
        expln_X = [expln_X, handles.X_familarity];
    end
    if isfield(handles, 'base_area') & length(handles.base_area) == NTAZ
        nonexpln_X_name{end+1} = 'BaseArea';
        nonexpln_X = [nonexpln_X, handles.base_area];
    end
    if isfield(handles, 'capacity') & length(handles.capacity) == NTAZ
        nonexpln_X_name{end+1} = 'Capacity';
        nonexpln_X = [nonexpln_X, handles.capacity];
    end
    
elseif adv_mode == 1
    %高级模式
    str = '';
    X_adv = handles.X_adv;
    adv_var_name = fieldnames(X_adv);
    for k = 1 : length(adv_var_name)
        crt_name = adv_var_name{k};
        crt_X = getfield(X_adv, crt_name);
        if isempty(crt_X)       %空字段不要
            continue
        elseif isstruct(crt_X)  %结构体不要，是taz与ent矩阵
            continue
        elseif ~isnumeric(crt_X)
            continue
        elseif size(crt_X, 2) ~= 1      %排除多维
            continue
        elseif length(crt_X) ~= NTAZ
            continue
        end
        if strcmp(crt_name, 'area')
            expln_X_name{end+1} = 'area';
            expln_X = [expln_X, crt_X];
        elseif strcmp(crt_name, 'familarity')
            expln_X_name{end+1} = 'attractiveness';
            expln_X = [expln_X, crt_X];
        else
            expln_X_name{end+1} = crt_name;
            expln_X = [expln_X, crt_X];
        end
    end
    not_editable_index = [];            %针对时间交互变量中的回家哑变量
    if isfield(handles, 'time_var')
        time_var = handles.time_var;
        for k = 1 : length(time_var)
            if time_var{k}.origin == 1      %与原变量交互的不用
                continue
            end
            crt_time_var_name = time_var{k}.name;
            crt_interaction_var_name = time_var{k}.interaction_var_name;
            crt_X_interaction = time_var{k}.X_created_interaction_var;
            if length(crt_X_interaction) == NTAZ
                compond_name = [crt_time_var_name, ': ', crt_interaction_var_name];
                nonexpln_X_name{end+1} = compond_name;
                nonexpln_X = [nonexpln_X, crt_X_interaction];
            elseif length(crt_X_interaction) == NTAZ+1 & isequal(crt_X_interaction, [zeros(NTAZ,1);1])
                compond_name = [crt_time_var_name, ': ', crt_interaction_var_name];
                nonexpln_X_name{end+1} = compond_name;
                nonexpln_X = [nonexpln_X, crt_X_interaction(1:end-1)];
                str = strvcat(str, ['''', compond_name, '''',...
                    ' is a go-home dummy variable, and thus is not editable here.']);
                not_editable_index(end+1) = 1+ length(expln_X_name)+ size(nonexpln_X, 2);       %实时索引，+1是因为回头还要加表头
            elseif length(crt_X_interaction) == NTAZ+1 & ~isequal(crt_X_interaction, [zeros(NTAZ,1);1])
                compond_name = [crt_time_var_name, ': ', crt_interaction_var_name];
                nonexpln_X_name{end+1} = compond_name;
                nonexpln_X = [nonexpln_X, crt_X_interaction(1:end-1)];
                str = strvcat(str, ['Warning: ''', compond_name, '''',...
                    ' is illy defined, it set an additional value for go-home alternative, ',...
                    'but it is not a dummy variable.']);
            else
                continue
            end
        end
    end
    if isfield(handles, 'base_area') & length(handles.base_area) == NTAZ
        nonexpln_X_name{end+1} = 'BaseArea';
        nonexpln_X = [nonexpln_X, handles.base_area];
    end
    if isfield(handles, 'capacity') & length(handles.capacity) == NTAZ
        nonexpln_X_name{end+1} = 'Capacity';
        nonexpln_X = [nonexpln_X, handles.capacity];
    end
end
all_X_name = [expln_X_name, nonexpln_X_name];
all_X = [expln_X, nonexpln_X];
NEXP = length(expln_X_name);
NNEXP = length(nonexpln_X_name);
%加上TAZ编号
all_X = [unique_XYZ, all_X];
all_X_name = ['TAZID', all_X_name];
for i = 1 : size(all_X, 2)
    if isequal(all_X(:,i), round(all_X(:,i)))
        column_format{i} = 'numeric';
    else
        column_format{i} = 'bank';
    end
end
editable_flag = [false true(1,NEXP+NNEXP)];
if exist('not_editable_index', 'var') & ~isempty(not_editable_index)
    editable_flag(not_editable_index) = false;
end
if exist('str', 'var') & ~isempty(str)
    str_h = msgbox(str, 'Notice');
    waitfor(str_h)
end
%---%-------------准备数据-------------%----%

overall_check_fig = figure('Name', 'Overall Check / Modify Variables',...
    'NumberTitle', 'off', 'position', [250 100 1400 850], 'Color', ...
    'w', 'Unit', 'normalized');
figure(overall_check_fig)
axis equal
axis off
for i = 1 : size(unique_XYZ)
    crtTAZindex = unique_XYZ(i);
    index = find(xyz(:,1) == crtTAZindex);
    hold on
    patch(xyz(index,2) , xyz(index,3) , xyz(index,4) , [0.8,0.8,0.8])
end
crt_ax = gca;
set(crt_ax,'position',[0 0.03 .5 .97])
set(gcf,'color','w')
axis(crt_ax, 'equal')
axis(crt_ax, 'off')
xlim(crt_ax, [min(xyz(:,2)) - .05*(max(xyz(:,2))-min(xyz(:,2))), max(xyz(:,2)) + .05*(max(xyz(:,2))-min(xyz(:,2)))]);
ylim(crt_ax, [min(xyz(:,3)) - .05*(max(xyz(:,3))-min(xyz(:,3))), max(xyz(:,3)) + .05*(max(xyz(:,3))-min(xyz(:,3)))]);
if max(xyz(:,4)) > min(xyz(:,4))
    zlim(crt_ax, [min(xyz(:,4)) - .05*(max(xyz(:,4))-min(xyz(:,4))), max(xyz(:,4)) + .05*(max(xyz(:,4))-min(xyz(:,4)))]);
end
alpha(0.5)
az = handles.az;
el = handles.el;
view(az,el)
rotate3d(crt_ax, 'on')

%标注
ids = unique(xyz(:,1));
for kkk = 1 : length(ids)
    crt = xyz(xyz(:,1) == ids(kkk) , 2:4);
    crt_rst = polygeom(crt(:,1) , crt(:,2));
    centroid(kkk , 1:2) = crt_rst(2:3);
    centroid(kkk, 3) = crt(1, 3);
end
for kkk = 1 : length(ids)
    centroid_h{kkk} = text(centroid(kkk,1), centroid(kkk,2), centroid(kkk,3), num2str(ids(kkk)) , 'color', 'k');
end

%出表格
if NEXP + NNEXP == 0
    uicontrol('parent', overall_check_fig, 'style', 'text',...
       'Units', 'normalized','Position', [.51 .32 .55 .28],...
       'HorizontalAlignment', 'center', 'string', 'NO DATA',...
       'fontsize', 70, 'fontweight', 'bold', ...
       'backgroundcolor', 'w');
   return
else
    overall_check_ut = uitable('parent', overall_check_fig, 'data', all_X,...
        'ColumnName', all_X_name,  'ColumnEditable', editable_flag,...
        'Units', 'normalized', 'CellSelectionCallback', @cellsel_callback_overall_check,...
        'CellEditCallback', @celledit_callback_overall_check,...
        'Position', [.51 .12 .45 .84],...
        'ColumnFormat', column_format,...
        'userdata', all_X);         %userdata作为原数据
end
overall_check_save = uicontrol('parent', overall_check_fig, 'style', 'pushbutton',...
    'units', 'normalized', 'position', [.68 .05 .12 .06], 'string', 'Save',...
    'fontsize', 14, 'callback', @overall_check_save_callback);
Info = struct();
Info.all_X_name = all_X_name;
Info.NEXP = NEXP ;
Info.NNEXP = NNEXP;
set(overall_check_save, 'userdata', Info);

%---%-------------callback-------------%----%
function cellsel_callback_overall_check(hTab , event)
main_gui_h = findall(0 , 'type', 'figure', 'tag', 'figure1');
overall_check = findall(0, 'type', 'figure', 'name', 'Overall Check / Modify Variables');
handles = guidata(main_gui_h);
XYZ = handles.XYZ;
if ~isfield(handles , 'Z_factor')
    Z_factor = str2double(get(handles.edit_Z_factor, 'String'));
else
    Z_factor = handles.Z_factor
end
figure(overall_check)
ax = gca;
drawnow_sel = findall(ax, 'facecolor', [1,0.2,0.2],...
    'FaceAlpha', .6);
if ~isempty(drawnow_sel)
    delete(drawnow_sel)
end
if ~isempty(event.Indices)
    data = get(hTab, 'Data');
    iRow = event.Indices(1);
    XYZ(:,4) = XYZ(:,4) * Z_factor;   
    crtIndex = data(iRow, 1);
    crt_xyz = XYZ(XYZ(:,1) == crtIndex, 2:4);
    drawnow_sel = patch(crt_xyz(:,1) , crt_xyz(:,2) , crt_xyz(:,3) , [1,0.2,0.2],...
        'FaceAlpha', .6);
end

function celledit_callback_overall_check(hTab , event)
if isempty(event.Error)
    data_new = get(hTab, 'Data');
    data_before = get(hTab, 'userdata');
    if isequal(data_new, data_before)
        return
    end
    iRow = event.Indices(1);
    iCol = event.Indices(2);
    crt_edit_data = data_new(iRow, iCol);
    %好像也只能看看是不是数字了
    if ~isnumeric(crt_edit_data) | isnan(crt_edit_data) | isempty(crt_edit_data)
        er = errordlg('Invalid input', 'Error');
        waitfor(er)
        set(hTab, 'data', data_before)
        return
    else
        set(hTab, 'userdata', data_new)
    end
end

function overall_check_save_callback(hObject, eventdata)
main_gui_h = findall(0 , 'type', 'figure', 'tag', 'figure1');
overall_check = findall(0, 'type', 'figure', 'name', 'Overall Check / Modify Variables');
handles = guidata(main_gui_h);
overall_check_ut = findall(overall_check, 'type', 'uitable');
adv_mode = handles.adv_mode;
Info = get(hObject, 'userdata');
all_X_name = Info.all_X_name;
NEXP = Info.NEXP;
NNEXP = Info.NNEXP;
all_X = get(overall_check_ut, 'data');
NTAZ = size(all_X, 1);
if length(all_X_name) ~= 1 + NEXP + NNEXP | length(all_X_name) ~= size(all_X,2)
    errordlg('Something strange happens, see error 6943', 'Error')
    return
end
expln_X = all_X(:, 2:1+NEXP);
expln_X_name = all_X_name(2:1+NEXP);
nonexpln_X = all_X(:, 1+NEXP+1: end);
nonexpln_X_name = all_X_name(1+NEXP+1: end);
if adv_mode == 0
    %一般模式
    for k = 1 : NEXP
        crt_var_name = expln_X_name{k};
        if strcmp(crt_var_name, 'area')
            handles.X_area = expln_X(:, k);
        elseif strcmp(crt_var_name, 'attractiveness')
            handles.X_familarity = expln_X(:,k);
        else
            errordlg('Something strange happens, see error 2800','Error')
            %基本模式，找到不对应的解释变量
            return
        end
    end
    if NNEXP == 1 
        %基本模式下，如果有非解释变量，就一定是基底面积/容量
        if strcmp(nonexpln_X_name, 'BaseArea')  & size(nonexpln_X,2) ==1
            handles.base_area = nonexpln_X;
        elseif strcmp(nonexpln_X_name, 'Capacity')  & size(nonexpln_X,2) ==1
            handles.capacity = nonexpln_X;
        else
            errordlg('Something strange happens, see error 2801', 'Error')
            %基本模式，非解释变量不只是基底面积
            return
        end
    elseif NNEXP == 2
        for ki = 1 : 2
            if strcmp(nonexpln_X_name(ki), 'BaseArea')
                handles.base_area = nonexpln_X(:,ki);
            elseif strcmp(nonexpln_X_name(ki), 'Capacity')
                handles.capacity = nonexpln_X(:,ki);
            else
                errordlg('Something strange happens, see error 2720', 'Error')
                return
            end
        end
    else
        errordlg('Something strange happens, see error 2809', 'Error')
        return
    end
        
elseif adv_mode == 1
    %高级模式
    X_adv = handles.X_adv;
    for k = 1 : NEXP
        crt_var_name = expln_X_name{k};
        crt_X = expln_X(:, k);
        if strcmp(crt_var_name, 'attractiveness')
            crt_var_name = 'familarity';
        end
        if ~isfield(X_adv, crt_var_name)
            errordlg('Something strange happens, see error 2802', 'Error')
            %高级模式，找到不对应的解释变量
            return
        else
            X_adv = setfield(X_adv, crt_var_name, crt_X);
        end
    end
    handles.X_adv = X_adv;
    if NNEXP > 0            %要么是时间变量，要么是基底面积/容量
        %先处理掉基底面积/容量
        if strcmp(nonexpln_X_name{end}, 'Capacity') 
            handles.capacity = nonexpln_X(:,end);
            NNEXP = NNEXP-1;                %去掉最后一个变量（容量）
            nonexpln_X_name(end) = [];
            nonexpln_X(:,end) = [];
            %去掉容量之后，说不定再在最后一个的是基底面积
            if strcmp(nonexpln_X_name{end}, 'BaseArea') 
                handles.base_area = nonexpln_X(:,end);
                NNEXP = NNEXP-1;                %去掉最后一个变量（基底面积，专心看时间变量）
                nonexpln_X_name(end) = [];
                nonexpln_X(:,end) = [];
            end
        else strcmp(nonexpln_X_name{end}, 'BaseArea') 
            handles.base_area = nonexpln_X(:,end);
            NNEXP = NNEXP-1;                %去掉最后一个变量（基底面积，专心看时间变量）
            nonexpln_X_name(end) = [];
            nonexpln_X(:,end) = [];
        end
        %现在没基底了
        if NNEXP > 0            %有时间变量
            if ~isfield(handles, 'time_var')
                errordlg('Something strange happens, see error 2812', 'Error')
                return
            end
            time_var = handles.time_var;
            for jj = 1 : NNEXP
                crt_find_ok = 0;    %当前时间变量的查找状态初始化为0，最终要找到它，更新为1
                crt_compond_name = nonexpln_X_name{jj};
                crt_interative_X = nonexpln_X(:,jj);        %这个是来自表格的
                %分解复合名字
                if length(regexp(crt_compond_name, '^([a-zA-Z]\S.*):\s([a-zA-Z]\S.*)')) ~= 0
                    token = regexp(crt_compond_name, '^([a-zA-Z]\S.*):\s([a-zA-Z]\S.*)', 'tokens');
                    crt_time_var_name = token{1}{1};
                    crt_interaction_var_name = token{1}{2};
                else
                    errordlg('Something strange happens, see error 2813', 'Error')
                    return
                end
                for kk = 1 : length(time_var)
                    if strcmp(crt_time_var_name, time_var{kk}.name) &...
                            strcmp(crt_interaction_var_name, time_var{kk}.interaction_var_name) &...
                            time_var{kk}.origin == 2
                        from_handles_crt_interative_X = time_var{kk}.X_created_interaction_var;     %这个来自于要改的handles
                        from_handles_crt_interative_X(1:NTAZ) = crt_interative_X;
                        time_var{kk}.X_created_interaction_var = from_handles_crt_interative_X;
                        crt_find_ok = 1;
                        break
                    end
                end
                if crt_find_ok == 0
                    %找了一轮没找到
                    errordlg(['Do not find the variable: ''', crt_compond_name, '''.'], 'Error')
                    return
                end    
            end
            handles.time_var = time_var;
        end
    end
end
guidata(main_gui_h, handles);
close(overall_check)


% --------------------------------------------------------------------
function space_time_TAZ_distr_Callback(hObject, eventdata, handles)
% hObject    handle to space_time_TAZ_distr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tic;
if ~isfield(handles, 'timely_taz_stat_result')
    errordlg('There is no spatiotemporal simulation result right now.', 'Error')
    return
else
    timely_taz_stat_result = handles.timely_taz_stat_result;
end
[fname , pname] = uiputfile('SimResult_Spatiotemporal_TAZ_Distribution.xlsx' , 'Save the Spatiotemporal TAZ Distribution XLSX');
if isequal(fname, 0) | isequal(pname, 0)
    return
end
fullnameS = strcat(pname , fname);
if exist(fullnameS,'file')
    delete(fullnameS)
end
timely_taz_stat_detail = timely_taz_stat_result.detail;
timely_taz_stat_mean = timely_taz_stat_result.mean;
b_sim_times = size(timely_taz_stat_detail, 3);
NTAZ = size(timely_taz_stat_detail, 1);
time_stat_intv_origin = timely_taz_stat_result.time_stat_intv_origin;
all_taz = [1:NTAZ]';
for i = 1 : b_sim_times
    crt_timely_taz_stat = timely_taz_stat_detail(: , : , i);
    xlswrite(fullnameS ,{['Spatiotemporal Simulatoin Result of Simulation  ',... 
        num2str(i) , '. This is a ', num2str(size(crt_timely_taz_stat ,1)),...
        ' * ', num2str(size(crt_timely_taz_stat ,2)),' Space(Row)-Time(Column) Matrix']},...
        ['Result of Sim', num2str(i)] , 'A1')
%     xlswrite(fullnameS ,'TAZID/Time', ['Result of Sim', num2str(i)] , 'A2')
    xlswrite(fullnameS ,time_stat_intv_origin, ['Result of Sim', num2str(i)] , 'B2')
    xlswrite(fullnameS ,all_taz, ['Result of Sim', num2str(i)] , 'A3')
    xlswrite(fullnameS ,crt_timely_taz_stat, ['Result of Sim', num2str(i)] , 'B3')
end
xlswrite(fullnameS ,{['Mean Spatiotemporal Simulatoin Result of All Simulations' ,...
    '. This is a ', num2str(size(timely_taz_stat_mean ,1)),' * ', ...
    num2str(size(timely_taz_stat_mean ,2)),' Space(Row)-Time(Column) Matrix']}, ...
    ['Mean Result of All Simulations'] , 'A1')
% xlswrite(fullnameS ,'TAZID/Time', ['Mean Result of All Simulations'] , 'A2')
xlswrite(fullnameS ,time_stat_intv_origin, ['Mean Result of All Simulations'] , 'B2')
xlswrite(fullnameS ,all_taz, ['Mean Result of All Simulations'] , 'A3')
xlswrite(fullnameS ,timely_taz_stat_mean, ['Mean Result of All Simulations'] , 'B3')
clo = toc;
msgbox({[fname, ' saved successfully'];['Elapsed time(s): ',num2str(clo)]})


% --------------------------------------------------------------------
function export_expenditure_distri_Callback(hObject, eventdata, handles)
% hObject    handle to export_expenditure_distri (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tic;
if ~isfield(handles, 'Sim_result_money')
    errordlg('There is no expenditure simulation result right now.', 'Error')
    return
else
    Sim_result_money = handles.Sim_result_money;
end
[fname , pname] = uiputfile('SimResult_Expenditure_Distribution.xlsx' , 'Save the Expenditure Distribution XLSX');
if isequal(fname, 0) | isequal(pname, 0)
    return
end
fullnameS = strcat(pname , fname);
if exist(fullnameS,'file')
    delete(fullnameS)
end
for i = 1 : length(Sim_result_money)
    Sim_result_money_single(:,i) = Sim_result_money(i).taz(:,4);
end
Sim_result_money_mean = mean(Sim_result_money_single, 2);
NTAZ = length(Sim_result_money_mean);
Sim_result_money_mean = [[1:NTAZ]', Sim_result_money_mean];
Sim_result_money_single = [[1:NTAZ]', Sim_result_money_single];
b_sim_times = length(Sim_result_money);
for i = 1 : b_sim_times
    sim_index{1 , i} = ['Sim' , num2str(i)];
end

xlswrite(fullnameS , {'TAZID'} , 'Result of Every Simulatoin' , 'A1')
xlswrite(fullnameS , sim_index , 'Result of Every Simulatoin' , 'B1')
xlswrite(fullnameS ,Sim_result_money_single, 'Result of Every Simulatoin' , 'A2')

xlswrite(fullnameS , {'TAZID' , 'Simulated Mean Distribution'} , 'Mean Result of All Simulations' , 'A1')
xlswrite(fullnameS , Sim_result_money_mean , 'Mean Result of All Simulations' , 'A2')
clo = toc;
msgbox({[fname, ' saved successfully'];['Elapsed time(s): ',num2str(clo)]})


% --------------------------------------------------------------------
function save_as_standard_config_Callback(hObject, eventdata, handles)
% hObject    handle to save_as_standard_config (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[fname , pname] = uiputfile('*.mat' , 'Save the Configuration File');
if isequal(fname, 0) | isequal(pname, 0)
    return
end
save_standard_config_general_4_save_and_saveas(handles, fname, pname)
handles.fname = fname;
handles.pname = pname;
% 2016-3-20：保存完了要体现文件名
file_name = fname;
main_fig = findall(0, 'type', 'figure', 'tag', 'figure1');
if handles.adv_mode == 1
    set(main_fig, 'name', ['鼓浪屿游客行为模拟器'])
else
    set(main_fig, 'name', ['鼓浪屿游客行为模拟器'])
end
%已经保存过了之后，就要更新动态状态，以便于在关闭和新开时检查是否需要新保存
%注：无论是active_handles还是blank_handles都是不包括自己的
active_handles = rmfield(handles, {'blank_handles', 'active_handles'});
handles.active_handles  = active_handles;
guidata(hObject, handles)


% --------------------------------------------------------------------
function default_viw_point_Callback(hObject, eventdata, handles)
% hObject    handle to default_viw_point (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
choice = questdlg('Please choose the way to set the default view point.',...
    'Default View Point', '2-D', '3-D', '2-D');
if isempty(choice)
    return
end
if strcmp(choice, '2-D')
    [az, el] = view(2);
elseif strcmp(choice, '3-D')
    vp_xyz = inputdlgWC({'X Coordinate','Y Coordinate' , 'Z Coordinate'},...
        'Set X-Y-Z Coordinates of View Point');
    if isempty(vp_xyz)
        return
    end
    try
        vpx = str2double(vp_xyz{1});
        vpy = str2double(vp_xyz{2});
        vpz = str2double(vp_xyz{3});
    catch
        errordlg('Invalid input.', 'Error')
        return
    end
    if isempty(vpx) | isempty(vpy) | isempty(vpz)
        return
    end
    if vpx==0 & vpy==0 & vpz==0
        errordlg('X-Y-Z could not be all 0.', 'Error')
        return
    end
    [az, el] = view([vpx, vpy, vpz]);
end
handles.az = az;
handles.el = el;
guidata(hObject, handles);


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp1 = handles.active_handles;     %上一次保存/打开新文件/完全新开文件时的数据
temp2 = rmfield(handles, {'blank_handles', 'active_handles'});      %当前的数据
if ~isequaln(temp1, temp2)
    save_quest = questdlg('Do you want to save the current data to a standard configuration file?', 'Save',...
        'Yes', 'No', 'Yes');
    if strcmp(save_quest, 'Yes')
        save_standard_config_Callback(hObject, eventdata, handles)
    elseif isempty(save_quest)
        return
    end
end
% Hint: delete(hObject) closes the figure
delete(hObject);


% --------------------------------------------------------------------
function new_standard_confi_Callback(hObject, eventdata, handles)
% hObject    handle to new_standard_confi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp1 = handles.active_handles;     %上一次保存/打开新文件/完全新开文件时的数据
temp2 = rmfield(handles, {'blank_handles', 'active_handles'});      %当前的数据
if ~isequaln(temp1, temp2)
    save_quest = questdlg('Do you want to save the current data to a standard configuration file?', 'Save',...
        'Yes', 'No', 'Yes');
    if strcmp(save_quest, 'Yes')
        save_standard_config_Callback(hObject, eventdata, handles)
    elseif isempty(save_quest)
        return
    end
end
blank_handles = handles.blank_handles;
% blank_handles_fieldname = fieldnames(blank_handles);
% to_be_deleted = setdiff(fieldnames(handles),blank_handles_fieldname);
handles = blank_handles;
handles.active_handles = blank_handles;
handles.blank_handles = blank_handles;          %复原到blank状态
guidata(hObject, handles)

cla reset
set(gcf,'color','w')
axis equal
axis off
set(handles.Num_TAZ, 'string', '')
set(handles.Num_ent, 'string', '')
set(handles.Num_Ped, 'string', '')
set(handles.AreaInput, 'string', 'Waiting for Input', 'Enable', 'on')
set(handles.FamInput, 'string', 'Waiting for Input', 'Enable', 'on')
set(handles.DistInput, 'string', 'Waiting for Input', 'Enable', 'on')
set(handles.StdfInput, 'string', 'Waiting for Input', 'Enable', 'on')
set(handles.e_a, 'string', '0.0001', 'style', 'edit')
set(handles.e_b, 'string', '1.4', 'style', 'edit')
set(handles.e_c, 'string', '-0.01', 'style', 'edit')
set(handles.edit_b_stdf, 'string', '-0.4', 'style', 'edit')
set(handles.edit_b_visited, 'string', '-1.5', 'style', 'edit')
set(handles.edit_b_past, 'string', '0.6', 'style', 'edit')
set(handles.edit_Comp_actpp, 'string', '')
handles.b_sim_times = 10;
handles.od_t = 1;
handles.od_abs_mode = 0;
handles.az = -37;
handles.el = 19;
handles.queue_on = 0;
handles.queue_bar.use = 1;
handles.queue_bar.reference_value = 30;
handles.queue_bar.reference_length = 5;
handles.queue_bar.width = 10;
set(handles.change_od_mode, 'checked', 'off')
set(handles.use_advance, 'checked', 'off')
file_name = 'Unnamed';
main_fig = findall(0 , 'type', 'figure', 'tag', 'figure1');
set(main_fig, 'name', ['鼓浪屿游客行为模拟器'])
set(handles.adv_def_var, 'enable', 'off')
set(handles.queue_on_check, 'enable', 'off');
set(handles.input_user_def_vars, 'enable', 'off');
set(handles.def_time_var, 'enable', 'off');
set(handles.def_dyn_var, 'enable', 'off');
set(handles.beta_panel, 'title', 'Behaivoral Coefficients')
set(handles.xs_panel, 'title', 'Explanatory Variables')
set(handles.use_predefine_with_fam, 'Enable', 'on');
set(handles.use_predefine_without_fam, 'Enable', 'on');
set(handles.use_user_define_coef, 'Enable', 'on');
set(handles.excel_confi_file, 'Enable', 'on');
set(handles.save_confi, 'Enable', 'on');
set(handles.open_confi, 'Enable', 'on');


% --------------------------------------------------------------------
function draw_plots_Callback(hObject, eventdata, handles)
% hObject    handle to draw_plots (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function drawplot1_plot_only_tazs_Callback(hObject, eventdata, handles)
% hObject    handle to drawplot1_plot_only_tazs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
PlotChoice = 1;
handles.PlotChoice = PlotChoice;
guidata(hObject, handles);
plot_execute_Callback(hObject, eventdata, handles)
set(handles.plot_type_choice_popmenu, 'value', PlotChoice)



% --------------------------------------------------------------------
function drawplot3_sim_individual_spatial_distr_all_Callback(hObject, eventdata, handles)
% hObject    handle to drawplot3_sim_individual_spatial_distr_all (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
PlotChoice = 3;
handles.PlotChoice = PlotChoice;
guidata(hObject, handles);
plot_execute_Callback(hObject, eventdata, handles)
set(handles.plot_type_choice_popmenu, 'value', PlotChoice)


% --------------------------------------------------------------------
function drawplot4_sim_individual_spatial_distr_certain_time_Callback(hObject, eventdata, handles)
% hObject    handle to drawplot4_sim_individual_spatial_distr_certain_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
PlotChoice = 4;
handles.PlotChoice = PlotChoice;
guidata(hObject, handles);
plot_execute_Callback(hObject, eventdata, handles)
set(handles.plot_type_choice_popmenu, 'value', PlotChoice)


% --------------------------------------------------------------------
function drawplot5_sim_individual_distr_colormap_all_Callback(hObject, eventdata, handles)
% hObject    handle to drawplot5_sim_individual_distr_colormap_all (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
PlotChoice = 5;
handles.PlotChoice = PlotChoice;
guidata(hObject, handles);
plot_execute_Callback(hObject, eventdata, handles)
set(handles.plot_type_choice_popmenu, 'value', PlotChoice)


% --------------------------------------------------------------------
function drawplot6_sim_individual_distr_colormap_certain_time_Callback(hObject, eventdata, handles)
% hObject    handle to drawplot6_sim_individual_distr_colormap_certain_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
PlotChoice = 6;
handles.PlotChoice = PlotChoice;
guidata(hObject, handles);
plot_execute_Callback(hObject, eventdata, handles)
set(handles.plot_type_choice_popmenu, 'value', PlotChoice)


% --------------------------------------------------------------------
function draw_plot7_sim_density_Callback(hObject, eventdata, handles)
% hObject    handle to draw_plot7_sim_density (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
PlotChoice = 7;
handles.PlotChoice = PlotChoice;
guidata(hObject, handles);
plot_execute_Callback(hObject, eventdata, handles)
set(handles.plot_type_choice_popmenu, 'value', PlotChoice)


% --------------------------------------------------------------------
function drawplot_8_sim_density_timely_Callback(hObject, eventdata, handles)
% hObject    handle to drawplot_8_sim_density_timely (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
PlotChoice = 8;
handles.PlotChoice = PlotChoice;
guidata(hObject, handles);
plot_execute_Callback(hObject, eventdata, handles)
set(handles.plot_type_choice_popmenu, 'value', PlotChoice)


% --------------------------------------------------------------------
function drawplot11_sim_od_Callback(hObject, eventdata, handles)
% hObject    handle to drawplot11_sim_od (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
PlotChoice = 11;
handles.PlotChoice = PlotChoice;
guidata(hObject, handles);
plot_execute_Callback(hObject, eventdata, handles)
set(handles.plot_type_choice_popmenu, 'value', PlotChoice)


% --------------------------------------------------------------------
function drawplot12_sim_money_Callback(hObject, eventdata, handles)
% hObject    handle to drawplot12_sim_money (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
PlotChoice = 12;
handles.PlotChoice = PlotChoice;
guidata(hObject, handles);
plot_execute_Callback(hObject, eventdata, handles)
set(handles.plot_type_choice_popmenu, 'value', PlotChoice)


% --------------------------------------------------------------------
function drawplot13_comp_distr_scatter_Callback(hObject, eventdata, handles)
% hObject    handle to drawplot13_comp_distr_scatter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
PlotChoice = 13;
handles.PlotChoice = PlotChoice;
guidata(hObject, handles);
plot_execute_Callback(hObject, eventdata, handles)
set(handles.plot_type_choice_popmenu, 'value', PlotChoice)


% --------------------------------------------------------------------
function drawplot14_comp_distr_scatter_time_Callback(hObject, eventdata, handles)
% hObject    handle to drawplot14_comp_distr_scatter_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
PlotChoice = 14;
handles.PlotChoice = PlotChoice;
guidata(hObject, handles);
plot_execute_Callback(hObject, eventdata, handles)
set(handles.plot_type_choice_popmenu, 'value', PlotChoice)

% --------------------------------------------------------------------
function drawplot15_comp_distr_color_Callback(hObject, eventdata, handles)
% hObject    handle to drawplot15_comp_distr_color (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
PlotChoice = 15;
handles.PlotChoice = PlotChoice;
guidata(hObject, handles);
plot_execute_Callback(hObject, eventdata, handles)
set(handles.plot_type_choice_popmenu, 'value', PlotChoice)


% --------------------------------------------------------------------
function drawplot16_comp_distri_color_timely_Callback(hObject, eventdata, handles)
% hObject    handle to drawplot16_comp_distri_color_timely (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
PlotChoice = 16;
handles.PlotChoice = PlotChoice;
guidata(hObject, handles);
plot_execute_Callback(hObject, eventdata, handles)
set(handles.plot_type_choice_popmenu, 'value', PlotChoice)


% --------------------------------------------------------------------
function drawplot17_comp_density_Callback(hObject, eventdata, handles)
% hObject    handle to drawplot17_comp_density (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
PlotChoice = 17;
handles.PlotChoice = PlotChoice;
guidata(hObject, handles);
plot_execute_Callback(hObject, eventdata, handles)
set(handles.plot_type_choice_popmenu, 'value', PlotChoice)


% --------------------------------------------------------------------
function drawplot18_comp_density_timely_Callback(hObject, eventdata, handles)
% hObject    handle to drawplot18_comp_density_timely (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
PlotChoice = 18;
handles.PlotChoice = PlotChoice;
guidata(hObject, handles);
plot_execute_Callback(hObject, eventdata, handles)
set(handles.plot_type_choice_popmenu, 'value', PlotChoice)


% --------------------------------------------------------------------
function drawplot21_comp_od_Callback(hObject, eventdata, handles)
% hObject    handle to drawplot21_comp_od (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
PlotChoice = 21;
handles.PlotChoice = PlotChoice;
guidata(hObject, handles);
plot_execute_Callback(hObject, eventdata, handles)
set(handles.plot_type_choice_popmenu, 'value', PlotChoice)


% --------------------------------------------------------------------
function drawplot22_comp_money_Callback(hObject, eventdata, handles)
% hObject    handle to drawplot22_comp_money (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
PlotChoice = 22;
handles.PlotChoice = PlotChoice;
guidata(hObject, handles);
plot_execute_Callback(hObject, eventdata, handles)
set(handles.plot_type_choice_popmenu, 'value', PlotChoice)


% --------------------------------------------------------------------
function drawplot_24_llz_ind_Callback(hObject, eventdata, handles)
% hObject    handle to drawplot_24_llz_ind (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
PlotChoice = 24;
handles.PlotChoice = PlotChoice;
guidata(hObject, handles);
plot_execute_Callback(hObject, eventdata, handles)
set(handles.plot_type_choice_popmenu, 'value', PlotChoice)


% --------------------------------------------------------------------
function drawplot25_llz_money_Callback(hObject, eventdata, handles)
% hObject    handle to drawplot25_llz_money (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
PlotChoice = 25;
handles.PlotChoice = PlotChoice;
guidata(hObject, handles);
plot_execute_Callback(hObject, eventdata, handles)
set(handles.plot_type_choice_popmenu, 'value', PlotChoice)


% --------------------------------------------------------------------
function drawplot27_mean_num_actpp_Callback(hObject, eventdata, handles)
% hObject    handle to drawplot27_mean_num_actpp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
PlotChoice = 27;
handles.PlotChoice = PlotChoice;
guidata(hObject, handles);
plot_execute_Callback(hObject, eventdata, handles)
set(handles.plot_type_choice_popmenu, 'value', PlotChoice)


% --------------------------------------------------------------------
function drawplot28_num_act_certain_taz_Callback(hObject, eventdata, handles)
% hObject    handle to drawplot28_num_act_certain_taz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
PlotChoice = 28;
handles.PlotChoice = PlotChoice;
guidata(hObject, handles);
plot_execute_Callback(hObject, eventdata, handles)
set(handles.plot_type_choice_popmenu, 'value', PlotChoice)


% --------------------------------------------------------------------
function drawplot29_comp_lineplot_Callback(hObject, eventdata, handles)
% hObject    handle to drawplot29_comp_lineplot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
PlotChoice = 29;
handles.PlotChoice = PlotChoice;
guidata(hObject, handles);
plot_execute_Callback(hObject, eventdata, handles)
set(handles.plot_type_choice_popmenu, 'value', PlotChoice)


% --------------------------------------------------------------------
function drawplot30_comp_scattplot_Callback(hObject, eventdata, handles)
% hObject    handle to drawplot30_comp_scattplot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
PlotChoice = 30;
handles.PlotChoice = PlotChoice;
guidata(hObject, handles);
plot_execute_Callback(hObject, eventdata, handles)
set(handles.plot_type_choice_popmenu, 'value', PlotChoice)


% --------------------------------------------------------------------
function def_dyn_var_Callback(hObject, eventdata, handles)
% hObject    handle to def_dyn_var (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isfield(handles, 'adv_var')
    errordlg('You should firstly define variables in advance mode.', 'Error')
    return
end
if ~isfield(handles, 'NTAZ')
    errordlg('You should firstly set the Num. of TAZs', 'Error')
    return
else
    NTAZ = handles.NTAZ;
end
if isfield(handles, 'dyn_var')
    dyn_var = handles.dyn_var;
else
    dyn_var.volumn.use = 0;
    dyn_var.volumn.type = 1;
    dyn_var.volumn.value = [];
    dyn_var.density.use = 0;
    dyn_var.density.type = 1;
    dyn_var.density.value = [];
    dyn_var.queue.use = 0;
    dyn_var.queue.type = 1;
    dyn_var.queue.value = [];
end
close_other_figurs()
instruction_str1 = ['1. You can choose dynamic ''Volumn'' and(or) ''Density'' and(or) ''Queue Time'' as ',...
    'behaviroal explanatory varaibles. If checked on, they will (only) work in spatiotemporal simulation in advance mode.'];
instruction_str2 = ['2. If you check ''Density'' on, base area variable is neccessary, ',...
    'if you check ''Queue Time'' on, capacity is neccessary, and you have to set queue on.'];
instruction_str3 = ['3. For each dynamic variable, you can set it as continuous or categorical, ',...
    'for categorical variable, you have to set a series of cut-points in ascending order, ',...
    'you would need N cut-points for N+1 categories, the minimum N is 1, ',...
    'the reference level would be the first category (values below the smallest cut-point).'];
instruction_str4 = ['4. Since the coefficients of dynamic variables are hard to be estimated from revealed preference ',...
    'data such as questionnaires or limited observations using logit model, you should input these coefficients by yourself, '...
    'you can try stated preference method.'];
instruction_str1234 = msgbox(strvcat('Instructions: ', instruction_str1, instruction_str2, instruction_str3, instruction_str4), 'Instructions');
waitfor(instruction_str1234);

dyn_var_def = figure('Name' , 'Dynamic Variable Definition' , 'NumberTitle' , 'off',...
    'Position', [650 350 500 400], 'Color', 'w', 'Unit', 'normalized',...
    'Menubar', 'none');
volumn_panel = uipanel('Parent', dyn_var_def, 'title', 'Volume', 'fontsize', 15,...
    'unit', 'normalized', 'position', [.05 .74 .9 .21]);
density_panel = uipanel('Parent', dyn_var_def, 'title', 'Density', 'fontsize', 15,...
    'unit', 'normalized', 'position', [.05 .46 .9 .21]);
queue_panel = uipanel('Parent', dyn_var_def, 'title', 'Queue Time', 'fontsize', 15,...
    'unit', 'normalized', 'position', [.05 .18 .9 .21]);
dyn_var_ok = uicontrol('Parent', dyn_var_def, 'string', 'OK', 'fontsize', 13,...
    'fontweight', 'bold', 'unit', 'normalized', 'position', [.3 .05 .4 .1],...
    'callback', @dyn_var_ok_callback);

volumn_check = uicontrol('Parent', volumn_panel, 'style', 'checkbox', 'value', dyn_var.volumn.use,...
    'unit', 'normalized', 'position', [.05 .1 .3 .8], 'string', 'Use Volume', 'fontsize',11,...
    'callback', @dyn_var_check_callback);
volumn_type = uicontrol('Parent', volumn_panel, 'style', 'popup', 'value', dyn_var.volumn.type,...
    'unit', 'normalized', 'position', [.4 .02 .2 .8], 'string', {'Continuous'; 'Categorical'}, 'fontsize',10,...
    'callback', @dyn_var_type_callback);
volumn_betaX = uicontrol('Parent', volumn_panel, 'style', 'pushbutton',  ...
    'unit', 'normalized', 'position', [.65 .1 .3 .8], 'string', {'Waiting for Input'}, 'fontsize',10,...
    'callback', @dyn_var_input_betaX_callback);

density_check = uicontrol('Parent', density_panel, 'style', 'checkbox', 'value', dyn_var.density.use,...
    'unit', 'normalized', 'position', [.05 .1 .3 .8], 'string', 'Use Density', 'fontsize',11,...
    'callback', @dyn_var_check_callback);
density_type = uicontrol('Parent', density_panel, 'style', 'popup', 'value', dyn_var.density.type,...
    'unit', 'normalized', 'position', [.4 .02 .2 .8], 'string', {'Continuous'; 'Categorical'}, 'fontsize',10,...
    'callback', @dyn_var_type_callback);
density_betaX = uicontrol('Parent', density_panel, 'style', 'pushbutton',  ...
    'unit', 'normalized', 'position', [.65 .1 .3 .8], 'string', {'Waiting for Input'}, 'fontsize',10,...
    'callback', @dyn_var_input_betaX_callback);

queue_check = uicontrol('Parent', queue_panel, 'style', 'checkbox', 'value', dyn_var.queue.use,...
    'unit', 'normalized', 'position', [.05 .1 .3 .8], 'string', 'Use Queue Time', 'fontsize',11,...
    'callback', @dyn_var_check_callback);
queue_type = uicontrol('Parent', queue_panel, 'style', 'popup', 'value', dyn_var.queue.type,...
    'unit', 'normalized', 'position', [.4 .02 .2 .8], 'string', {'Continuous'; 'Categorical'}, 'fontsize',10,...
    'callback', @dyn_var_type_callback);
queue_betaX = uicontrol('Parent', queue_panel, 'style', 'pushbutton',  ...
    'unit', 'normalized', 'position', [.65 .1 .3 .8], 'string', {'Waiting for Input'}, 'fontsize',10,...
    'callback', @dyn_var_input_betaX_callback);
volumn_type_value.type = dyn_var.volumn.type;
volumn_type_value.value = dyn_var.volumn.value;
density_type_value.type = dyn_var.density.type;
density_type_value.value = dyn_var.density.value;
queue_type_value.type = dyn_var.queue.type;
queue_type_value.value = dyn_var.queue.value;
set(volumn_betaX, 'userdata', volumn_type_value);
set(density_betaX, 'userdata', density_type_value);
set(queue_betaX, 'userdata', queue_type_value);
if ~isempty(dyn_var.volumn.value)
    set(volumn_betaX, 'string', 'Finished')
end
if ~isempty(dyn_var.density.value)
    set(density_betaX, 'string', 'Finished')
end
if ~isempty(dyn_var.queue.value)
    set(queue_betaX, 'string', 'Finished')
end
if dyn_var.volumn.use == 0
    set(volumn_type, 'enable', 'off')
    set(volumn_betaX, 'enable', 'off')
end
if dyn_var.density.use == 0
    set(density_type, 'enable', 'off')
    set(density_betaX, 'enable', 'off')
end
if dyn_var.queue.use == 0
    set(queue_type, 'enable', 'off')
    set(queue_betaX, 'enable', 'off')
end


function dyn_var_check_callback(hObject, eventdata, handles)
panel_h = get(hObject, 'parent');
type_h = findall(panel_h, 'type', 'uicontrol', 'style', 'popup');
value_h = findall(panel_h, 'type', 'uicontrol', 'style', 'pushbutton');
check_value = get(hObject, 'value');
switch check_value
    case 1
        set(type_h, 'enable', 'on');
        set(value_h, 'enable', 'on');
    case 0
        set(type_h, 'enable', 'off');
        set(value_h, 'enable', 'off');
end


function dyn_var_type_callback(hObject, eventdata, handles)
panel_h = get(hObject, 'parent');
value_h = findall(panel_h, 'type', 'uicontrol', 'style', 'pushbutton');
type_value = get(value_h, 'userdata');
new_type = get(hObject, 'value');
if type_value.type ~= new_type
    type_value.type = new_type;
    type_value.value = [];
    set(value_h, 'string', 'Waiting for Input')
end
set(value_h, 'userdata', type_value);


function dyn_var_input_betaX_callback(hObject, eventdata, handles)
type_value = get(hObject, 'userdata');
type = type_value.type;
default_value = num2str(type_value.value);
switch type
    case 1
        if ~isempty(default_value)
            default_value = strtrim(default_value(2, :));
        end
        beta = inputdlgWC('Input the coefficient: only one number', 'Dynamic Variables',...
            1, {default_value});
        if isempty(beta) | (~isempty(beta)&isempty(beta{:}))
            return
        end
        try beta = str2num(beta{1});
        catch errordlg('Invalid input.', 'Error'); return
        end
        if ~isnumeric(beta) | isnan(beta) | isempty(beta)
            errordlg; return
        end
        betaX = [-inf; beta];
    case 2
        prompt = {'Input the cut-off values in ascending order: N numbers for N+1 categories, using space or comma as seprator',...
            ['Input the coefficients: N numbers, using space or comma as seprator, ',...
            'the first category ( ~ lowest) is the reference level with zero coefficient.']};
        if isempty(default_value)
            default_value_cutpoints = '';
            default_value_beta = '';
        else
            default_value_cutpoints = strtrim(default_value(1,:));
            default_value_beta = strtrim(default_value(2,:));
        end
        betaX = inputdlgWC(prompt, 'Dynamic Variables', 1, {default_value_cutpoints, default_value_beta});
        if isempty(betaX)
            return
        end
        try
            X = str2num(betaX{1});
            beta = str2num(betaX{2});
        catch 
            errordlg('Invalid input', 'Error')
            return
        end
        if isempty(X) | isempty(beta) 
            errordlg('Invalid or incomplete input.', 'Error')
            return
        end
        if ~issorted(X)
            errordlg('Cut-off values should be sorted in ascending order.', 'Error')
            return
        end
        if length(X) ~= length(beta)
            errordlg('Cut-off values should have the same length as the beta.', 'Error')
            return
        end
        if (size(X,1) == 1 & size(X,2) >= 1) & (size(beta,1) == 1 & size(beta,2) >= 1)
            betaX = [X; beta];
        elseif (size(X,1) >= 1 & size(X,2) == 1) & (size(beta,1) >= 1 & size(beta,2) == 1)
            betaX = [X, beta]';
        else
            errordlg('Size of input data is not right.', 'Error')
            return
        end
end
type_value.value = betaX;
set(hObject, 'userdata', type_value, 'string', 'Finished');



function dyn_var_ok_callback(hObject, eventdata, handles)
crt_fig = findall(0, 'type', 'figure', 'name', 'Dynamic Variable Definition');
volumn_panel = findall(crt_fig, 'type', 'uipanel', 'title', 'Volumn');
density_panel = findall(crt_fig, 'type', 'uipanel', 'title', 'Density');
queue_panel = findall(crt_fig, 'type', 'uipanel', 'title', 'Queue Time');
volumn_check = findall(volumn_panel, 'type', 'uicontrol', 'style', 'checkbox');
volumn_type = findall(volumn_panel, 'type', 'uicontrol', 'style', 'popup');
volumn_betaX = findall(volumn_panel, 'type', 'uicontrol', 'style', 'pushbutton');
density_check = findall(density_panel, 'type', 'uicontrol', 'style', 'checkbox');
density_type = findall(density_panel, 'type', 'uicontrol', 'style', 'popup');
density_betaX = findall(density_panel, 'type', 'uicontrol', 'style', 'pushbutton');
queue_check = findall(queue_panel, 'type', 'uicontrol', 'style', 'checkbox');
queue_type = findall(queue_panel, 'type', 'uicontrol', 'style', 'popup');
queue_betaX = findall(queue_panel, 'type', 'uicontrol', 'style', 'pushbutton');

dyn_var.volumn.use = get(volumn_check, 'value');
dyn_var.volumn.type = get(volumn_type, 'value');
volumn_betaX_userdata = get(volumn_betaX, 'userdata');
if dyn_var.volumn.use == 1 & isempty(volumn_betaX_userdata.value)
    errordlg('Since you use ''Volumn'' variable, you must set the its coefficient.', 'Error')
    return
end
dyn_var.volumn.value = volumn_betaX_userdata.value;
dyn_var.density.use = get(density_check, 'value');
dyn_var.density.type = get(density_type, 'value');
density_betaX_userdata = get(density_betaX, 'userdata');
if dyn_var.density.use == 1 & isempty(density_betaX_userdata.value)
    errordlg('Since you use ''Density'' variable, you must set the its coefficient.', 'Error')
    return
end
dyn_var.density.value = density_betaX_userdata.value;
dyn_var.queue.use = get(queue_check, 'value');
dyn_var.queue.type = get(queue_type, 'value');
queue_betaX_userdata = get(queue_betaX, 'userdata');
if dyn_var.queue.use == 1 & isempty(queue_betaX_userdata.value)
    errordlg('Since you use ''Queue Time'' variable, you must set the its coefficient.', 'Error')
    return
end
dyn_var.queue.value = queue_betaX_userdata.value;
main_fig = findall(0, 'type', 'figure', 'tag', 'figure1');
handles = guidata(main_fig);
handles.dyn_var = dyn_var;
guidata(main_fig, handles);
close(crt_fig);


% --------------------------------------------------------------------
function input_capacity_Callback(hObject, eventdata, handles)
% hObject    handle to input_capacity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isfield(handles , 'NTAZ')
    errordlg('Please firstly input Num of TAZs' , 'NTAZ Error')
    return
end
NTAZ = handles.NTAZ;
instr = ['Once you are going to input capacity data, you need to input ',...
    'for all TAZs, if some of TAZs has no capacity limitation, DO NOT ',...
    'leave it alone or wrongly set them to 0, because 0 means no one can ',...
    'enter, the proper way is to set them as inf, which means infinity.'];
instr_msg = msgbox(instr, 'Instruction');
waitfor(instr_msg)
choice = questdlg('Choose the way of inputting data or check data',...
    'TAZ Capacity', 'Load CSV File', 'Directly Type or Copy / Paste',...
    'Check Data', 'Load CSV File');
if strcmp(choice, 'Load CSV File')
    choiceIndex = 1;
elseif strcmp(choice, 'Directly Type or Copy / Paste')
    choiceIndex = 2;
elseif strcmp(choice, 'Check Data')
    choiceIndex = 3;
else
    return
end
switch choiceIndex
    case 1      %导入
        [fname , pname] = uigetfile('*.csv' , 'Open the Capacity Data CSV');
        if isequal(fname, 0) | isequal(pname, 0)
            return
        end
        fullname = strcat(pname,fname);
        table_data = importdata(fullname);
        if isfield(table_data, 'colheaders')
            colheaders = table_data.colheaders;
            TAZID_index = find(ismember(colheaders, 'TAZID'));
            if isempty(TAZID_index)
                TAZID_index = listdlg('PromptString','Select TAZ ID Variable:','SelectionMode','single',...
                    'ListString',colheaders);
                if isempty(TAZID_index)
                    TAZID_index  = [];          %相当于按顺序排列了
                end
            end
            capacity_index = find(ismember(colheaders, 'Capacity'));
            if isempty(capacity_index)
                capacity_index = listdlg('PromptString','Select Capacity Variable:','SelectionMode','single',...
                    'ListString',colheaders);
                if isempty(capacity_index)
                    return
                end
            end
            try
                capacity_csv = csvread(fullname, 1, 0);
            catch
                errordlg('Fail to open the csv file', 'Open Error')
                return
            end
            capacity_csv = capacity_csv(:, [TAZID_index, capacity_index(1)]);
        else
            try
                capacity_csv = csvread(fullname);
            catch
                errordlg('Fail to open the csv file', 'Open Error')
                return
            end
        end
        [nrow_area , ncol_area] = size(capacity_csv);
        if nrow_area == NTAZ
            if ncol_area == 1
                capacity = capacity_csv;
            elseif ncol_area == 2
                capacity_csv = sortrows(capacity_csv , 1);
                capacity = capacity_csv(:,2);
            else
                errordlg('The input csv file should contain no more than 2 columns of data', 'Input Error')
                return
            end
        else
            errordlg('Input Num of capacity data NOT equal Num of TAZ' , 'Input Error')
            return
        end
        if sum(capacity > 0) ~= NTAZ
            errordlg('There are some non-positive capacity values.', 'Error')
            return
        else
            handles.capacity = capacity;
            guidata(hObject, handles);
        end
        msgbox('Finshed')
    case 2      %直接输
        str = ['Please enter space(/comma)-separated capacity data in the order: from TAZ_1 to TAZ_' , ...
            num2str(NTAZ)];
        same_pasted_value = inputdlgWC({str, 'OR please enter the same capacity for All TAZS'} , ...
            'Capacity Data Input', [1 80 ; 1 45]);
        if isempty(same_pasted_value)
            return
        end
        pasted_value = same_pasted_value{1};
        same_value = same_pasted_value{2};
        if length(pasted_value) ~= 0
            try
                pasted_value = str2double(pasted_value);
            catch
                errordlg('Invalid Input', 'Input Error')
                return
            end
            if sum(pasted_value > 0) ~= length(pasted_value)
                errordlg('There are some non-positive capacity values.', 'Error')
                return
            end
            if length(pasted_value) == NTAZ
                capacity = pasted_value';
                handles.capacity = capaacity;
                guidata(hObject,handles);
            else
                errordlg('Input Num of capacity data NOT equal Num of TAZ' , 'Input Error')
                return
            end
        elseif length(same_value) ~= 0
            try
                same_value = str2double(same_value);
            catch
                errordlg('Invalid Input', 'Input Error')
                return
            end
            if same_value <= 0 
                errordlg('The capacity value must be positive.', 'Error')
                return
            end
            capacity = same_value * ones(NTAZ, 1);
            handles.capacity = capacity;
            guidata(hObject,handles);
        end    
        msgbox('Finshed')
    case 3      %检查数据
        if ~isfield(handles , 'capacity')
            errordlg('There is NO valid capacity input' ,'Error')
            return
        else
            capacity = handles.capacity;
            taz_capacity = [[1:NTAZ]' , capacity];
            show = strvcat('TAZ    CAPACITY' , num2str(taz_capacity));
            msgbox(show)
        end
end


% --------------------------------------------------------------------
function queue_on_check_Callback(hObject, eventdata, handles)
% hObject    handle to queue_on_check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if strcmp(get(hObject,'Checked'),'on')
    set(hObject,'Checked','off');
    handles.queue_on = 0;
    msgbox('Queue Off');
else 
    if ~isfield(handles, 'capacity')
        errordlg('You can not set queue on before you input TAZ capacity data.', 'Error')
        return
    end
    set(hObject,'Checked','on');
    handles.queue_on = 1;
    msgbox('Queue On');
end
guidata(hObject, handles);


% --------------------------------------------------------------------
function drawplot9_sim_queue_volumn_Callback(hObject, eventdata, handles)
% hObject    handle to drawplot9_sim_queue_volumn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
PlotChoice = 9;
handles.PlotChoice = PlotChoice;
guidata(hObject, handles);
plot_execute_Callback(hObject, eventdata, handles)
set(handles.plot_type_choice_popmenu, 'value', PlotChoice)


% --------------------------------------------------------------------
function drawplot10_sim_queue_time_Callback(hObject, eventdata, handles)
% hObject    handle to drawplot10_sim_queue_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
PlotChoice = 10;
handles.PlotChoice = PlotChoice;
guidata(hObject, handles);
plot_execute_Callback(hObject, eventdata, handles)
set(handles.plot_type_choice_popmenu, 'value', PlotChoice)


% --------------------------------------------------------------------
function drawplot19_comp_queue_volumn_Callback(hObject, eventdata, handles)
% hObject    handle to drawplot19_comp_queue_volumn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
PlotChoice = 19;
handles.PlotChoice = PlotChoice;
guidata(hObject, handles);
plot_execute_Callback(hObject, eventdata, handles)
set(handles.plot_type_choice_popmenu, 'value', PlotChoice)


% --------------------------------------------------------------------
function drawplot20_comp_queue_time_Callback(hObject, eventdata, handles)
% hObject    handle to drawplot20_comp_queue_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
PlotChoice = 20;
handles.PlotChoice = PlotChoice;
guidata(hObject, handles);
plot_execute_Callback(hObject, eventdata, handles)
set(handles.plot_type_choice_popmenu, 'value', PlotChoice)


% --------------------------------------------------------------------
function drawplot26_time_variant_stat4TAZ_Callback(hObject, eventdata, handles)
% hObject    handle to drawplot26_time_variant_stat4TAZ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
PlotChoice = 26;
handles.PlotChoice = PlotChoice;
guidata(hObject, handles);
plot_execute_Callback(hObject, eventdata, handles)
set(handles.plot_type_choice_popmenu, 'value', PlotChoice)


% --------------------------------------------------------------------
function save_space_time_queue_volumn_Callback(hObject, eventdata, handles)
% hObject    handle to save_space_time_queue_volumn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tic;
if ~isfield(handles, 'timely_taz_queue_population_result')
    errordlg('There is no queue volumn simulation result right now.', 'Error')
    return
else
    timely_taz_queue_population_result = handles.timely_taz_queue_population_result;
end
[fname , pname] = uiputfile('SimResult_Queue_Volumn.xlsx' , 'Save the Simulated Queue Volumn XLSX');
if isequal(fname, 0) | isequal(pname, 0)
    return
end
fullnameS = strcat(pname , fname);
if exist(fullnameS,'file')
    delete(fullnameS)
end
timely_taz_queue_population_detail = timely_taz_queue_population_result.detail;
timely_taz_queue_population_mean = timely_taz_queue_population_result.mean;
b_sim_times = size(timely_taz_queue_population_detail, 3);
NTAZ = size(timely_taz_queue_population_detail, 1);
time_stat_intv_origin = timely_taz_queue_population_result.time_stat_intv_origin;
all_taz = [1:NTAZ]';
for i = 1 : b_sim_times
    crt_timely_taz_queue_population = timely_taz_queue_population_detail(: , : , i);
    xlswrite(fullnameS ,{['Queue Volumn Simulatoin Result of Simulation  ',... 
        num2str(i) , '. This is a ', num2str(size(crt_timely_taz_queue_population ,1)),...
        ' * ', num2str(size(crt_timely_taz_queue_population ,2)),' Space(Row)-Time(Column) Matrix']},...
        ['Result of Sim', num2str(i)] , 'A1')
%     xlswrite(fullnameS ,'TAZID/Time', ['Result of Sim', num2str(i)] , 'A2')
    xlswrite(fullnameS ,time_stat_intv_origin, ['Result of Sim', num2str(i)] , 'B2')
    xlswrite(fullnameS ,all_taz, ['Result of Sim', num2str(i)] , 'A3')
    xlswrite(fullnameS ,crt_timely_taz_queue_population, ['Result of Sim', num2str(i)] , 'B3')
end
xlswrite(fullnameS ,{['Mean Queue Volumn Simulatoin Result of All Simulations' ,...
    '. This is a ', num2str(size(timely_taz_queue_population_mean ,1)),' * ', ...
    num2str(size(timely_taz_queue_population_mean ,2)),' Space(Row)-Time(Column) Matrix']}, ...
    ['Mean Result of All Simulations'] , 'A1')
% xlswrite(fullnameS ,'TAZID/Time', ['Mean Result of All Simulations'] , 'A2')
xlswrite(fullnameS ,time_stat_intv_origin, ['Mean Result of All Simulations'] , 'B2')
xlswrite(fullnameS ,all_taz, ['Mean Result of All Simulations'] , 'A3')
xlswrite(fullnameS ,timely_taz_queue_population_mean, ['Mean Result of All Simulations'] , 'B3')
clo = toc;
msgbox({[fname, ' saved successfully'];['Elapsed time(s): ',num2str(clo)]})


% --------------------------------------------------------------------
function save_space_time_queue_time_Callback(hObject, eventdata, handles)
% hObject    handle to save_space_time_queue_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tic;
if ~isfield(handles, 'timely_taz_queue_time_result')
    errordlg('There is no queue time simulation result right now.', 'Error')
    return
else
    timely_taz_queue_time_result = handles.timely_taz_queue_time_result;
end
[fname , pname] = uiputfile('SimResult_Queue_Time.xlsx' , 'Save the Simulated Queue Time XLSX');
if isequal(fname, 0) | isequal(pname, 0)
    return
end
fullnameS = strcat(pname , fname);
if exist(fullnameS,'file')
    delete(fullnameS)
end
timely_taz_queue_time_detail = timely_taz_queue_time_result.detail;
timely_taz_queue_time_mean = timely_taz_queue_time_result.mean;
b_sim_times = size(timely_taz_queue_time_detail, 3);
NTAZ = size(timely_taz_queue_time_detail, 1);
time_stat_intv_origin = timely_taz_queue_time_result.time_stat_intv_origin;
all_taz = [1:NTAZ]';
for i = 1 : b_sim_times
    crt_timely_taz_queue_time = timely_taz_queue_time_detail(: , : , i);
    xlswrite(fullnameS ,{['Queue Time Simulatoin Result of Simulation  ',... 
        num2str(i) , '. This is a ', num2str(size(crt_timely_taz_queue_time ,1)),...
        ' * ', num2str(size(crt_timely_taz_queue_time ,2)),' Space(Row)-Time(Column) Matrix']},...
        ['Result of Sim', num2str(i)] , 'A1')
%     xlswrite(fullnameS ,'TAZID/Time', ['Result of Sim', num2str(i)] , 'A2')
    xlswrite(fullnameS ,time_stat_intv_origin, ['Result of Sim', num2str(i)] , 'B2')
    xlswrite(fullnameS ,all_taz, ['Result of Sim', num2str(i)] , 'A3')
    xlswrite(fullnameS ,crt_timely_taz_queue_time, ['Result of Sim', num2str(i)] , 'B3')
end
xlswrite(fullnameS ,{['Mean Queue Time Simulatoin Result of All Simulations' ,...
    '. This is a ', num2str(size(timely_taz_queue_time_mean ,1)),' * ', ...
    num2str(size(timely_taz_queue_time_mean ,2)),' Space(Row)-Time(Column) Matrix']}, ...
    ['Mean Result of All Simulations'] , 'A1')
% xlswrite(fullnameS ,'TAZID/Time', ['Mean Result of All Simulations'] , 'A2')
xlswrite(fullnameS ,time_stat_intv_origin, ['Mean Result of All Simulations'] , 'B2')
xlswrite(fullnameS ,all_taz, ['Mean Result of All Simulations'] , 'A3')
xlswrite(fullnameS ,timely_taz_queue_time_mean, ['Mean Result of All Simulations'] , 'B3')
clo = toc;
msgbox({[fname, ' saved successfully'];['Elapsed time(s): ',num2str(clo)]})


% --------------------------------------------------------------------
function comp_load_taz_queue_volumn_distr_Callback(hObject, eventdata, handles)
% hObject    handle to comp_load_taz_queue_volumn_distr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tic
if isfield(handles, 'NTAZ')
    NTAZ = handles.NTAZ;
else
    errordlg('Num. TAZ is neccessary', 'Comparison Data Error')
    return
end
[fname , pname]=uigetfile('*.xlsx' , 'Open the Comparison Queue Volumn Distribution XLSX');
if isequal(fname, 0)
    return
end
fullname = strcat(pname, fname);
try
    Comp = xlsread(fullname , 1);
catch
    Comp = [];
end
if isempty(Comp)
    try
        Comp = xlsread(fullname , 'Mean Result of All Simulations');
    catch
        errordlg(['Fail to open the file, no valid data in ', ...
            'either ''Sheet1'' or ''Mean Result of All Simulations''.'], 'Error')
        return
    end
end
comp_timely_taz_queue_population = Comp(2:end, 2:end);
start_time = Comp(1,2);
end_time = Comp(1,end);
step_size = (WDtimeConvert(end_time,1) - WDtimeConvert(start_time,1)) /...
    (size(comp_timely_taz_queue_population, 2) - 1);
if ~isequal(Comp(1, 2:end), WDtimeConvert(WDtimeConvert(start_time,1):...
        step_size:WDtimeConvert(end_time,1) ,3))
    errordlg('Invalid format: inequal time interval.','Error')
    return
else
    time_stat_intv_origin = Comp(1, 2:end);
    time_stat_intv_diff = WDtimeConvert(time_stat_intv_origin, 1);
end
comp_timely_taz_queue_population_result.data = comp_timely_taz_queue_population;
comp_timely_taz_queue_population_result.time_par = [start_time; step_size; end_time];
comp_timely_taz_queue_population_result.time_stat_intv_origin = time_stat_intv_origin;
comp_timely_taz_queue_population_result.time_stat_intv_diff = time_stat_intv_diff;
handles.comp_timely_taz_queue_population_result = comp_timely_taz_queue_population_result;
guidata(hObject , handles)
clo = toc;
msgbox(strvcat('Finished.', ['Elapse time(s): ', num2str(clo)]))


% --------------------------------------------------------------------
function comp_load_taz_queue_time_distr_Callback(hObject, eventdata, handles)
% hObject    handle to comp_load_taz_queue_time_distr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tic
if isfield(handles, 'NTAZ')
    NTAZ = handles.NTAZ;
else
    errordlg('Num. TAZ is neccessary', 'Comparison Data Error')
    return
end
[fname , pname]=uigetfile('*.xlsx' , 'Open the Comparison Queue Time Distribution XLSX');
if isequal(fname, 0)
    return
end
fullname = strcat(pname, fname);
try
    Comp = xlsread(fullname , 1);
catch
    Comp = [];
end
if isempty(Comp)
    try
        Comp = xlsread(fullname , 'Mean Result of All Simulations');
    catch
        errordlg(['Fail to open the file, no valid data in ', ...
            'either ''Sheet1'' or ''Mean Result of All Simulations''.'], 'Error')
        return
    end
end
comp_timely_taz_queue_time = Comp(2:end, 2:end);
start_time = Comp(1,2);
end_time = Comp(1,end);
step_size = (WDtimeConvert(end_time,1) - WDtimeConvert(start_time,1)) /...
    (size(comp_timely_taz_queue_time, 2) - 1);
if ~isequal(Comp(1, 2:end), WDtimeConvert(WDtimeConvert(start_time,1):...
        step_size:WDtimeConvert(end_time,1) ,3))
    errordlg('Invalid format: inequal time interval.','Error')
    return
else
    time_stat_intv_origin = Comp(1, 2:end);
    time_stat_intv_diff = WDtimeConvert(time_stat_intv_origin, 1);
end
comp_timely_taz_queue_time_result.data = comp_timely_taz_queue_time;
comp_timely_taz_queue_time_result.time_par = [start_time; step_size; end_time];
comp_timely_taz_queue_time_result.time_stat_intv_origin = time_stat_intv_origin;
comp_timely_taz_queue_time_result.time_stat_intv_diff = time_stat_intv_diff;
handles.comp_timely_taz_queue_time_result = comp_timely_taz_queue_time_result;
guidata(hObject , handles)
clo = toc;
msgbox(strvcat('Finished.', ['Elapse time(s): ', num2str(clo)]))


% --------------------------------------------------------------------
function dynamic_queue_volumn_sim_Callback(hObject, eventdata, handles)
% hObject    handle to dynamic_queue_volumn_sim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close_other_figurs()
if ~isfield(handles, 'NTAZ')
    errordlg('You must firstly set the Num. of TAZ', 'Error')
    return
end
if ~isfield(handles, 'NENT')
    errordlg('You must firstly set the Num. of Entrances', 'Error')
    return
end
if ~isfield(handles, 'timely_taz_queue_population_result')
    errordlg('There is NO queue volumn simulation result.', 'Error')
    return
else 
    timely_taz_queue_population_result = handles.timely_taz_queue_population_result;
    full_data_before = timely_taz_queue_population_result.mean;                                    %full data是指精确到每一分的完整时间统计数据
    if isfield(handles, 'dyn_rst_play_start_time')
        start_time = handles.dyn_rst_play_start_time;
    else
        start_time = 900;
    end
    if isfield(handles, 'dyn_rst_play_end_time')
        end_time = handles.dyn_rst_play_end_time;
    else
        end_time = 2300;
    end
    if isfield(handles, 'dyn_rst_play_step_size')
        step_size = handles.dyn_rst_play_step_size;
    else
        step_size = 30;
    end
    time_intv_stat_before = timely_taz_queue_population_result.time_stat_intv_origin;
    try
        [time_intv_4stat_column_index, full_data, time_intv_stat]  = ...
            set_dynamic_display_time_intv(time_intv_stat_before, full_data_before, ...
            start_time, end_time, step_size);
    catch
        return
    end
    Y = full_data(:, time_intv_4stat_column_index);            
    Y = Y(:);
end
if ~isfield(handles, 'XYZ')
    errordlg('No TAZ Data', 'TAZ Data');
    return
end
%关闭其它小fig
all_figs = findall(0, 'type', 'figure');
for af_i = 1 : length(all_figs)
    crt_fig_in_all_figs = all_figs(af_i);
    if ~isequal(get(crt_fig_in_all_figs, 'tag') , 'figure1')
        delete(crt_fig_in_all_figs)
    end
end
max_value = max(Y);
min_value = min(Y);
color_generate_userdata = struct();
color_generate_userdata.name = 'Sim timely queue volumn';
color_generate_userdata.Y = Y;
set_color = figure('Name' , 'Set Color Map' , 'NumberTitle' , 'off',...
    'Position', [500 400 800 300], 'Color', 'w', 'Unit', 'normalized',...
    'Menubar', 'none');
color_generate = uicontrol('parent', set_color, 'style', 'pushbutton',...
    'String', 'Generate Classes', 'unit', 'normalized', 'position',...
    [.47, .85, .16, .1], 'fontsize', 10, 'value', 2,...
    'callback', @color_generate_callback,...
    'userdata', color_generate_userdata);     %不得不设userdata，以知道画的什么图
color_class_method = uicontrol('parent', set_color, 'style', 'popupmenu',...
    'String', {'Equal Interval', 'Quantile'}, 'unit', 'normalized', 'position',...
    [.29, .85, .13, .1], 'backgroundcolor', 'w', 'fontsize', 10, 'value', 2,...
    'callback', @color_class_method_callback);
%输入set_color句柄和辅助用的最大最小值，自动布局
set_color_layout(set_color, min_value, max_value);
% 前面的都可以通用，但是OK键不一样，要根据画的图不同而设置不同的callback
set_color_all_ok = uicontrol('parent', set_color, 'style', 'pushbutton', ...
    'string', 'OK', 'fontsize', 10, 'unit', 'normalized', 'position',...
    [.8, .05, .15, .15], 'callback', @color_map_ok_sim_queue_volumn_time);
%初始化set color，一点开就有色带
class_num = 5;
color_ramp_name = '*RdYlGn';
value_cut = linspace(min_value, max_value, class_num+1);
set_color_initializatoin(set_color, class_num, color_ramp_name, value_cut);


% --------------------------------------------------------------------
function dynamic_queue_time_sim_Callback(hObject, eventdata, handles)
% hObject    handle to dynamic_queue_time_sim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close_other_figurs()
if ~isfield(handles, 'NTAZ')
    errordlg('You must firstly set the Num. of TAZ', 'Error')
    return
end
if ~isfield(handles, 'NENT')
    errordlg('You must firstly set the Num. of Entrances', 'Error')
    return
end
if ~isfield(handles, 'timely_taz_queue_time_result')
    errordlg('There is NO queue time simulation result.', 'Error')
    return
else 
    timely_taz_queue_time_result = handles.timely_taz_queue_time_result;
    full_data_before = timely_taz_queue_time_result.mean;                                    %full data是指精确到每一分的完整时间统计数据
    if isfield(handles, 'dyn_rst_play_start_time')
        start_time = handles.dyn_rst_play_start_time;
    else
        start_time = 900;
    end
    if isfield(handles, 'dyn_rst_play_end_time')
        end_time = handles.dyn_rst_play_end_time;
    else
        end_time = 2300;
    end
    if isfield(handles, 'dyn_rst_play_step_size')
        step_size = handles.dyn_rst_play_step_size;
    else
        step_size = 30;
    end
    time_intv_stat_before = timely_taz_queue_time_result.time_stat_intv_origin;
    try
        [time_intv_4stat_column_index, full_data, time_intv_stat]  = ...
            set_dynamic_display_time_intv(time_intv_stat_before, full_data_before, ...
            start_time, end_time, step_size);
    catch
        return
    end
    Y = full_data(:, time_intv_4stat_column_index);            
    Y = Y(:);
end
if ~isfield(handles, 'XYZ')
    errordlg('No TAZ Data', 'TAZ Data');
    return
end
%关闭其它小fig
all_figs = findall(0, 'type', 'figure');
for af_i = 1 : length(all_figs)
    crt_fig_in_all_figs = all_figs(af_i);
    if ~isequal(get(crt_fig_in_all_figs, 'tag') , 'figure1')
        delete(crt_fig_in_all_figs)
    end
end
max_value = max(Y);
min_value = min(Y);
color_generate_userdata = struct();
color_generate_userdata.name = 'Sim timely queue time';
color_generate_userdata.Y = Y;
set_color = figure('Name' , 'Set Color Map' , 'NumberTitle' , 'off',...
    'Position', [500 400 800 300], 'Color', 'w', 'Unit', 'normalized',...
    'Menubar', 'none');
color_generate = uicontrol('parent', set_color, 'style', 'pushbutton',...
    'String', 'Generate Classes', 'unit', 'normalized', 'position',...
    [.47, .85, .16, .1], 'fontsize', 10, 'value', 2,...
    'callback', @color_generate_callback,...
    'userdata', color_generate_userdata);     %不得不设userdata，以知道画的什么图
color_class_method = uicontrol('parent', set_color, 'style', 'popupmenu',...
    'String', {'Equal Interval', 'Quantile'}, 'unit', 'normalized', 'position',...
    [.29, .85, .13, .1], 'backgroundcolor', 'w', 'fontsize', 10, 'value', 2,...
    'callback', @color_class_method_callback);
%输入set_color句柄和辅助用的最大最小值，自动布局
set_color_layout(set_color, min_value, max_value);
% 前面的都可以通用，但是OK键不一样，要根据画的图不同而设置不同的callback
set_color_all_ok = uicontrol('parent', set_color, 'style', 'pushbutton', ...
    'string', 'OK', 'fontsize', 10, 'unit', 'normalized', 'position',...
    [.8, .05, .15, .15], 'callback', @color_map_ok_sim_queue_time_time);
%初始化set color，一点开就有色带
class_num = 5;
color_ramp_name = '*RdYlGn';
value_cut = linspace(min_value, max_value, class_num+1);
set_color_initializatoin(set_color, class_num, color_ramp_name, value_cut);


% --------------------------------------------------------------------
function dynamic_queue_volumn_comp_Callback(hObject, eventdata, handles)
% hObject    handle to dynamic_queue_volumn_comp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close_other_figurs()
if ~isfield(handles, 'NTAZ')
    errordlg('You must firstly set the Num. of TAZ', 'Error')
    return
end
if ~isfield(handles, 'NENT')
    errordlg('You must firstly set the Num. of Entrances', 'Error')
    return
end
if ~isfield(handles, 'comp_timely_taz_queue_population_result') 
    errordlg('There is NO queue volumn comparison result.', 'Error')
    return
else
    comp_timely_taz_queue_population_result = handles.comp_timely_taz_queue_population_result;
    full_data_before = comp_timely_taz_queue_population_result.data;                                    %full data是指精确到每一分的完整时间统计数据
    if isfield(handles, 'dyn_rst_play_start_time')
        start_time = handles.dyn_rst_play_start_time;
    else
        start_time = 900;
    end
    if isfield(handles, 'dyn_rst_play_end_time')
        end_time = handles.dyn_rst_play_end_time;
    else
        end_time = 2300;
    end
    if isfield(handles, 'dyn_rst_play_step_size')
        step_size = handles.dyn_rst_play_step_size;
    else
        step_size = 30;
    end
    time_intv_stat_before = comp_timely_taz_queue_population_result.time_stat_intv_origin;
    try
        [time_intv_4stat_column_index, full_data, time_intv_stat]  = ...
            set_dynamic_display_time_intv(time_intv_stat_before, full_data_before, ...
            start_time, end_time, step_size);
    catch
        return
    end
    Y = full_data(:, time_intv_4stat_column_index);            
    Y = Y(:);
end
if ~isfield(handles, 'XYZ')
    errordlg('No TAZ Data', 'TAZ Data');
    return
end
%关闭其它小fig
all_figs = findall(0, 'type', 'figure');
for af_i = 1 : length(all_figs)
    crt_fig_in_all_figs = all_figs(af_i);
    if ~isequal(get(crt_fig_in_all_figs, 'tag') , 'figure1')
        delete(crt_fig_in_all_figs)
    end
end
max_value = max(Y);
min_value = min(Y);
color_generate_userdata = struct();
color_generate_userdata.name = 'Comp timely queue volumn';
color_generate_userdata.Y = Y;
set_color = figure('Name' , 'Set Color Map' , 'NumberTitle' , 'off',...
    'Position', [500 400 800 300], 'Color', 'w', 'Unit', 'normalized',...
    'Menubar', 'none');
color_generate = uicontrol('parent', set_color, 'style', 'pushbutton',...
    'String', 'Generate Classes', 'unit', 'normalized', 'position',...
    [.47, .85, .16, .1], 'fontsize', 10, 'value', 2,...
    'callback', @color_generate_callback,...
    'userdata', color_generate_userdata);     %不得不设userdata，以知道画的什么图
color_class_method = uicontrol('parent', set_color, 'style', 'popupmenu',...
    'String', {'Equal Interval', 'Quantile'}, 'unit', 'normalized', 'position',...
    [.29, .85, .13, .1], 'backgroundcolor', 'w', 'fontsize', 10, 'value', 2,...
    'callback', @color_class_method_callback);
%输入set_color句柄和辅助用的最大最小值，自动布局
set_color_layout(set_color, min_value, max_value);
% 前面的都可以通用，但是OK键不一样，要根据画的图不同而设置不同的callback
set_color_all_ok = uicontrol('parent', set_color, 'style', 'pushbutton', ...
    'string', 'OK', 'fontsize', 10, 'unit', 'normalized', 'position',...
    [.8, .05, .15, .15], 'callback', @color_map_ok_comp_queue_volumn_time);
%初始化set color，一点开就有色带
class_num = 5;
color_ramp_name = '*RdYlGn';
value_cut = linspace(min_value, max_value, class_num+1);
set_color_initializatoin(set_color, class_num, color_ramp_name, value_cut);


% --------------------------------------------------------------------
function dynamic_queue_time_comp_Callback(hObject, eventdata, handles)
% hObject    handle to dynamic_queue_time_comp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close_other_figurs()
if ~isfield(handles, 'NTAZ')
    errordlg('You must firstly set the Num. of TAZ', 'Error')
    return
end
if ~isfield(handles, 'NENT')
    errordlg('You must firstly set the Num. of Entrances', 'Error')
    return
end
if ~isfield(handles, 'comp_timely_taz_queue_time_result') 
    errordlg('There is NO queue time comparison result.', 'Error')
    return
else
    comp_timely_taz_queue_time_result = handles.comp_timely_taz_queue_time_result;
    full_data_before = comp_timely_taz_queue_time_result.data;                                    %full data是指精确到每一分的完整时间统计数据
    if isfield(handles, 'dyn_rst_play_start_time')
        start_time = handles.dyn_rst_play_start_time;
    else
        start_time = 900;
    end
    if isfield(handles, 'dyn_rst_play_end_time')
        end_time = handles.dyn_rst_play_end_time;
    else
        end_time = 2300;
    end
    if isfield(handles, 'dyn_rst_play_step_size')
        step_size = handles.dyn_rst_play_step_size;
    else
        step_size = 30;
    end
    time_intv_stat_before = comp_timely_taz_queue_time_result.time_stat_intv_origin;
    try
        [time_intv_4stat_column_index, full_data, time_intv_stat]  = ...
            set_dynamic_display_time_intv(time_intv_stat_before, full_data_before, ...
            start_time, end_time, step_size);
    catch
        return
    end
    Y = full_data(:, time_intv_4stat_column_index);            
    Y = Y(:);
end
if ~isfield(handles, 'XYZ')
    errordlg('No TAZ Data', 'TAZ Data');
    return
end
%关闭其它小fig
all_figs = findall(0, 'type', 'figure');
for af_i = 1 : length(all_figs)
    crt_fig_in_all_figs = all_figs(af_i);
    if ~isequal(get(crt_fig_in_all_figs, 'tag') , 'figure1')
        delete(crt_fig_in_all_figs)
    end
end
max_value = max(Y);
min_value = min(Y);
color_generate_userdata = struct();
color_generate_userdata.name = 'Comp timely queue time';
color_generate_userdata.Y = Y;
set_color = figure('Name' , 'Set Color Map' , 'NumberTitle' , 'off',...
    'Position', [500 400 800 300], 'Color', 'w', 'Unit', 'normalized',...
    'Menubar', 'none');
color_generate = uicontrol('parent', set_color, 'style', 'pushbutton',...
    'String', 'Generate Classes', 'unit', 'normalized', 'position',...
    [.47, .85, .16, .1], 'fontsize', 10, 'value', 2,...
    'callback', @color_generate_callback,...
    'userdata', color_generate_userdata);     %不得不设userdata，以知道画的什么图
color_class_method = uicontrol('parent', set_color, 'style', 'popupmenu',...
    'String', {'Equal Interval', 'Quantile'}, 'unit', 'normalized', 'position',...
    [.29, .85, .13, .1], 'backgroundcolor', 'w', 'fontsize', 10, 'value', 2,...
    'callback', @color_class_method_callback);
%输入set_color句柄和辅助用的最大最小值，自动布局
set_color_layout(set_color, min_value, max_value);
% 前面的都可以通用，但是OK键不一样，要根据画的图不同而设置不同的callback
set_color_all_ok = uicontrol('parent', set_color, 'style', 'pushbutton', ...
    'string', 'OK', 'fontsize', 10, 'unit', 'normalized', 'position',...
    [.8, .05, .15, .15], 'callback', @color_map_ok_comp_queue_time_time);
%初始化set color，一点开就有色带
class_num = 5;
color_ramp_name = '*RdYlGn';
value_cut = linspace(min_value, max_value, class_num+1);
set_color_initializatoin(set_color, class_num, color_ramp_name, value_cut);


% --------------------------------------------------------------------
function show_queue_bar_Callback(hObject, eventdata, handles)
% hObject    handle to show_queue_bar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if strcmp(get(hObject,'Checked'),'on')
    set(hObject,'Checked','off');
    queue_bar.use = 0;
    queue_bar.reference_value = [];
    queue_bar.reference_length = [];
    queue_bar.width = [];
else 
    set(hObject,'Checked','on');
    queue_bar.use = 1;
end
if strcmp(get(hObject,'Checked'),'on')
    prompt = {'Set the reference value of queue volumn or time: ',...
        'Set the reference height for above reference value, this height will be scaled by Z factor',...
        'Set the bar width'};
    queue_bar_set = inputdlgWC(prompt, 'Queue Bar', 1, {'30' , '5', '10'});
    if isempty(queue_bar_set)
        set(hObject,'Checked','off');
        return
    end
    try
        reference_value = str2num(queue_bar_set{1});
        reference_length = str2num(queue_bar_set{2});
        width = str2num(queue_bar_set{3});
    catch
        set(hObject,'Checked','off');
        errordlg('Invalid input.', 'Error')
        return
    end
    if isempty(reference_value) | isnan(reference_value) | isempty(reference_length) | isnan(reference_length) |...
            isempty(width) | isnan(width)
        set(hObject,'Checked','off');
        errordlg('Invalid or incomplete input.', 'Error')
        return
    end
    if reference_value <=0 | reference_length <= 0 | width <= 0
        set(hObject,'Checked','off');
        errordlg('All inputs should be positive.', 'Error')
        return
    end
    queue_bar.reference_value = reference_value;
    queue_bar.reference_length = reference_length;
    queue_bar.width = width;
end
handles.queue_bar = queue_bar;
guidata(hObject, handles);


% --- Executes on button press in pushbutton24.
function pushbutton24_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit38_Callback(hObject, eventdata, handles)
% hObject    handle to edit38 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit38 as text
%        str2double(get(hObject,'String')) returns contents of edit38 as a double


% --- Executes during object creation, after setting all properties.
function edit38_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit38 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox3.
function listbox3_Callback(hObject, eventdata, handles)
% hObject    handle to listbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox3


% --- Executes during object creation, after setting all properties.
function listbox3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton25.
function pushbutton25_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
inputdlg('请输入购买联票的游客比例', '分人群比例', 1, {'0.5'}, 'on')


% --- Executes on button press in pushbutton26.
function pushbutton26_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if strcmp(get(hObject, 'string'), '等待输入')
    set(hObject, 'string', '输入完成');
elseif  strcmp(get(hObject, 'string'), '输入完成')
    set(hObject, 'string', '等待输入');
end


% --- Executes on button press in pushbutton27.
function pushbutton27_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if strcmp(get(hObject, 'string'), '等待输入')
    set(hObject, 'string', '输入完成');
elseif  strcmp(get(hObject, 'string'), '输入完成')
    set(hObject, 'string', '等待输入');
end


% --- Executes on button press in pushbutton28.
function pushbutton28_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if strcmp(get(hObject, 'string'), '等待输入')
    set(hObject, 'string', '输入完成');
elseif  strcmp(get(hObject, 'string'), '输入完成')
    set(hObject, 'string', '等待输入');
end

% --- Executes on button press in pushbutton29.
function pushbutton29_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton29 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if strcmp(get(hObject, 'string'), '等待输入')
    set(hObject, 'string', '输入完成');
elseif  strcmp(get(hObject, 'string'), '输入完成')
    set(hObject, 'string', '等待输入');
end


% --- Executes on button press in pushbutton30.
function pushbutton30_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton30 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if strcmp(get(hObject, 'string'), '等待输入')
    set(hObject, 'string', '输入完成');
elseif  strcmp(get(hObject, 'string'), '输入完成')
    set(hObject, 'string', '等待输入');
end


% --- Executes on button press in pushbutton31.
function pushbutton31_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if strcmp(get(hObject, 'string'), '等待输入')
    set(hObject, 'string', '输入完成');
elseif  strcmp(get(hObject, 'string'), '输入完成')
    set(hObject, 'string', '等待输入');
end


% --- Executes on button press in pushbutton32.
function pushbutton32_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if strcmp(get(hObject, 'string'), '等待输入')
    set(hObject, 'string', '输入完成');
elseif  strcmp(get(hObject, 'string'), '输入完成')
    set(hObject, 'string', '等待输入');
end



function e_d_Callback(hObject, eventdata, handles)
% hObject    handle to e_d (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of e_d as text
%        str2double(get(hObject,'String')) returns contents of e_d as a double


% --- Executes during object creation, after setting all properties.
function e_d_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e_d (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function e_e_Callback(hObject, eventdata, handles)
% hObject    handle to e_e (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of e_e as text
%        str2double(get(hObject,'String')) returns contents of e_e as a double


% --- Executes during object creation, after setting all properties.
function e_e_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e_e (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function e_g_Callback(hObject, eventdata, handles)
% hObject    handle to e_g (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of e_g as text
%        str2double(get(hObject,'String')) returns contents of e_g as a double


% --- Executes during object creation, after setting all properties.
function e_g_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e_g (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function e_i_Callback(hObject, eventdata, handles)
% hObject    handle to e_i (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of e_i as text
%        str2double(get(hObject,'String')) returns contents of e_i as a double


% --- Executes during object creation, after setting all properties.
function e_i_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e_i (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function e_f_Callback(hObject, eventdata, handles)
% hObject    handle to e_f (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of e_f as text
%        str2double(get(hObject,'String')) returns contents of e_f as a double


% --- Executes during object creation, after setting all properties.
function e_f_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e_f (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function e_h_Callback(hObject, eventdata, handles)
% hObject    handle to e_h (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of e_h as text
%        str2double(get(hObject,'String')) returns contents of e_h as a double


% --- Executes during object creation, after setting all properties.
function e_h_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e_h (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function e_j_Callback(hObject, eventdata, handles)
% hObject    handle to e_j (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of e_j as text
%        str2double(get(hObject,'String')) returns contents of e_j as a double


% --- Executes during object creation, after setting all properties.
function e_j_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e_j (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu11.
function popupmenu11_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject, 'value') == 2
    set(handles.e_a, 'string', '0.366')
    set(handles.e_b, 'string', '1.485')
    set(handles.e_c, 'string', '0.740')
    set(handles.e_d, 'string', '-0.0032')
    set(handles.e_e, 'string', '0.00033')
    set(handles.e_f, 'string', '0.0396')
    set(handles.e_g, 'string', '0.0244')
    set(handles.e_h, 'string', '0.480')
    set(handles.e_i, 'string', '-2.471')
    set(handles.e_j, 'string', '0.00033')
end

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu11 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu11


% --- Executes during object creation, after setting all properties.
function popupmenu11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu12.
function popupmenu12_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu12 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu12


% --- Executes during object creation, after setting all properties.
function popupmenu12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton34.
function pushbutton34_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton34 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
