function maaa()
clc
set_color = figure('Name' , 'Set Color Map' , 'NumberTitle' , 'off',...
    'Position', [500 400 800 300], 'Color', 'w', 'Unit', 'normalized',...
    'Menubar', 'none');
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
color_class_method = uicontrol('parent', set_color, 'style', 'popupmenu',...
    'String', {'Equal Interval', 'Quantile'}, 'unit', 'normalized', 'position',...
    [.29, .85, .13, .1], 'backgroundcolor', 'w', 'fontsize', 10, 'value', 2);
color_generate = uicontrol('parent', set_color, 'style', 'pushbutton',...
    'String', 'Generate Classes', 'unit', 'normalized', 'position',...
    [.47, .85, .16, .1], 'fontsize', 10, 'value', 2,...
    'callback', @color_generate_callback);
color_ramp_sel = uicontrol('parent', set_color, 'style', 'pushbutton',...
    'String', 'Color Ramp', 'unit', 'normalized', 'position',...
    [.66, .85, .16, .1], 'fontsize', 10, 'value', 2);
color_ramp_reverse = uicontrol('parent', set_color, 'style', 'pushbutton',...
    'String', 'Reverse', 'unit', 'normalized', 'position',...
    [.85, .85, .1, .1], 'fontsize', 10, 'value', 2,...
    'callback', @color_ramp_reverse_callback);
a = 1;

function color_class_num_callback(source,callbackdata)
set(source, 'userdata', source.Value)

function color_class_method_callback(source, callbackdata)
set(source, 'userdata', source.Value)

function color_generate_callback(hObject, eventdata)
main_fig = findall(0, 'type', 'figure', 'tag', 'figure1');
crt_fig = findall(0, 'type', 'figure', 'name', 'set_color');
color_class_num = findall(crt_fig, 'position',[.13, .85, .06, .1]);
color_class_method = findall(crt_fig, 'position', [.29, .85, .13, .1]);
class_num = get(color_class_num, 'userdata');
class_method = get(color_class_method, 'userdata');
color_ramp_name = 'BrBG';
handles = guidata(main_fig);
Sim_mean_taz_distrib = handles.Sim_mean_taz_distrib;
max_amount = max(Sim_mean_taz_distrib);
min_amount = min(Sim_mean_taz_distrib);
if class_method == 1
    value_cut = linspace(min_amount, max_amout, class_num+1);
elseif class_method == 2
    value_cut = quantile(Sim_mean_taz_distrib, linspace(0,1,class_num+1));
end
text_place_cut = linspace(.1, .9, class_num+1);
for k = 1 : class_num
    color_place_cut(k, :) = [text_place_cut(k), text_place_cut(k+1)-.75-text_place_cut(k)];
end
color_rgb = brewermap(class_num, color_ramp_name);
%生成色带显示
color_ramp_disp = cell(0);
for k = 1 : class_num
    color_ramp_disp{k} = uicontrol('parent', crt_fig, 'unit', 'normalized',...
        'style', 'pushbutton', 'position', [color_place_cut(k,1), .45, color_place_cut(k,2), .36],...
        'backgroundcolor', color_rgb(k,:), 'string', '', 'callback', @color_ramp_disp_callback,...
        'userdata', color_rgb(k,:));
end
%生成值文本框
for k = 1 : class_num+1
    value_cut_disp{k} = uicontrol('parent', crt_fig, 'unit', 'normalized',...
        'style', 'edit', 'postion', [text_place_cut(k), .15, text_place_cut(k+1)-text_place_cut(k), .29],...
        'backgroundcolor', 'w', 'string', num2str(value_cut(k)), ...
        'callback', @value_cut_disp_callback,...
        'userdata', value_cut(k));
end

function color_ramp_disp_callback(hObject, eventdata)
c = uisetcolor(get(hObject, 'userdata'));
set(hObject, 'userdata', c,...
    'backgroundcolor', c);

function value_cut_disp_callback(hObject, eventdata)
value_before = get(hObject, 'userdata');
value_new = get(hObject, 'value')
main_fig = findall(0, 'type', 'figure', 'tag', 'figure1');
handles = guidata(main_fig);
Sim_mean_taz_distrib = handles.Sim_mean_taz_distrib;
max_amount = max(Sim_mean_taz_distrib);
min_amount = min(Sim_mean_taz_distrib);
if isnan(value_new) | isempty(value_new) | ~isnumeric(value_new)
    errordlg('Value should be a number.', 'Error')
    set(hObject, 'value', value_before);
elseif value_new <min_amount | value_new > max_amount
    errordlg(['Out of range: value should be within ', num2str(min_amount),...
        '~', num2str(max_amount),'.'], 'Error')
    set(hObject, 'value', value_before);
else
    set(hObject, 'userdata', value_new);
end

% function color_ramp_reverse_callback(hObject, eventdata)



color_generate_callback