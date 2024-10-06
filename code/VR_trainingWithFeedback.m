clc
clear
close all
%%
toolboxPath = pwd;
addpath(genpath(toolboxPath))
%%
isTest = 0;
if isTest
    counterThr = 12+1;
else
    counterThr = 36+1;
end

%%
isRealEEG = 0;
if isRealEEG
    sharePath = '\\192.168.0.1\BCI-VR-share';
else
    sharePath = fullfile(pwd, 'BCI-VR-share');
    cue_typePath = fullfile(pwd, 'data', 'sample_trainingWithFeedback.mat');
    Trial_3FileName = 'Trial_3.mat';
    Trial_425FileName = 'Trial_425.mat';
    Trial_3FilePath = fullfile(sharePath, Trial_3FileName);
    Trial_425FilePath = fullfile(sharePath, Trial_425FileName);
end

listing = dir(sharePath);
for i = 1 : length(listing)
    if isfile(fullfile(listing(i).folder,listing(i).name))
        delete(fullfile(listing(i).folder,listing(i).name))
    end
end

Trial_TrigFileName = 'Trial_Trig.mat';
Trial_10FileName = 'Trial_10.mat';
Trial_10FilePath = fullfile(sharePath, Trial_10FileName);
Trial_TrigFilePath = fullfile(sharePath, Trial_TrigFileName);
%%
myworld=vrworld(fullfile(pwd, 'utilities', 'VR_trainingWithFeedback.wrl'));%Create a virtual world.
open(myworld);%Open files by extension.
reload(myworld)
object_nodes=nodes(myworld,'-full');%List VRML nodes in a virtual world.
UpDownCylinder=object_nodes(4,1);
LeftRightCylinder=object_nodes(3,1);
LeftRightArrow=object_nodes(2,1);
UpDownArrow=object_nodes(1,1);

if isRealEEG
    total_trials=36;%total number of trials in each run (12 trials from each class)
    cue_type=randperm(total_trials);%1:12 refer to class 1; 13:24 refer to class 2; 25:36 refer to class 3;
    for i=1:length(cue_type)
        if  sum(cue_type(i)==[1:12])==1
            cue_type(i)=1;
        elseif sum(cue_type(i)==[13:24])==1
            cue_type(i)=2;
        elseif sum(cue_type(i)==[25:36])==1
            cue_type(i)=3;
        end
    end
    save(fullfile(sharePath, 'cue_type'),'cue_type');
else
    load(cue_typePath, 'cue_type')
end

vrfigure_object=vrfigure(myworld);%Create a new Virtual Reality figure.
set(vrfigure_object,'StatusBar','off');%Set object properties.
pause(eps)
set(vrfigure_object,'ToolBar','off');%Set object properties.
pause(eps)
set(vrfigure_object,'NavPanel','none');%Set object properties.(default:halfbar)
pause(eps)
% set(vrfigure_object,'Fullscreen','on');%Set object properties.
% pause(eps)
set(vrfigure_object,'Position',[0 79 696 696*768/1366]);%Set object properties.
pause(eps)
setfield(LeftRightCylinder,'scale',[0 .3 .3]);pause(eps);%Set structure field contents.
setfield(UpDownCylinder,'scale',[0 .3 .3]);pause(eps);%Set structure field contents.
setfield(LeftRightArrow,'translation',[1.006 0 -.1]);pause(eps);%Set structure field contents for default value.
setfield(UpDownArrow,'translation',[0 1 -.1]);pause(eps);%Set structure field contents for default value.
cylinder_increase=0;
set(vrfigure_object,'CameraPosition',[10 -.03 7]);pause(eps);%Set object properties.
counter=1;
handles.C11=0;handles.C12=0;handles.C13=0;
handles.C21=0;handles.C22=0;handles.C23=0;
handles.C31=0;handles.C32=0;handles.C33=0;
addpath(sharePath)
stretch=23;% scale for stretching the bar
k=1;class_ind=1;del_ind=1;class_ind_inc=2;
cylinder_increase=0;
isScaleZero = 0;
while 1
    n=1;
    if ~isScaleZero
        LeftRightCylinder.scale=[0 0 0];pause(eps);%Set structure field contents.
        UpDownCylinder.scale=[0 0 0];pause(eps);%Set structure field contents.
        vrdrawnow
        isScaleZero = 1;
    end
    if exist(Trial_TrigFilePath, 'file')
        if isRealEEG
            t1=tic;
            set(vrfigure_object,'CameraPosition',[0 -.03 7]);pause(eps);%Set object properties.
            while ~exist(Trial_10FilePath, 'file')%toc(t1)<=10
                if toc(t1)>=3 && n==1
                    if cue_type(counter)==1
                        LeftRightArrow.translation=[-1.006 0 .06];pause(eps);%Set structure field contents for left cue.
                    elseif cue_type(counter)==2
                        LeftRightArrow.translation=[1.006 0 .06];pause(eps);%Set structure field contents for right cue.
                    elseif cue_type(counter)==3
                        UpDownArrow.translation=[0 -1.05 .03];pause(eps);%Set structure field contents for right cue.
                    end
                    vrdrawnow
                    n=2;
                end
                if toc(t1)>=4.25
                    LeftRightArrow.translation=[1.006 0 -.1];pause(eps);%Set structure field contents for default value.
                    UpDownArrow.translation=[0 1 -.1];pause(eps);%Set structure field contents for default value.
                    n=n+1;
                    vrdrawnow
                end
                eval(['if exist(''Class',num2str(class_ind),'.mat'');pause(.1);load(''Class',num2str(class_ind),'.mat'');With_Feedback_Client_feedback;class_ind=class_ind+class_ind_inc;end'])%pause(.2) Correct this (without eval)
            end
            set(vrfigure_object,'CameraPosition',[10 -.03 7]);pause(eps);%Set object properties.
            delete(Trial_TrigFilePath)
            if ~isScaleZero
                LeftRightCylinder.scale=[0 0 0];pause(eps);%Set structure field contents.
                UpDownCylinder.scale=[0 0 0];pause(eps);%Set structure field contents.
                vrdrawnow
                isScaleZero = 1;
            end
            load(Trial_10FilePath)
            class_ind=k;
            delete(Trial_10FilePath)
            n=1;cylinder_increase=0;
            for i=del_ind:class_ind-class_ind_inc
                delete(fullfile(sharePath,['Class',num2str(i),'.mat']))
            end
            del_ind=class_ind-class_ind_inc+1;%pause(1.5)
            counter=counter+1;
            if counter==37
                break
            end
        else % --------------------------
            delete(Trial_TrigFilePath)
            set(vrfigure_object,'CameraPosition',[0 -.03 7]);pause(eps);%Set object properties.
            vrdrawnow
            while ~exist(Trial_10FilePath, 'file')%toc(t1)<=10
                if exist(Trial_3FilePath, 'file') && n==1 % toc(t1)>=3
                    if cue_type(counter)==1
                        LeftRightArrow.translation=[-1.006 0 .06];pause(eps);%Set structure field contents for left cue.
                    elseif cue_type(counter)==2
                        LeftRightArrow.translation=[1.006 0 .06];pause(eps);%Set structure field contents for right cue.
                    elseif cue_type(counter)==3
                        UpDownArrow.translation=[0 -1.05 .03];pause(eps);%Set structure field contents for right cue.
                    end
                    vrdrawnow
                    n=2;
                end
                if exist(Trial_425FilePath, 'file') && n==2 %toc(t1)>=4.25
                    LeftRightArrow.translation=[1.006 0 -.1];pause(eps);%Set structure field contents for default value.
                    UpDownArrow.translation=[0 1 -.1];pause(eps);%Set structure field contents for default value.
                    vrdrawnow
                    n=n+1;
                end
                if exist(fullfile(sharePath, ['Class',num2str(class_ind),'.mat']), 'file')
                    loadCheckCorrupt;
                    if ~isCorrupt
                        With_Feedback_Client_feedback;
                        class_ind=class_ind+class_ind_inc;
                    end
                end
            end
            delete(Trial_3FilePath)
            delete(Trial_425FilePath)
            set(vrfigure_object,'CameraPosition',[10 -.03 7]);pause(eps);%Set object properties.
            if ~isScaleZero
                LeftRightCylinder.scale=[0 0 0];pause(eps);%Set structure field contents.
                UpDownCylinder.scale=[0 0 0];pause(eps);%Set structure field contents.
                isScaleZero = 1;
            end
            load(Trial_10FilePath)
            class_ind=k;
            delete(Trial_10FilePath)
            n=1;cylinder_increase=0;
            for i=del_ind:class_ind-class_ind_inc
                delete(fullfile(sharePath,['Class',num2str(i),'.mat']))
            end
            del_ind=class_ind-class_ind_inc+1;%pause(1.5)
            
            counter=counter+1;
            if counter == counterThr %counter==0 % counter==37
                break
            end
        end % if isRealEEG
        isScaleZero = 0;
    end
    pause(eps)
end
handles_C=handles;
save(fullfile(sharePath,'Acc_Kappa'),'handles_C','cue_type');

vrclose