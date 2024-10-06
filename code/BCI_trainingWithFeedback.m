function varargout = BCI_trainingWithFeedback(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @BCI_trainingWithFeedback_OpeningFcn, ...
    'gui_OutputFcn',  @BCI_trainingWithFeedback_OutputFcn, ...
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

function BCI_trainingWithFeedback_OpeningFcn(hObject, eventdata, handles, varargin)
% % % set(handles.edit1,'string','sub1')
% % % set(handles.edit3,'string','-')
% % % set(handles.edit4,'string','1')
% % % set(handles.edit6,'string','dd_mm_yy')
% set(handles.popupmenu1,'string', 'Female');
% set(handles.popupmenu1,3);
handles.toolboxPath = pwd;
addpath(genpath(handles.toolboxPath))

barAxPrepare(handles.axes1, []);
requiredTime = 13; % time interval to display on the GUI
axNbEEG = 4:6;
tMarker = -[2, 3, 4.25, 7, 10];
yLim = [-5*10^-5, 5*10^-5];
channelName = {'C4', 'C3', 'Cz'};
prepareAxes(handles, axNbEEG, tMarker, yLim, channelName, requiredTime);

handles.axNbEEG = axNbEEG;
handles.requiredTime = requiredTime;

set(handles.figure1,'Units', 'pixels');
guiPosition = get(hObject, 'Position');
set(handles.figure1,'Position', [guiPosition(1)+160, guiPosition(2), guiPosition(3), guiPosition(4)]);

handles.output = hObject;
guidata(hObject, handles);
function varargout = BCI_trainingWithFeedback_OutputFcn(hObject, eventdata, handles)
varargout{1} = handles.output;
function pushbutton1_Callback(hObject, eventdata, handles)
isTest = 0;

isRealEEG = 0;

if isRealEEG
    % Share dir
    trnFeatPath = 'Training_features_Fardin.mat'; % Training feature
else % results of saved data
    trnFeatPath = fullfile(pwd, 'data', 'sample_trainingFeatures.mat');
    eegPath = fullfile(pwd, 'data', 'sample_trainingWithFeedback.mat');
    eeg = load(eegPath);
end

features=load(trnFeatPath);
handles.signal_123_label=features.signal_123_label;
handles.BP=features.BP;
handles.alpha_L=features.alpha_band(1);
handles.alpha_H=features.alpha_band(2);
handles.beta_L=features.beta_band(1);
handles.beta_H=features.beta_band(2);
% handles.AR=features.AR_Order;
% handles.Amp_comp=features.Amp_comp;
% handles.Freq_comp=features.Freq_comp;
% handles.PS=features.PS;

if isRealEEG
    addpath(fullfile(pwd, 'BCI-VR-share'))
    load cue_type
    delete(fullfile(pwd, 'BCI-VR-share', 'cue_type.mat'))
else
    cue_type = eeg.cue_type;
end

if isTest
    trialsNb = 12;
else
    trialsNb = length(cue_type);
end

Trial_TrigFileName = 'Trial_Trig.mat';
Trial_10FileName = 'Trial_10.mat';

clear features
sharePath = fullfile(pwd, 'BCI-VR-share');
handles.sharePath = sharePath;
if isRealEEG
    chNb = 3;
else
    handles.Data = eeg.Data;
    
    handles.Subject_Name = eeg.Subject_Name;
    % % %     set(handles.edit1,'string', handles.Subject_Name);
    
    handles.Gender = eeg.Gender;
    % % %     switch eeg.Gender
    % % %         case 'Male' % User selects Peaks.
    % % %             set(handles.popupmenu1,'Value', 2);
    % % %         case 'Female' % User selects Membrane.
    % % %             set(handles.popupmenu1,'Value', 3);
    % % %     end
    
    handles.Age = num2str(eeg.Age);
    % % %     set(handles.edit3,'string', eeg.Age);
    
    handles.Session = eeg.Session;
    % % %     set(handles.edit4,'string', eeg.Session);
    
    handles.Run= eeg.Run;
    % % %     set(handles.edit5,'string', eeg.Run);
    
    handles.Date= eeg.Date;
    % % %     set(handles.edit6,'string', eeg.Date);
    
    handles.Remarks= eeg.Remarks;
    % % %     set(handles.edit13,'string', eeg.Remarks);
    
    chNb = size(eeg.Data, 1);
    
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
Trial_10Path = fullfile(sharePath, Trial_10FileName);

Fs = 256;  % sampling frequency
PausePeriod = .1;   % loop pause interval (necessary for streaming display)
P = 1/Fs;
requiredTime= handles.requiredTime;
requiredSamples = Fs * requiredTime; % current epoch window
updateSamples = round(Fs * PausePeriod); % incoming data block
k=1;%index of Class variable
t = -requiredTime+P:P:0;
eegHandle = cell(1, 3); % eeg channels plot handle
axNbEEG = handles.axNbEEG;

%---> statist_log=abs(log(mean(abs(newData(:,end-3*Fs+1:end))')));
%---> FFT=abs(fft(newData(:,end-3*Fs+1:end)'));
%     SORT_FFT=sort(FFT(1:length(FFT)/2,:));
%     max_fft_amp=reshape(SORT_FFT(end-handles.Amp_comp+1:end,:),size(SORT_FFT(end-handles.Amp_comp+1:end,:),1)*size(SORT_FFT(end-handles.Amp_comp+1:end,:),2),1);
%     max_fft_amp_log=log(max_fft_amp);
%---> FFT=abs(fft(newData(:,end-3*Fs+1:end)'));
%     SORT_FFT=sort(FFT(1:length(FFT)/2,:));
%     for i_m=1:handles.Freq_comp
%        for i_m_j=1:3
%            max_fft(i_m,i_m_j)=min(find(FFT(:,i_m_j)==SORT_FFT(end-i_m+1,i_m_j)));
%        end
%     end
%     max_fft_comp=reshape(max_fft,size(max_fft,1)*size(max_fft,2),1);
%     max_fft_comp_log=log(max_fft_comp);
%---> AR_1=arburg(newData(1,end-3*Fs+1:end),handles.AR);
%     AR_2=arburg(newData(2,end-3*Fs+1:end),handles.AR);
%     AR_3=arburg(newData(3,end-3*Fs+1:end),handles.AR);
%     AR_Coeff=[AR_1(2:handles.AR+1) AR_2(2:handles.AR+1) AR_3(2:handles.AR+1)]
%     AR_Coeff_log=abs(log(AR_Coeff));
%---> fft_newData=fft(newData(:,end-3*Fs+1:end)');
%     BP_alpha=diag(fft_newData(handles.alpha_L*3*Fs/Fs:handles.alpha_H*3*Fs/Fs,:)'*fft_newData(handles.alpha_L*3*Fs/Fs:handles.alpha_H*3*Fs/Fs,:));
%     BP_alpha=BP_alpha';
%     BP_alpha_log=log(BP_alpha);
%---> fft_newData=fft(newData(:,end-3*Fs+1:end)');
%     BP_beta=diag(fft_newData(handles.beta_L*3*Fs/Fs:handles.beta_H*3*Fs/Fs,:)'*fft_newData(handles.beta_L*3*Fs/Fs:handles.beta_H*3*Fs/Fs,:));
%     BP_beta=BP_beta';
%     BP_beta_log=log(BP_beta);

for n=1:trialsNb
    set(handles.edit13,'string', ['',num2str(n),'/',num2str(trialsNb),'']);
    
    newData = zeros(chNb,requiredSamples);%for increasing cylinder
    BinCounts = zeros(1, 3);
    if isRealEEG
        save(Trial_TrigPath,'n');%indicating start of a trial
        t1=tic;m=0;
        while (toc(t1) <= 10)
            pause(PausePeriod);
            warndlg('EEG device-specific code (SDK) for real-time EEG buffering should be implemented here.')
            if toc(t1)>=2 && m==0
                beep;m=1;
            end
            if toc(t1)>=7 && toc(t1)<=10
                % Subject-specific feature type
                FFT=abs(fft(newData(:,end-3*Fs+1:end)'));
                SORT_FFT=sort(FFT(1:length(FFT)/2,:));
                max_fft_amp=log(reshape(SORT_FFT(end-handles.Amp_comp+1:end,:),size(SORT_FFT(end-handles.Amp_comp+1:end,:),1)*size(SORT_FFT(end-handles.Amp_comp+1:end,:),2),1));
                for i_m=1:handles.Freq_comp
                    for i_m_j=1:chNb
                        max_fft(i_m,i_m_j)=min(find(FFT(:,i_m_j)==SORT_FFT(end-i_m+1,i_m_j)));
                    end
                end
                max_fft_comp=log(reshape(max_fft,size(max_fft,1)*size(max_fft,2),1));
                BP_new = mapminmax('apply',[max_fft_amp' max_fft_comp']',handles.PS);
                [C(1,k),err,P,logp,coeff] = classify(BP_new',handles.BP,handles.signal_123_label');
                eval(['save(fullfile(sharePath, ''Class',num2str(k),'''),''C'');'])%indicating start of a trial
                k=k+1;
            end
        end
        save(Trial_10Path,'k');%indicating start of a trial
        handles.Data(:,:,n)=newData(:,requiredSamples-10*Fs+1:requiredSamples);
        inter_trial=2+rand(1);
        while toc(t1)<=10+inter_trial
            pause(PausePeriod);
            warndlg('EEG device-specific code (SDK) for real-time EEG buffering should be implemented here.')
        end
        
    else %---------------- stereaming Simulation
        save(Trial_TrigPath,'n');%indicating start of a trial
        m=0;is3=0;is425=0;
        DataPointer = 1; % Sample pointer in Data to simulate EEG streaming
        pauseOffset = 0;%0.10;%0.05;
        while DataPointer <= size(eeg.Data, 2)
            pause(PausePeriod-pauseOffset);
            try
                temp = eeg.Data(:, DataPointer:DataPointer+updateSamples-1, n);
                newData = [newData(:,updateSamples+1:requiredSamples) temp];
                DataPointer = DataPointer + updateSamples; % update
            catch % to read the last block of data that is smaller than the previous ones
                temp = eeg.Data(:, DataPointer:end, n);
                newData = [newData(:,size(temp, 2)+1:requiredSamples) temp];
                break
            end
            for i = 1 : length(axNbEEG)
                eegHandle{i} = plotEEG(eegHandle{i}, handles.(['axes',num2str(axNbEEG(i)),'']), t, newData(i, :), 'b');
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
            if lastZeroIdx < (requiredTime-7)* Fs && lastZeroIdx > (requiredTime-10)* Fs% FEEDBACK
                columnSignal = newData(:,end-3*Fs+1:end)';
                BP_alpha = band_power(Fs, columnSignal, [handles.alpha_L, handles.alpha_H]);
                BP_beta = band_power(Fs, columnSignal, [handles.beta_L, handles.beta_H]);
                
                BP_new = [BP_alpha, BP_beta]';
                C(1,k) = classify(BP_new',handles.BP,handles.signal_123_label');
                BinCounts(C(1,k)) = BinCounts(C(1,k)) + 1;
                
                save(fullfile(sharePath, ['Class',num2str(k),'']),'C');%indicating start of a trial
                k=k+1;
                bar(handles.axes1, 1,BinCounts(1),'b')
                bar(handles.axes1, 2,BinCounts(3),'g')
                bar(handles.axes1, 3,BinCounts(2),'y')
                drawnow
            end
        end
        save(Trial_10Path,'k');%indicating start of a trial
        inter_trial=2+rand(1);
        while lastZeroIdx < (requiredTime-(10+inter_trial))* Fs
            pause(PausePeriod);
        end
    end % if isRealEEG
    barAxPrepare(handles.axes1, []);
end
if isRealEEG
    warndlg('EEG device-specific code (SDK) for closing the real-time EEG streaming should be implemented here.')
end
clc
%% calculate evaluation metrics
pause(1)
load(fullfile(handles.sharePath, 'Acc_Kappa.mat'))
classificationReport = cell(4);
matrixC = [handles_C.C11, handles_C.C12, handles_C.C13;
    handles_C.C21, handles_C.C22, handles_C.C23;
    handles_C.C31, handles_C.C32, handles_C.C33];
[precision, recall, f1] = precisionRecallF1_confusion(matrixC);
Acc = sum(diag(matrixC)) / (sum(matrixC(:)));

for i = 1 : length(precision)
    classificationReport{i, 1} = num2str(precision(i));
    classificationReport{i, 2} = num2str(recall(i));
    classificationReport{i, 3} = num2str(f1(i));
end
classificationReport{4, 4} = num2str(Acc);

% change LRF to LFR
tmp = classificationReport(2, :);
classificationReport(2, :) = classificationReport(3, :);
classificationReport(3, :) = tmp;
set(handles.uitable1,'data',classificationReport)
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
Data=handles.Data;
features=load(trnFeatPath);
savePath = fullfile(pwd, 'data', ['',Subject_Name,'_WF_',Date,'_s',Session,'_r',Run,'.mat']);

save(savePath, 'Age','Gender','Subject_Name','Remarks','Run','Session','Date','cue_type','Data', ...
    'matrixC', 'handles_C', 'Acc', 'classificationReport', 'features')

guidata(hObject, handles);
function edit1_Callback(hObject, eventdata, handles)
handles.Subject_Name=get(handles.edit1,'string');
guidata(hObject, handles);
function edit1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edit2_Callback(hObject, eventdata, handles)
function edit2_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edit3_Callback(hObject, eventdata, handles)
handles.Age=num2str(get(handles.edit3,'string'));
guidata(hObject, handles);
function edit3_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edit4_Callback(hObject, eventdata, handles)
handles.Session=get(handles.edit4,'string');
guidata(hObject, handles);
function edit4_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edit5_Callback(hObject, eventdata, handles)
handles.Run=get(handles.edit5,'string');
guidata(hObject, handles);
function edit5_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edit6_Callback(hObject, eventdata, handles)
handles.Date=get(handles.edit6,'string');
guidata(hObject, handles);
function edit6_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edit13_Callback(hObject, eventdata, handles)
handles.Remarks=get(handles.edit13,'string');
guidata(hObject, handles);
function edit13_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function pushbutton3_Callback(hObject, eventdata, handles)
function pushbutton4_Callback(hObject, eventdata, handles)
set(handles.edit1,'string','')
set(handles.edit3,'string','')
set(handles.edit4,'string','')
set(handles.edit5,'string','')
set(handles.edit6,'string','')
set(handles.edit13,'string','')
set(handles.edit14,'string','')
set(handles.edit15,'string','')
set(handles.edit16,'string','')
set(handles.edit17,'string','')
set(handles.popupmenu1,'Value',1);
subplot(8,6,8:11);cla; axis off,title('')
subplot(8,6,20:23);cla; axis off,title('')
subplot(8,6,32:35);cla; axis off,title('')
set(handles.edit18,'string','')
set(handles.edit19,'string','')
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
function edit14_Callback(hObject, eventdata, handles)
function edit14_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edit15_Callback(hObject, eventdata, handles)
function edit15_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edit16_Callback(hObject, eventdata, handles)
function edit16_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edit17_Callback(hObject, eventdata, handles)
function edit17_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edit18_Callback(hObject, eventdata, handles)
function edit18_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edit19_Callback(hObject, eventdata, handles)
function edit19_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function pushbutton5_Callback(hObject, eventdata, handles)
guidata(hObject, handles);
function figure1_CreateFcn(hObject, eventdata, handles)