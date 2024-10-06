function deleteTrialPathSaveSelectedClass(TrialPath, selectedClassPath, selectedClass)
delete(TrialPath);% end of feature extraction and classification in bci workstation
save(selectedClassPath, 'selectedClass');