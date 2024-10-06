% Pause before sending the command (save trial.mat) to BCI workstation to start the classification
% pause(3) % Commented for eeg simulation
% save('\\192.168.0.1\SHARE\Trial','i');% start of feature extraction and classification
% save(TrialPath,'i');% start of feature extraction and classification 
save(TrialPath,'Subject_Route');% Trial.mat: start of feature extraction and classification. Subject_Route shows where the subject is inside the VE
% disp(['Trial.mat saved for Subject_Route=',num2str(Subject_Route(end)),''])