clc,
clear
%%
isRealEEG = 0;
if isRealEEG
    sharePath = '\\192.168.0.1\BCI-VR-share';
else
    sharePath = fullfile(pwd, 'BCI-VR-share');
end
toolboxPath = pwd;
addpath(genpath(toolboxPath))
%%
listing = dir(sharePath);
for i = 1 : length(listing)
    if isfile(fullfile(listing(i).folder,listing(i).name))
    delete(fullfile(listing(i).folder,listing(i).name))
    end
end
%%
HouseTourPath = fullfile(sharePath, 'HouseTour.mat');
HouseTourSubjectPath = fullfile(sharePath, 'HouseTourSubject.mat');
StartStationPath = fullfile(sharePath, 'StartStation.mat');
TrialPath = fullfile(sharePath, 'Trial.mat');
k_classPath = fullfile(sharePath, 'k_class.mat');
selectedClassPath = fullfile(sharePath, 'selectedClass.mat');

%%
App_env=1;
while App_env
    if exist(HouseTourPath, 'file')
        delete(HouseTourPath)
        apartment_tour
        pause(1)
        clear;%Clear variables and functions from memory.(1822)
        vrclose;%Closes Virtual Reality figures.
        vrclear;%Purge closed virtual worlds from memory.
        App_env=0;
    elseif exist(HouseTourSubjectPath, 'file')
        delete(HouseTourSubjectPath)
        Navigation=1;
        apartment_tour_SubjectDependent
        pause(1)
        clear;%Clear variables and functions from memory.(1822)
        vrclose;%Closes Virtual Reality figures.
        vrclear;%Purge closed virtual worlds from memory.
        App_env=0;
    elseif exist(StartStationPath, 'file')
        load(StartStationPath)
        Navigation=1;
        apartment_Navigation_Client
        save(fullfile(sharePath, 'Navigation_Time'),'Navigation_Time')
        save(fullfile(sharePath, 'Subject_Route'),'Subject_Route')
        save(fullfile(sharePath, 'TrialEnd'),'Navigation_Time')
        delete(fullfile(sharePath, 'StartStation.mat'))
        pause(1)
        %         clear;%Clear variables and functions from memory.(1822)
        vrclose;%Closes Virtual Reality figures.
        vrclear;%Purge closed virtual worlds from memory.
        App_env=0;
    end
end