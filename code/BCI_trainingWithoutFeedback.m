function varargout = BCI_trainingWithoutFeedback(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @BCI_trainingWithoutFeedback_OpeningFcn, ...
    'gui_OutputFcn',  @BCI_trainingWithoutFeedback_OutputFcn, ...
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

function BCI_trainingWithoutFeedback_OpeningFcn(hObject, eventdata, handles, varargin)
% set(handles.edit1,'string','sub1')
% set(handles.edit2,'string','-')
% set(handles.edit10,'string','s1')
% set(handles.edit7,'string','r1')
% set(handles.edit9,'string','dd_mm_yy')
% set(handles.edit6,'string','-')
% set(handles.popupmenu2,'Value', 2);

handles.toolboxPath = pwd;
addpath(genpath(handles.toolboxPath))

requiredTime = 10; % time interval to display on the GUI
axNbEEG = 6:8;
tMarker = -[2, 3, 4.25, 7];
yLim = [-5*10^-5, 5*10^-5];
channelName = {'C4', 'C3', 'Cz'};  
prepareAxes(handles, axNbEEG, tMarker, yLim, channelName, requiredTime);

handles.axNbEEG = axNbEEG;
handles.requiredTime = requiredTime;

handles.output = hObject;
guidata(hObject, handles);
function varargout = BCI_trainingWithoutFeedback_OutputFcn(hObject, eventdata, handles)
varargout{1} = handles.output;
function edit1_Callback(hObject, eventdata, handles)
handles.Subject_Name=get(handles.edit1,'string');
guidata(hObject, handles);
function edit1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edit2_Callback(hObject, eventdata, handles)
handles.Age=num2str(get(handles.edit2,'string'));
guidata(hObject, handles);
function edit2_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function popupmenu2_Callback(hObject, eventdata, handles)
str = get(hObject, 'String');
val = get(hObject,'Value');
switch str{val};
    case 'Male' % User selects Peaks.
        handles.Gender = 'Male';
    case 'Female' % User selects Membrane.
        handles.Gender = 'Female';
end
guidata(hObject, handles);
function popupmenu2_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function pushbutton1_Callback(hObject, eventdata, handles)
% Age=str2num(handles.Age);
% Gender=handles.Gender;
% Subject_Name=handles.Subject_Name;
% Remarks=handles.Remarks;
% Run=handles.Run;
% Session=handles.Session;
% Date=handles.Date;
% cue_type=handles.cue_type;
% Data=handles.Data;
% % time_2=handles.time_2;
% % time_3=handles.time_3;
% % time_425=handles.time_425;
% % time_7=handles.time_7;
% address=pwd;
% eval(['save(''',address,'\',Subject_Name,'_WOF_',Date,'_s',Session,'_r',Run,''',''Age'',''Gender'',''Subject_Name'',''Remarks'',''Run'',''Session'',''Date'',''cue_type'',''Data'')'])
function edit6_Callback(hObject, eventdata, handles)
handles.Remarks=get(handles.edit6,'string');
guidata(hObject, handles);
function edit6_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edit7_Callback(hObject, eventdata, handles)
handles.Run=get(handles.edit7,'string');
guidata(hObject, handles);
function edit7_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edit9_Callback(hObject, eventdata, handles)
handles.Date=get(handles.edit9,'string');
guidata(hObject, handles);
function edit9_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edit10_Callback(hObject, eventdata, handles)
handles.Session=get(handles.edit10,'string');
guidata(hObject, handles);
function edit10_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function pushbutton3_Callback(hObject, eventdata, handles)
set(handles.edit1,'string','')
set(handles.edit2,'string','')
set(handles.edit6,'string','')
set(handles.edit7,'string','')
set(handles.edit9,'string','')
set(handles.edit10,'string','')
set(handles.popupmenu2,'Value',1);
subplot(6,6,8:11);cla; axis off,title('')
subplot(6,6,20:23);cla; axis off,title('')
subplot(5,6,26:29);cla; axis off,title('')
function pushbutton4_Callback(hObject, eventdata, handles)
isTest = 0;
isRealEEG = 0;
if isRealEEG
    matPath = fullfile(pwd, 'BCI-VR-share', 'cue_type.mat');
else
    matPath = fullfile(pwd, 'data', 'sample_trainingWitoutFeedback.mat');
end

load(matPath);
handles.cue_type=cue_type;

if isTest
    trialsNb = 12;
else
    trialsNb = length(handles.cue_type);
end

Trial_TrigFileName = 'Trial_Trig.mat';
Trial_7FileName = 'Trial_7.mat';

sharePath = fullfile(pwd, 'BCI-VR-share');
if isRealEEG    
    chNb = 3;    
else
    handles.Data = Data;
    
    handles.Subject_Name = Subject_Name;
% % %     set(handles.edit1,'string', handles.Subject_Name);
    
    handles.Gender = Gender;
% % %     switch Gender
% % %         case 'Male' % User selects Peaks.
% % %             set(handles.popupmenu2,'Value', 2);
% % %         case 'Female' % User selects Membrane.
% % %             set(handles.popupmenu2,'Value', 3);
% % %     end
    
    handles.Age = num2str(Age);
% % %     set(handles.edit2,'string', Age);
    
    handles.Session = Session;
% % %     set(handles.edit10,'string', Session);
    
    handles.Run= Run;
% % %     set(handles.edit7,'string', Run);
    
    handles.Date= Date;
% % %     set(handles.edit9,'string', Date);
    
    handles.Remarks= Remarks;
% % %     set(handles.edit6,'string', Remarks);
    
    chNb = size(Data, 1);
        
    Trial_3FileName = 'Trial_3.mat';
    Trial_425FileName = 'Trial_425.mat';
    Trial_3Path = fullfile(sharePath, Trial_3FileName);
    Trial_425Path = fullfile(sharePath, Trial_425FileName);
end

listing = dir(sharePath);
for i = 1 : length(listing)
    if isfile(fullfile(listing(i).folder,listing(i).name))
    delete(fullfile(listing(i).folder,listing(i).name))
    end
end

Trial_TrigPath = fullfile(sharePath, Trial_TrigFileName);
Trial_7Path = fullfile(sharePath, Trial_7FileName);

PausePeriod = .10;%1/Fs;%0.25;   % loop pause interval (necessary for streaming display)
Fs = 256;  % sampling frequency
P = 1/Fs;
requiredTime = handles.requiredTime;
requiredSamples = Fs * requiredTime; % current epoch window
updateSamples = round(Fs * PausePeriod); % incoming data block
t = -requiredTime+P:P:0;
eegHandle = cell(1, 3); % eeg channels plot handle
axNbEEG = handles.axNbEEG;

for n=1:trialsNb
set(handles.edit6,'string', ['',num2str(n),'/',num2str(trialsNb),'']);
    newData = zeros(chNb,requiredSamples); % for visualisation    
    if isRealEEG
        save(Trial_TrigPath,'n');%indicating start of a trial
        t1=tic;m=0;
        while (toc(t1) <= 7)
            pause(PausePeriod);
            warndlg('EEG device-specific code (SDK) for real-time EEG buffering should be implemented here.') 
            PlotData_new;
            if toc(t1)>=2 && m==0
                beep;m=1;
            end
        end
        save(Trial_7Path,'n');%indicating 7th sec of the trial
        handles.Data(:,:,n)=newData(:,requiredSamples-7*Fs+1:requiredSamples);
        
        inter_trial=2+rand(1);
        while toc(t1)<=7+inter_trial
            pause(PausePeriod);
            warndlg('EEG device-specific code (SDK) for real-time EEG buffering should be implemented here.')            
            PlotData_new_red;
        end
        
    else % ---------------------------
        save(Trial_TrigPath,'n');%indicating start of a trial
        m=0; is3=0;is425=0;
        DataPointer = 1; % Sample pointer in Data to simulate EEG streaming
        pauseOffset = 0.05;
        while DataPointer <= size(Data, 2)
            pause(PausePeriod-pauseOffset); % It has to be PausePeriod, but because of system speed we changed it manually. Change the offset, if there is error
            try
                temp = Data(:, DataPointer:DataPointer+updateSamples-1, n);
                newData = [newData(:,updateSamples+1:requiredSamples) temp];
                DataPointer = DataPointer + updateSamples; % update
                for i = 1 : length(axNbEEG)
                    eegHandle{i} = plotEEG(eegHandle{i}, handles.(['axes',num2str(axNbEEG(i)),'']), t, newData(i, :), 'b');
                end
            catch % to read the last block of data that is smaller than the previous ones
                temp = Data(:, DataPointer:end, n);
                newData = [newData(:,size(temp, 2)+1:requiredSamples) temp];
                for i = 1 : length(axNbEEG)
                    eegHandle{i} = plotEEG(eegHandle{i}, handles.(['axes',num2str(axNbEEG(i)),'']), t, newData(i, :), 'b');
                end
                break
            end
            zeroIdx = find(newData(1,:) == 0);

            lastZeroIdx = find(diff(zeroIdx) ~= 1, 1, 'first');
            if isempty(lastZeroIdx)
                lastZeroIdx = zeroIdx(end);
            end
            if  lastZeroIdx < (requiredTime-2) * Fs && m==0
                beep;m=1;
            end
            if  lastZeroIdx < (requiredTime-3) * Fs && is3==0
                save(Trial_3Path,'n');%indicating second 3
                is3=1;
            end
            if  lastZeroIdx < (requiredTime-4.25) * Fs && is425==0
                save(Trial_425Path,'n');%indicating second 4.25
                is425=1;
            end
        end
        save(Trial_7Path,'n');%indicating 7th sec of the trial
        
        DataPointer = 1; % Reset for t>7 because Data is not saved for t>7 and we reread from the beginning
        inter_trial= round((2+rand(1))*Fs);
        Data2 = Data(:, 1:inter_trial, n); % Select inter_trial samples
        while DataPointer+updateSamples-1 <= size(Data2, 2)
            pause(PausePeriod-pauseOffset);
temp = zeros(3, updateSamples);
            newData = [newData(:,updateSamples+1:requiredSamples) temp];
            DataPointer = DataPointer + updateSamples; % update
            for i = 1 : length(axNbEEG)
                eegHandle{i} = plotEEG(eegHandle{i}, handles.(['axes',num2str(axNbEEG(i)),'']), t, newData(i, :), 'b');
            end
        end
    end
end
if isRealEEG
    warndlg('EEG device-specific code (SDK) for closing the real-time EEG streaming should be implemented here.')
end
clc

for i = 1 : length(axNbEEG)
    cla(handles.(['axes',num2str(axNbEEG(i)),'']))
end

%% save
Age=str2num(handles.Age);
Gender=handles.Gender;
Subject_Name=handles.Subject_Name;
Remarks=handles.Remarks;
Run=handles.Run;
Session=handles.Session;
Date=handles.Date;
cue_type=handles.cue_type;
Data=handles.Data;
savePath = fullfile(pwd, 'data', ['',Subject_Name,'_WOF_',Date,'_s',Session,'_r',Run,'.mat']);
save(savePath, 'Age','Gender','Subject_Name','Remarks','Run','Session','Date','cue_type','Data')

guidata(hObject, handles);
function figure1_CreateFcn(hObject, eventdata, handles)
function figure1_DeleteFcn(hObject, eventdata, handles)
function uipanel5_CreateFcn(hObject, eventdata, handles)
