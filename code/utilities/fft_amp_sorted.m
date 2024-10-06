function out = fft_amp_sorted(columnSignal, compNb)
% columnSignal: signalLength * channels
% compNb: # of components

columnSignalFFT = abs(fft(columnSignal, 2^nextpow2(size(columnSignal,1))));
columnSignalFFTSort = sort(columnSignalFFT(1:round(size(columnSignalFFT, 1)/2),:), 'ascend');
columnSignalFFTSort = columnSignalFFTSort(end-compNb+1:end,:); % select compNb components
out = columnSignalFFTSort(:);
