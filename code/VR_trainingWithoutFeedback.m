% vrclose
% vrclear
%%
clc
clear
close all
%%
isTest = 0; % 1: test case (small number of trials); 0: real number of trials
if isTest
    counterThr = 12+1;
else
    counterThr = 36+1;
end

%%
isRealEEG = 0; % 0: Simulated stream of EEG; 1: Real EEG stream
if isRealEEG
    sharePath = '\\192.168.0.1\BCI-VR-share';
else
    sharePath = fullfile(pwd, 'BCI-VR-share');
    cue_typePath = fullfile(pwd, 'data', 'sample_trainingWitoutFeedback.mat');
    Trial_3FileName = 'Trial_3.mat';
    Trial_425FileName = 'Trial_425.mat';
    Trial_3FilePath = fullfile(sharePath, 'Trial_3.mat');
    Trial_425FilePath = fullfile(sharePath, 'Trial_425.mat');
end

listing = dir(sharePath);
for i = 1 : length(listing)
    if isfile(fullfile(listing(i).folder,listing(i).name))
        delete(fullfile(listing(i).folder,listing(i).name))
    end
end
Trial_TrigFileName = 'Trial_Trig.mat';
Trial_7FileName = 'Trial_7.mat';
Trial_TrigFilePath = fullfile(sharePath, Trial_TrigFileName);
Trial_7FilePath = fullfile(sharePath, Trial_7FileName);
%%
myworld=vrworld(fullfile(pwd, 'utilities', 'VR_trainingWithoutFeedback.wrl'));%Create a virtual world.
open(myworld);%Open files by extension.
reload(myworld)
object_nodes=nodes(myworld,'-full');%List VRML nodes in a virtual world.
LeftRightArrow=object_nodes(2,1);%assigning nodes to variables
UpDownArrow=object_nodes(1,1);%assigning nodes to variables

if isRealEEG
    total_trials=36;%total number of trials in each run (12 trials from each class)
    cue_type=randperm(total_trials);%1:12 refer to class 1; 13:24 refer to class 2; 25:36 refer to class 3
    for i=1:length(cue_type)
        if  sum(cue_type(i)==[1:12])==1
            cue_type(i)=1;
        elseif sum(cue_type(i)==[13:24])==1
            cue_type(i)=2;
        elseif sum(cue_type(i)==[25:36])==1
            cue_type(i)=3;
        end
    end
else
    load(cue_typePath, 'cue_type')
end
vrfigure_object=vrfigure(myworld);%Create a new Virtual Reality figure.
set(vrfigure_object,'NavPanel','none');%Set object properties.(default:halfbar)
pause(eps)
set(vrfigure_object,'StatusBar','off');%Set object properties.
pause(eps)
set(vrfigure_object,'ToolBar','off');%Set object properties.
pause(eps)
% set(vrfigure_object,'Fullscreen','on');%Set object properties.
% pause(eps)
set(vrfigure_object,'Position',[0 79 696 696*768/1366]);%Set object properties.
pause(eps)
LeftRightArrow.translation=[1.006 0 -.1];pause(eps);%Set structure field contents for default value.
UpDownArrow.translation=[0 1 -.1];pause(eps);%Set structure field contents for default value.
set(vrfigure_object,'CameraPosition',[10 -.03 7]);%Set object properties.
pause(eps)
counter=1;
% addpath(sharePath)
if isRealEEG
    save(fullfile(sharePath, 'cue_type'),'cue_type');
else % No need to save cue_type. The function that needs it, reads saved data
end

while 1
    n=1;
    if exist(Trial_TrigFilePath, 'file')
        if isRealEEG
            t1=tic;
            set(vrfigure_object,'CameraPosition',[0 -.03 7]);pause(eps);%Set object properties.
            while ~exist(Trial_7FilePath)%toc(t1)<=7
                if toc(t1)>=3 && n==1 && cue_type(counter)==1
                    LeftRightArrow.translation=[-1.006 0 .06];pause(eps);%Set structure field contents for left cue.
                    n=2;
                elseif toc(t1)>=3 && n==1 && cue_type(counter)==2
                    LeftRightArrow.translation=[1.006 0 .06];pause(eps);%Set structure field contents for right cue.
                    n=2;
                elseif toc(t1)>=3 && n==1 && cue_type(counter)==3
                    UpDownArrow.translation=[0 -1.05 .03];pause(eps);%Set structure field contents for right cue.
                    n=2;
                end
                if toc(t1)>=4.25
                    LeftRightArrow.translation=[1.006 0 -.1];pause(eps);%Set structure field contents for default value.
                    UpDownArrow.translation=[0 -1.05 -1];pause(eps);%Set structure field contents for default value.
                end
            end
        else
            set(vrfigure_object,'CameraPosition',[0 -.03 7]);pause(eps);%Set object properties.
            while ~exist(Trial_7FilePath, 'file')%toc(t1)<=7
                if exist(Trial_3FilePath, 'file') && n==1 && cue_type(counter)==1
                    LeftRightArrow.translation=[-1.006 0 .06];pause(eps);%Set structure field contents for left cue.
                    n=2;
                    vrdrawnow
                elseif exist(Trial_3FilePath, 'file') && n==1 && cue_type(counter)==2
                    LeftRightArrow.translation=[1.006 0 .06];pause(eps);%Set structure field contents for right cue.
                    n=2;
                    vrdrawnow
                elseif exist(Trial_3FilePath, 'file') && n==1 && cue_type(counter)==3
                    UpDownArrow.translation=[0 -1.05 .03];pause(eps);%Set structure field contents for right cue.
                    n=2;
                    vrdrawnow
                end
                if exist(Trial_425FilePath, 'file') && n==2
                    LeftRightArrow.translation=[1.006 0 -.1];pause(eps);%Set structure field contents for default value.
                    UpDownArrow.translation=[0 -1.05 -1];pause(eps);%Set structure field contents for default value.
                    drawnow
                end
            end
            delete(Trial_3FilePath)
            delete(Trial_425FilePath)
        end
        set(vrfigure_object,'CameraPosition',[10 -.03 7]);pause(eps);%Set object properties.
        delete(Trial_TrigFilePath)
        delete(Trial_7FilePath)
        n=1;
        counter=counter+1;
        if counter == counterThr
            break
        end
    end
end
vrclose