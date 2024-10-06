function eegHandle = plotEEG(eegHandle, ax, t, eeg, color)

delete(eegHandle);
eegHandle = plot(ax, t, eeg, color);
drawnow


