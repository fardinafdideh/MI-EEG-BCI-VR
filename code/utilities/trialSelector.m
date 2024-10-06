function [trialNb, targetClass] = trialSelector(TrialPath, StartStation, EndStation)
load(TrialPath) % loads Subject_Route
% left = [36,35,33,29,28,25,16,15,11,8,6,5];
% right = [34,30,27,24,23,18,14,13,7,2]; % low quality trials: 32,31
% feet = [22,21,20,19,17,12,10,9,4,3,1]; % low quality trials: 26,

if StartStation == 1 && EndStation == 8 % OutFront-KitchenFront
    if Subject_Route(end) == 1 % OutFront
        trialNb = 22; % feet
        targetClass = 3;
    elseif Subject_Route(end) == 4 % InputDoor
        trialNb = 34; % right
        targetClass = 2;
    elseif Subject_Route(end) == 5 &&  Subject_Route(end-1) ~= 5 % Kitchen (confirm)
        trialNb = 30; % right
        targetClass = 2;
    elseif Subject_Route(end) == 5 &&  Subject_Route(end-1) == 5 % Kitchen
        trialNb = 21; % feet
        targetClass = 3;
    elseif Subject_Route(end) == 8 % KitchenFront (select)
        trialNb = 30; % right
        targetClass = 2;
    else
        error('Not a predefined route!')
    end
% elseif StartStation == 1 && EndStation == 17 % OutFront-WCBathLeft
%     if Subject_Route(end) == 1 % OutFront
%         trialNb = 20; % feet
%         targetClass = 3;
%     elseif Subject_Route(end) == 4 % InputDoor
%         trialNb = 36; % left
%         targetClass = 1;
%     elseif Subject_Route(end) == 10 % BedBathDoor
%         trialNb = 19; % feet
%         targetClass = 3;
%     elseif Subject_Route(end) == 15 &&  Subject_Route(end-1) ~= 15 % WCBath (confirm)
%         trialNb = 27; % right
%         targetClass = 2;
%     elseif Subject_Route(end) == 15 &&  Subject_Route(end-1) == 15 % WCBath
%         trialNb = 35; % left
%         targetClass = 1;
%     elseif Subject_Route(end) == 17 % WCBathLeft
%         trialNb = 24; % right
%         targetClass = 2;
%     else
%         error('Not a predefined route!')
%     end
% elseif StartStation == 1 && EndStation == 12 % OutFront-BedroomRight
%     if Subject_Route(end) == 1 % OutFront
%         trialNb = 17; % feet
%         targetClass = 3;
%     elseif Subject_Route(end) == 4 % InputDoor
%         trialNb = 33; % left
%         targetClass = 1;
%     elseif Subject_Route(end) == 10 % BedBathDoor
%         trialNb = 29; % left
%         targetClass = 1;
%     elseif Subject_Route(end) == 11 &&  Subject_Route(end-1) ~= 11 % Bedroom (confirm)
%         trialNb = 34; % right/feet. 23,27,17 didn't work
%         targetClass = 2;
%     elseif Subject_Route(end) == 11 &&  Subject_Route(end-1) == 11 % Bedroom
%         trialNb = 18; % right
%         targetClass = 2;
%     elseif Subject_Route(end) == 12 % BedroomRight
%         trialNb = 14; % right
%         targetClass = 2;
%     else
%         error('Not a predefined route!')
%     end
% elseif StartStation == 1 && EndStation == 21 % OutFront-SalonLeft
%     if Subject_Route(end) == 1 % OutFront
%         trialNb = 12; % feet
%         targetClass = 3;
%     elseif Subject_Route(end) == 4 % InputDoor
%         trialNb = 28; % left
%         targetClass = 1;
%     elseif Subject_Route(end) == 10 % BedBathDoor
%         trialNb = 13; % right
%         targetClass = 2;
%     elseif Subject_Route(end) == 19 &&  Subject_Route(end-1) ~= 19 % Salon (confirm)
%         trialNb = 7; % right
%         targetClass = 2;
%     elseif Subject_Route(end) == 19 &&  Subject_Route(end-1) == 19 % Salon
%         trialNb = 25; % left
%         targetClass = 1;
%     elseif Subject_Route(end) == 21 % BedroomRight
%         trialNb = 2; % right
%         targetClass = 2;
%     else
%         error('Not a predefined route!')
%     end
else
    error('Not a predefined route!')
end
%% From (21:OutFront-SalonLeft; 12: OutFront-BedroomRight; 17: OutFront-WCBathLeft; 8: OutFront-KitchenFront)
% 
% Out-Front
% Out-Right
% Out-Left
% Input-Door
% Kitchen
% Kitchen-Right
% Kitchen-Left
% Kitchen-Front
% Dining-Table
% Bed-Bath_Door
% Bedroom
% Bedroom-Right
% Bedroom-Left
% Bedroom-Front
% WC-Bathroom
% WC-Bathroom-Right
% WC-Bathroom-Left
% WC-Bathroom-Front
% Salon
% Salon-Right
% Salon-Left
% Salon-Front