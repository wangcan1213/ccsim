function varargout = ccsim(varargin)
% CCSIM MATLAB code for ccsim.fig
%      CCSIM, by itself, creates a new CCSIM or raises the existing
%      singleton*.
%
%      H = CCSIM returns the handle to a new CCSIM or the handle to
%      the existing singleton*.
%
%      CCSIM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CCSIM.M with the given input arguments.
%
%      CCSIM('Property','Value',...) creates a new CCSIM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ccsim_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ccsim_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ccsim

% Last Modified by GUIDE v2.5 29-Nov-2015 14:54:48

% Begin initialization code - DO NOT EDIT
clc
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ccsim_OpeningFcn, ...
                   'gui_OutputFcn',  @ccsim_OutputFcn, ...
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

% --- Executes just before ccsim is made visible.
function ccsim_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ccsim (see VARARGIN)

% Choose default command line output for ccsim
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% This sets up the initial plot - only do when we are invisible
% so window can get raised using ccsim.
if strcmp(get(hObject,'Visible'),'off')
    cla reset
    axis off
end
b_area = str2double(get(handles.edit_b_area , 'string'));
handles.b_area = b_area;
b_familarity = str2double(get(handles.edit_b_familarity , 'string'));
handles.b_familarity = b_familarity;
b_dist = str2double(get(handles.edit_b_dist , 'string'));
handles.b_dist = b_dist;
b_stdf = str2double(get(handles.edit_b_stdf , 'string'));
handles.b_stdf = b_stdf;
b_visited = str2double(get(handles.edit_b_visited , 'string'));
handles.b_visited = b_visited;
b_past = str2double(get(handles.edit_b_past , 'string'));
handles.b_past = b_past;
guidata(hObject , handles);

% UIWAIT makes ccsim wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ccsim_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

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


% --- Executes on button press in load_taz_info.
function load_taz_info_Callback(hObject, eventdata, handles)
% hObject    handle to load_taz_info (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global XYZ
[fname_taz_csv , pname_taz_csv]=uigetfile('*.csv' , 'Open the TAZ CSV');
fullname_taz_csv = strcat(pname_taz_csv,fname_taz_csv);
taz_csv = csvread(fullname_taz_csv);
ids = unique(taz_csv(: , 1));
NTAZ = length(ids);
handles.Num_TAZ.String = NTAZ;
handles.NTAZ = NTAZ;
guidata(hObject , handles);

XYZ = taz_csv;



% --- Executes on button press in load_ent_info.
function load_ent_info_Callback(hObject, eventdata, handles)
% hObject    handle to load_ent_info (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ENTXYZ
[fname_ent_csv , pname_ent_csv]=uigetfile('*.csv' , 'Open the Entrance/Exit CSV');
fullname_ent_csv = strcat(pname_ent_csv,fname_ent_csv);
ent_csv = csvread(fullname_ent_csv);
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
fullname_ind_csv = strcat(pname_ind_csv,fname_ind_csv);
ind_csv = csvread(fullname_ind_csv);
ids = unique(ind_csv(: , 1));
NPED = length(ids);
handles.Num_Ped.String = NPED;
handles.NPED = NPED;
guidata(hObject , handles);
if size(ind_csv) >= 2
    X_ind_ent = unique(ind_csv(:,1:2) , 'rows');
    handles.X_ind_ent = X_ind_ent;
    tab = tabulate(X_ind_ent(: , 2));
    X_ent_distrib_load_ind_derived = tab(: , [3]);
    X_ent_distrib_load_ind_derived = X_ent_distrib_load_ind_derived / 100;
    handles.X_ent_distrib_load_ind_derived = X_ent_distrib_load_ind_derived;
%     handles.X_ent_distrib_load_ind = X_ind_ent(: , 2);
    guidata(hObject , handles);
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



function edit_b_familarity_Callback(hObject, eventdata, handles)
% hObject    handle to edit_b_familarity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
b_familarity = str2double(get(hObject,'String'));
handles.b_familarity = b_familarity;
guidata(hObject , handles);

% Hints: get(hObject,'String') returns contents of edit_b_familarity as text
%        str2double(get(hObject,'String')) returns contents of edit_b_familarity as a double


% --- Executes during object creation, after setting all properties.
function edit_b_familarity_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_b_familarity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_b_dist_Callback(hObject, eventdata, handles)
% hObject    handle to edit_b_dist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
b_dist = str2double(get(hObject,'String'));
handles.b_dist = b_dist;
guidata(hObject , handles);

% Hints: get(hObject,'String') returns contents of edit_b_dist as text
%        str2double(get(hObject,'String')) returns contents of edit_b_dist as a double


% --- Executes during object creation, after setting all properties.
function edit_b_dist_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_b_dist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_b_area_Callback(hObject, eventdata, handles)
% hObject    handle to edit_b_area (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
b_area = str2double(get(hObject,'String'));
handles.b_area = b_area;
guidata(hObject , handles);

% Hints: get(hObject,'String') returns contents of edit_b_area as text
%        str2double(get(hObject,'String')) returns contents of edit_b_area as a double


% --- Executes during object creation, after setting all properties.
function edit_b_area_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_b_area (see GCBO)
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
% --- Firstly Check the Data.
tic;
hw = waitbar(0 , 'Prepare and Check Data. Please Wait.','Name', 'Simulation Process');
if isfield(handles, 'NTAZ')
    NTAZ = handles.NTAZ;
else
    errordlg('Num. of TAZ is neccessary')
    return
end
if isfield(handles, 'NPED')
    NPED = handles.NPED;
else
    errordlg('Num. of Consumers is neccessary')
    return
end
if isfield(handles, 'NENT')
    NENT = handles.NENT;
else
    errordlg('Num. of ENT is neccessary')
    return
end
if isfield(handles, 'b_area')
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
    return
end
if isfield(handles , 'X_dist')
    X_dist = handles.X_dist;
else
    errordlg('Horizontal distance matrix among TAZs is neccessary')
    return
end
if isfield(handles , 'X_dist_ent')
    X_dist_ent = handles.X_dist_ent;
else
    errordlg('Horizontal distance matrix between TAZs and entrances is neccessary')
    return
end
if isfield(handles , 'X_stdf')
    X_stdf = handles.X_stdf;
else
    errordlg('Vertical distance matrix(in stairs) among TAZs is neccessary')
    return
end
if isfield(handles, 'X_stdf_ent')
    X_stdf_ent = handles.X_stdf_ent;
else
    errordlg('Vertical distance matrix(in stairs) between TAZs and entrances is neccessary')
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
    X_familarity = zeros(NPED , NTAZ);
end

if isfield(handles , 'X_ent_distrib')
    X_ent_distrib = handles.X_ent_distrib;
    X_ent_distrib = X_ent_distrib(: , 2);
else
    errordlg('Sptial distributoin of consumers among entrances is neccessary')
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


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isfield(handles , 'PlotChoice')
    PlotChoice = 1;
else
    PlotChoice = handles.PlotChoice;
end
if ~isfield(handles , 'Z_factor')
    Z_factor = str2double(get(handles.edit_Z_factor, 'String'));
else
    Z_factor = handles.edit_Z_factor
end
cla reset
global XYZ
xyz = XYZ;              %不用全局变量，用局部变量 
switch PlotChoice 
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
        %图形控制
        set(gcf,'color','w')
        axis equal
        axis off
        view(3)
        alpha(0.5)
        view(-37,19)
    case 2                      %底图+空间分布（本次模拟）
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
        set(gcf,'color','w')
        axis equal
        axis off
        view(3)
        alpha(0.5)
        view(-37,19)
        
        %然后是数据
        h_TAZ_distrib_Sim  = WDplotTAZ_GUI( round(Sim_mean_taz_distrib), xyz, 2, 5 );
        
    case 3                      %底图+OD分布
        
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
        set(gcf,'color','w')
        axis equal
        axis off
        view(3)
        alpha(0.5)
        view(-37,19)
        
        %然后是数据
        if od_abs_mode == 0             %相对模式
            h_OD_Sim  = WDplotDesLine_GUI( Sim_mean_OD, xyz, od_t, 2 );
        elseif od_abs_mode == 1         %绝对模式
            od_abs_mode_max = handles.od_abs_mode_max;
            od_abs_mode_min = handles.od_abs_mode_min;
            h_OD_Sim  = WDplotDesLine_ABS_GUI( Sim_mean_OD, xyz, od_abs_mode_max , od_abs_mode_min, 2 );
        end
        
        
end
        


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in popupmenu8.
function popupmenu8_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
PlotChoice = get(hObject , 'Value');
handles.PlotChoice = PlotChoice;
guidata(hObject , handles)
if PlotChoice == 6
    helpdlg('Please choose a specific statistical plot item','Plot Item')
end
if ~isfield(handles , 'Compair_OD') & PlotChoice == 5
    errordlg('There is NO comparing OD matrix available', 'Compare Data Error')
end
if ~isfield(handles , 'Compair_TAZ') & (PlotChoice == 4 | PlotChoice == 11 | PlotChoice == 12)
    errordlg('There is NO comparing TAZ distribution data available' , 'Compare Data Error')
end
    
% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu8 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu8


% --- Executes during object creation, after setting all properties.
function popupmenu8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1


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
global XYZ
if ~isfield(handles , 'NTAZ')
     errordlg('Please firstly input Num of TAZs' , 'NTAZ Error')
     return
end
NTAZ = handles.NTAZ;
choice1 = questdlg('Do you want to input area data or just check area data?' , 'Area Data'...
    , 'Input Data' , 'Check Data' , 'Input Data');
if choice1 == 'Input Data'
    choice2 = questdlg('Please choose the way of inputting area data' , 'Area Data Input',...
        'Load CSV File'  ,'Directly Type or Copy / Paste' , 'Automatic Calculatoin', 'Load CSV File');
    switch choice2
        case 'Directly Type or Copy / Paste'
            str = ['Please enter space(/comma)-separated areas in the order: from TAZ_1 to TAZ_' , num2str(NTAZ)];
            same_pasted_value = inputdlg({str, 'OR please enter the same area for All TAZS'} , 'Area Data Input', [1 80 ; 1 45]);
            pasted_value = same_pasted_value{1};
            same_value = same_pasted_value{2};
            if length(pasted_value) ~= 0
                pasted_value = str2num(pasted_value);
                if length(pasted_value) == NTAZ
                    X_area = pasted_value';
                    handles.X_area = X_area;
                    guidata(hObject,handles);
                else
                    errordlg('Input Num of area data NOT equal Num of TAZ' , 'Area Input Error')
                end
            elseif length(same_value) ~= 0
                same_value = str2num(same_value);
                X_area = same_value * ones(NTAZ, 1);
                handles.X_area = X_area;
                guidata(hObject,handles);
            end
        case 'Load CSV File'
            [fname_area_csv , pname_area_csv] = uigetfile('*.csv' , 'Open the Area Data CSV');
%             if ischar(fname_area_csv) == 0 
                fullname_area_csv = strcat(pname_area_csv,fname_area_csv);
                area_csv = csvread(fullname_area_csv);
                [nrow_area , ncol_area] = size(area_csv);
                if nrow_area == NTAZ
                    if ncol_area == 1
                        handles.X_area = X_area;
                        guidata(hObject,handles);
                    elseif ncol_area == 2
                        area_csv = sortrows(area_csv , 1);
                        X_area = area_csv(: , 2);
                        handles.X_area = X_area;
                        guidata(hObject,handles);
                    end
                else
                    errordlg('Input Num of area data NOT equal Num of TAZ' , 'Area Input Error')
                end
%             end
        case 'Automatic Calculatoin'
            clear X_area
            if ~exist('XYZ' , 'var')
                errordlg('NO TAZ inputting' , 'Area Input Error')
            else
                xyz = XYZ;
                ids = unique(xyz(:,1));
                for kk = 1 : length(ids);
                    crt = xyz(xyz(:,1) == ids(kk) , 2:3);
                    crt_rst = polygeom(crt(:,1) , crt(:,2));
                    X_area(kk , 1) = crt_rst(1);
                end
                if length(X_area) == NTAZ;
                    handles.X_area = X_area;
                    guidata(hObject,handles);
                else
                    errordlg('Input Num of area data NOT equal Num of TAZ' , 'Area Input Error')
                end
            end
    end

elseif choice1 == 'Check Data'
    if ~isfield(handles , 'X_area')
        warndlg('There is NO valid area input' ,'Area Data Input')
    else
        X_area = handles.X_area;
        taz_area = [[1:NTAZ]' , X_area];
        show = strvcat('TAZ    AREA' , num2str(taz_area));
        msgbox(show)
    end
    
end
if isfield(handles , 'X_area')
%     X_area = handles.X_area;
%     fin_str = ['OK, Data Size: ' , num2str(length(X_area))];
    fin_str = 'Finished';
    handles.AreaInput.String = fin_str;
end
            
        
    


% --- Executes on button press in DistInput.
function DistInput_Callback(hObject, eventdata, handles)
% hObject    handle to DistInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global XYZ
global ENTXYZ
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
if choice1 == 'Input Data'
    choice2 = questdlg('Please choose the way of inputting horizontal distance data' , 'Horizontal Distance Data Input',...
        'Load CSV File' , 'Automatic Calculatoin', 'Load CSV File');
    switch choice2
        case 'Load CSV File'
            choice3 = questdlg('Which kind is your input matrix:' , 'Horizontal Distance Data Input',...
                'TAZ - TAZ Matrix' , 'TAZ - Entrance Matrix' ,...
                'TAZ/Entrance - TAZ/Entrance Matrix' , 'TAZ - TAZ Matrix');
            [fname_dist_csv , pname_dist_csv] = uigetfile('*.csv' , 'Open the area data CSV');
            fullname_dist_csv = strcat(pname_dist_csv,fname_dist_csv);
            dist_csv = csvread(fullname_dist_csv);
            [dist_nrow , dist_ncol] = size(dist_csv);
            switch choice3
                case 'TAZ - TAZ Matrix'
                    if dist_nrow == NTAZ & dist_ncol == NTAZ
                        X_dist = dist_csv;
                        handles.X_dist = X_dist;
                        guidata(hObject , handles);
                    else
                        errordlg(['Dimenshion of inputting matrix should be ', num2str(NTAZ),'*',num2str(NTAZ)] , 'Distance Input Error')
                    end
                case  'TAZ - Entrance Matrix'
                    if dist_nrow == NTAZ & dist_ncol == NENT
                        X_dist_ent = dist_csv;
                        handles.X_dist_ent = X_dist_ent;
                        guidata(hObject , handles);
                    else
                        errordlg(['Dimenshion of inputting matrix should be ', num2str(NTAZ),'*',num2str(NENT)] , 'Distance Input Error')
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
                    end
            end
                    
        case 'Automatic Calculatoin'
            if ~exist('XYZ' , 'var') 
                errordlg('NO TAZ inputting' , 'Area Input Error')
                return
            end
            if ~exist('ENTXYZ' , 'var')
                errordlg('NO TAZ inputting' , 'Area Input Error')
                return
            end
            xyz = XYZ;
            entxyz = ENTXYZ;
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
if choice1 == 'Input Data'
    choice2 = questdlg('Please choose the way of inputting horizontal distance data' , 'Vertical Distance Data',...
        'Load CSV File' , 'Load CSV File');
    switch choice2
        case 'Load CSV File'
            choice3 = questdlg('Which kind is your input matrix:' ,  'Vertical Distance Data',...
                'TAZ - TAZ Matrix' , 'TAZ - Entrance Matrix' ,...
                'TAZ/Entrance - TAZ/Entrance Matrix' , 'TAZ - TAZ Matrix');
            [fname_stdf_csv , pname_stdf_csv] = uigetfile('*.csv' , 'Open the area data CSV');
            fullname_stdf_csv = strcat(pname_stdf_csv,fname_stdf_csv);
            stdf_csv = csvread(fullname_stdf_csv);
            [stdf_nrow , stdf_ncol] = size(stdf_csv);
            switch choice3
                case 'TAZ - TAZ Matrix'
                    if stdf_nrow == NTAZ & stdf_ncol == NTAZ
                        X_stdf = stdf_csv;
                        handles.X_stdf = X_stdf;
                        guidata(hObject , handles);
                    else
                        errordlg(['Dimenshion of inputting matrix should be ', num2str(NTAZ),'*',num2str(NTAZ)] , 'Distance Input Error')
                    end
                case  'TAZ - Entrance Matrix'
                    if stdf_nrow == NTAZ & stdf_ncol == NENT
                        X_stdf_ent = stdf_csv;
                        handles.X_stdf_ent = X_stdf_ent;
                        guidata(hObject , handles);
                    else
                        errordlg(['Dimenshion of inputting matrix should be ', num2str(NTAZ),'*',num2str(NENT)] , 'Distance Input Error')
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
                    end
            end
                    
            
    end

elseif choice1 == 'Check Data'
    choice4 = questdlg('Which vertical distance matrix do you want to check?' ,  'Vertical Distance Data'...
        , 'TAZ - TAZ Matrix' , 'TAZ - Entrance Matrix' , 'TAZ - TAZ Matrix');
    switch choice4
        case 'TAZ - TAZ Matrix'
            if ~isfield(handles , 'X_dist')
                warndlg('There is NO valid TAZ - TAZ vertical distance input' , 'Vertical Distance Data')
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


% --- Executes on button press in FamInput.
function FamInput_Callback(hObject, eventdata, handles)
% hObject    handle to FamInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
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
            same_pasted_value = inputdlg({str, 'OR please enter the same familarity for All TAZS'} , 'Familarity Data Input', [1 80 ; 1 45]);
            pasted_value = same_pasted_value{1};
            same_value = same_pasted_value{2};
            if length(pasted_value) ~= 0
                pasted_value = str2num(pasted_value);
                if length(pasted_value) == NTAZ
                    X_familarity = pasted_value';
                    handles.X_familarity = X_familarity;
                    guidata(hObject,handles);
                else
                    errordlg('Input Num of familarity data NOT equal Num of TAZ' , 'Familarity Input Error')
                end
            elseif length(same_value) ~= 0
                same_value = str2num(same_value);
                X_familarity = same_value * ones(NTAZ, 1);
                handles.X_familarity = X_familarity;
                guidata(hObject,handles);
            end
        case 'Load CSV File'
            [fname_familarity_csv , pname_familarity_csv] = uigetfile('*.csv' , 'Open the Familarity Data CSV');
%             if ischar(fname_area_csv) == 0 
                fullname_familarity_csv = strcat(pname_familarity_csv,fname_familarity_csv);
                familarity_csv = csvread(fullname_familarity_csv);
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
                    end
                else
                    errordlg('Input Num of familarity data NOT equal Num of TAZ' , 'Familarity Input Error')
                end
%             end
        case 'Automatic Calculatoin from Individual-Level Data'
            clear X_familarity
            if ~isfield(handles, 'X_familarity')
                errordlg('NO prior familarity inputting' , 'Familarity Input Error')
            else
                X_familarity = handles.X_familarity;
                X_familarity = mean(X_familarity , 2);
                if length(X_familarity) == NTAZ;
                    handles.X_familarity = X_familarity;
                    guidata(hObject,handles);
                else
                    errordlg('Input Num of familarity data NOT equal Num of TAZ' , 'Area Input Error')
                end
            end
    end
elseif strcmp(choice1 , 'Input Individual-Level Data') ==1
    [fname_familarity_ind_csv , pname_familarity_ind_csv] = uigetfile('*.csv' , 'Open the Individual-Level Familarity Data CSV');
    fullname_familarity_ind_csv = strcat(pname_familarity_ind_csv,fname_familarity_ind_csv);
    familarity_ind_csv = csvread(fullname_familarity_ind_csv);
    [nrow_familarity_ind , ncol_familarity_ind] = size(familarity_ind_csv);
    if ncol_familarity_ind == 3 & mod(nrow_familarity_ind , NTAZ) == 0
        X_familarity_ind = familarity_ind_csv(: , 3);
        X_familarity_ind = reshape(X_familarity_ind , NTAZ , nrow_familarity_ind/NTAZ);
        handles.X_familarity_ind = X_familarity_ind;
        handles.X_familarity = X_familarity_ind;
        guidata(hObject,handles);
    elseif ncol_familarity_ind ~= 3
        errordlg('Individual-level data should have 3 columns' , 'Familarity Input Error')
    elseif mod(nrow_familarity_ind , NTAZ) ~= 0
        errordlg(['Num. of rows of individual-level data should be N * ' ,num2str(NTAZ)], 'Familarity Input Error')
    end

elseif strcmp(choice1 , 'Check Data')==1
    if ~isfield(handles , 'X_familarity')
        warndlg('There is NO valid familarity input' ,'Familarity Data Input')
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
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
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
set(handles.edit_b_area , 'String' , num2str(b_area));
set(handles.edit_b_dist , 'String' , num2str(b_dist));
set(handles.edit_b_stdf , 'String' , num2str(b_stdf));
set(handles.edit_b_familarity , 'String' , num2str(b_familarity));
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
set(handles.edit_b_area , 'String' , num2str(b_area));
set(handles.edit_b_dist , 'String' , num2str(b_dist));
set(handles.edit_b_stdf , 'String' , num2str(b_stdf));
set(handles.edit_b_visited , 'String' , num2str(b_visited));
set(handles.edit_b_past , 'String' , num2str(b_past));
b_familarity = 0;
handles.b_familarity = b_familarity;
set(handles.edit_b_familarity , 'String' , num2str(b_familarity));
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
    case 3
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
        pasted_value = inputdlg([str, '; OR please enter ONLY ONE abitrary number for EVEN distribution among ALL entrances'] , 'Area Data Input', [1 80 ]);
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
    case 4
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
[fname_save_xlsx , pname_save_xlsx] = uiputfile('*.xlsx' , 'Save the Configuration XLS');
fullnameS = strcat(pname_save_xlsx , fname_save_xlsx);
if exist(fullnameS,'file')
    delete(fullnameS)
end
global XYZ
global ENTXYZ
if exist('XYZ' , 'var')
    flag_TAZ = 1;
    xlswrite(fullnameS , XYZ , 'TAZ');
else
    flag_TAZ = 0;
end
if exist('ENTXYZ' , 'var')
    flag_ENT = 1;
    xlswrite(fullnameS , ENTXYZ, 'Entrance');
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
msgbox(message , 'Configuration File: Successfully Saved')

            


    




% --------------------------------------------------------------------
function open_confi_Callback(hObject, eventdata, handles)
% hObject    handle to open_confi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global XYZ
global ENTXYZ
[fname , pname] = uigetfile('*.xlsx' , 'Open the Configuration XLSX');
fullnameO = strcat(pname , fname);

general = xlsread(fullnameO , 1 , 'b1:b5');
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

flags = xlsread(fullnameO , 1 , 'b8:b16');
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
end
if flag_ENT == 1
    ENTXYZ = xlsread(fullnameO , 'Entrance');
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
set(handles.edit_b_area , 'String' , num2str(b_area));
b_dist = beta(2);
handles.b_dist = b_dist;
set(handles.edit_b_dist , 'String' , num2str(b_dist));
b_stdf = beta(3);
handles.b_stdf = b_stdf;
set(handles.edit_b_stdf , 'String' , num2str(b_stdf));
b_familarity = beta(4);
handles.b_familarity = b_familarity;
set(handles.edit_b_familarity , 'String' , num2str(b_familarity));
b_visited = beta(5);
handles.b_visited = b_visited;
set(handles.edit_b_visited , 'String' , num2str(b_visited));
b_past = beta(6);
handles.b_past = b_past;
set(handles.edit_b_past , 'String' , num2str(b_past));
guidata(hObject , handles);
msgbox(message , 'Configuration File: Successfully Open')




    


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

xlswrite(fullnameS , {'Sim. Index' , 'Average Num. of Activities', 'Gini' , 'Coefficient of Variaton'} , 'Result of Every Simulatoin' , 'A1')
xlswrite(fullnameS ,Sim_sta, 'Result of Every Simulatoin' , 'A2')

xlswrite(fullnameS , {'Simulated Average Num. of Activities per Consumer (Mean Level Across All Simulations):'} , 'Mean Result of All Simulations' , 'A1')
xlswrite(fullnameS , Sim_mean_actpp_mean , 'Mean Result of All Simulations' , 'A2')
xlswrite(fullnameS , {'Simulated Mean Spatial Distribution Gini Coefficient (Mean Level Across All Simulations):'} , 'Mean Result of All Simulations' , 'A5')
xlswrite(fullnameS , Sim_mean_gn , 'Mean Result of All Simulations' , 'A6')
xlswrite(fullnameS , {'Simulated Mean Coefficient of Variationn of Spatial Distribution (Mean Level Across All Simulations):'} , 'Mean Result of All Simulations' , 'A9')
xlswrite(fullnameS , Sim_mean_cv , 'Mean Result of All Simulations' , 'A10')
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
[fname_xlsx , pname_xlsx] = uiputfile('SimResult_TAZ_Distribution.xlsx' , 'Save the TAZ Distribution XLSX');
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
        view(-37,19)
    case 2
        view(2)
    case 3
        vp_xyz = inputdlg({'X Coordinate','Y Coordinate' , 'Z Coordinate'},...
            'Set X-Y-Z Coordinates of View Point');
        vpx = str2num(vp_xyz{1});
        vpy = str2num(vp_xyz{2});
        vpz = str2num(vp_xyz{3});
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
Z_factor = str2double(get(Object , 'String'));
handles.edit_Z_factor = Z_factor;
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
new_od_t = inputdlg(od_t_str , 'OD Plot Threshold');
new_od_t = str2double(new_od_t{:});
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
    od_abs_mode = inputdlg({'Please input a fixed maximum possible OD-value', 'Please input a fixed minimum OD-value'} , 'Change to Absolute Mode');
    od_abs_mode_max = str2num(od_abs_mode{1});
    od_abs_mode_min = str2num(od_abs_mode{2});
    od_abs_mode = 1;
    handles.od_abs_mode_max = od_abs_mode_max;
    handles.od_abs_mode_min = od_abs_mode_min;
else
    od_abs_mode = 0;
end
handles.od_abs_mode = od_abs_mode;
guidata(hObject , handles)

    
    
