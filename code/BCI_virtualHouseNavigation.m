function varargout = BCI_virtualHouseNavigation(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @BCI_virtualHouseNavigation_OpeningFcn, ...
    'gui_OutputFcn',  @BCI_virtualHouseNavigation_OutputFcn, ...
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
function BCI_virtualHouseNavigation_OpeningFcn(hObject, eventdata, handles, varargin)
toolboxPath = pwd;
addpath(genpath(toolboxPath))

handles.sharePath = fullfile(pwd, 'BCI-VR-share');
handles.stretch = 40; % check the value in apartment_Navigation_Client.m
plotNavigationRoute(handles);
barAxPrepare(handles.axes5, handles.stretch);

requiredTimeToShow = 10; % time interval to display on the GUI
axNbEEG = 2:4;
tMarker = [];
yLim = [-5*10^-5, 5*10^-5];
channelName = {'C4', 'C3', 'Cz'};
prepareAxes(handles, axNbEEG, tMarker, yLim, channelName, requiredTimeToShow);
handles.requiredTimeToShow = requiredTimeToShow;
handles.axNbEEG = axNbEEG;
handles.isRealEEG = 0;
handles.output = hObject;
guidata(hObject, handles);
function varargout = BCI_virtualHouseNavigation_OutputFcn(hObject, eventdata, handles)
varargout{1} = handles.output;
function edit1_Callback(hObject, eventdata, handles)
function edit1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edit2_Callback(hObject, eventdata, handles)
function edit2_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function pushbutton1_Callback(hObject, eventdata, handles)
guidata(hObject, handles);
function pushbutton2_Callback(hObject, eventdata, handles)
function pushbutton3_Callback(hObject, eventdata, handles)
set(handles.edit2,'string','')
set(handles.edit3,'string','')
set(handles.edit4,'string','')
set(handles.edit5,'string','')
set(handles.edit6,'string','')
set(handles.edit7,'string','')
set(handles.edit8,'string','')
set(handles.edit9,'string','')
set(handles.edit10,'string','')
set(handles.edit11,'string','')
set(handles.edit12,'string','')
set(handles.popupmenu1,'Value',1);
set(handles.popupmenu2,'Value',1);
set(handles.popupmenu3,'Value',1);
f1 = axes('units','normalized','position', [0.21 0 .575 1]);
subplot(f1);cla; axis off,title('')

function edit3_Callback(hObject, eventdata, handles)
handles.Remarks=get(handles.edit3,'string');
guidata(hObject, handles);
function edit3_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function pushbutton4_Callback(hObject, eventdata, handles)
isRealEEG = 0;

Fs = 256;  % sampling frequency

if isRealEEG
    % Share dir
    trnFeatPath = 'trainingFeatures.mat'; % Training feature
else % results of saved data
    trnFeatPath = fullfile(pwd, 'data', 'sample_trainingFeatures.mat');
    eegPath = fullfile(pwd, 'data', 'sample_trainingWithFeedback.mat');
    eeg = load(eegPath);
    Data = [eeg.Data(:,4*Fs:end,:), eeg.Data(:,4*Fs:end,:)]; % Concatenate if eeg lacked
end

features=load(trnFeatPath);
handles.signal_123_label=features.signal_123_label;
handles.BP=features.BP;
% handles.PS=features.PS;
handles.alpha_L=features.alpha_band(1); %B.alpha_L;
handles.alpha_H=features.alpha_band(2); %B.alpha_H;
handles.beta_L=features.beta_band(1); %B.beta_L;
handles.beta_H=features.beta_band(2); %B.beta_H;
% handles.AR=features.AR_Order;
% handles.Amp_comp=features.Amp_comp;
% handles.Freq_comp=features.Freq_comp;

clear features

    sharePath = fullfile(pwd, 'BCI-VR-share');
    handles.sharePath = sharePath;

if isRealEEG
else
    handles.Data = eeg.Data;
    
    handles.Subject_Name = eeg.Subject_Name;
% % %     set(handles.edit4,'string', handles.Subject_Name);
    
    handles.Gender = eeg.Gender;
% % %     switch eeg.Gender
% % %         case 'Male' % User selects Peaks.
% % %             set(handles.popupmenu1,'Value', 2);
% % %         case 'Female' % User selects Membrane.
% % %             set(handles.popupmenu1,'Value', 3);
% % %     end
    
    handles.Age = num2str(eeg.Age);
% % %     set(handles.edit5,'string', eeg.Age);
    
    handles.Session = eeg.Session;
% % %     set(handles.edit6,'string', eeg.Session);
    
    handles.Run= eeg.Run;
% % %     set(handles.edit7,'string', eeg.Run);
    
    handles.Date= eeg.Date;
% % %     set(handles.edit8,'string', eeg.Date);
    
    handles.Remarks= eeg.Remarks;
% % %     set(handles.edit3,'string', eeg.Remarks);
    
    chNb = size(eeg.Data, 1);
    end

listing = dir(sharePath);
for i = 1 : length(listing)
    if isfile(fullfile(listing(i).folder,listing(i).name))
    delete(fullfile(listing(i).folder,listing(i).name))
    end
end
TrialEndPath = fullfile(sharePath, 'TrialEnd.mat');
TrialPath = fullfile(sharePath, 'Trial.mat');
selectedClassPath = fullfile(sharePath, 'selectedClass.mat');

PausePeriod = .1;   % loop pause interval (necessary for streaming display)
P = 1/Fs;
requiredSamples = Fs * 10*60; % current epoch window
updateSamples = round(Fs * PausePeriod); % incoming data block
newData = zeros(3,requiredSamples); % initialize data structures (array dim is channel x sample)
requiredTimeToShow = handles.requiredTimeToShow;
requiredSamplesToShow = Fs * requiredTimeToShow; % current epoch window
t = -requiredTimeToShow+P:P:0;
eegHandle = cell(1, 3); % eeg channels plot handle

axNbEEG = handles.axNbEEG;
t1=tic;k_class=1;
StartStation=handles.StartStation;
save(fullfile(handles.sharePath,'StartStation'),'StartStation');
classifierConfusion = zeros(3);
decisionConfusion = zeros(3);

if isRealEEG
    while (toc(t1) <= requiredSamples/Fs && ~exist(TrialEndPath, 'file'))
        pause(.1);
            warndlg('EEG device-specific code (SDK) for real-time EEG buffering should be implemented here.')
        if exist(TrialPath, 'file')
            FFT=abs(fft(newData(:,end-3*Fs+1:end)'));
            SORT_FFT=sort(FFT(1:length(FFT)/2,:));
            max_fft_amp=log(reshape(SORT_FFT(end-handles.Amp_comp+1:end,:),size(SORT_FFT(end-handles.Amp_comp+1:end,:),1)*size(SORT_FFT(end-handles.Amp_comp+1:end,:),2),1));
            for i_m=1:handles.Freq_comp
                for i_m_j=1:3
                    max_fft(i_m,i_m_j)=min(find(FFT(:,i_m_j)==SORT_FFT(end-i_m+1,i_m_j)));
                end
            end
            max_fft_comp=log(reshape(max_fft,size(max_fft,1)*size(max_fft,2),1));
            BP_new = mapminmax('apply',[max_fft_amp' max_fft_comp']',handles.PS);
            [C(1,k_class),err,P,logp,coeff] = classify(BP_new',handles.BP,handles.signal_123_label');
            save(fullfile(handles.sharePath,['Class',num2str(k_class),'']),'C');
            k_class=k_class+1; % Added
        end
        save(fullfile(handles.sharePath,'k_class'),'k_class');
    end
    warndlg('EEG device-specific code (SDK) for closing the real-time EEG streaming should be implemented here.')
else % --------------
    DataPointer = 1; % 3-4.25: cue. Sample pointer in Data to simulate EEG streaming
    pauseOffset = -0.05;%0.05;
    while (toc(t1) <= requiredSamples/Fs && ~exist(TrialEndPath, 'file'))
        BinCounts = zeros(1, 3);
        while exist(TrialPath, 'file') % start of feature extraction and classification. saved from VR workstation.
pause(PausePeriod); % -0.4
try % if TrialPath deletes after the above line
                [trialNb, targetClass] = trialSelector(TrialPath, handles.StartStation, handles.EndStation);
                catch
                disp('Error handled! TrialPath has been deleted in the meantime.')
                break
            end
                try
                    temp = Data(:, DataPointer:DataPointer+updateSamples-1, trialNb);
                    newData = [newData(:,updateSamples+1:requiredSamples) temp];
                    DataPointer = DataPointer + updateSamples; % update
                catch % to read the last block of data that is smaller than the previous ones
                    temp = Data(:, DataPointer:end, trialNb);
                    newData = [newData(:,size(temp, 2)+1:requiredSamples) temp];
                    disp('Error handled!')
                end
                for i = 1 : length(axNbEEG)
                eegHandle{i} = plotEEG(eegHandle{i}, handles.(['axes',num2str(axNbEEG(i)),'']), t, newData(i, end-requiredSamplesToShow+1:end), 'b');
                end
                                columnSignal = newData(:,end-3*Fs+1:end)';
                BP_alpha = band_power(Fs, columnSignal, [handles.alpha_L, handles.alpha_H]);
                BP_beta = band_power(Fs, columnSignal, [handles.beta_L, handles.beta_H]);
                
                BP_new = [BP_alpha, BP_beta]';
                C(1,k_class)= classify(BP_new',handles.BP,handles.signal_123_label');
                BinCounts(C(1,k_class)) = BinCounts(C(1,k_class)) + 1;
                classifierConfusion(targetClass, C(1,k_class)) = classifierConfusion(targetClass, C(1,k_class)) + 1;
                save(fullfile(handles.sharePath,['Class',num2str(k_class),'']),'C');
                k_class=k_class+1; % Added
                save(fullfile(handles.sharePath,'k_class'),'k_class');
bar(handles.axes5, 1,BinCounts(1),'b')
bar(handles.axes5, 2,BinCounts(3),'g')
bar(handles.axes5, 3,BinCounts(2),'y')
                drawnow
        end
        barAxPrepare(handles.axes5, handles.stretch);
        
        temp = zeros(chNb, updateSamples);
        newData = [newData(:,updateSamples+1:requiredSamples) temp];
for i = 1 : length(axNbEEG)
                eegHandle{i} = plotEEG(eegHandle{i}, handles.(['axes',num2str(axNbEEG(i)),'']), t, newData(i, end-requiredSamplesToShow+1:end), 'b');
                end
        DataPointer = 1; % 3-4.25: cue. Sample pointer in Data to simulate EEG streaming
        if exist(selectedClassPath, 'file')
        load(selectedClassPath)
        decisionConfusion(targetClass, selectedClass) = decisionConfusion(targetClass, selectedClass) + 1;
        end
        pause(PausePeriod-pauseOffset);
    end
end
handles.newData = newData;
%% plot subject route
Bird_Viewpoint=imread('Bird_Viewpoint.bmp');
Subject_Route=load('Subject_Route.mat');
Subject_Route=Subject_Route.Subject_Route;
axes(handles.axes1)
imshow(Bird_Viewpoint);
hold on
Station_coordination=[
    14.0000  233.0000
    114.0000  324.0000
    113.0000  142.0000
    346.0000  228.0000
    397.0000  282.0000
    304.0000  303.0000
    364.0000  386.0000
    298.0000  349.0000
    505.0000  259.0000
    431.0000  215.0000
    446.0000  166.0000
    407.0000  101.0000
    278.0000  164.0000
    334.0000  105.0000
    511.0000  168.0000
    681.0000  163.0000
    527.0000   64.0000
    595.0000   93.0000
    741.0000  209.0000
    836.0000  228.0000
    751.0000  109.0000
    815.0000  102.0000
    459.0000  260.0000];
plot(Station_coordination(Subject_Route,1),Station_coordination(Subject_Route,2),'p',...
    'MarkerEdgeColor','k',...
    'MarkerFaceColor','b',...
    'MarkerSize',8)
Station_coordination= [Station_coordination;[
    457.0000  197.0000
    499.0000  198.0000
    158.0000  224.0000]];%1 to 22 is old(23:bedFalse;24:bedDoor;25:WCDoor;26:InputDoorExterior)
for i=1:length(Subject_Route)-1
    if sum([Subject_Route(i) Subject_Route(i+1)]==[2 4])==2 | sum([Subject_Route(i) Subject_Route(i+1)]==[3 4])==2
        Subject_Route=[Subject_Route(1,1:i) 26 Subject_Route(1,i+1:end)];
    end
end
for i=1:length(Subject_Route)-1
    if sum([Subject_Route(i) Subject_Route(i+1)]==[10 11])==2 | sum([Subject_Route(i) Subject_Route(i+1)]==[9 11])==2 | sum([Subject_Route(i) Subject_Route(i+1)]==[19 11])==2
        Subject_Route=[Subject_Route(1,1:i) 24 Subject_Route(1,i+1:end)];
    end
end
for i=1:length(Subject_Route)-1
    if sum([Subject_Route(i) Subject_Route(i+1)]==[10 15])==2 | sum([Subject_Route(i) Subject_Route(i+1)]==[23 15])==2 | sum([Subject_Route(i) Subject_Route(i+1)]==[19 15])==2
        Subject_Route=[Subject_Route(1,1:i) 25 Subject_Route(1,i+1:end)];
    end
end
plot(Station_coordination(Subject_Route,1),Station_coordination(Subject_Route,2),'k-.','LineWidth',2)
plot(Station_coordination(handles.StartStation,1),Station_coordination(handles.StartStation,2),'p',...
    'MarkerEdgeColor','k',...
    'MarkerFaceColor','r',...
    'MarkerSize',15)
plot(Station_coordination(handles.EndStation,1),Station_coordination(handles.EndStation,2),'p',...
    'MarkerEdgeColor','k',...
    'MarkerFaceColor','r',...
    'MarkerSize',15)
%%
classificationReportDecision = cell(4);
[precision, recall, f1] = precisionRecallF1_confusion(decisionConfusion);
Acc = sum(diag(decisionConfusion)) / (sum(decisionConfusion(:)));

for i = 1 : length(precision)
    classificationReportDecision{i, 1} = num2str(round(precision(i), 2));
    classificationReportDecision{i, 2} = num2str(round(recall(i), 2));
    classificationReportDecision{i, 3} = num2str(round(f1(i), 2));
end
classificationReportDecision{4, 4} = num2str(round(Acc, 2));

classificationReportClassifier = cell(4);
[precision, recall, f1] = precisionRecallF1_confusion(classifierConfusion);
Acc = sum(diag(classifierConfusion)) / (sum(classifierConfusion(:)));

for i = 1 : length(precision)
    classificationReportClassifier{i, 1} = num2str(round(precision(i), 2));
    classificationReportClassifier{i, 2} = num2str(round(recall(i), 2));
    classificationReportClassifier{i, 3} = num2str(round(f1(i), 2));
end
classificationReportClassifier{4, 4} = num2str(round(Acc, 2));

classificationReportClassifierDecision = cell(4);
for i = 1 : size(classificationReportClassifierDecision, 1)
    for j = 1 : size(classificationReportClassifierDecision, 2)
        if ~isempty(classificationReportClassifier{i, j})
    classificationReportClassifierDecision{i, j} = [classificationReportClassifier{i, j}, ' - ', classificationReportDecision{i, j}];
        end
end
end

% change LRF to LFR
tmp = classificationReportClassifierDecision(2, :);
classificationReportClassifierDecision(2, :) = classificationReportClassifierDecision(3, :);
classificationReportClassifierDecision(3, :) = tmp;
set(handles.uitable2,'data',classificationReportClassifierDecision)
%% save
Age=str2num(handles.Age);
Gender=handles.Gender;
Subject_Name=handles.Subject_Name;
Remarks=handles.Remarks;
Run=handles.Run;
Session=handles.Session;
Date=handles.Date;
alpha_L=handles.alpha_L;
alpha_H=handles.alpha_H;
beta_L=handles.beta_L;
beta_H=handles.beta_H;
StartStation=handles.StartStation;
EndStation=handles.EndStation;
Data = handles.newData;
load('Navigation_Time.mat');
features=load(trnFeatPath);
savePath = fullfile(pwd, 'data', ['',Subject_Name,'_Apartment_',Date,'_s',Session,'_r',Run,'.mat']);
save(savePath, 'Age','Gender','Subject_Name','Remarks','Run','Session','Date','Data', ... ,'cue_type'
    'classificationReportClassifierDecision', 'Acc', 'features')% , 'Kappa' 'matrixC', 'handles_C', 
clc
guidata(hObject, handles);
function edit4_Callback(hObject, eventdata, handles)
handles.Subject_Name=get(handles.edit4,'string');
guidata(hObject, handles);
function edit4_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edit5_Callback(hObject, eventdata, handles)
handles.Age=num2str(get(handles.edit5,'string'));
guidata(hObject, handles);
function edit5_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edit6_Callback(hObject, eventdata, handles)
handles.Session=get(handles.edit6,'string');
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
function edit8_Callback(hObject, eventdata, handles)
handles.Date=get(handles.edit8,'string');
guidata(hObject, handles);
function edit8_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function popupmenu1_Callback(hObject, eventdata, handles)
str = get(hObject, 'String');
val = get(hObject,'Value');
switch str{val};
    case 'Male' % User selects Peaks.
        handles.Gender = 'Male';
    case 'Female' % User selects Membrane.
        handles.Gender = 'Female';
end
guidata(hObject, handles);
function popupmenu1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edit9_Callback(hObject, eventdata, handles)
function edit9_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edit10_Callback(hObject, eventdata, handles)
function edit10_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edit11_Callback(hObject, eventdata, handles)
function edit11_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edit12_Callback(hObject, eventdata, handles)
function edit12_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function figure1_CreateFcn(hObject, eventdata, handles)
function pushbutton5_Callback(hObject, eventdata, handles)
HouseTour=1;
save(fullfile(handles.sharePath,'HouseTour'),'HouseTour');


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
guidata(hObject, handles);

function pushbutton7_Callback(hObject, eventdata, handles)

function plotNavigationRoute(handles)
Bird_Viewpoint=imread('Bird_Viewpoint.bmp');
axes(handles.axes1) % was kept for imshow
cla(handles.axes1)
imshow(Bird_Viewpoint);
hold(handles.axes1, 'on')
Station_coordination=[
    14.0000  233.0000
    114.0000  324.0000
    113.0000  142.0000
    346.0000  228.0000
    397.0000  282.0000
    304.0000  303.0000
    364.0000  386.0000
    298.0000  349.0000
    505.0000  259.0000
    431.0000  215.0000
    446.0000  166.0000
    407.0000  101.0000
    278.0000  164.0000
    334.0000  105.0000
    511.0000  168.0000
    681.0000  163.0000
    527.0000   64.0000
    595.0000   93.0000
    741.0000  209.0000
    836.0000  228.0000
    751.0000  109.0000
    815.0000  102.0000];
plot(handles.axes1, Station_coordination(:,1),Station_coordination(:,2),'p',...
    'MarkerEdgeColor','k',...
    'MarkerFaceColor','b',...
    'MarkerSize',8)
if isfield(handles, 'StartStation') && ~isnan(handles.StartStation)
    plot(handles.axes1, Station_coordination(handles.StartStation,1),Station_coordination(handles.StartStation,2),'p',...
        'MarkerEdgeColor','k',...
        'MarkerFaceColor','r',...
        'MarkerSize',15)
end
if isfield(handles, 'EndStation') && ~isnan(handles.EndStation)
    plot(handles.axes1, Station_coordination(handles.EndStation,1),Station_coordination(handles.EndStation,2),'p',...
        'MarkerEdgeColor','k',...
        'MarkerFaceColor','r',...
        'MarkerSize',15)
end
function popupmenu2_Callback(hObject, eventdata, handles)
str = get(hObject, 'String');
val = get(hObject,'Value');
if ~handles.isRealEEG
    if ~strcmp(str{val}, 'Out-Front')
        warndlg('In the simulated streaming scenario, the only valid option to select is ''Out-Front''. Please choose ''Out-Front''.')
    end
    end
switch str{val};
    case 'Out-Front' % User selects Peaks.
        handles.StartStation = 1;
    case 'Out-Right' % User selects Membrane.
        handles.StartStation = 2;
    case 'Out-Left' % User selects Membrane.
        handles.StartStation = 3;
    case 'Input-Door' % User selects Membrane.
        handles.StartStation = 4;
    case 'Kitchen' % User selects Membrane.
        handles.StartStation = 5;
    case 'Kitchen-Right' % User selects Membrane.
        handles.StartStation = 6;
    case 'Kitchen-Left' % User selects Membrane.
        handles.StartStation = 7;
    case 'Kitchen-Front' % User selects Membrane.
        handles.StartStation = 8;
    case 'Dining-Table' % User selects Membrane.
        handles.StartStation =9;
    case 'Bed-Bath_Door' % User selects Membrane.
        handles.StartStation = 10;
    case 'Bedroom' % User selects Membrane.
        handles.StartStation = 11;
    case 'Bedroom-Right' % User selects Membrane.
        handles.StartStation = 12;
    case 'Bedroom-Left' % User selects Membrane.
        handles.StartStation = 13;
    case 'Bedroom-Front' % User selects Membrane.
        handles.StartStation = 14;
    case 'WC-Bathroom' % User selects Membrane.
        handles.StartStation =15;
    case 'WC-Bathroom-Right' % User selects Membrane.
        handles.StartStation = 16';
    case 'WC-Bathroom-Left' % User selects Membrane.
        handles.StartStation = 17;
    case 'WC-Bathroom-Front' % User selects Membrane.
        handles.StartStation = 18;
    case 'Salon' % User selects Membrane.
        handles.StartStation = 19;
    case 'Salon-Right' % User selects Membrane.
        handles.StartStation = 20;
    case 'Salon-Left' % User selects Membrane.
        handles.StartStation =21;
    case 'Salon-Front' % User selects Membrane.
        handles.StartStation = 22;
    otherwise
        handles.StartStation = nan;
        set(handles.pushbutton4, 'enable', 'off')
end
if ~isnan(handles.StartStation)
    set(handles.pushbutton4, 'enable', 'on')
end
plotNavigationRoute(handles)
guidata(hObject, handles);
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
str = get(hObject, 'String');
val = get(hObject,'Value');
if ~handles.isRealEEG
    if ~any(ismember(str{val}, {'Kitchen-Front', 'Bedroom-Right', 'WC-Bathroom-Left', 'Salon-Left'}))
        warndlg('In the simulated streaming scenario, the only valid option to select is ''Kitchen-Front''. Please choose ''Kitchen-Front''.')
    end
    end
switch str{val};
    case 'Out-Front' % User selects Peaks.
        handles.EndStation = 1;
    case 'Out-Right' % User selects Membrane.
        handles.EndStation = 2;
    case 'Out-Left' % User selects Membrane.
        handles.EndStation = 3;
    case 'Input-Door' % User selects Membrane.
        handles.EndStation = 4;
    case 'Kitchen' % User selects Membrane.
        handles.EndStation = 5;
    case 'Kitchen-Right' % User selects Membrane.
        handles.EndStation = 6;
    case 'Kitchen-Left' % User selects Membrane.
        handles.EndStation = 7;
    case 'Kitchen-Front' % User selects Membrane.
        handles.EndStation = 8;
    case 'Dining-Table' % User selects Membrane.
        handles.EndStation =9;
    case 'Bed-Bath_Door' % User selects Membrane.
        handles.EndStation = 10;
    case 'Bedroom' % User selects Membrane.
        handles.EndStation = 11;
    case 'Bedroom-Right' % User selects Membrane.  Kitchen-Front 'Bedroom-Right'
        handles.EndStation = 12;
    case 'Bedroom-Left' % User selects Membrane.
        handles.EndStation = 13;
    case 'Bedroom-Front' % User selects Membrane.
        handles.EndStation = 14;
    case 'WC-Bathroom' % User selects Membrane.
        handles.EndStation =15;
    case 'WC-Bathroom-Right' % User selects Membrane.
        handles.EndStation = 16';
    case 'WC-Bathroom-Left' % User selects Membrane. 
        handles.EndStation = 17;
    case 'WC-Bathroom-Front' % User selects Membrane.
        handles.EndStation = 18;
    case 'Salon' % User selects Membrane.
        handles.EndStation = 19;
    case 'Salon-Right' % User selects Membrane.
        handles.EndStation = 20;  
    case 'Salon-Left' % User selects Membrane.
        handles.EndStation =21;
    case 'Salon-Front' % User selects Membrane.
        handles.EndStation = 22;
    otherwise
        handles.EndStation = nan;
        set(handles.pushbutton4, 'enable', 'off')
end
if ~isnan(handles.EndStation)
    set(handles.pushbutton4, 'enable', 'on')
end
plotNavigationRoute(handles)
guidata(hObject, handles);
function popupmenu3_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
HouseTourSubject=1;
save(fullfile(handles.sharePath,'HouseTourSubject'),'HouseTourSubject');


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
C=ones(1,20);
save(fullfile(handles.sharePath,'Class'),'C');
pause(2)
delete(fullfile(handles.sharePath,'Class.mat'));
% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
C=2*ones(1,20);
save(fullfile(handles.sharePath,'Class'),'C');
pause(2)
delete(fullfile(handles.sharePath,'Class.mat'));

% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
C=3*ones(1,20);
save(fullfile(handles.sharePath,'Class'),'C');
pause(2)
delete(fullfile(handles.sharePath,'Class.mat'));
