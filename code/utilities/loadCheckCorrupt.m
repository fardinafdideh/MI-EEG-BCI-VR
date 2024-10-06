isCorrupt = 0;
try
    load(fullfile(sharePath, ['Class',num2str(class_ind),'.mat']));
catch
%     class_ind = class_ind + 1; % Load the next file, if the current is corrupt
    disp('An error related to corrupt file was handled!')
    isCorrupt = 1;
end