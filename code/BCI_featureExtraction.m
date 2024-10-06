function varargout = BCI_featureExtraction(varargin)
% BCI_FEATUREEXTRACTION M-file for BCI_featureExtraction.fig
%      BCI_FEATUREEXTRACTION, by itself, creates a new BCI_FEATUREEXTRACTION or raises the existing
%      singleton*.
%
%      H = BCI_FEATUREEXTRACTION returns the handle to a new BCI_FEATUREEXTRACTION or the handle to
%      the existing singleton*.
%
%      BCI_FEATUREEXTRACTION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BCI_FEATUREEXTRACTION.M with the given input arguments.
%
%      BCI_FEATUREEXTRACTION('Property','Value',...) creates a new BCI_FEATUREEXTRACTION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before BCI_featureExtraction_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to BCI_featureExtraction_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help BCI_featureExtraction

% Last Modified by GUIDE v2.5 25-Mar-2024 18:02:25

% Begin initialization code - DO NOT EDIT

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @BCI_featureExtraction_OpeningFcn, ...
    'gui_OutputFcn',  @BCI_featureExtraction_OutputFcn, ...
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


% --- Executes just before BCI_featureExtraction is made visible.
function BCI_featureExtraction_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to BCI_featureExtraction (see VARARGIN)
% Choose default command line output for BCI_featureExtraction
handles.output = hObject;

handles.toolboxPath = pwd;
addpath(genpath(handles.toolboxPath))

isTest = 0; 

% Data creating
Trial_start=4;
Trial_end=7;
handles.dataFolderName = 'data';
handles.GUIAnalysisPath = pwd;
dataPath = fullfile(handles.GUIAnalysisPath, handles.dataFolderName);
runs = dir(fullfile(dataPath, '*_r*'));
dataTot = cell(1, length(runs));
labelTot = cell(1, length(runs));
for i = 1: length(runs)
    load(fullfile(runs(i).folder, runs(i).name), 'Data', 'cue_type');%loading the subject data (BCIC data)
    disp(['load ',fullfile(runs(i).folder, runs(i).name),''])
    dataTot{i} = Data;
    labelTot{i} = cue_type;
end
Data_total = cat(3, dataTot{:});
Fs=256;
signal_123 = nan(size(Data_total, 1), Fs*Trial_end-Fs*Trial_start+1, size(Data_total, 3));
for i = 1 : size(Data_total,3) % trials
    signal_123(:,:,i) = Data_total(:, Fs*Trial_start:Fs*Trial_end, i); % Select ROI froom trials
end
signal_123_label = horzcat(labelTot{:});
save(fullfile(handles.dataFolderName, 'Data.mat'),'signal_123','signal_123_label','Fs')
%% for ERDS
handles.BioSigPath = uigetdir(pwd,'Select BioSig Directory');
addPathInMatlabPathIfNotAlready({handles.BioSigPath}, handles.toolboxPath)
t = [0, 0, 6.996]; % Start point, time resolution and end point within a trial
f_borders = [2, 40];
method = 'bp'; %{'bp', 'fft'}
ref = [0, 2]; % Reference interval (in s) <1x2>.
refmethod = 'classic'; %{'classic', 'absolute', 'trial'}
cue = 3; %Draws a vertical line at the location of the cue (in s) <1x1>
if isTest
f_steps = 5;% Frequency step sizes
else
 f_steps = 0.1; %Frequency step sizes
end
labels = unique(signal_123_label);
r = cell(length(labels), size(dataTot{1}, 1)); % time-frequency (ERDS) maps.
for i = 1 : length(labels) % classes
    s = []; % Input signal (as obtained by sload) <TxC>.
    for j = 1 : length(dataTot) % runs
        s = [s; reshape(dataTot{j}(:, :, labelTot{j} == labels(i)), size(dataTot{j}, 1), [], 1)'];
    end
    h = []; % Header structure (as obtained by sload) <1x1 struct>.
    h.SampleRate = Fs;
    h.TRIG = (1:size(dataTot{1}, 2):length(s))';
    h.Classlabel = labels(i)*ones(length(find(signal_123_label == labels(i))), 1);
    for j = 1 : size(s, 2) % channels
        r{i, j} = calcErdsMap(s(:,j), h, t, f_borders, 'cue', cue,'ref', ref, 'method', method, 'refmethod', refmethod, 'f_steps', f_steps);
    end
end
handles.dataErdsName = 'Data_total.mat';
save(fullfile(handles.dataFolderName, handles.dataErdsName),'r')
handles.erds.r = r;
%%
handles.plottedAxes = []; % list of plotted axes
handles.plottedSliders = []; % list of plotted sliders
handles.plottedTables = []; % list of plotted tables
handles.plottedTexts = []; % list of plotted texts
handles.plottedEdits = []; % list of plotted edits

pshBtn = [6, 24, 38, 40, 42:47]; % 28:
elementOnOff(handles, 'pushbutton', pshBtn, 'enable', false)
chkbx = 1:12;
elementOnOff(handles, 'checkbox', chkbx, 'enable', false)
editNb = [1, 2, 34, 47];
elementOnOff(handles, 'edit', editNb, 'enable', false)
handles.eeglabAddress = uigetdir(pwd,'Select EEGLab Directory');
handles.colormap = jet; %inferno;
handles.freqfac = 10;
handles.Selected_Features_Counter=1;
handles.signal_123 = signal_123;
handles.signal_123_label = signal_123_label;
handles.Fs = Fs;
if isTest
   handles.nTimes = 2;
handles.kFold = 3; 
handles.arOrderRange = 1:5; 
handles.mRange = 1:5; 
handles.alphaHalfRange = 0.2:0.3:1;
handles.betaHalfRange = 0.2:.3:1;
else
handles.nTimes = 10;
handles.kFold = 10;
handles.arOrderRange = 1:10; 
handles.mRange = 1:10; 
handles.alphaHalfRange = 0.2:0.3:5;
handles.betaHalfRange = 0.2:.3:10;
end
 
handles.featureDimension = 0;
set(handles.text53,'string',num2str(handles.featureDimension))
handles.classTitle = {'Left', 'Right', 'Feet'};
handles.freqfac = 10; %frequency resolution {default: 2}
handles.patchHandle = cell(length(labels),size(signal_123, 1)); % classNb*channelNb
% Update handles structure
guidata(hObject, handles);


function elementOnOff(handles, elementType, elementNb, property, isOn)
h = waitbar(0,'Please wait... ','Position',[384 -10 270 50]);
for i = 1 : length(elementNb)
    if isOn
        set(handles.(['',elementType,'',num2str(elementNb(i)),'']), property, 'on')
    else
        set(handles.(['',elementType,'',num2str(elementNb(i)),'']), property, 'off')
    end
    waitbar(i/length(elementNb))
end
close(h)


% --- Outputs from this function are returned to the command line.
function varargout = BCI_featureExtraction_OutputFcn(hObject, eventdata, handles)
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
handles = clear_axes(handles, 1, [], 1, 1, 1);
statist = nan(size(handles.signal_123,3), size(handles.signal_123,1));
for i=1:size(handles.signal_123,3)
    statist(i,:) = mean(abs(handles.signal_123(:,:,i))');
end
statist_log=abs(log(statist));
[accuracy_mean, accuracy_SD] = nTimesKFoldCrossValidation(handles.nTimes, handles.kFold, statist, handles.signal_123_label, true, true);
[accuracy_log_mean, accuracy_log_SD] = nTimesKFoldCrossValidation(handles.nTimes, handles.kFold, statist_log, handles.signal_123_label, true, true);
handles.statist_log=statist_log;
handles.statist=statist;
set(handles.text55,'string',[num2str(round(accuracy_mean, 2)) ' +- ' num2str(round(accuracy_SD, 2))])
set(handles.text56,'string',[num2str(round(accuracy_log_mean, 2)) ' +- ' num2str(round(accuracy_log_SD, 2))])
btnNb = [1, 2];
for i = 1 : length(btnNb)
    set(handles.(['checkbox',num2str(btnNb(i)),'']), 'enable', 'on')
end
guidata(hObject, handles);


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double

val = str2double(get(hObject,'String'));
if isNum(val) && val >= handles.erds.r{1,1}.t_plot(1) && val <= handles.erds.r{1,1}.t_plot(end)
handles.erds.timeFreqLim(1) = val;
handles = plot_roi_AllAxes(handles);

%%
r = handles.erds.r;
timeSeries = cell(size(r, 1), size(r, 2));
sptr = cell(size(r, 1), size(r, 2));
for i = 1 : size(r, 1) % classes
    for j = 1 : size(r, 2) % channels
        [t, timeSeries{i, j}, f, sptr{i, j}] = timeFreqMarginal(r{i, j}.ERDS{1}.erds', r{i, j}.t_plot, r{i, j}.f_plot, handles.erds.timeFreqLim(1:2), handles.erds.timeFreqLim(3:4));
    end
end
for i = 1 : size(timeSeries, 2)
handles.erds.timeSeries{i} = horzcat(timeSeries{:, i});
handles.erds.sptr{i} = horzcat(sptr{:, i});
end
handles.erds.t = t;
handles.erds.f = f;
handles = plot_timeFreqMarginal(handles, handles.erds.t, handles.erds.timeSeries, handles.erds.f, handles.erds.sptr, handles.classTitle);
end
guidata(hObject, handles);


function out = isNum(val) % check if the val is numeric
if and(~isempty(val), ~isnan(val))
    out = true;
else
    out =  false;
end
    
    
function handles = plot_roi_AllAxes(handles)
r = handles.erds.r;
axesH = [114:116; 117:119; 120:122];
for i = 1 : size(r, 1) % classes
    for j = 1 : size(r, 2) % channels
handles.patchHandle{i,j} = plot_roi(handles.patchHandle{i,j}, handles.(['axes',num2str(axesH(i,j)),'']), handles.erds.timeFreqLim(1:2),...
    r{i, j}.t_plot, handles.erds.timeFreqLim(3:4), r{i, j}.f_plot, r{i, j}.f_borders);
    end
end

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
val = str2double(get(hObject,'String'));
if isNum(val) && val >= handles.erds.r{1,1}.t_plot(1) && val <= handles.erds.r{1,1}.t_plot(end)
handles.erds.timeFreqLim(2) = val;
handles = plot_roi_AllAxes(handles);

r = handles.erds.r;
timeSeries = cell(size(r, 1), size(r, 2));
sptr = cell(size(r, 1), size(r, 2));
for i = 1 : size(r, 1) % classes
    for j = 1 : size(r, 2) % channels
        [t, timeSeries{i, j}, f, sptr{i, j}] = timeFreqMarginal(r{i, j}.ERDS{1}.erds', r{i, j}.t_plot, r{i, j}.f_plot, handles.erds.timeFreqLim(1:2), handles.erds.timeFreqLim(3:4));
    end
end
for i = 1 : size(timeSeries, 2)
handles.erds.timeSeries{i} = horzcat(timeSeries{:, i});
handles.erds.sptr{i} = horzcat(sptr{:, i});
end
handles.erds.t = t;
handles.erds.f = f;
handles = plot_timeFreqMarginal(handles, handles.erds.t, handles.erds.timeSeries, handles.erds.f, handles.erds.sptr, handles.classTitle);

end
guidata(hObject, handles);


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
editNb = [6,9, 11, 13:15];
elementType = 'pushbutton';
elementNb = 24;
checkEditsElementOnOff(hObject, handles, editNb, elementType, elementNb)

editNb = [];
elementType = 'checkbox';
elementNb = [5, 6];
checkEditsElementOnOff(hObject, handles, editNb, elementType, elementNb)


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
editNb = [4,9, 11, 13:15];
elementType = 'pushbutton';
elementNb = 24;
checkEditsElementOnOff(hObject, handles, editNb, elementType, elementNb)

editNb = [];
elementType = 'checkbox';
elementNb = [3, 4];
checkEditsElementOnOff(hObject, handles, editNb, elementType, elementNb)

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


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = clear_axes(handles, 1, [], 1, 1, 1);
signal_123 = handles.signal_123;
signal_123_label = handles.signal_123_label;
Fs = handles.Fs;
%%

mRange = handles.mRange;
for m = mRange
    max_fft_amp = nan(size(signal_123,3), m * size(signal_123,1));
    for ii=1:size(signal_123,3)
        max_fft_amp(ii,:) = fft_amp_sorted(signal_123(:,:,ii)', m);
    end
    max_fft_amp_log=(log(max_fft_amp));
    [accuracy_mean, accuracy_SD] = nTimesKFoldCrossValidation(handles.nTimes, handles.kFold, max_fft_amp, signal_123_label, true, true);
    [accuracy_log_mean, accuracy_log_SD] = nTimesKFoldCrossValidation(handles.nTimes, handles.kFold, max_fft_amp_log, signal_123_label, true, true);
    ACCURACY_fft_amp(:,m)=[accuracy_mean;accuracy_SD;accuracy_log_mean;accuracy_log_SD];
end
handles.plottedAxes = [handles.plottedAxes, 1];
axis(handles.axes1, 'on')
errorbar(handles.axes1, ACCURACY_fft_amp(3,:),ACCURACY_fft_amp(4,:),'r')
hold(handles.axes1, 'on')
errorbar(handles.axes1, ACCURACY_fft_amp(1,:),ACCURACY_fft_amp(2,:))
ylabel(handles.axes1, 'Accuracy(%)')
xlabel(handles.axes1, '# of components')
title(handles.axes1, 'Amplitude Component')
grid(handles.axes1, 'on')
set(handles.axes1, 'xtick', mRange)
legend(handles.axes1, {'Log(Feature)', 'Feature'})
for m = mRange
    max_fft_comp = nan(size(signal_123,3), m * size(signal_123,1));
    for ii=1:size(signal_123,3)
        max_fft_comp(ii,:) = fft_freq_sorted(Fs, signal_123(:,:,ii)', m);
    end
    max_fft_comp_log=(log(max_fft_comp));
    [accuracy_mean, accuracy_SD] = nTimesKFoldCrossValidation(handles.nTimes, handles.kFold, max_fft_comp, signal_123_label, true, true);
    [accuracy_log_mean, accuracy_log_SD] = nTimesKFoldCrossValidation(handles.nTimes, handles.kFold, max_fft_comp_log, signal_123_label, true, true);
    ACCURACY_fft_comp(:,m)=[accuracy_mean;accuracy_SD;accuracy_log_mean;accuracy_log_SD];
end
handles.plottedAxes = [handles.plottedAxes, 2];
axis(handles.axes2, 'on')
errorbar(handles.axes2, ACCURACY_fft_comp(3,:),ACCURACY_fft_comp(4,:),'r')
hold(handles.axes2, 'on')
errorbar(handles.axes2, ACCURACY_fft_comp(1,:),ACCURACY_fft_comp(2,:))
ylabel(handles.axes2, 'Accuracy(%)')
xlabel(handles.axes2, '# of components')
title(handles.axes2, 'Frequency Component')
grid(handles.axes2, 'on')
set(handles.axes2, 'xtick', mRange)
legend(handles.axes1, {'Log(Feature)', 'Feature'})
guidata(hObject, handles);


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
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


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



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
editNb = [4,6, 11, 13:15];
elementType = 'pushbutton';
elementNb = 24;
checkEditsElementOnOff(hObject, handles, editNb, elementType, elementNb)

editNb = [];
elementType = 'checkbox';
elementNb = [7, 8];
checkEditsElementOnOff(hObject, handles, editNb, elementType, elementNb)


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


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = clear_axes(handles, 1, [], 1, 1, 1);
signal_123 = handles.signal_123;
signal_123_label = handles.signal_123_label;
h = waitbar(0,'Please wait ...');
arOrderRange = handles.arOrderRange;
ACCURACY_AR = nan(4, length(arOrderRange));
for AR_order = arOrderRange
    AR_Coeff = nan(size(signal_123,3), AR_order * size(signal_123,1));
    for ii=1:size(signal_123,3)
        AR_Coeff(ii,:) = ar_order(signal_123(:,:,ii)', AR_order);
    end
    AR_Coeff_log = abs(log(AR_Coeff));
    [accuracy_mean, accuracy_SD] = nTimesKFoldCrossValidation(handles.nTimes, handles.kFold, AR_Coeff, signal_123_label, true, true);
    [accuracy_log_mean, accuracy_log_SD] = nTimesKFoldCrossValidation(handles.nTimes, handles.kFold, AR_Coeff_log, signal_123_label, true, true);
    ACCURACY_AR(:,AR_order)=[accuracy_mean;accuracy_SD;accuracy_log_mean;accuracy_log_SD];
    waitbar(AR_order / length(arOrderRange))
end
close(h)
handles.plottedAxes = [handles.plottedAxes, 3];
axis(handles.axes3, 'on')
errorbar(handles.axes3, ACCURACY_AR(3,:),ACCURACY_AR(4,:),'r')
hold(handles.axes3, 'on')
errorbar(handles.axes3, ACCURACY_AR(1,:),ACCURACY_AR(2,:))
legend(handles.axes3, 'Log AR Coefficients','AR Coefficients')
ylabel(handles.axes3, 'Accuracy(%)')
xlabel(handles.axes3, 'AR Order')
title(handles.axes3, 'Accuracy for different AR orders')
grid(handles.axes3, 'on')
set(handles.axes3, 'xtick', arOrderRange)
guidata(hObject, handles);


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
editNb = [4,6,9, 13:15];
elementType = 'pushbutton';
elementNb = 24;
checkEditsElementOnOff(hObject, handles, editNb, elementType, elementNb)

editNb = 15;
elementType = 'checkbox';
elementNb = [11, 12];
checkEditsElementOnOff(hObject, handles, editNb, elementType, elementNb)


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



function edit13_Callback(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit13 as text
%        str2double(get(hObject,'String')) returns contents of edit13 as a double
editNb = [4,6,9, 11, 14,15];
elementType = 'pushbutton';
elementNb = 24;
checkEditsElementOnOff(hObject, handles, editNb, elementType, elementNb)

editNb = 14;
elementType = 'checkbox';
elementNb = [9, 10];
checkEditsElementOnOff(hObject, handles, editNb, elementType, elementNb)


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


% function handles = remove_sliders(handles, slides_remove)
% if strcmp(get(handles.(['slider',num2str(slides_remove(1)),'']), 'visible'), 'on')
%     for i = 1 : length(slides_remove)
%         set(handles.(['slider',num2str(slides_remove(i)),'']), 'visible', 'off')
%     end
% end

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = clear_axes(handles, 1, [], 1, 1, 1);
h = waitbar(0,'Please wait ... ');

% Alpha
editNb = 14;
axNb = 1;
BP_featureExtraction_classification_visualisation(handles.Fs, ...
    handles.signal_123, handles.signal_123_label,handles.(['edit',num2str(editNb),'']), ...
    handles.(['axes',num2str(axNb),'']), handles.alphaHalfRange, handles.nTimes, handles.kFold);
handles.plottedAxes = [handles.plottedAxes, axNb];
waitbar(1/2)
% Beta
editNb = 15;
axNb = 2;
BP_featureExtraction_classification_visualisation(handles.Fs, ...
    handles.signal_123, handles.signal_123_label,handles.(['edit',num2str(editNb),'']), ...
    handles.(['axes',num2str(axNb),'']), handles.betaHalfRange, handles.nTimes, handles.kFold);
handles.plottedAxes = [handles.plottedAxes, axNb];
waitbar(2/2)
close(h)
% Update handles structure
guidata(hObject, handles);


function [BP, BP_log] = BP_featureExtraction(fs, signal_123, editCenterHandle, halfRange)
% BP: #trial * #channel * #halfRange
bandCenter = str2double(get(editCenterHandle, 'string'));
if isempty(bandCenter) || isnan(bandCenter)
    warndlg('Enter numeric value for the band center!', 'Warning');
    return
end

BP = nan(size(signal_123,3), size(signal_123,1), length(halfRange));
for i = 1:size(BP, 1) % trials
    for j = 1:size(BP, 3) % band range
        BP(i,:,j) = band_power(fs, signal_123(:,:,i)', [bandCenter-halfRange(j), bandCenter+halfRange(j)]);
    end
end
BP_log = log(BP);


function [accuracy_mean, accuracy_SD, accuracy_log_mean, accuracy_log_SD] = ...
    BP_featureExtraction_classification(fs, signal_123, signal_123_label, editCenterHandle, halfRange, nTimes, kFold)

[BP, BP_log] = BP_featureExtraction(fs, signal_123, editCenterHandle, halfRange);

% -------------------------------------------------------------------------
% Classification
% LDA with 10*10 fold Cross Validation
accuracy_mean = nan(1, length(halfRange));
accuracy_SD = nan(1, length(halfRange));
accuracy_log_mean = nan(1, length(halfRange));
accuracy_log_SD = nan(1, length(halfRange));
for k= 1:length(halfRange)
    [accuracy_mean(k), accuracy_SD(k)] = nTimesKFoldCrossValidation(nTimes, kFold, BP(:,:,k), signal_123_label, true, true);
    [accuracy_log_mean(k), accuracy_log_SD(k)] = nTimesKFoldCrossValidation(nTimes, kFold, BP_log(:,:,k), signal_123_label, true, true);
end


function BP_featureExtraction_classification_visualisation(fs, signal_123, ...
    signal_123_label, editCenterHandle, axHandle, halfRange, nTimes, kFold)

[accuracy_mean, accuracy_SD, accuracy_log_mean, accuracy_log_SD] = ...
    BP_featureExtraction_classification(fs, signal_123, ...
    signal_123_label, editCenterHandle, halfRange, nTimes, kFold);
axis(axHandle, 'on')
errorbar(axHandle, halfRange, accuracy_log_mean, accuracy_log_SD,'r')
hold(axHandle, 'on')
errorbar(axHandle, halfRange, accuracy_mean, accuracy_SD)
legend(axHandle, 'Logarithmic BP', 'BP','Location','SouthEast')
ylabel(axHandle, 'Accuracy(%) ')
bandCenter = str2double(get(editCenterHandle, 'string'));
xlabel(axHandle, ['half of frequency band range of filter (',num2str(bandCenter),' \pm x)'])
grid(axHandle, 'on')
set(axHandle, 'xtick', halfRange)

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


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
restoredefaultpath
addpath(genpath(handles.eeglabAddress))
addpath(genpath(fullfile(handles.eeglabAddress, 'functions','sigprocfunc')))
handles = clear_axes(handles, 1, [], 1, 1, 1);
% load Data
load(fullfile(handles.dataFolderName, 'Data.mat'))
h = waitbar(0,'Please wait... (1/2)');
for i=1:size(signal_123,3)
    A=signal_123(:,:,i);
    [Pxx_1(:,i),w]=pwelch(A(1,:),256,0,512,Fs);
    [Pxx_2(:,i),w]=pwelch(A(2,:),256,0,512,Fs);
    [Pxx_3(:,i),w]=pwelch(A(3,:),256,0,512,Fs);
    waitbar(i/size(signal_123,3))
end
close(h)
axes(handles.axes4)
handles.plottedAxes = [handles.plottedAxes, 4];
axis on
plot(w,mean(Pxx_1,2))
hold on
plot(w,mean(Pxx_2,2),'g')
plot(w,mean(Pxx_3,2),'r')
plot(w,mean([mean(Pxx_1,2) mean(Pxx_2,2) mean(Pxx_3,2)],2),'k')
ylabel('\muv^2/Hz')
legend('C4','C3','Cz','mean(C4,C3,Cz)')
title('PSD of all Classes')
% PSD using Welch's method for each class
signal_1_label=find(signal_123_label==1);
signal_2_label=find(signal_123_label==2);
signal_3_label=find(signal_123_label==3);
h = waitbar(0,'Please wait... (2/2)');
for i=1:length(signal_1_label)
    A1=signal_123(:,:,signal_1_label(i));
    A2=signal_123(:,:,signal_2_label(i));
    A3=signal_123(:,:,signal_3_label(i));
    [Pxx_1_ch1(:,i),w]=pwelch(A1(1,:),256,0,512,Fs);
    [Pxx_2_ch1(:,i),w]=pwelch(A2(1,:),256,0,512,Fs);
    [Pxx_3_ch1(:,i),w]=pwelch(A3(1,:),256,0,512,Fs);
    [Pxx_1_ch2(:,i),w]=pwelch(A1(2,:),256,0,512,Fs);
    [Pxx_2_ch2(:,i),w]=pwelch(A2(2,:),256,0,512,Fs);
    [Pxx_3_ch2(:,i),w]=pwelch(A3(2,:),256,0,512,Fs);
    [Pxx_1_ch3(:,i),w]=pwelch(A1(3,:),256,0,512,Fs);
    [Pxx_2_ch3(:,i),w]=pwelch(A2(3,:),256,0,512,Fs);
    [Pxx_3_ch3(:,i),w]=pwelch(A3(3,:),256,0,512,Fs);
    waitbar(i/length(signal_1_label))
end
close(h)
axes(handles.axes5)
handles.plottedAxes = [handles.plottedAxes, 5];
axis on
plot(w,mean(Pxx_1_ch1,2))
hold on
plot(w,mean(Pxx_2_ch1,2),'g')
plot(w,mean(Pxx_3_ch1,2),'r')
ylabel('\muv^2/Hz')
legend('Left Hand MI','Right Hand MI','Feet MI')
title('PSD of C4')
axes(handles.axes6)
handles.plottedAxes = [handles.plottedAxes, 6];
axis on
plot(w,mean(Pxx_1_ch2,2))
hold on
plot(w,mean(Pxx_2_ch2,2),'g')
plot(w,mean(Pxx_3_ch2,2),'r')
ylabel('\muv^2/Hz')
legend('Left Hand MI','Right Hand MI','Feet MI')
title('PSD of C3')
xlabel('Frequency (Hz)')
axes(handles.axes7)
handles.plottedAxes = [handles.plottedAxes, 7];
axis on
plot(w,mean(Pxx_1_ch3,2))
hold on
plot(w,mean(Pxx_2_ch3,2),'g')
plot(w,mean(Pxx_3_ch3,2),'r')
ylabel('\muv^2/Hz')
legend('Left Hand MI','Right Hand MI','Feet MI')
title('PSD of Cz')
xlabel('Frequency (Hz)')
guidata(hObject, handles);


function edit14_Callback(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit14 as text
%        str2double(get(hObject,'String')) returns contents of edit14 as a double
editNb = 15;
elementType = 'pushbutton';
elementNb = 6;
checkEditsElementOnOff(hObject, handles, editNb, elementType, elementNb)
editNb = [4,6,9, 11, 13, 15];
elementType = 'pushbutton';
elementNb = 24;
checkEditsElementOnOff(hObject, handles, editNb, elementType, elementNb)
editNb = 13;
elementType = 'checkbox';
elementNb = [9, 10];
checkEditsElementOnOff(hObject, handles, editNb, elementType, elementNb)


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
editNb = 14;
elementType = 'pushbutton';
elementNb = 6;
checkEditsElementOnOff(hObject, handles, editNb, elementType, elementNb)
editNb = [4,6,9, 11, 13:14];
elementType = 'pushbutton';
elementNb = 24;
checkEditsElementOnOff(hObject, handles, editNb, elementType, elementNb)
editNb = 11;
elementType = 'checkbox';
elementNb = [11, 12];
checkEditsElementOnOff(hObject, handles, editNb, elementType, elementNb)


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


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = clear_axes(handles, 1, [], 1, 1, 1);
% load Data
load(fullfile(handles.dataFolderName, 'Data.mat'))
L=size(signal_123,2);
NFFT = 2^nextpow2(L); % Next power of 2 from length of y
h = waitbar(0,'Please wait... (1/2)');
for i=1:size(signal_123,3)
    A=signal_123(:,:,i);
    Y_1(i,:) = fft(A(1,:),NFFT)/L;
    Y_2(i,:) = fft(A(2,:),NFFT)/L;
    Y_3(i,:) = fft(A(3,:),NFFT)/L;
    waitbar(i/size(signal_123,3))
end
close(h)
f = Fs/2*linspace(0,1,NFFT/2+1);
% Plot single-sided amplitude spectrum.
axes(handles.axes4)
handles.plottedAxes = [handles.plottedAxes, 4];
axis on
plot(f,2*abs(mean(Y_1(:,1:NFFT/2+1))))
hold on
plot(f,2*abs(mean(Y_2(:,1:NFFT/2+1))),'g')
plot(f,2*abs(mean(Y_3(:,1:NFFT/2+1))),'r')
plot(f,mean([2*abs(mean(Y_1(:,1:NFFT/2+1))); 2*abs(mean(Y_2(:,1:NFFT/2+1))); 2*abs(mean(Y_3(:,1:NFFT/2+1)))]),'k')
title('Single-Sided Amplitude Spectrum of all Classes')
ylabel('|Y(f)|')
legend('C4','C3','Cz','mean(C4,C3,Cz)')
% PSD using Welch's method for each class
signal_1_label=find(signal_123_label==1);
signal_2_label=find(signal_123_label==2);
signal_3_label=find(signal_123_label==3);
h = waitbar(0,'Please wait... (2/2)');
for i=1:length(signal_1_label)
    A1=signal_123(:,:,signal_1_label(i));
    A2=signal_123(:,:,signal_2_label(i));
    A3=signal_123(:,:,signal_3_label(i));
    Y_1_ch1(i,:) = fft(A1(1,:),NFFT)/L;
    Y_1_ch2(i,:) = fft(A1(2,:),NFFT)/L;
    Y_1_ch3(i,:) = fft(A1(3,:),NFFT)/L;
    Y_2_ch1(i,:) = fft(A2(1,:),NFFT)/L;
    Y_2_ch2(i,:) = fft(A2(2,:),NFFT)/L;
    Y_2_ch3(i,:) = fft(A2(3,:),NFFT)/L;
    Y_3_ch1(i,:) = fft(A3(1,:),NFFT)/L;
    Y_3_ch2(i,:) = fft(A3(2,:),NFFT)/L;
    Y_3_ch3(i,:) = fft(A3(3,:),NFFT)/L;
    waitbar(i/length(signal_1_label))
end
close(h)
axes(handles.axes5)
handles.plottedAxes = [handles.plottedAxes, 5];
axis on
plot(f,2*abs(mean(Y_1_ch1(:,1:NFFT/2+1))))
hold on
plot(f,2*abs(mean(Y_2_ch1(:,1:NFFT/2+1))),'g')
plot(f,2*abs(mean(Y_3_ch1(:,1:NFFT/2+1))),'r')
ylabel('|Y(f)|')
legend('Left Hand MI','Right Hand MI','Feet MI')
title('Single-Sided Amplitude Spectrum of C4')
axes(handles.axes6)
handles.plottedAxes = [handles.plottedAxes, 6];
axis on
plot(f,2*abs(mean(Y_1_ch2(:,1:NFFT/2+1))))
hold on
plot(f,2*abs(mean(Y_2_ch2(:,1:NFFT/2+1))),'g')
plot(f,2*abs(mean(Y_3_ch2(:,1:NFFT/2+1))),'r')
xlabel('Frequency (Hz)')
ylabel('|Y(f)|')
legend('Left Hand MI','Right Hand MI','Feet MI')
title('Single-Sided Amplitude Spectrum of C3')
axes(handles.axes7)
handles.plottedAxes = [handles.plottedAxes, 7];
axis on
plot(f,2*abs(mean(Y_1_ch3(:,1:NFFT/2+1))))
hold on
plot(f,2*abs(mean(Y_2_ch3(:,1:NFFT/2+1))),'g')
plot(f,2*abs(mean(Y_3_ch3(:,1:NFFT/2+1))),'r')
xlabel('Frequency (Hz)')
ylabel('|Y(f)|')
legend('Left Hand MI','Right Hand MI','Feet MI')
title('Single-Sided Amplitude Spectrum of Cz')
guidata(hObject, handles);

% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% datacursormode on
datacursormode toggle

% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h = zoom(gcf);
if strcmp(h.Enable, 'on')
    h.Enable = 'off';
else
    h.Enable = 'on';
end

% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h = pan(gcf);
if strcmp(h.Enable, 'on')
    h.Enable = 'off';
else
    h.Enable = 'on';
end

% --- Executes on button press in pushbutton24.
function pushbutton24_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = clear_axes(handles, 1, [], 1, 1, 1);
% Statistical features
statist_log=handles.statist_log;
statist=handles.statist;
signal_123 = handles.signal_123;
signal_123_label = handles.signal_123_label;
Fs = handles.Fs;
nTimes = handles.nTimes;
kFold = handles.kFold;
    Amp_comp = str2double(get(handles.edit6,'string'));
    max_fft_amp = nan(size(signal_123,3), Amp_comp * size(signal_123,1));
    for ii=1:size(signal_123,3)
        max_fft_amp(ii,:) = fft_amp_sorted(signal_123(:,:,ii)', Amp_comp);
end
max_fft_amp_log=log(max_fft_amp);
    Freq_comp = str2double(get(handles.edit4,'string'));
        max_fft_comp = nan(size(signal_123,3), Freq_comp * size(signal_123,1));
for ii=1:size(signal_123,3)
            max_fft_comp(ii,:) = fft_freq_sorted(Fs, signal_123(:,:,ii)', Freq_comp);
end
max_fft_comp_log=(log(max_fft_comp));

% AR features
    AR_order = str2double(get(handles.edit9, 'string'));
for ii=1:size(signal_123,3)
        AR_Coeff(ii,:) = ar_order(signal_123(:,:,ii)', AR_order);
end
AR_Coeff_log=abs(log(AR_Coeff));

% Alpha BP features
    editNb = 14; % center
    halfRange = str2double(get(handles.edit13, 'string'));
    [BP_alpha, BP_alpha_log] = BP_featureExtraction(handles.Fs, handles.signal_123, handles.(['edit',num2str(editNb),'']), halfRange);

% beta BP features
    editNb = 15; % center
    halfRange = str2double(get(handles.edit11, 'string'));
    [BP_beta, BP_beta_log] = BP_featureExtraction(handles.Fs, handles.signal_123, handles.(['edit',num2str(editNb),'']), halfRange);

    handles.statist = statist;
        handles.statist_log = statist_log;
    handles.max_fft_amp = max_fft_amp;
    handles.max_fft_amp_log = max_fft_amp_log;
    handles.max_fft_comp = max_fft_comp;
    handles.max_fft_comp_log = max_fft_comp_log;
    handles.AR_Coeff = AR_Coeff;
    handles.AR_Coeff_log = AR_Coeff_log;
    handles.BP_alpha = BP_alpha;
    handles.BP_alpha_log = BP_alpha_log;
    handles.BP_beta = BP_beta;
    handles.BP_beta_log = BP_beta_log;
% Start feature combination
tic
Features={'statist' 'max_fft_amp' 'max_fft_comp' 'AR_Coeff' 'BP_alpha' 'BP_beta'};
counter=1;
h = waitbar(0,'Please wait ... (1/6)');
for ii=1: length(Features)    
    [accuracy_mean, accuracy_SD] = nTimesKFoldCrossValidation(nTimes, kFold, handles.(Features{ii}), signal_123_label, true, false);
[accuracy_log_mean, accuracy_log_SD] = nTimesKFoldCrossValidation(nTimes, kFold, handles.(['',Features{ii},'_log']), signal_123_label, true, false);
ACCURACY(:,counter)=[accuracy_mean;accuracy_SD;accuracy_log_mean;accuracy_log_SD;size(handles.(Features{ii}), 2)];
    counter=counter+1;
    waitbar(ii / 6)
end
close(h)
h = waitbar(0,'Please wait ... (2/6)');
waitbar_counter=1;
for ii=1:5
    for jj=ii+1:6        
        feature = [handles.(Features{ii}), handles.(Features{jj})];
        feature_log = [handles.(['',Features{ii},'_log']), handles.(['',Features{jj},'_log'])];
            [accuracy_mean, accuracy_SD] = nTimesKFoldCrossValidation(nTimes, kFold, feature, signal_123_label, true, false);
[accuracy_log_mean, accuracy_log_SD] = nTimesKFoldCrossValidation(nTimes, kFold, feature_log, signal_123_label, true, false);
ACCURACY(:,counter)=[accuracy_mean;accuracy_SD;accuracy_log_mean;accuracy_log_SD;size(feature, 2)];
        counter=counter+1;
        waitbar_counter=waitbar_counter+1;
        waitbar(waitbar_counter / 15)
    end
end
close(h)
clear fea_train_norm fea_test_norm PS
h = waitbar(0,'Please wait ... (3/6)');
waitbar_counter=1;
for ii=1:4
    for jj=ii+1:5
        for kk=jj+1:6            
                    feature = [handles.(Features{ii}), handles.(Features{jj}), handles.(Features{kk})];
        feature_log = [handles.(['',Features{ii},'_log']), handles.(['',Features{jj},'_log']), handles.(['',Features{kk},'_log'])];
            [accuracy_mean, accuracy_SD] = nTimesKFoldCrossValidation(nTimes, kFold, feature, signal_123_label, true, false);
[accuracy_log_mean, accuracy_log_SD] = nTimesKFoldCrossValidation(nTimes, kFold, feature_log, signal_123_label, true, false);
ACCURACY(:,counter)=[accuracy_mean;accuracy_SD;accuracy_log_mean;accuracy_log_SD;size(feature, 2)];
            counter=counter+1;
            waitbar_counter=waitbar_counter+1;
            waitbar(waitbar_counter /20)
        end
    end
end
close(h)
clear fea_train_norm fea_test_norm PS
h = waitbar(0,'Please wait ... (4/6)');
waitbar_counter=1;
for ii=1:3
    for jj=ii+1:4
        for kk=jj+1:5
            for ll=kk+1:6                
                                    feature = [handles.(Features{ii}), handles.(Features{jj}), handles.(Features{kk}), handles.(Features{ll})];
        feature_log = [handles.(['',Features{ii},'_log']), handles.(['',Features{jj},'_log']), handles.(['',Features{kk},'_log']), handles.(['',Features{ll},'_log'])];
            [accuracy_mean, accuracy_SD] = nTimesKFoldCrossValidation(nTimes, kFold, feature, signal_123_label, true, false);
[accuracy_log_mean, accuracy_log_SD] = nTimesKFoldCrossValidation(nTimes, kFold, feature_log, signal_123_label, true, false);
ACCURACY(:,counter)=[accuracy_mean;accuracy_SD;accuracy_log_mean;accuracy_log_SD;size(feature, 2)];
                counter=counter+1;
                waitbar_counter=waitbar_counter+1;
                waitbar(waitbar_counter /15)
            end
        end
    end
end
close(h)
clear fea_train_norm fea_test_norm PS
h = waitbar(0,'Please wait ... (5/6)');
waitbar_counter=1;
for ii=1:2
    for jj=ii+1:3
        for kk=jj+1:4
            for ll=kk+1:5
                for mm=ll+1:6                    
                                                        feature = [handles.(Features{ii}), handles.(Features{jj}), handles.(Features{kk}), handles.(Features{ll}), handles.(Features{mm})];
        feature_log = [handles.(['',Features{ii},'_log']), handles.(['',Features{jj},'_log']), handles.(['',Features{kk},'_log']), handles.(['',Features{ll},'_log']), handles.(['',Features{mm},'_log'])];
            [accuracy_mean, accuracy_SD] = nTimesKFoldCrossValidation(nTimes, kFold, feature, signal_123_label, true, false);
[accuracy_log_mean, accuracy_log_SD] = nTimesKFoldCrossValidation(nTimes, kFold, feature_log, signal_123_label, true, false);
ACCURACY(:,counter)=[accuracy_mean;accuracy_SD;accuracy_log_mean;accuracy_log_SD;size(feature, 2)];
                    counter=counter+1;
                    waitbar_counter=waitbar_counter+1;
                    waitbar(waitbar_counter /6)
                end
            end
        end
    end
end
close(h)
clear fea_train_norm fea_test_norm PS
h = waitbar(0,'Please wait ... (6/6)');
for ii=1:1
    for jj=ii+1:2
        for kk=jj+1:3
            for ll=kk+1:4
                for mm=ll+1:5
                    for nn=mm+1:6                        
                                                                                feature = [handles.(Features{ii}), handles.(Features{jj}), handles.(Features{kk}), handles.(Features{ll}), handles.(Features{mm}), handles.(Features{nn})];
        feature_log = [handles.(['',Features{ii},'_log']), handles.(['',Features{jj},'_log']), handles.(['',Features{kk},'_log']), handles.(['',Features{ll},'_log']), handles.(['',Features{mm},'_log']), handles.(['',Features{nn},'_log'])];
            [accuracy_mean, accuracy_SD] = nTimesKFoldCrossValidation(nTimes, kFold, feature, signal_123_label, true, false);
[accuracy_log_mean, accuracy_log_SD] = nTimesKFoldCrossValidation(nTimes, kFold, feature_log, signal_123_label, true, false);
                        ACCURACY(:,counter)=[accuracy_mean;accuracy_SD;accuracy_log_mean;accuracy_log_SD;size(feature, 2)];
                        counter=counter+1;
                    end
                end
            end
        end
    end
    waitbar(ii / 1)
end
close(h)
counter=1;
Features_Brief={'stat' 'fftAmp' 'fftFreq' 'AR' 'Alpha' 'Beta'};
F1=[
    1
    2
    3
    4
    5
    6];
for i=1:size(F1,1)
    Feature_XTick{1,counter}=Features_Brief{F1(i)};
    counter=counter+1;
end
F2=[
    1     2
    1     3
    1     4
    1     5
    1     6
    2     3
    2     4
    2     5
    2     6
    3     4
    3     5
    3     6
    4     5
    4     6
    5     6];
for i=1:size(F2,1)
    Feature_XTick{1,counter}=[Features_Brief{F2(i,1)} ',' Features_Brief{F2(i,2)}];
    counter=counter+1;
end
F3=[
    1     2     3
    1     2     4
    1     2     5
    1     2     6
    1     3     4
    1     3     5
    1     3     6
    1     4     5
    1     4     6
    1     5     6
    2     3     4
    2     3     5
    2     3     6
    2     4     5
    2     4     6
    2     5     6
    3     4     5
    3     4     6
    3     5     6
    4     5     6];
for i=1:size(F3,1)
    Feature_XTick{1,counter}=[Features_Brief{F3(i,1)} ',' Features_Brief{F3(i,2)} ',' Features_Brief{F3(i,3)}];
    counter=counter+1;
end
F4=[
    1     2     3     4
    1     2     3     5
    1     2     3     6
    1     2     4     5
    1     2     4     6
    1     2     5     6
    1     3     4     5
    1     3     4     6
    1     3     5     6
    1     4     5     6
    2     3     4     5
    2     3     4     6
    2     3     5     6
    2     4     5     6
    3     4     5     6];
for i=1:size(F4,1)
    Feature_XTick{1,counter}=[Features_Brief{F4(i,1)} ',' Features_Brief{F4(i,2)} ',' Features_Brief{F4(i,3)} ',' Features_Brief{F4(i,4)}];
    counter=counter+1;
end
F5=[
    1     2     3     4     5
    1     2     3     4     6
    1     2     3     5     6
    1     2     4     5     6
    1     3     4     5     6
    2     3     4     5     6];
for i=1:size(F5,1)
    Feature_XTick{1,counter}=[Features_Brief{F5(i,1)} ',' Features_Brief{F5(i,2)} ',' Features_Brief{F5(i,3)} ',' Features_Brief{F5(i,4)} ',' Features_Brief{F5(i,5)}];
    counter=counter+1;
end
F6=[
    1     2     3     4     5     6];
for i=1:size(F6,1)
    Feature_XTick{1,counter}=[Features_Brief{F6(i,1)} ',' Features_Brief{F6(i,2)} ',' Features_Brief{F6(i,3)} ',' Features_Brief{F6(i,4)} ',' Features_Brief{F6(i,5)} ',' Features_Brief{F6(i,6)}];
    counter=counter+1;
end

toc
axes(handles.axes22) % was kept becasue of xticklabel_rotate
axis(handles.axes22, 'on')
errorbar(handles.axes22, ACCURACY(1,:),ACCURACY(2,:))
hold(handles.axes22, 'on')
errorbar(handles.axes22, ACCURACY(3,:),ACCURACY(4,:),'r')
stem(handles.axes22, ACCURACY(5,:),'filled', 'color', 'k')
set(handles.axes22,'XTick',1:length(Feature_XTick), 'XTickLabel',Feature_XTick, 'XTickLabelRotation',90) % 63 
legend(handles.axes22, {'feature', 'log(feature)', 'dimension'}, 'Location', 'best')
savePath = fullfile(handles.GUIAnalysisPath, handles.dataFolderName, 'sample_featureCombinationResult.mat');
save(savePath, 'ACCURACY', 'Feature_XTick')

ylabel(handles.axes22, 'Accuracy (%)')
grid(handles.axes22, 'on')
xlim(handles.axes22, [1, length(Feature_XTick)])
handles.plottedAxes = [handles.plottedAxes, 22];
guidata(hObject, handles);


% --- Executes on button press in pushbutton25.
function pushbutton25_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ginput(1)


% --- Executes on button press in pushbutton26.
function pushbutton26_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
elementType = 'pushbutton';
elementNb = [38, 40];
isOn = true;
property = 'enable';
elementOnOff(handles, elementType, elementNb, property, isOn);

handles.Selected_Features{1,handles.Selected_Features_Counter}='statist';
handles.Selected_Features_Counter=handles.Selected_Features_Counter+1;
guidata(hObject, handles);


% --- Executes on button press in pushbutton27.
function pushbutton27_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
elementType = 'pushbutton';
elementNb = [38, 40];
isOn = true;
property = 'enable';
elementOnOff(handles, elementType, elementNb, property, isOn);

handles.Selected_Features{1,handles.Selected_Features_Counter}='statist_log';
handles.Selected_Features_Counter=handles.Selected_Features_Counter+1;
guidata(hObject, handles);


% --- Executes on button press in pushbutton28.
function pushbutton28_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
elementType = 'pushbutton';
elementNb = [38, 40];
isOn = true;
property = 'enable';
elementOnOff(handles, elementType, elementNb, property, isOn);
handles.Selected_Features{1,handles.Selected_Features_Counter}='max_fft_amp';
handles.Selected_Features_Counter=handles.Selected_Features_Counter+1;
guidata(hObject, handles);



% --- Executes on button press in pushbutton29.
function pushbutton29_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton29 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
elementType = 'pushbutton';
elementNb = [38, 40];
isOn = true;
property = 'enable';
elementOnOff(handles, elementType, elementNb, property, isOn);

handles.Selected_Features{1,handles.Selected_Features_Counter}='max_fft_amp_log';
handles.Selected_Features_Counter=handles.Selected_Features_Counter+1;
guidata(hObject, handles);



% --- Executes on button press in pushbutton30.
function pushbutton30_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton30 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
elementType = 'pushbutton';
elementNb = [38, 40];
isOn = true;
property = 'enable';
elementOnOff(handles, elementType, elementNb, property, isOn);

handles.Selected_Features{1,handles.Selected_Features_Counter}='max_fft_comp';
handles.Selected_Features_Counter=handles.Selected_Features_Counter+1;
guidata(hObject, handles);


% --- Executes on button press in pushbutton31.
function pushbutton31_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
elementType = 'pushbutton';
elementNb = [38, 40];
isOn = true;
property = 'enable';
elementOnOff(handles, elementType, elementNb, property, isOn);

handles.Selected_Features{1,handles.Selected_Features_Counter}='max_fft_comp_log';
handles.Selected_Features_Counter=handles.Selected_Features_Counter+1;
guidata(hObject, handles);


% --- Executes on button press in pushbutton32.
function pushbutton32_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
elementType = 'pushbutton';
elementNb = [38, 40];
isOn = true;
property = 'enable';
elementOnOff(handles, elementType, elementNb, property, isOn);

handles.Selected_Features{1,handles.Selected_Features_Counter}='AR_Coeff';
handles.Selected_Features_Counter=handles.Selected_Features_Counter+1;
guidata(hObject, handles);


% --- Executes on button press in pushbutton33.
function pushbutton33_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
elementType = 'pushbutton';
elementNb = [38, 40];
isOn = true;
property = 'enable';
elementOnOff(handles, elementType, elementNb, property, isOn);

handles.Selected_Features{1,handles.Selected_Features_Counter}='AR_Coeff_log';
handles.Selected_Features_Counter=handles.Selected_Features_Counter+1;
guidata(hObject, handles);


% --- Executes on button press in pushbutton34.
function pushbutton34_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton34 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
elementType = 'pushbutton';
elementNb = [38, 40];
isOn = true;
property = 'enable';
elementOnOff(handles, elementType, elementNb, property, isOn);

handles.Selected_Features{1,handles.Selected_Features_Counter}='BP_alpha';
handles.Selected_Features_Counter=handles.Selected_Features_Counter+1;
guidata(hObject, handles);


% --- Executes on button press in pushbutton35.
function pushbutton35_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton35 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
elementType = 'pushbutton';
elementNb = [38, 40];
isOn = true;
property = 'enable';
elementOnOff(handles, elementType, elementNb, property, isOn);

handles.Selected_Features{1,handles.Selected_Features_Counter}='BP_alpha_log';
handles.Selected_Features_Counter=handles.Selected_Features_Counter+1;
guidata(hObject, handles);


% --- Executes on button press in pushbutton36.
function pushbutton36_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton36 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
elementType = 'pushbutton';
elementNb = [38, 40];
isOn = true;
property = 'enable';
elementOnOff(handles, elementType, elementNb, property, isOn);

handles.Selected_Features{1,handles.Selected_Features_Counter}='BP_beta';
handles.Selected_Features_Counter=handles.Selected_Features_Counter+1;
guidata(hObject, handles);


% --- Executes on button press in pushbutton37.
function pushbutton37_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton37 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
elementType = 'pushbutton';
elementNb = [38, 40];
isOn = true;
property = 'enable';
elementOnOff(handles, elementType, elementNb, property, isOn);

handles.Selected_Features{1,handles.Selected_Features_Counter}='BP_beta_log';
handles.Selected_Features_Counter=handles.Selected_Features_Counter+1;
guidata(hObject, handles);


% --- Executes on button press in pushbutton38.
function pushbutton38_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton38 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = clear_axes(handles, 1, [], 1, 1, 1);
signal_123 = handles.signal_123;
signal_123_label = handles.signal_123_label;
Fs = handles.Fs;
if any(ismember({'max_fft_amp', 'max_fft_amp_log'}, handles.Selected_Features))
    m = str2double(get(handles.edit6,'string'));
    max_fft_amp = nan(size(signal_123,3), m * size(signal_123,1));
    for ii = 1:size(signal_123,3)
        max_fft_amp(ii,:) = fft_amp_sorted(signal_123(:,:,ii)', m);
    end
    max_fft_amp_log = log(max_fft_amp);
    handles.max_fft_amp_log=max_fft_amp_log;
    handles.max_fft_amp=max_fft_amp;
end

if any(ismember({'max_fft_comp', 'max_fft_comp_log'}, handles.Selected_Features))
    m = str2double(get(handles.edit4,'string'));
    max_fft_comp = nan(size(signal_123,3), m * size(signal_123,1));
    for ii = 1:size(signal_123,3)
        max_fft_comp(ii,:) = fft_freq_sorted(Fs, signal_123(:,:,ii)', m);
    end
    max_fft_comp_log=(log(max_fft_comp));
    handles.max_fft_comp_log=max_fft_comp_log;
    handles.max_fft_comp=max_fft_comp;
end

if any(ismember({'AR_Coeff', 'AR_Coeff_log'}, handles.Selected_Features))
    % AR features
    AR_order = str2double(get(handles.edit9, 'string'));
    AR_Coeff = nan(size(signal_123,3), AR_order * size(signal_123,1));
    for ii = 1:size(signal_123,3)
        AR_Coeff(ii,:) = ar_order(signal_123(:,:,ii)', AR_order);
    end
    AR_Coeff_log = abs(log(AR_Coeff));
    handles.AR_Coeff_log = AR_Coeff_log;
    handles.AR_Coeff = AR_Coeff;
end

if any(ismember({'BP_alpha', 'BP_alpha_log'}, handles.Selected_Features))
    % Alpha BP features
    editNb = 14; % center
    halfRange = str2double(get(handles.edit13, 'string'));
    [BP_alpha, BP_alpha_log] = BP_featureExtraction(handles.Fs, handles.signal_123, handles.(['edit',num2str(editNb),'']), halfRange);
    
    handles.BP_alpha_log=BP_alpha_log;
    handles.BP_alpha=BP_alpha;
end

if any(ismember({'BP_beta', 'BP_beta_log'}, handles.Selected_Features))
    % beta BP features
    editNb = 15; % center
    halfRange = str2double(get(handles.edit11, 'string'));
    [BP_beta, BP_beta_log] = BP_featureExtraction(handles.Fs, handles.signal_123, handles.(['edit',num2str(editNb),'']), halfRange);
    
    handles.BP_beta_log=BP_beta_log;
    handles.BP_beta=BP_beta;
end
handles.Selected_Features = unique(handles.Selected_Features);
Features=[];
for i=1:length(handles.Selected_Features)
    Features=[Features handles.(['',handles.Selected_Features{i},''])];
end
handles.featureDimension = size(Features, 2);
set(handles.text53,'string',num2str(handles.featureDimension))

[accuracy_mean, accuracy_SD, precision_mean, precision_SD, ...
    recall_mean, recall_SD, f1score_mean, f1score_SD] = nTimesKFoldCrossValidation(handles.nTimes, handles.kFold, Features, signal_123_label, false, true);
classification_report = {};
for i = 1 : length(precision_mean)
    classification_report(i, 1) = {['',num2str(round(precision_mean(i), 2)),' +- ',num2str(round(precision_SD(i),2)),'']};
end
for i = 1 : length(recall_mean)
    classification_report(i, 2) = {['',num2str(round(recall_mean(i),2)),' +- ',num2str(round(recall_SD(i),2)),'']};
end
for i = 1 : length(f1score_mean)
    classification_report(i, 3) = {['',num2str(round(f1score_mean(i),2)),' +- ',num2str(round(f1score_SD(i),2)),'']};
end
classification_report(:, 4) = {'', '', ''};
classification_report(4, :) = {'', '', '', ['',num2str(round(accuracy_mean,2)),' +- ',num2str(round(accuracy_SD,2)),'']};
set(handles.uitable1,'data', classification_report, 'visible', 'on')
handles.plottedTables = [handles.plottedTables, 1];
guidata(hObject, handles);


function edit34_Callback(hObject, eventdata, handles)
% hObject    handle to edit34 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit34 as text
%        str2double(get(hObject,'String')) returns contents of edit34 as a double
val = str2double(get(hObject,'String'));
if isNum(val) && val >= handles.erds.r{1,1}.f_plot(1) && val <= handles.erds.r{1,1}.f_plot(end)
handles.erds.timeFreqLim(3) = val;
handles = plot_roi_AllAxes(handles);

r = handles.erds.r;
timeSeries = cell(size(r, 1), size(r, 2));
sptr = cell(size(r, 1), size(r, 2));
for i = 1 : size(r, 1) % classes
    for j = 1 : size(r, 2) % channels
        [t, timeSeries{i, j}, f, sptr{i, j}] = timeFreqMarginal(r{i, j}.ERDS{1}.erds', r{i, j}.t_plot, r{i, j}.f_plot, handles.erds.timeFreqLim(1:2), handles.erds.timeFreqLim(3:4));
    end
end
for i = 1 : size(timeSeries, 2)
handles.erds.timeSeries{i} = horzcat(timeSeries{:, i});
handles.erds.sptr{i} = horzcat(sptr{:, i});
end
handles.erds.t = t;
handles.erds.f = f;
handles = plot_timeFreqMarginal(handles, handles.erds.t, handles.erds.timeSeries, handles.erds.f, handles.erds.sptr, handles.classTitle);

end
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function edit34_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit34 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton39.
function pushbutton39_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton39 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton40.
function pushbutton40_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton40 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = clear_axes(handles, 1, [], 1, 1, 1);

signal_123 = handles.signal_123;
signal_123_label = handles.signal_123_label;
Fs = handles.Fs;

    Amp_comp = str2double(get(handles.edit6,'string'));
    max_fft_amp = nan(size(signal_123,3), Amp_comp * size(signal_123,1));
    for ii=1:size(signal_123,3)
        max_fft_amp(ii,:) = fft_amp_sorted(signal_123(:,:,ii)', Amp_comp);
end
max_fft_amp_log=log(max_fft_amp);
    Freq_comp = str2double(get(handles.edit4,'string'));
        max_fft_comp = nan(size(signal_123,3), Freq_comp * size(signal_123,1));
for ii=1:size(signal_123,3)
            max_fft_comp(ii,:) = fft_freq_sorted(Fs, signal_123(:,:,ii)', Freq_comp);
end
max_fft_comp_log=(log(max_fft_comp));
% AR features
    AR_order = str2double(get(handles.edit9, 'string'));
for ii=1:size(signal_123,3)
        AR_Coeff(ii,:) = ar_order(signal_123(:,:,ii)', AR_order);
end
AR_Coeff_log=abs(log(AR_Coeff));
% Alpha BP features
    editNb = 14; % center
    halfRange = str2double(get(handles.edit13, 'string'));
    [BP_alpha, BP_alpha_log] = BP_featureExtraction(handles.Fs, handles.signal_123, handles.(['edit',num2str(editNb),'']), halfRange);

% beta BP features
    editNb = 15; % center
    halfRange = str2double(get(handles.edit11, 'string'));
    [BP_beta, BP_beta_log] = BP_featureExtraction(handles.Fs, handles.signal_123, handles.(['edit',num2str(editNb),'']), halfRange);

Features=[];
for i=1:length(handles.Selected_Features)
    eval(['Features=[Features handles.',handles.Selected_Features{i},'];'])
end
handles.Selected_Features=[];
handles.Selected_Features_Counter=1;

[BP,PS]=mapminmax(Features');
BP=BP';

alpha_center=str2double(get(handles.edit14,'string'));
alpha_range=str2double(get(handles.edit13,'string'));
alpha_L=alpha_center-alpha_range;
alpha_H=alpha_center+alpha_range;

beta_center=str2double(get(handles.edit15,'string'));
beta_range=str2double(get(handles.edit11,'string'));
beta_L=beta_center-beta_range;
beta_H=beta_center+beta_range;

save(fullfile(handles.dataFolderName, 'trainingFeatures.mat'), ...
    'BP', 'signal_123_label', 'PS', ...
    'alpha_L', 'alpha_H', 'beta_L', 'beta_H', 'AR_order', 'Freq_comp', 'Amp_comp', ...
'max_fft_amp_log', 'max_fft_amp', 'max_fft_comp_log', 'max_fft_comp', 'AR_Coeff_log', ...
    'AR_Coeff', 'BP_alpha_log', 'BP_alpha', 'BP_beta_log', 'BP_beta')


guidata(hObject, handles);

function handles = clear_axes(handles, isClearSliders, exceptAxes, isClearTables, isClearTexts, isClearEdits)
if ~isempty(handles.plottedAxes)
    handles.plottedAxes = unique(handles.plottedAxes);
    h = waitbar(0,'Please wait... (Clearing display elements)','Position',[384 -10 270 50]);
    for i=1:length(handles.plottedAxes)
        if ~ismember(handles.plottedAxes(i), exceptAxes) % Don't touch exceptAxes
            cla(handles.(['axes',num2str(handles.plottedAxes(i)),'']));
            axis(handles.(['axes',num2str(handles.plottedAxes(i)),'']), 'off'),
            title(handles.(['axes',num2str(handles.plottedAxes(i)),'']), ''),
            legend(handles.(['axes',num2str(handles.plottedAxes(i)),'']), 'off')
        end
        waitbar(i/length(handles.plottedAxes))
    end
    handles.plottedAxes = exceptAxes;
    close(h)
end
if isClearSliders && ~isempty(handles.plottedSliders)
    handles.plottedSliders = unique(handles.plottedSliders);
    elementType = 'slider';
    elementNb = handles.plottedSliders;
    isOn = false;
    property = 'visible';
    elementOnOff(handles, elementType, elementNb, property, isOn);
    handles.plottedSliders = [];
end
if isClearTables && ~isempty(handles.plottedTables)
    handles.plottedTables = unique(handles.plottedTables);
    elementType = 'uitable';
    elementNb = handles.plottedTables;
    isOn = false;
    property = 'visible';
    elementOnOff(handles, elementType, elementNb, property, isOn);
    handles.plottedTables = [];
end
if isClearTexts && ~isempty(handles.plottedTexts)
    handles.plottedTexts = unique(handles.plottedTexts);
    elementType = 'text';
    elementNb = handles.plottedTexts;
    isOn = false;
    property = 'visible';
    elementOnOff(handles, elementType, elementNb, property, isOn);
    handles.plottedTexts = [];
end
if isClearEdits && ~isempty(handles.plottedEdits)
    handles.plottedEdits = unique(handles.plottedEdits);
    elementType = 'edit';
    elementNb = handles.plottedEdits;
    isOn = false;
    property = 'enable';
    elementOnOff(handles, elementType, elementNb, property, isOn);
    handles.plottedEdits = [];
end


% --- Executes on button press in pushbutton41.
function pushbutton41_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton41 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
addPathInMatlabPathIfNotAlready({
    handles.eeglabAddress, ...
    fullfile(handles.eeglabAddress, 'functions', 'sigprocfunc')
    }, handles.toolboxPath);
handles = clear_axes(handles, 1, [], 1, 1, 1);

elementNb = 57:59;
elementType = 'text';
isOn = true;
property = 'visible';
elementOnOff(handles, elementType, elementNb, property, isOn);
handles.plottedTexts = [handles.plottedTexts, elementNb];

signal_123 = handles.signal_123;
signal_123_label = handles.signal_123_label;
Fs = handles.Fs;
freqfac = handles.freqfac; %frequency resolution {default: 2}

signal_123_C1=signal_123(:,:,signal_123_label==1);
signal_123_C2=signal_123(:,:,signal_123_label==2);
signal_123_C3=signal_123(:,:,signal_123_label==3);
[spectra_1 freqs] = spectopo( signal_123_C1,size(signal_123,2), Fs,'freqfac',freqfac, 'plot', 'off');
spectra_2 = spectopo( signal_123_C2,size(signal_123,2), Fs,'freqfac',freqfac, 'plot', 'off');
spectra_3 = spectopo( signal_123_C3,size(signal_123,2), Fs,'freqfac',freqfac, 'plot', 'off');

spectra_1=mapminmax(spectra_1')';
spectra_2=mapminmax(spectra_2')';
spectra_3=mapminmax(spectra_3')';
colormap(handles.colormap)
for i=7:30
    topoplotter(handles.(['axes',num2str(i+17),'']), freqs, i, spectra_1, '');
    drawnow
end
handles.plottedAxes = [handles.plottedAxes, 7+17:30+17];
for i=7:18
    topoplotter(handles.(['axes',num2str(i+41),'']), freqs, i, spectra_2, '');
    drawnow
end
handles.plottedAxes = [handles.plottedAxes, 7+41:18+41];
for i=19:30
    topoplotter(handles.(['axes',num2str(i+53),'']), freqs, i, spectra_2, '');
    drawnow
end
handles.plottedAxes = [handles.plottedAxes, 19+53:30+53];
for i=7:30
    topoplotter(handles.(['axes',num2str(i+77),'']), freqs, i, spectra_3, '');
    drawnow
end
handles.plottedAxes = [handles.plottedAxes, 7+77:30+77];
guidata(hObject, handles);

function topoplotter(axHandles, freqsVec, freqsSel, spectra, titleTxt)
[~, idx] = min(abs(freqsVec - freqsSel));
topoplot(spectra(:, idx),'Channel_Cz_C3_C4_location.ced','electrodes','on','maplimits','absmax','style','map', 'ax', axHandles);
title(axHandles, ['',num2str(freqsSel),'Hz', titleTxt], 'FontSize', 10, 'FontWeight', 'bold')

function edit35_Callback(hObject, eventdata, handles)
% hObject    handle to edit35 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit35 as text
%        str2double(get(hObject,'String')) returns contents of edit35 as a double
editNb = 36;
elementType = 'pushbutton';
elementNb = 42;
checkEditsElementOnOff(hObject, handles, editNb, elementType, elementNb)

% --- Executes during object creation, after setting all properties.
function edit35_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit35 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit36_Callback(hObject, eventdata, handles)
% hObject    handle to edit36 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit36 as text
%        str2double(get(hObject,'String')) returns contents of edit36 as a double
editNb = 35;
elementType = 'pushbutton';
elementNb = 42;
checkEditsElementOnOff(hObject, handles, editNb, elementType, elementNb)

% --- Executes during object creation, after setting all properties.
function edit36_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit36 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit37_Callback(hObject, eventdata, handles)
% hObject    handle to edit37 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit37 as text
%        str2double(get(hObject,'String')) returns contents of edit37 as a double
editNb = 38;
elementType = 'pushbutton';
elementNb = 45;
checkEditsElementOnOff(hObject, handles, editNb, elementType, elementNb)


function checkEditsElementOnOff(hObject, handles, editNb, elementType, elementNb)
editCheck = true;
for i = 1 : length(editNb) % Check if all edit boxes are numeric
    editCheck = and(editCheck, ...
        and(~isempty(str2double(get(handles.(['edit',num2str(editNb(i)),'']),'String'))), ...
        ~isnan(str2double(get(handles.(['edit',num2str(editNb(i)),'']),'String')))));
end
if and(and(~isempty(str2double(get(hObject,'String'))) , ~isnan(str2double(get(hObject,'String')))), editCheck)
    isOn = true;
    property = 'enable';
    elementOnOff(handles, elementType, elementNb, property, isOn);
else
    isOn = false;
    property = 'enable';
    elementOnOff(handles, elementType, elementNb, property, isOn);
end


% --- Executes during object creation, after setting all properties.
function edit37_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit37 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit38_Callback(hObject, eventdata, handles)
% hObject    handle to edit38 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit38 as text
%        str2double(get(hObject,'String')) returns contents of edit38 as a double
editNb = 37;
elementType = 'pushbutton';
elementNb = 45;
checkEditsElementOnOff(hObject, handles, editNb, elementType, elementNb)


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



function edit39_Callback(hObject, eventdata, handles)
% hObject    handle to edit39 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit39 as text
%        str2double(get(hObject,'String')) returns contents of edit39 as a double
editNb = 40;
elementType = 'pushbutton';
elementNb = 43;
checkEditsElementOnOff(hObject, handles, editNb, elementType, elementNb)

% --- Executes during object creation, after setting all properties.
function edit39_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit39 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit40_Callback(hObject, eventdata, handles)
% hObject    handle to edit40 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit40 as text
%        str2double(get(hObject,'String')) returns contents of edit40 as a double
editNb = 39;
elementType = 'pushbutton';
elementNb = 43;
checkEditsElementOnOff(hObject, handles, editNb, elementType, elementNb)


% --- Executes during object creation, after setting all properties.
function edit40_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit40 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton42.
function pushbutton42_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton42 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

label = 1;
editNb = [35, 36];
axNb = 108;
sliderNb = 1;
titleTxt = ' | Alpha | Left Hand';
[handles, freqs, spectra, titleTxt] = slider_topoplotter(handles, label, handles.freqfac, editNb, axNb, sliderNb, titleTxt);
handles.leftAlphaFreqs = freqs;
handles.leftAlphaSpectra = spectra;
handles.leftAlphaTitle = titleTxt;
guidata(hObject, handles);


function [handles, freqs, spectra, titleTxt] = slider_topoplotter(handles, ...
    label, freqfac, editNb, axNb, sliderNb, titleTxt)
freq1 = str2double(get(handles.(['edit',num2str(editNb(1)),'']), 'string')); % Lower freq
freq2 = str2double(get(handles.(['edit',num2str(editNb(2)),'']), 'string')); % Higher freq
if isempty(freq1) || isnan(freq1) || isempty(freq2) || isnan(freq2)
    warndlg('Enter numeric values for the band range!', 'Warning');
    [freqs, spectra, titleTxt] = deal(nan, nan, nan);
    return
end
freq12 = sort([freq1 , freq2], 'ascend');
freqLow = freq12(1);
freqHigh = freq12(2);
addPathInMatlabPathIfNotAlready({
    handles.eeglabAddress, ...
    fullfile(handles.eeglabAddress, 'functions', 'sigprocfunc')
    }, handles.toolboxPath);
handles = clear_axes(handles, 0, 108:113, 1, 1, 1);
signal_123 = handles.signal_123(:,:,handles.signal_123_label == label);
[spectra, freqs] = spectopo(signal_123, size(handles.signal_123,2), handles.Fs, 'freqfac', freqfac, 'plot', 'off');
spectra = mapminmax(spectra')'; % Normalise along channels per freqs
[~, freqLowIdx] = min(abs(freqs - freqLow));
[~, freqHighIdx] = min(abs(freqs - freqHigh));
spectra = spectra(:, freqLowIdx:freqHighIdx);
freqs = freqs(freqLowIdx:freqHighIdx);
colormap(handles.colormap)
topoplotter(handles.(['axes',num2str(axNb),'']), freqs, freqLow, spectra, titleTxt);
set(handles.(['slider',num2str(sliderNb),'']), 'visible', 'on', 'Value', freqs(1), 'Min', freqs(1), 'Max', freqs(end), 'SliderStep', [1/(length(freqs)-1),1/(freqs(end)-freqs(1))])
handles.plottedAxes = [handles.plottedAxes, axNb];
handles.plottedSliders = [handles.plottedSliders, sliderNb];


function addPathInMatlabPathIfNotAlready(targetPath, toolboxPath)
pathList = strsplit(path, pathsep); % Convert to a cell array for easy comparison
if any(~ismember(targetPath, pathList)) % Check if the target path is in the MATLAB search path
    restoredefaultpath
    addpath(genpath(toolboxPath)) 
    for i = 1 : length(targetPath)
        addpath(genpath(targetPath{i}))
    end
end


% --- Executes on button press in pushbutton43.
function pushbutton43_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton43 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

label = 2;
editNb = [39, 40];
axNb = 110;
sliderNb = 3;
titleTxt = ' | Alpha | Right Hand';
[handles, freqs, spectra, titleTxt] = slider_topoplotter(handles, label, handles.freqfac, editNb, axNb, sliderNb, titleTxt);
handles.rightAlphaFreqs = freqs;
handles.rightAlphaSpectra = spectra;
handles.rightAlphaTitle = titleTxt;
% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in pushbutton44.
function pushbutton44_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton44 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
label = 3;
editNb = [43, 44];
axNb = 112;
sliderNb = 5;
titleTxt = ' | Alpha | Feet';
[handles, freqs, spectra, titleTxt] = slider_topoplotter(handles, label, handles.freqfac, editNb, axNb, sliderNb, titleTxt);
handles.footAlphaFreqs = freqs;
handles.footAlphaSpectra = spectra;
handles.footAlphaTitle = titleTxt;
% Update handles structure
guidata(hObject, handles);


function edit41_Callback(hObject, eventdata, handles)
% hObject    handle to edit41 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit41 as text
%        str2double(get(hObject,'String')) returns contents of edit41 as a double
editNb = 42;
elementType = 'pushbutton';
elementNb = 46;
checkEditsElementOnOff(hObject, handles, editNb, elementType, elementNb)


% --- Executes during object creation, after setting all properties.
function edit41_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit41 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit42_Callback(hObject, eventdata, handles)
% hObject    handle to edit42 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit42 as text
%        str2double(get(hObject,'String')) returns contents of edit42 as a double
editNb = 41;
elementType = 'pushbutton';
elementNb = 46;
checkEditsElementOnOff(hObject, handles, editNb, elementType, elementNb)


% --- Executes during object creation, after setting all properties.
function edit42_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit42 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit43_Callback(hObject, eventdata, handles)
% hObject    handle to edit43 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit43 as text
%        str2double(get(hObject,'String')) returns contents of edit43 as a double
editNb = 44;
elementType = 'pushbutton';
elementNb = 44;
checkEditsElementOnOff(hObject, handles, editNb, elementType, elementNb)


% --- Executes during object creation, after setting all properties.
function edit43_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit43 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit44_Callback(hObject, eventdata, handles)
% hObject    handle to edit44 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit44 as text
%        str2double(get(hObject,'String')) returns contents of edit44 as a double
editNb = 43;
elementType = 'pushbutton';
elementNb = 44;
checkEditsElementOnOff(hObject, handles, editNb, elementType, elementNb)


% --- Executes during object creation, after setting all properties.
function edit44_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit44 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit45_Callback(hObject, eventdata, handles)
% hObject    handle to edit45 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit45 as text
%        str2double(get(hObject,'String')) returns contents of edit45 as a double
editNb = 46;
elementType = 'pushbutton';
elementNb = 47;
checkEditsElementOnOff(hObject, handles, editNb, elementType, elementNb)


% --- Executes during object creation, after setting all properties.
function edit45_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit45 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit46_Callback(hObject, eventdata, handles)
% hObject    handle to edit46 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit46 as text
%        str2double(get(hObject,'String')) returns contents of edit46 as a double
editNb = 45;
elementType = 'pushbutton';
elementNb = 47;
checkEditsElementOnOff(hObject, handles, editNb, elementType, elementNb)


% --- Executes during object creation, after setting all properties.
function edit46_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit46 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton45.
function pushbutton45_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton45 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
label = 1;
editNb = [37, 38];
axNb = 109;
sliderNb = 2;
titleTxt = ' | Beta | Left Hand';
[handles, freqs, spectra, titleTxt] = slider_topoplotter(handles, label, handles.freqfac, editNb, axNb, sliderNb, titleTxt);
handles.leftBetaFreqs = freqs;
handles.leftBetaSpectra = spectra;
handles.leftBetaTitle = titleTxt;
% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in pushbutton46.
function pushbutton46_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton46 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
label = 2;
editNb = [41, 42];
axNb = 111;
sliderNb = 4;
titleTxt = ' | Beta | Right Hand';
[handles, freqs, spectra, titleTxt] = slider_topoplotter(handles, label, handles.freqfac, editNb, axNb, sliderNb, titleTxt);
handles.rightBetaFreqs = freqs;
handles.rightBetaSpectra = spectra;
handles.rightBetaTitle = titleTxt;
% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in pushbutton47.
function pushbutton47_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton47 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
label = 3;
editNb = [45, 46];
axNb = 113;
sliderNb = 6;
titleTxt = ' | Beta | Feet';
[handles, freqs, spectra, titleTxt] = slider_topoplotter(handles, label, handles.freqfac, editNb, axNb, sliderNb, titleTxt);
handles.footBetaFreqs = freqs;
handles.footBetaSpectra = spectra;
handles.footBetaTitle = titleTxt;

% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in pushbutton48.
function pushbutton48_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton48 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
addPathInMatlabPathIfNotAlready(handles.BioSigPath, handles.toolboxPath)
handles = clear_axes(handles, 1, [], 1, 1, 1);
editNb = [1, 2, 34, 47];
elementOnOff(handles, 'edit', editNb, 'enable', true)
handles.plottedEdits = editNb;

r = handles.erds.r;
handles.erds.timeFreqLim = [r{1, 1}.t_plot(1), r{1, 1}.t_plot(end), r{1, 1}.f_plot(1), r{1, 1}.f_plot(end)]; 

axesH = [114:116; 117:119; 120:122];
classTitle = {'Left', 'Right', 'Feet'};
channelTitle = {'C4', 'C3', 'Cz'};
timeSeries = cell(size(r, 1), size(r, 2));
sptr = cell(size(r, 1), size(r, 2));
for i = 1 : size(r, 1) % classes
    for j = 1 : size(r, 2) % channels
        handles.plottedAxes = [handles.plottedAxes, axesH(i,j)];
        axis(handles.(['axes',num2str(axesH(i,j)),'']), 'on')
axes(handles.(['axes',num2str(axesH(i,j)),'']))
        plotErdsMap_GUI(r{i, j});
        if i == size(r, 1)
            xlabel(handles.(['axes',num2str(axesH(i,j)),'']), 'time [sec]')
        else
            set(handles.(['axes',num2str(axesH(i,j)),'']), 'xticklabel', [])
            if i == 1
               title(handles.(['axes',num2str(axesH(i,j)),'']), channelTitle{j}) 
            end
        end
        if j == 1
            ylabel(handles.(['axes',num2str(axesH(i,j)),'']), {['',classTitle{i},''], 'freq. [Hz]'})
        end
        [t, timeSeries{i, j}, f, sptr{i, j}] = timeFreqMarginal(r{i, j}.ERDS{1}.erds', r{i, j}.t_plot, r{i, j}.f_plot, handles.erds.timeFreqLim(1:2), handles.erds.timeFreqLim(3:4));
    end
end
for i = 1 : size(timeSeries, 2)
handles.erds.timeSeries{i} = horzcat(timeSeries{:, i});
handles.erds.sptr{i} = horzcat(sptr{:, i});
end
handles.erds.t = t;
handles.erds.f = f;
handles = plot_timeFreqMarginal(handles, handles.erds.t, handles.erds.timeSeries, handles.erds.f, handles.erds.sptr, classTitle);
% guidata(hObject, handles);
guidata(hObject, handles);

function handles = plot_timeFreqMarginal(handles, t, timeSeries, f, sptr, classTitle)
axNb = 123:125;
handles.plottedAxes = [handles.plottedAxes, axNb];
for i = 1 : length(timeSeries)
    cla(handles.(['axes',num2str(axNb(i)),'']))
    plot(handles.(['axes',num2str(axNb(i)),'']), t, timeSeries{i}, 'linewidth', 2)
    hold(handles.(['axes',num2str(axNb(i)),'']), 'on')
axis(handles.(['axes',num2str(axNb(i)),'']), 'tight')
axis(handles.(['axes',num2str(axNb(i)),'']), 'on')
grid(handles.(['axes',num2str(axNb(i)),'']), 'on')
xlabel(handles.(['axes',num2str(axNb(i)),'']), 'time [sec]')
if i == length(timeSeries)
    legend(handles.(['axes',num2str(axNb(i)),'']), classTitle, 'FontSize', 7, 'Location', 'best')
end
end

axNb = 126:128;
handles.plottedAxes = [handles.plottedAxes, axNb];
for i = 1 : length(sptr)
    cla(handles.(['axes',num2str(axNb(i)),'']))
    plot(handles.(['axes',num2str(axNb(i)),'']), f, sptr{i}, 'linewidth', 2)
    hold(handles.(['axes',num2str(axNb(i)),'']), 'on')
axis(handles.(['axes',num2str(axNb(i)),'']), 'tight')
axis(handles.(['axes',num2str(axNb(i)),'']), 'on')
grid(handles.(['axes',num2str(axNb(i)),'']), 'on')
xlabel(handles.(['axes',num2str(axNb(i)),'']), 'freq. [Hz]')
end

function [t, timeSeries, f, sptr] = timeFreqMarginal(erds, timeVector, freqVector, timeRoi, freqRoi)
[~, t1Idx] = min(abs(timeVector - timeRoi(1)));
[~, t2Idx] = min(abs(timeVector - timeRoi(2)));
t = timeVector(t1Idx:t2Idx);
[~, f1Idx] = min(abs(freqVector - freqRoi(1)));
[~, f2Idx] = min(abs(freqVector - freqRoi(2)));
f = freqVector(f1Idx:f2Idx);
timeSeries = mean(erds(f1Idx:f2Idx, t1Idx:t2Idx)).';
sptr = mean(erds(f1Idx:f2Idx, t1Idx:t2Idx), 2);


function patchHandle = plot_roi(patchHandle, axHandle, xRoi, xVector, yRoi, yVector, yLim)
if ~isempty(patchHandle)
    for i = 1 : length(patchHandle)
        try
        delete(patchHandle{i});
        catch
            pause
        end
    end
end
hold(axHandle, 'on')
FaceAlpha = 0.4;
[~, x1Idx] = min(abs(xVector - xRoi(1)));
[~, x2Idx] = min(abs(xVector - xRoi(2)));
[~, y1Idx] = min(abs(yVector - yRoi(1)));
[~, y2Idx] = min(abs(yVector - yRoi(2)));
y = [yLim(1), yLim(2), yLim(2), yLim(1)];
xLeft = [xVector(1), xVector(1), xVector(x1Idx), xVector(x1Idx)];
xRight = [xVector(x2Idx), xVector(x2Idx), xVector(end), xVector(end)];
x = [xVector(x1Idx), xVector(x1Idx), xVector(x2Idx), xVector(x2Idx)];
yUp = [yVector(y1Idx), yVector(1), yVector(1), yVector(y1Idx)];
yDown = [yVector(end), yVector(y2Idx), yVector(y2Idx), yVector(end)];
patchHandle{1} = patch(axHandle, xLeft, y, 'k', 'EdgeColor', 'none', 'FaceAlpha', FaceAlpha);
patchHandle{2} = patch(axHandle, xRight, y, 'k', 'EdgeColor', 'none', 'FaceAlpha', FaceAlpha);
patchHandle{3} = patch(axHandle, x, yUp, 'k', 'EdgeColor', 'none', 'FaceAlpha', FaceAlpha);
patchHandle{4} = patch(axHandle, x, yDown, 'k', 'EdgeColor', 'none', 'FaceAlpha', FaceAlpha);
patchHandle{5} = line(axHandle, [xVector(x1Idx),xVector(x1Idx)], [yVector(y1Idx), yVector(y2Idx)], 'color', 'k', 'LineWidth', 2);
patchHandle{6} = line(axHandle, [xVector(x2Idx),xVector(x2Idx)], [yVector(y1Idx), yVector(y2Idx)], 'color', 'k', 'LineWidth', 2);
patchHandle{7} = line(axHandle, [xVector(x1Idx),xVector(x2Idx)], [yVector(y1Idx), yVector(y1Idx)], 'color', 'k', 'LineWidth', 2);
patchHandle{8} = line(axHandle, [xVector(x1Idx),xVector(x2Idx)], [yVector(y2Idx), yVector(y2Idx)], 'color', 'k', 'LineWidth', 2);

% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
axNb = 108;
axSel = handles.(['axes',num2str(axNb),'']);
freqs = handles.leftAlphaFreqs;
freqSel = get(hObject,'Value');
spectra = handles.leftAlphaSpectra;
titleTxt = handles.leftAlphaTitle;
sliderFn_topoplotter(axSel, freqs, freqSel, spectra, titleTxt)


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
axNb = 109;
axSel = handles.(['axes',num2str(axNb),'']);
freqs = handles.leftBetaFreqs;
freqSel = get(hObject,'Value');
spectra = handles.leftBetaSpectra;
titleTxt = handles.leftBetaTitle;
sliderFn_topoplotter(axSel, freqs, freqSel, spectra, titleTxt)

% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
axNb = 110;
axSel = handles.(['axes',num2str(axNb),'']);
freqs = handles.rightAlphaFreqs;
freqSel = get(hObject,'Value');
spectra = handles.rightAlphaSpectra;
titleTxt = handles.rightAlphaTitle;
sliderFn_topoplotter(axSel, freqs, freqSel, spectra, titleTxt)


function sliderFn_topoplotter(axSel, freqs, freqSel, spectra, titleTxt)
if isnan(freqs)
    warndlg('Enter numeric values for the band range!', 'Warning');
    return
end
topoplotter(axSel, freqs, freqSel, spectra, titleTxt);


% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider4_Callback(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
axNb = 111;
axSel = handles.(['axes',num2str(axNb),'']);
freqs = handles.rightBetaFreqs;
freqSel = get(hObject,'Value');
spectra = handles.rightBetaSpectra;
titleTxt = handles.rightBetaTitle;
sliderFn_topoplotter(axSel, freqs, freqSel, spectra, titleTxt)


% --- Executes during object creation, after setting all properties.
function slider4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider5_Callback(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
axNb = 112;
axSel = handles.(['axes',num2str(axNb),'']);
freqs = handles.footAlphaFreqs;
freqSel = get(hObject,'Value');
spectra = handles.footAlphaSpectra;
titleTxt = handles.footAlphaTitle;
sliderFn_topoplotter(axSel, freqs, freqSel, spectra, titleTxt)


% --- Executes during object creation, after setting all properties.
function slider5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider6_Callback(hObject, eventdata, handles)
% hObject    handle to slider6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
axNb = 113;
axSel = handles.(['axes',num2str(axNb),'']);
freqs = handles.footBetaFreqs;
freqSel = get(hObject,'Value');
spectra = handles.footBetaSpectra;
titleTxt = handles.footBetaTitle;
sliderFn_topoplotter(axSel, freqs, freqSel, spectra, titleTxt)


% --- Executes during object creation, after setting all properties.
function slider6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1
chkVal = get(hObject,'Value');
chkNb = 2:12;
handles = ckeckBoxOperation(handles, chkVal, chkNb, 'statist');
guidata(hObject, handles);


% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2
chkVal = get(hObject,'Value');
chkNb = [1, 3:12];
handles = ckeckBoxOperation(handles, chkVal, chkNb, 'statist_log');
guidata(hObject, handles);


function handles = ckeckBoxOperation(handles, chkVal, chkNb, featureName)
btnNb = [38, 40]; % enable classify and save

handles = clear_axes(handles, 1, [], 1, 1, 1);
if chkVal
    elementType = 'pushbutton';
    elementNb = btnNb;
    isOn = true;
    property = 'enable';
    elementOnOff(handles, elementType, elementNb, property, isOn);
    
    handles.Selected_Features{1,handles.Selected_Features_Counter} = featureName;
    handles.Selected_Features_Counter=handles.Selected_Features_Counter+1;
    switch featureName
        case {'statist_log', 'statist', 'BP_alpha_log','BP_alpha','BP_beta_log','BP_beta'}
            handles.featureDimension = handles.featureDimension + 3;
        case {'max_fft_amp_log', 'max_fft_amp'}
            handles.featureDimension = handles.featureDimension + 3*str2double(get(handles.edit6, 'string'));
        case {'max_fft_comp_log', 'max_fft_comp'}
            handles.featureDimension = handles.featureDimension + 3*str2double(get(handles.edit4, 'string'));
        case {'AR_Coeff_log', 'AR_Coeff'}
            handles.featureDimension = handles.featureDimension + 3*str2double(get(handles.edit9, 'string'));
    end
else
    if isAllCheckboxesFalse(handles, chkNb)
        elementType = 'pushbutton';
        elementNb = btnNb;
        isOn = false;
        property = 'enable';
        elementOnOff(handles, elementType, elementNb, property, isOn);
    end
    delIdx = ismember(handles.Selected_Features, featureName);
    handles.Selected_Features(delIdx) = [];
    handles.Selected_Features_Counter=handles.Selected_Features_Counter-1;
    switch featureName
        case {'statist_log', 'statist', 'BP_alpha_log','BP_alpha','BP_beta_log','BP_beta'}
            handles.featureDimension = handles.featureDimension - 3;
        case {'max_fft_amp_log', 'max_fft_amp'}
            handles.featureDimension = handles.featureDimension - 3*str2double(get(handles.edit6, 'string'));
        case {'max_fft_comp_log', 'max_fft_comp'}
            handles.featureDimension = handles.featureDimension - 3*str2double(get(handles.edit4, 'string'));
        case {'AR_Coeff_log', 'AR_Coeff'}
            handles.featureDimension = handles.featureDimension - 3*str2double(get(handles.edit9, 'string'));
    end
end
set(handles.text53,'string',num2str(handles.featureDimension))

% --- Executes on button press in checkbox3.
function checkbox3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox3
chkVal = get(hObject,'Value');
chkNb = [1:2, 4:12];
handles = ckeckBoxOperation(handles, chkVal, chkNb, 'max_fft_amp');
guidata(hObject, handles);


% --- Executes on button press in checkbox4.
function checkbox4_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox4
chkVal = get(hObject,'Value');
chkNb = [1:3, 5:12];
handles = ckeckBoxOperation(handles, chkVal, chkNb, 'max_fft_amp_log');
guidata(hObject, handles);


% --- Executes on button press in checkbox5.
function checkbox5_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox5
chkVal = get(hObject,'Value');
chkNb = [1:4, 6:12];
handles = ckeckBoxOperation(handles, chkVal, chkNb, 'max_fft_comp');
guidata(hObject, handles);


% --- Executes on button press in checkbox6.
function checkbox6_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox6
chkVal = get(hObject,'Value');
chkNb = [1:5, 7:12];
handles = ckeckBoxOperation(handles, chkVal, chkNb, 'max_fft_comp_log');
guidata(hObject, handles);


% --- Executes on button press in checkbox7.
function checkbox7_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox7
chkVal = get(hObject,'Value');
chkNb = [1:6, 8:12];
handles = ckeckBoxOperation(handles, chkVal, chkNb, 'AR_Coeff');
guidata(hObject, handles);


% --- Executes on button press in checkbox8.
function checkbox8_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox8
chkVal = get(hObject,'Value');
chkNb = [1:7, 9:12];
handles = ckeckBoxOperation(handles, chkVal, chkNb, 'AR_Coeff_log');
guidata(hObject, handles);


% --- Executes on button press in checkbox9.
function checkbox9_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox9
chkVal = get(hObject,'Value');
chkNb = [1:8, 10:12];
handles = ckeckBoxOperation(handles, chkVal, chkNb, 'BP_alpha');
guidata(hObject, handles);


% --- Executes on button press in checkbox10.
function checkbox10_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox10
chkVal = get(hObject,'Value');
chkNb = [1:9, 11:12];
handles = ckeckBoxOperation(handles, chkVal, chkNb, 'BP_alpha_log');
guidata(hObject, handles);


% --- Executes on button press in checkbox11.
function checkbox11_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox11
chkVal = get(hObject,'Value');
chkNb = [1:10, 12];
handles = ckeckBoxOperation(handles, chkVal, chkNb, 'BP_beta');
guidata(hObject, handles);


% --- Executes on button press in checkbox12.
function checkbox12_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox12
chkVal = get(hObject,'Value');
chkNb = 1:11;
handles = ckeckBoxOperation(handles, chkVal, chkNb, 'BP_beta_log');
guidata(hObject, handles);


function yes = isAllCheckboxesFalse(handles, chkNb)
for i = 1 : length(chkNb)
    if get(handles.(['checkbox',num2str(chkNb(i)),'']), 'Value')
        yes = false;
        return
    end
end
yes = true;
return



function edit47_Callback(hObject, eventdata, handles)
% hObject    handle to edit47 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit47 as text
%        str2double(get(hObject,'String')) returns contents of edit47 as a double
val = str2double(get(hObject,'String'));
if isNum(val) && val >= handles.erds.r{1,1}.f_plot(1) && val <= handles.erds.r{1,1}.f_plot(end)
handles.erds.timeFreqLim(4) = val;
handles = plot_roi_AllAxes(handles);

r = handles.erds.r;
timeSeries = cell(size(r, 1), size(r, 2));
sptr = cell(size(r, 1), size(r, 2));
for i = 1 : size(r, 1) % classes
    for j = 1 : size(r, 2) % channels
        [t, timeSeries{i, j}, f, sptr{i, j}] = timeFreqMarginal(r{i, j}.ERDS{1}.erds', r{i, j}.t_plot, r{i, j}.f_plot, handles.erds.timeFreqLim(1:2), handles.erds.timeFreqLim(3:4));
    end
end
for i = 1 : size(timeSeries, 2)
handles.erds.timeSeries{i} = horzcat(timeSeries{:, i});
handles.erds.sptr{i} = horzcat(sptr{:, i});
end
handles.erds.t = t;
handles.erds.f = f;
handles = plot_timeFreqMarginal(handles, handles.erds.t, handles.erds.timeSeries, handles.erds.f, handles.erds.sptr, handles.classTitle);

end
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function edit47_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit47 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
